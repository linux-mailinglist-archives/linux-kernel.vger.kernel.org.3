Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1144B4CD9AE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiCDRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbiCDRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:05:31 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433C1CD7EA;
        Fri,  4 Mar 2022 09:04:40 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C1DC5C0294;
        Fri,  4 Mar 2022 12:04:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 04 Mar 2022 12:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=19N+V6o+FQXpDoOacL5Tst7trUS8I31eJl+exI
        QkyAA=; b=QzRfuJqGM6ZdcwMgmuN7etzIjqBRwQOL+z8zzpPWeHR8ZahsL0tzr4
        1yA6vZtEUn1Qp2tQYvdliAeErt6mnRd2RWyGLDLyw0kSJhzCyTN6quZwk75fhSC1
        z7OAjr7jpFi74YVR7vV6YmDowGdI5Of+uCoYaUHutAAArscXY677moChObN3sTbo
        9rcIu008b2p5bd+W2099U1UZg8lenDt+1yxzYfVKDkt466x+33Gk8PDKhMWxtueL
        WWwki6cR5DJrSCElIdV2HyxV0YkgVTnFV92kDU/o81uEsf9jwtVhGGNoP31G2gFe
        U1B2A5QLYi3VqRvkOFVkg8LktMCXHohg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=19N+V6o+FQXpDoOac
        L5Tst7trUS8I31eJl+exIQkyAA=; b=NfZxkzs/z2dP53kDlRr48k+zoDztkBRGq
        ZgqZL9c6HE4z4+mRUKWXQweWivvRrlv11Dm0txBu0bM8Euc3GVs1yWe33+uqRf4B
        owHF4ZW3BmeskJ3nSthhZw8hCJ2Mrzp3wk6hBJfPl42J+3cOmEEosZi+hLf9XqNC
        Klnufg8It1Cs2vuL7UFuL6YqTGoi41e0ZHjROV6gH4AwLFRBwZzjfQ5DTeQM5/RW
        ApAXys/aWi7Futu0IMYYZkWKBof+ic/P+cDvCEWKnOhs1pinmvsi6/RNKrVGlO7F
        SaNtDfrid0HDIOFEkpqyQiByTR8P4aoeHSKQ3NGDygk0NKmm9hWBg==
X-ME-Sender: <xms:pEYiYtoZoC9_jwKUEfNj3lS82mA2L8P3d3FWXtJDsOOBj2PXBQgZGQ>
    <xme:pEYiYvr5UkcLcN0vfPzjJXRCHX51Imdy1fKZpr20uDQpnGZ8ykT6zmRW-gJ85lnnQ
    hJ2ZTe5Yw15qORshXM>
X-ME-Received: <xmr:pEYiYqNjwyDHY-pos8tNeBIQSpbtvRmmQ5NsyDxQ8PKywmE115wkEav_Z1PXWuRHh5WtDTUzrgfJpo0oC4DQxWPSyHAvOye5wzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepvdffgefgfeetiefgtefhieevuedu
    gedvgffgjeefheduteejfeffteektdelhefhnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    rghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:pEYiYo5K3ffizSWnxKWJBo2BXFJ6wh2iIu0CLfeoSnQxT3U1cNRKeA>
    <xmx:pEYiYs4WYHVgVd6WoizmJFwvO-YGsAxac6B0O5Ry894RVMf7k8VZNg>
    <xmx:pEYiYghmNXkU0lAOJNDcVZLWDAFIDevssYBPo022ckIRgg0cJsm8OQ>
    <xmx:pUYiYpupD3roEySVQ7uILmXG96OkExFVYj_uXhFtmmvQfc8IU8GoDw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 12:04:36 -0500 (EST)
Date:   Fri, 4 Mar 2022 11:04:35 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ARM: dts: aspeed: bletchley: add sample averaging
 for ADM1278
Message-ID: <YiJGo7Tor3IKEToq@heinlein>
References: <20220304003506.4243-1-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VYm2G0+QLn/4yGoL"
Content-Disposition: inline
In-Reply-To: <20220304003506.4243-1-potin.lai@quantatw.com>
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VYm2G0+QLn/4yGoL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 04, 2022 at 08:35:06AM +0800, Potin Lai wrote:
> set number of sample averaging to 128 for both PWR_AVG and VI_AVG
>=20
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/a=
rm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index eaf1bc261ee3..be76cd955129 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -732,6 +732,8 @@
>  		compatible =3D "adi,adm1278";
>  		reg =3D <0x11>;
>  		shunt-resistor-micro-ohms =3D <300>;
> +		adi,volt-curr-sample-average =3D <128>;
> +		adi,power-sample-average =3D <128>;
>  	};
> =20
>  	tmp421@4c {
> --=20
> 2.17.1
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Note that this code depends on ADM1275 support pulled into groeck/linux-sta=
ging
already.

https://lore.kernel.org/all/20220222223610.23098-1-linux@roeck-us.net/

--=20
Patrick Williams

--VYm2G0+QLn/4yGoL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmIiRqMACgkQqwNHzC0A
wRnPgQ/8CvQ5AKgdzdynopTHa+Iz0ECeeFQi98vSMKhKUOdz9sHmItqjiEf9BtPa
lTYj0lPOrkAW+tkzN6hfLdhmWFg5z7z1vpWPqKRYhoVtORtjO/EATja3iEua4p2a
6JhUvRQXryduEwKvulEZ7CGbL8VgCaZTZHUrawdwEtfyQkmOxaLjfOtA/tksWmxU
aa5/OG06Dk3wV7HejScWSJXyLYt0Mv4+R0PQUOPuVIfHYx18hd7hPzsyuga2UuWw
yY11KcvA5Deyp5U195pUNDar9J2VrSe+fAAmuBqR214P7wC8qBK19dwx4j7qXfQt
kfWnbJs481DQas7uLBH4WxytuoWVslB1fTUQu6XWgCQj7jjcODKVdmuQZLRLXiz7
kiIPk/pqJWwZr5No300pbc0EfAsKKfdCuTjJe2chz3TmCkbky4opehVKTOafSB2o
UBMB1Nz2LL1l1Kwe2XDvViS0rbQlLw3sn82SO7ez+gXjjKh9OivelUgOhcPeRGTv
s48za2Nq3MUuaSbSBJaAB2NZaZ19zi8BnM9m5aohnYa3yzElW+yrHzHmx/rJdanZ
JqA9RoCmtB4krTFDeOAV+kAHUSSHK0HL3O0ecJViSKt70fM4jAHKJzoag2Fn5FMB
GrCRNd+OCs+H+y4Y0e6bBTEMbcycb5XWK8Z4XeyiWrcIkpkWsyQ=
=Uw+x
-----END PGP SIGNATURE-----

--VYm2G0+QLn/4yGoL--
