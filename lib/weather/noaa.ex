defmodule Weather.NOAA do
  require Record

  #
  # Records
  #

  Record.defrecord :xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlAttribute :: record(
    :xmlAttribute,
    name: Atom,
    expanded_name: Atom | {char_list, Atom},
    nsinfo: {Prefix, Local} | [],
    namespace: xmlNamespace,
    parents: [{Atom, Integer}],
    pos: Integer,
    language: char_list,
    value: IOlist | Atom | Integer,
    normalized: true | false
  )

  Record.defrecord :xmlDocument, Record.extract(:xmlDocument, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlDocument :: record(:xmlDocument, content: any)

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlElement :: record(
    :xmlElement,
    name: Atom,
    expanded_name: char_list | {URI, Local} | {String.t, Local},
    nsinfo: {Prefix, Local} | [],
    namespace: xmlNamespace,
    parents: [{Atom, Integer}],
    pos: Integer,
    attributes: [xmlAttribute],
    content: [],
    language: char_list,
    xmlbase: char_list,
    elementdef: :undeclared | :prolog | :external | :element
  )

  Record.defrecord :xmlNamespace, Record.extract(:xmlNamespace, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlNamespace :: record(:xmlNamespace, default: list, nodes: list)

  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  @type xmlText :: record(
    :xmlText,
    parents: [{Atom, Integer}],
    pos: Integer,
    language: char_list,
    value: IOlist,
    type: Atom
  )

  #
  # Functions
  #

  @doc """
  Finds and extracts the text under the `xpath` from `document`.
  """
  @spec find_text(xmlElement, String.t) :: String.t
  def find_text(document_or_element, xpath) do
    [xpathXmlText] = Exmerl.XPath.find(document_or_element, "#{xpath}/text()")
    keywordList = xmlText(xpathXmlText)

    keywordList[:value]
    |> String.Chars.to_string
    |> String.strip
  end

  @doc """
  Converts raw, unparsed XML to root `xmlElement`
  """
  @spec raw_to_xml(String.t) :: xmlElement
  def raw_to_xml(raw) do
    {root_element, _rest} = Exmerl.from_string(
      raw,
      acc_fun: fn
        (xmlText(value: ' ', pos: position), accumulator, global_state) ->
          {accumulator, position, global_state} 
          (parsed_entity, accumulator, global_state) ->
            {[parsed_entity | accumulator], global_state}
      end,
      space: :normalize
    )

    root_element
  end
end
