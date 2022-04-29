Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E351514F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378351AbiD2PZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378337AbiD2PZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:25:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001884CD48
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:22:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i5so11201409wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BLvBmPgWkNIYBzQnMsLjrqJ6Q+Wo6mPOinOOp47QPLM=;
        b=ggJGd8qKt0ELuTvuMsbWNZtzSIw9cGxyNauKWCMmtHioFLC20Rc/OmS7a7krR8bwlh
         06MV7aFOWcmY9ZSq18dLu7TDzMa+yDXAUB1N/0PYfmmdhQPzzRfProzG6hiP8eVix5oe
         Dyj5cDIG9yE45kT+TvfwqlprC1UXuyed54SQ47VfpKCakjesL943hVZK9hHKGVWcPj4F
         9rHtNWzb6K2FNXItMTONP3YVZv31FwkqLwkBYps2pyh9quG0/oahmhTLwnywmBLtY/gK
         F9iF3XvdrY33ZOXBN/J5HJJL/kMB3lXLyqZ3SJNNH4/HbUOitp416cQt5ey7Fgc0k01u
         88Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BLvBmPgWkNIYBzQnMsLjrqJ6Q+Wo6mPOinOOp47QPLM=;
        b=g034j7Cf4MI7gKI36EKXi+VXvr6phCZoiQgV06yLrL4QQOjqNSuvV11p/5DfK+iGZu
         Sna22Rsew/ALYT0KevvL05oOAXTYQj8VKQmMOeW54AF1x3yCZA3Hdi4Ic7ZRG3njFsR+
         6QbNGWsHc0JFZsyVlqMEaRf3CiddkN1/8nLhuoI2cvoxd6K+CQu7n6G0NARBiSg0iqbS
         VjMPu0XsIkvpzjkKkuMHQfAAD/4Js9pQntNINosQZDLSrM241FRQc2+PciIdLauiJigP
         856DE81IuiUWw7ltwRhjSmu76F2XR+rXIOoaHDV606DPR1bs4Xn4dJgkelx8vcNnrG4U
         +T3w==
X-Gm-Message-State: AOAM533yrel6hBu8141kb3t9DPyyToFbX4mfBjhAQrHHR7sdepvxowWc
        dY2TEzUZT3f+RmiUCytDHBEuew==
X-Google-Smtp-Source: ABdhPJyxAaDV29Pk5q4lL8bvqoUXIkNNDFy+Jel6MnDtQTC/NHbbOczZsAk1AeP9vUrxlLUEo7TeZg==
X-Received: by 2002:adf:f745:0:b0:20a:c43b:3dfe with SMTP id z5-20020adff745000000b0020ac43b3dfemr29754985wrp.117.1651245730494;
        Fri, 29 Apr 2022 08:22:10 -0700 (PDT)
Received: from radium ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm3579793wml.5.2022.04.29.08.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:22:09 -0700 (PDT)
Date:   Fri, 29 Apr 2022 17:22:03 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt8195-demo: enable ethernet
Message-ID: <20220429152203.ppuimwcka5d6rvq4@radium>
References: <20220426134106.242353-1-fparent@baylibre.com>
 <20220426134106.242353-6-fparent@baylibre.com>
 <c0cf89c05ee708ec3648b267c1c0a0baa1331836.camel@mediatek.com>
 <f4256b5e-e6b8-f9de-fe97-3e9c6cdcb00c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzoq53ieck3g4u4f"
Content-Disposition: inline
In-Reply-To: <f4256b5e-e6b8-f9de-fe97-3e9c6cdcb00c@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lzoq53ieck3g4u4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 04:00:32PM +0200, Matthias Brugger wrote:
>=20
>=20
> On 27/04/2022 08:25, Macpaul Lin wrote:
> > On Tue, 2022-04-26 at 15:41 +0200, Fabien Parent wrote:
> > > Enable ethernet on the MT8195 demo board.
> > >=20
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > ---
> > >   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 108
> > > +++++++++++++++++++
> > >   1 file changed, 108 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > index 08cab3b3943b..0b7985486e2a 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> > > @@ -80,6 +80,30 @@ optee_reserved: optee@43200000 {
> > >   	};
> > >   };
> > > +&eth {
> > > +	phy-mode =3D "rgmii-rxid";
> > > +	phy-handle =3D <&eth_phy>;
> > > +	snps,reset-gpio =3D <&pio 93 GPIO_ACTIVE_HIGH>;
> > > +	snps,reset-delays-us =3D <0 10000 10000>;
> > > +	mediatek,tx-delay-ps =3D <2030>;
> > > +	pinctrl-names =3D "default", "sleep";
> > > +	pinctrl-0 =3D <&eth_default_pins>;
> > > +	pinctrl-1 =3D <&eth_sleep_pins>;
> > > +	status =3D "okay";
> > > +
> > > +	mdio {
> > > +		compatible =3D "snps,dwmac-mdio";
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> > > +
> > > +		eth_phy: phy@1 {
> > > +			compatible =3D "ethernet-phy-id001c.c916";
> > > +			#phy-cells =3D <0>;
> > > +			reg =3D <0x1>;
> > > +		};
> > > +	};
> > > +};
> > > +
> > >   &i2c6 {
> > >   	clock-frequency =3D <400000>;
> > >   	pinctrl-0 =3D <&i2c6_pins>;
> > > @@ -260,6 +284,90 @@ &mt6359_vsram_others_ldo_reg {
> > >   };
> > >   &pio {
> > > +	eth_default_pins: eth-default-pins {
> > > +		pins-cc {
> > > +			pinmux =3D <PINMUX_GPIO85__FUNC_GBE_TXC>,
> > > +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
> > > +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
> > > +				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
> > > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > > +		};
> > > +
> > > +		pins-mdio {
> > > +			pinmux =3D <PINMUX_GPIO89__FUNC_GBE_MDC>,
> > > +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
> > > +			input-enable;
> > > +		};
> > > +
> > > +		pins-phy-reset {
> > > +			pinmux =3D <PINMUX_GPIO93__FUNC_GPIO93>;
> > > +		};
> > > +
> > > +		pins-power {
> > > +			pinmux =3D <PINMUX_GPIO91__FUNC_GPIO91>,
> > > +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> > > +			output-high;
> > > +		};
> > > +
> > > +		pins-rxd {
> > > +			pinmux =3D <PINMUX_GPIO81__FUNC_GBE_RXD3>,
> > > +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
> > > +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
> > > +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
> > > +		};
> > > +
> > > +		pins-txd {
> > > +			pinmux =3D <PINMUX_GPIO77__FUNC_GBE_TXD3>,
> > > +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
> > > +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
> > > +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
> > > +			drive-strength =3D <MTK_DRIVE_8mA>;
> > > +		};
> > > +	};
> > > +
> > > +	eth_sleep_pins: eth-sleep-pins {
> > > +		pins-cc {
> > > +			pinmux =3D <PINMUX_GPIO85__FUNC_GPIO85>,
> > > +				 <PINMUX_GPIO88__FUNC_GPIO88>,
> > > +				 <PINMUX_GPIO87__FUNC_GPIO87>,
> > > +				 <PINMUX_GPIO86__FUNC_GPIO86>;
> > > +		};
> > > +
> > > +		pins-mdio {
> > > +			pinmux =3D <PINMUX_GPIO89__FUNC_GPIO89>,
> > > +				 <PINMUX_GPIO90__FUNC_GPIO90>;
> > > +			input-disable;
> > > +			bias-disable;
> > > +		};
> > > +
> > > +		pins-phy-reset {
> > > +			pinmux =3D <PINMUX_GPIO93__FUNC_GPIO93>;
> > > +			input-disable;
> > > +			bias-disable;
> > > +		};
> > > +
> > > +		pins-power {
> > > +			pinmux =3D <PINMUX_GPIO91__FUNC_GPIO91>,
> > > +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> > > +			input-disable;
> > > +			bias-disable;
> > > +		};
> > > +
> > > +		pins-rxd {
> > > +			pinmux =3D <PINMUX_GPIO81__FUNC_GPIO81>,
> > > +				 <PINMUX_GPIO82__FUNC_GPIO82>,
> > > +				 <PINMUX_GPIO83__FUNC_GPIO83>,
> > > +				 <PINMUX_GPIO84__FUNC_GPIO84>;
> > > +		};
> > > +
> > > +		pins-txd {
> > > +			pinmux =3D <PINMUX_GPIO77__FUNC_GPIO77>,
> > > +				 <PINMUX_GPIO78__FUNC_GPIO78>,
> > > +				 <PINMUX_GPIO79__FUNC_GPIO79>,
> > > +				 <PINMUX_GPIO80__FUNC_GPIO80>;
> > > +		};
> > > +	};
> > > +
> > >   	gpio_keys_pins: gpio-keys-pins {
> > >   		pins {
> > >   			pinmux =3D <PINMUX_GPIO106__FUNC_GPIO106>;
> >=20
> > Tested-by: Macpaul Lin <macpaul.lin@mediatek.com>
> >=20
>=20
> I get the following error:
> Error: arch/arm64/boot/dts/mediatek/mt8195.dtsi:582.26-27 syntax error

I think he used my upstreaming branch where I store the patches I sent
and will send to the mailing list: [0].

I forgot there is a dependency between this patch and [1], and I forgot
to test this patch serie independenly from the other commits from my
branch. I will make sure to not forget next time.

So from this patch serie, only patch 1-2, 6-7 can be applied since they
don't have any hidden dependency:
  dt-bindings: usb: mediatek,mtu3: add binding for MT8195 SoC
  arm64: dts: mediatek: mt8195: add ssusb support
  arm64: dts: mediatek: mt8195-demo: Remove input-name property
  arm64: dts: mediatek: mt8195-demo: enable uart1

[0] https://github.com/Fabo/linux/tree/mt8195-demo
[1] https://lore.kernel.org/all/20210615173233.26682-7-tinghan.shen@mediate=
k.com/

>=20
>=20
>=20
> How did you test?
>=20
> Regards,
> Matthias

--lzoq53ieck3g4u4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmJsApoACgkQVJKc6g3C
eADspw/+L2GTNsHF9vIW29/RPamW2SwAH5iyxGmnDfgAGPU5P2dIVC+TQv4bGPCf
YCF58yZGnNRljB7gUISwbBpq+fXSsU0rusTqNV7HYTDQV55MAUt+qYUPHsJjTWLC
NcrUEf532RGv2uD/fSaQlMsfx55KZUepAkljPrvesjiRB55zrJQeEFO/cCdPsEMG
e9Dx/+uZC1HR0zgy35FuuSvQLAXEuLQP+i10NDfpNAb2Fx9dQGeQnGsLlLv80NUP
h7p4kJpytmrMVI0qRnj9i9boAOaJQyA/3HXpZqxN68QeRWS5nnx/3SsFedpwjqRK
8IWz8DveEwUi1fxO7TjajgNPdKj6FuZWSoPTxg+Rl1uQzBSsYADidZ7JwyB/qH/w
JbY1q+OlN/KJ8yx0eSQa6sFrjNIMbljcb0NJ4/FTWsnxI6UZ+93GbwpnPJ/MTc3J
dX3G86mla/+lWLjz99e9bbgQndoXvPk0smBGM2roZYd5O5vzbP+CVBF63UXIOlCy
jGOKd8fDRSMCRYSU56AV7WMdwbgzAMJ7sZmqF8OIZqJFfo7jijv/U500jmP++bQq
7sFaQcyvLFr75yNXNiBBAJgNjHcfM1zz3BQaWL62XoA7hqZ4wMdWNPz9dBu5A89x
jxawIrm5GhlRAugRaKYFPoOoDyEGtIWqRQHp8ja2m8Fiibtn5g8=
=u18v
-----END PGP SIGNATURE-----

--lzoq53ieck3g4u4f--
