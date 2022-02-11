Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E854B3063
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354072AbiBKW0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:26:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242658AbiBKW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:26:03 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76148D4C;
        Fri, 11 Feb 2022 14:26:01 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 45A4132005D8;
        Fri, 11 Feb 2022 17:16:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 11 Feb 2022 17:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=3mHNaDPBXVWvJ7Z+tc/LeGGmMFQxwPXBNxws6X
        ffobk=; b=PwtFXfKewLhU9TC8tuHmii5T+A/ShI/BXQCXNmBRJSqfARbuimym3u
        BAGkdGfQUx12f4hl/NzIQQ5wQlQ6mOPPJdcHBmuGVY4QAEXQHnx1RtVQF/O9V0jM
        0+3lX0LvYy8EiM2ENqozDn/ZNvaTdQpVqaA0X0l1g46QJXVOEHTut6ZxsPiv6gGK
        hitLUOU/Ubzm7Ec2SWCWSqRR7Ildwf0qiXAKFAXirmlNSg6sQPIwnLRdQsOXaFV4
        oNsMX581PV03AUyrOvOFlp63D6VjL0FSL6sQiSLGnaOYmNEOGbtbknGXqXCesBPp
        5sH9ZBDgPikuahP2yd6ZEH/ffhcJnxEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3mHNaDPBXVWvJ7Z+t
        c/LeGGmMFQxwPXBNxws6Xffobk=; b=iV+9NQ7G5rHOAB3C6OIQ+uWzLS0ZtKxET
        eLVJ9XQBygrw8U2RfgyZ66gzVLwPdj8EogPgqDrNdVkgjQVNFPhVU1TfVKM8Hfi1
        BgMnmVoQOAJ5C4eSJ8U0REo8l19VFtakYy/NZ5x7Oili+7Q/Q/5MMFkDzg6ETMoa
        vg6Spy0SpOY/F06il3OurT0MCgTT827t+XFZKXn3PmtMNLKuof6OEeOx8oo8q6Hj
        dVctFFTmg8yflsd3xvLKXT+2YjQYILYavaDzK4KlgqnFfoYusOZpu/YBDeHDBMtp
        /Tx8v/PPgj4azOXd76J1hxHOkO/hq7kaOV+vONZEbs5083i0dM/vQ==
X-ME-Sender: <xms:N-AGYiAQcRpjGDeSRayA8ZViMBppXi-FI3GNKAdTfZ6ZHB85Iry3qA>
    <xme:N-AGYsi5FrzFO5oIowMwq7r3K_F67czQWgBFYZCIIzzmMBVi8wbjAOarCHwJ6hyBh
    BuGJZJ8E-3C75JIMKc>
X-ME-Received: <xmr:N-AGYlkiVyyhYr607COVirjtJCYBCDSY8cDCuur0iGG3CgXU8NeINh1afznuiW-vTTk6Sd8mF5dbS5D0sVF9Bv3DEcY7IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepgeehheefffegkeevhedthffgudfh
    geefgfdthefhkedtleffveekgfeuffehtdeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:N-AGYgwC5UbU5oEeaHWncAFBNmA4KGJVOYIUGVhCijuhxsYvE5n5fA>
    <xmx:N-AGYnRrrHY7vvP5Ui_GXa0be6FRl5qIHf0ARRZnhBfM7IXjCSCZNg>
    <xmx:N-AGYraUypeOXrBUTTNLVe8m5h8Fig7ykXpYbPsLRkp-VzpE42oXDg>
    <xmx:OOAGYmG9wpJIqnUl0SiEJNBz_EVv4MENHsmxcZN3qbPfoka3VyVw-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:16:23 -0500 (EST)
Date:   Fri, 11 Feb 2022 16:16:22 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] arch: arm: dts: bletchley: update gpio-line-names
Message-ID: <YgbgNrgEtG4PFxeB@heinlein>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
 <20220211014347.24841-4-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pdX/T1chGUmw2hjx"
Content-Disposition: inline
In-Reply-To: <20220211014347.24841-4-potin.lai@quantatw.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pdX/T1chGUmw2hjx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 09:43:40AM +0800, Potin Lai wrote:
> update gpio-line-names for gpio0 and all io expander

It would be good to describe what kind of update(s) you are doing.  I see m=
ostly
pins being added.  Maybe a bullet-point of what ones you are adding?

>=20
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  .../dts/aspeed-bmc-facebook-bletchley.dts     | 26 ++++++++++---------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/a=
rm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index ebd2430a3bdd..fc0690ccdb0a 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -270,7 +270,7 @@
>  		#gpio-cells =3D <2>;
> =20
>  		gpio-line-names =3D
> -		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","",
> +		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM=
",
>  		"","","","",
>  		"","","","",
>  		"","","","";
> @@ -333,7 +333,7 @@
>  		#gpio-cells =3D <2>;
> =20
>  		gpio-line-names =3D
> -		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","",
> +		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM=
",
>  		"","","","",
>  		"","","","",
>  		"","","","";
> @@ -400,7 +400,7 @@
>  		#gpio-cells =3D <2>;
> =20
>  		gpio-line-names =3D
> -		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","",
> +		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM=
",
>  		"","","","",
>  		"","","","",
>  		"","","","";
> @@ -463,7 +463,7 @@
>  		#gpio-cells =3D <2>;
> =20
>  		gpio-line-names =3D
> -		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","",
> +		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM=
",
>  		"","","","",
>  		"","","","",
>  		"","","","";
> @@ -526,7 +526,7 @@
>  		#gpio-cells =3D <2>;
> =20
>  		gpio-line-names =3D
> -		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","",
> +		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM=
",
>  		"","","","",
>  		"","","","",
>  		"","","","";
> @@ -589,7 +589,7 @@
>  		#gpio-cells =3D <2>;
> =20
>  		gpio-line-names =3D
> -		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","",
> +		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM=
",
>  		"","","","",
>  		"","","","",
>  		"","","","";
> @@ -727,16 +727,17 @@
>  	/*D0-D7*/	"","","","","","","","",
>  	/*E0-E7*/	"","","","","","","","",
>  	/*F0-F7*/	"","","","","","","","",
> -	/*G0-G7*/	"","SWITCH_FRU_MUX","","","","","","",
> +	/*G0-G7*/	"BSM_FRU_WP","SWITCH_FRU_MUX","","",
> +			"PWRGD_P1V05_VDDCORE","PWRGD_P1V5_VDD","","",
>  	/*H0-H7*/	"presence-riser1","presence-riser2",
>  			"presence-sled1","presence-sled2",
>  			"presence-sled3","presence-sled4",
>  			"presence-sled5","presence-sled6",
>  	/*I0-I7*/	"REV_ID0","","REV_ID1","REV_ID2",
> -			"","","","",
> +			"","BSM_FLASH_WP_STATUS","BMC_TPM_PRES","",
>  	/*J0-J7*/	"","","","","","","","",
>  	/*K0-K7*/	"","","","","","","","",
> -	/*L0-L7*/	"","","","","","","","",
> +	/*L0-L7*/	"","","","","","BMC_RTC_INT","","",
>  	/*M0-M7*/	"ALERT_SLED1","ALERT_SLED2",
>  			"ALERT_SLED3","ALERT_SLED4",
>  			"ALERT_SLED5","ALERT_SLED6",
> @@ -744,19 +745,20 @@
>  	/*N0-N7*/	"","","","","","","","",
>  	/*O0-O7*/	"","","","",
>  			"","BOARD_ID0","BOARD_ID1","BOARD_ID2",
> -	/*P0-P7*/	"","","","","","","","",
> +	/*P0-P7*/	"","","","","","","","BMC_HEARTBEAT",
>  	/*Q0-Q7*/	"","","","","","","","",
>  	/*R0-R7*/	"","","","","","","","",
>  	/*S0-S7*/	"","","","BAT_DETECT",
>  			"BMC_BT_WP0","BMC_BT_WP1","","",
>  	/*T0-T7*/	"","","","","","","","",
>  	/*U0-U7*/	"","","","","","","","",
> -	/*V0-V7*/	"","RST_BMC_MVL","","",
> +	/*V0-V7*/	"PWRGD_CNS_PSU","RST_BMC_MVL","","PSU_PRSNT",
>  			"USB2_SEL0_A","USB2_SEL1_A",
>  			"USB2_SEL0_B","USB2_SEL1_B",
>  	/*W0-W7*/	"RST_FRONT_IOEXP","","","","","","","",
>  	/*X0-X7*/	"","","","","","","","",
> -	/*Y0-Y7*/	"","","BSM_FLASH_LATCH","","","","","",
> +	/*Y0-Y7*/	"BMC_SELF_HW_RST","BSM_PRSNT","BSM_FLASH_LATCH","",
> +			"","","","",
>  	/*Z0-Z7*/	"","","","","","","","";
>  };
> =20
> --=20
> 2.17.1
>=20

--=20
Patrick Williams

--pdX/T1chGUmw2hjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmIG4DQACgkQqwNHzC0A
wRmFxQ/7BP0tmHuExLDEMi1UP1A95bZblDpoIsLu4Y7phQDuSxEmREoUORx7jq1W
jP7aOtt8Mvr0xXxi98JgXW7x9Cm8zTNQil/R3woUlJZfEOQTJO30zvgnfRsdaxKG
1+vUVk+jgehuVdA3L8BNJe1RmlWwwIBFfpFP9b0PJZ1p3x6ZcFScAZMCyR6paIY5
73xxCLM8Hh+RwIuqJaxtw/XiuFjFSRcsDT8qjbCuCabED221anjaZdxw0x035c2S
TRt8UISyWs9tJLoDvz2PxIn5/N9eZ+BZ1Ahj7sinkHI7MotIptFTQeFEMP74pPZ1
EX76NCa2at4b/QT47quHlhY8BEajd/bLg19uxmP6NmzJTENzQ+vaehWfmkkvwqQL
XWgnUF++ajLYhbVjd6wRnS9MxH/QpkOYOrXCS71YBjPextsD4++vSOFzX3bwFZEf
DGjgSJJ5JP3ZLPm+xMk5+aefvPGOg/pzPmyhBeM+BC8D6l+ADk+r0bIzDVSZBTd0
z9P2enP0kJbv4aibxvyxZQm+zCshEJye7zv39qb3h+RIwaniv4M+e/r9CauiDJk4
b+SHy/q3OOs7gsY+lEH0NhibDfT1VTWso4KUZhOEKobgjH0nJuc/rRa/JVcMR1sJ
ATYbxUOFLVLgj5mIohTVI4f0Nmcch1+WPzJYi5LVfrBpx2ja/Fw=
=9kDy
-----END PGP SIGNATURE-----

--pdX/T1chGUmw2hjx--
