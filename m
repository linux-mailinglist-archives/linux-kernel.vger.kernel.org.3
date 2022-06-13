Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298E549CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbiFMTFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347352AbiFMTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:04:24 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044BDAE461;
        Mon, 13 Jun 2022 09:54:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F1BF8320093C;
        Mon, 13 Jun 2022 12:54:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 13 Jun 2022 12:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1655139288; x=1655225688; bh=w4n02oQUKx
        7H8B+PgNZX4OsXP8VxI6IGI7qQhWHj9MQ=; b=DP7oGg4f3ap5vbyQo/0Q5Cc2si
        shVZ3tES4aiVNsrWKF2hb6E8Vl1geVzYIpQuTFH2GGqYirAWR+A2WOsWf9sxWwuB
        uhnaHNdrwynDY2mgJnLaLsQHonSUKlErQvXPlw+Opds3eI7lovBVj26l5flOkCmw
        hCmfEfmCRVEGY0jLMV6GHxx1xo2sFGxbFX84+K40ScYrLgzgW6mvLUus/sd2JRBh
        wCoitm0kyg67rkv0IclLqptAmJHiplmf8we9u18X9Nbkq7p0mnivDYh2eG9Bcmty
        kapiZkOXuryA5Obw/qnyeob0Ianj3z4iEJ2ROWr+iOaRs1UR7JcOdi5zRKoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1655139288; x=1655225688; bh=w4n02oQUKx7H8B+PgNZX4OsXP8Vx
        I6IGI7qQhWHj9MQ=; b=CkYUOV+/p8bFjMbeiAMq5LMV0fB6Fl24I/rEAw2nPd1e
        RTYv2dEyQ49BT2/0Y/u2pgt8KfPuILT89TOsC1qxUbVcAKuK9WvbB8witdDdBccu
        K1dFxKqg/5s28HAP20erWAlueeEZ1RYhKuvRbRLJM1bZbhW7K4bRwAjz8oP8R0HT
        AkPGBZcrdj7HPtJVtYE5dxZ81NTxSs4yCE6bbDMU/fjVOAWVm58XYjEWhYn5rI94
        SfLX8kWyjdM53KhaAUUuZWXVGLdfH2uTVjYqWYNGvQSjR9II8vkSRD/hQeghu+cy
        fr6UGQDQgbhFBbL65c2aNSLoVl2lMQJISeTxvNPLVg==
X-ME-Sender: <xms:12unYsxuDyY8MGT0OxK9k2SkJhF_lUo05DHgTvFUmPHi3-Fp6_AUMg>
    <xme:12unYgSRI2b1_rYkEYvCWHbydjOEYNo1BIqbS14i4d1RvCyD7BrY6Fjwf9two0kz6
    zCpe1LXjhdp49dWc8I>
X-ME-Received: <xmr:12unYuWufpDwBBSBdjYzx487Yhb9BiN7XjckAv9CAJGGXvvwEai6FeSW2vcC7ilk7xpoMAjZMbrWX1zuWSNBkAn9OjgUoP1ziyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddujedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreer
    tddtvdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkh
    esshhtfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepheefjeehfedtjeeivdefkeff
    heeludekudelleffkefgtdeludelvddtgedtheeknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:12unYqihEW2t3u6yx2veW8CGzdu0EW7ut8a8blqTotcHS4UcWccQDA>
    <xmx:12unYuCI4jodqEMYBik5Apr9KjhHkZbOBJ1hzB5hDKipE_2guM0T7g>
    <xmx:12unYrIj1IiuecCDGPtOYug_Sv28UsVXPd15U1PyXmp5VtpKJXb5wg>
    <xmx:2GunYkBkY16DcueyNZ2bKU7S-zKy-2E_IFuSkx7mC9mFazUhMZ0AEQ>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jun 2022 12:54:46 -0400 (EDT)
Date:   Mon, 13 Jun 2022 11:54:45 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Potin Lai <potin.lai@quantatw.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Update Facebook Bletchley BMC DTS
Message-ID: <Yqdr1ZS6d71QeACd@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6jmKncZVUj7hG/F1"
Content-Disposition: inline
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6jmKncZVUj7hG/F1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 05:51:46PM +0800, Potin Lai wrote:
> Update below items for Facebook Bletchley BMC devicetree.
>=20
> Potin Lai (4):
>   ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
>   ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
>   ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
>   ARM: dts: aspeed: bletchley: update fusb302 nodes
>=20
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 197 +++++++++++++-----
>  1 file changed, 148 insertions(+), 49 deletions(-)

The whole patch set looks good to me as the closest domain expert to the
Bletchley system after Potin.

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--6jmKncZVUj7hG/F1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmKna9MACgkQqwNHzC0A
wRkCuA/+Lk/UCnb9WJxnAo+6ujKnM/SuKjGbG23OoaNN+BNsTEja0/9Y7V3DoIjF
xm71jwxoDsR25X3rt8EUyNq6XNXEKe6y8JR51sdAMegwPCK7tfUuRzXpd5y4zfUd
hEQOFcauV0oi0aLX5GGSTX80Ka3BDOQx0Fz2RiLQXZaKR/4h+eLnHO3yfAx0GItp
DlRGxqD3fHWNoK9vji/0ylMIquHvkl8mlKUyrU3cTJj6pT6nSD6EzkSwvYNhuTZA
hrZKrst3W6NmyrLJRpj/CZCY0A0GGGDSSPv2jpm362tERCX7oEoh3HwtYw/Y2XEj
kTvw0IjHvqcaovhCHCkYOtuA6yAqenwjYERb8M9sNL4qzjeoinC4YuKdMYxi3tnk
Q72JUwPC/R2gvth7ysAvlbCs45ioZoS9ZSd2MxI4i9QH3Pri9yg7X1IuG6I4NmG5
K3NHP8EHgyfsYk+zreVnkWBCl07/VXcTfFHq74m0Qsfqb3IAWzjOjII3S4rdDSPp
hNqXLGoHvEexruS6K/cDB1wHU2oxCHfPD7lTc2jc+g7b0WLyMbc5KRAhfrG75ljZ
Of/LUShe9F40XcroLHHnwTmOFLFOFVo2oong9rvdK8Rw7oVmXrufOjr+khgBDYkk
QbEFpGChKCNKLSaialAnyt+vgD5l8/U2RvnFuWr38uMcFY0xyG0=
=Ou4S
-----END PGP SIGNATURE-----

--6jmKncZVUj7hG/F1--
