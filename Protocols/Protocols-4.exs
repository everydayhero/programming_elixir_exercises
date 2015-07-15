defimpl Inspect, for: Bitmap do
  def inspect(bitmap, _opts) do
    "%Bitmap{value: 0b#{bitmap}}"
  end
end