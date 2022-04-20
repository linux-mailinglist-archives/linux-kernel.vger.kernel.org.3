Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D1C50826B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376294AbiDTHoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiDTHn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:43:59 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5213B00E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:41:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8C5DB20002;
        Wed, 20 Apr 2022 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650440472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNCqHdoDiIIO8GrtVq7oJYoQzRKdLynJa7XVU5UOud4=;
        b=i/MXxswxLD8ta458UREAWTH+0ALFDKozqVuToRsulIqcGNM2YAptjjqKvLAiZz5e2gCndm
        nqgIMYpubMC1APg2m6WTDjD/Vr1Qlh6UnZ0VB1Z8jA0C6U9vNu7p/6L4Xa1k1r9yP/f5cc
        Y38ZhebeyKs5bP2uC++iRWh1dajZQgWbv2maBEy/L9zS1dDoCTkRP9I669nwiBMtdpvdH5
        FUFlJ/S6RDN7TraAHsce2Hd2joNQF2f57iF3u6iAGcORrGXLZ4JcOa8EuYypCrDv5/5xZo
        TJjB8vhalj11RjqP5K0Yy3yXK1X4BeuP22UxU5lHKoEWJb76svGcRlKTn2l+eA==
Date:   Wed, 20 Apr 2022 09:41:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: nand: meson: refine Amlogic NAND
 controller driver
Message-ID: <20220420094107.4799f15a@xps13>
In-Reply-To: <20220402074921.13316-3-liang.yang@amlogic.com>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
        <20220402074921.13316-3-liang.yang@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

liang.yang@amlogic.com wrote on Sat, 2 Apr 2022 15:49:20 +0800:

> convert txt to yaml and refine the meson NFC clock document.

We generally prefer to split this into two changes (yaml conversion
then modifications). You need to be very explicit on the changes you
bring to this file afterward. Also you may s/refine/fix/ in your title
if this really is a correction of something that does not work at all as
you suggest.

Please mention that due to the other series about the clock changes
never being accepted the current binding was never valid/working
(again, I'm not sure it's the case on all Amlogic SoCs, so please be
very careful about that).

And please use a Link: tag to point to the discussion with Neil and
Jerome on your MMC/NAND subclock final discussion.

> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt       | 60 --------------
>  .../bindings/mtd/amlogic,meson-nand.yaml      | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-n=
and.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-n=
and.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt=
 b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> deleted file mode 100644
> index 5794ab1147c1..000000000000
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> -
> -This file documents the properties in addition to those available in
> -the MTD NAND bindings.
> -
> -Required properties:
> -- compatible : contains one of:
> -  - "amlogic,meson-gxl-nfc"
> -  - "amlogic,meson-axg-nfc"
> -- clocks     :
> -	A list of phandle + clock-specifier pairs for the clocks listed
> -	in clock-names.
> -
> -- clock-names: Should contain the following:
> -	"core" - NFC module gate clock
> -	"device" - device clock from eMMC sub clock controller
> -	"rx" - rx clock phase
> -	"tx" - tx clock phase
> -
> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> -				controller port C
> -
> -Optional children nodes:
> -Children nodes represent the available nand chips.
> -
> -Other properties:
> -see Documentation/devicetree/bindings/mtd/nand-controller.yaml for gener=
ic bindings.
> -
> -Example demonstrate on AXG SoC:
> -
> -	sd_emmc_c_clkc: mmc@7000 {
> -		compatible =3D "amlogic,meson-axg-mmc-clkc", "syscon";
> -		reg =3D <0x0 0x7000 0x0 0x800>;
> -	};
> -
> -	nand-controller@7800 {
> -		compatible =3D "amlogic,meson-axg-nfc";
> -		reg =3D <0x0 0x7800 0x0 0x100>;
> -		#address-cells =3D <1>;
> -		#size-cells =3D <0>;
> -		interrupts =3D <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> -
> -		clocks =3D <&clkc CLKID_SD_EMMC_C>,
> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
> -		clock-names =3D "core", "device", "rx", "tx";
> -		amlogic,mmc-syscon =3D <&sd_emmc_c_clkc>;
> -
> -		pinctrl-names =3D "default";
> -		pinctrl-0 =3D <&nand_pins>;
> -
> -		nand@0 {
> -			reg =3D <0>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <1>;
> -
> -			nand-on-flash-bbt;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> new file mode 100644
> index 000000000000..965a2dd20645
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/amlogic,meson-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs

Maybe you need to inherit from nand-controller.yaml.

> +
> +maintainers:
> +  - liang.yang@amlogic.com
> +
> +properties:
> +  compatible:
> +    enum:
> +      - "amlogic,meson-gxl-nfc"
> +      - "amlogic,meson-axg-nfc"
> +
> +  reg:
> +    maxItems: 2
> +
> +  '#address-cells':
> +    const: 1

Not sure this property is needed.

> +
> +  '#size-cells':
> +    const: 0

Ditto. Plus, this one looks wrong anyway.

> +
> +  reg-names:
> +    items:
> +      - const: nfc
> +      - const: emmc

Why do you need the emmc register map? Do you really need to perform a
register access there?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: device
> +
> +  "#clock-cells":
> +    const: 1

?

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#address-cells'
> +  - '#size-cells'
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false

I will let Rob check that but I think what you need is

unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/axg-clkc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    apb {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;

Not sure you need this upper node in the example.

> +      nand-controller@7800 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        compatible =3D "amlogic,meson-axg-nfc";
> +        reg =3D <0x0 0x7800 0x0 0x100>,
> +              <0x0 0x7000 0x0 0x800>;
> +        reg-names =3D "nfc", "emmc";
> +
> +        interrupts =3D <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +        clocks =3D <&clkc CLKID_SD_EMMC_C>,
> +                 <&clkc CLKID_FCLK_DIV2>;
> +        clock-names =3D "core", "device";
> +
> +      };
> +    };
> +...


Thanks,
Miqu=C3=A8l
