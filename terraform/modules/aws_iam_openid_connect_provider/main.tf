
resource "aws_iam_openid_connect_provider" "this" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  // A thumbprint is mandatory, but it won't be used at all so we just set it to fff as suggested by github.
  thumbprint_list = ["ffffffffffffffffffffffffffffffffffffffff"]
}
