Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3C858EBA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiHJMGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiHJMGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:06:31 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8311463;
        Wed, 10 Aug 2022 05:06:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9E6DD320016F;
        Wed, 10 Aug 2022 08:06:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 10 Aug 2022 08:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660133186; x=1660219586; bh=3XbRmvT48M
        pdRH2ywGW3ehrhy3CjGTqx3lHdeyY6c4c=; b=SXj98chvzemW2+D+giV//Vm4lf
        r0EJ0mMccOw9xMl0/NXENd7eVaYfQ1DK1HRkBEM8KjHAlXil4CEmBiGCrwPNC+Kh
        hdahInc6BNxj3+bgqo+qiQy3a2MuRbkMaVbxVTTfDDjaHhca/P4swZ80ycTQgIP0
        604VoWI9WvUmBiGdjB80uacucJML0c4713e0o9R4bdQi+56kcU9DYg0uRw4eglis
        qbIXoi+9w7g/9+gT5L4L2sgjwhOahqygyo/49KVLLkeFfHhp8A6o7Qoyir2X+5Mq
        6W8dxW2k7Lvd2qMAtmeEvB2tHGjRBgChap1El0CZI2m45ugdRZyf9ZnTNU6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660133186; x=1660219586; bh=3XbRmvT48MpdRH2ywGW3ehrhy3Cj
        GTqx3lHdeyY6c4c=; b=C4MvPgfFs+BmCzMgV9dR95NpWJBJABmCxPG4pWCiPbl8
        69YgY7X/ywibwO4u3aUcngLbqOzs8bw21VZCUnAL0Cygb1IhJYA1Icdmur/WTwY9
        ZUaVmJft7S26teaKS62PW3J3/L8qPLjkznmRb4g/7odmOU+016c0KvtzVpEX/zS6
        WN7g2aQTWccy0801bi6LM8XMO000IvULM4v5i5APIsjylQiBS3H8CJFnB9bV2vws
        guhzECP9VxdGWjhW2ZkXygBD2cXmpaGmZBfOIfUo8r07ouAKJPaF2z4GA15x/+8M
        n+YsI8Wx6HrhkiiKF7gyhHuDQquoswTwSrBhaOlrKg==
X-ME-Sender: <xms:QZ_zYkgQaZkPKw8JtSWIBwz6vNWku9vl9MqjBGGpTZmDOxuBH9IGmA>
    <xme:QZ_zYtC6snDGOa6mrvRLMdy-93orr09baR-9wBpGI7lADlAMHGcJ-60FPfcW7xTMv
    e7T6SKMXLtuWmKksvA>
X-ME-Received: <xmr:QZ_zYsHCEB9z1_b6YnGWuGDlnFmEV7roc5fGggXpgEBZ9ATbMG-C-ywEv6jOscqBEtAsdma45N1f4GAoa7mds781xm0gNAbM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegvddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:QZ_zYlS-63UCptcj1fEp1ZNjvHjt0bce7xWTP4hogKk2rjd36sJxEQ>
    <xmx:QZ_zYhxGE4xrlLKojS2ICOQ-aNFMEGNK5xqvKbKHU2bBXS0lywT51A>
    <xmx:QZ_zYj6e6F-ell4eS8bcMiK6iLM9_30ZCoMFOga4emjmHKycLwVd9g>
    <xmx:Qp_zYokX29Hu51nRVBWwF7ZxD-zykgNnZehGy0mL6zPu1dJ67UE65Q>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Aug 2022 08:06:25 -0400 (EDT)
Date:   Wed, 10 Aug 2022 07:06:24 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Update Facebook Bletchley BMC devicetree
Message-ID: <YvOfQEqj+XsYkuUH@heinlein.stwcx.org.github.beta.tailscale.net>
References: <20220810004338.329832-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DZeXxxwZnmqG9svL"
Content-Disposition: inline
In-Reply-To: <20220810004338.329832-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DZeXxxwZnmqG9svL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 10, 2022 at 12:43:36AM +0000, Potin Lai wrote:
> This patch series add modifications as below
> 1. add a IPMB node for USB debug card communication.
> 2. remove hdc1080 node due to incompatible 2nd source (si7021).=20
>=20
> Potin Lai (2):
>   ARM: dts: aspeed: bletchley: add USB debug card IPMB node
>   ARM: dts: aspeed: bletchley: remove hdc1080 node
>=20
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.31.1
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--DZeXxxwZnmqG9svL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmLznz4ACgkQqwNHzC0A
wRnPuQ/+PcGTpWhfDtWXamXrYywWWaX0ZK9HYuuwLnUyBv9SR9TL/MNpX6i8mKQ4
YyY5eiCc9Y9WDlO5sqc6rNluye39Yvo9C87QPRWNj0tjAm7sGwKMl0MuKLx0G0sQ
9l5Bi2I3MX6XRKnn1F0O/XlAoaG8vwSwK+9q+RYc5tqeZ/lZ5Creh54Egrh234gz
v3nbGIoN1dIkJFwOScUTzz9SPv/i2jLIzIFJ8yrZ+uDa0gOYLkQVLyRXSNKnFzHD
taWGhCHxEokkap+iIPjeWtzUgSli7Z/FsBwqZjNLPXGTbH1KxILuuB+ehrAqwXe2
yBgKVum4GdFLG2/7AEJgd+atBHQ9RadrrY3ufELtM8J5Bi29qs1jG1yRklqp9r3N
8c8zhU52qQXgMYXEQg6XIzXxZYR/qxb6DfebUJXBvJCGmr6fa3JrXmoEveqcWGpH
KTCPN8SeziJ7yoFR5nu8NTCg/mLQ5aXi8OefTMQI8hxi3MpdNV+TUf3JUsRhuDbn
lSQJu8MW7MFtafta+Xw2ljVQd8Wfwe2V9P3r9cDfXJZtxawVs2RJUjmjcLhutk/v
lcUY75KCnpUhTsdxtOOjWVfO8XMQVZ+JzqugkbkxrlbamFh8D6cjtvZu+PQEq0tW
f5uhyZhUjOYoGRN0borG4VItlm69bpUeUKOgbYbbfmDfk1CB0HU=
=egzp
-----END PGP SIGNATURE-----

--DZeXxxwZnmqG9svL--
