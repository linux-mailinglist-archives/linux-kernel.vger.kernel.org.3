Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0F5215B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbiEJMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbiEJMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:47:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7A754FB5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:43:50 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e194so18328886iof.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZCHHeV1vrwaORolvlc++uou2W11D5cQmd9g7J8Duyo=;
        b=6r3ZTvcJXGB8tEPC11iQZMG1+0uwYhCNX2OEALTbsIShYvYKXO+ujmbx2NoBqkxg1k
         WACAKpdh9G32mfAQMsWhB8G7kGvN4sMELkFykG97HDSUrZW+1XFhdtB6km5Nq3DfAWTK
         szrgABXbRPdfJfZCnULIu0zGe5JrKftEhv3ajv76PD7uNNII+0/ZWWzrZI4+KLLfW3ij
         zJCxmoolia82c46FMh61IQKC6o7SspyCoGq9Er8ojL70p72Z1FVZEhmqM0oHrlpm6H1j
         nMiJ/I998OtM0Fz7WLzhZVZAoc7Mo3oZqwx6oQZJ2NlwguIvLixltnyOtM/7BrsBrGyF
         ekiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZCHHeV1vrwaORolvlc++uou2W11D5cQmd9g7J8Duyo=;
        b=RsMBQsEtabcm5xaC5YwwDT1AAZRVqcEMqlX/+98yayMuuXKSoWBKUrW20YTUT+O3fT
         D2cBYdAcXUpC4El1HXTQGPvg9XqE5/e2ZtWI48NBv5TcQcvfg+7Feid807hha9w5Xahh
         uZUgn0FoVpXYVq/G6zDD+VGapugEuwClNFLV0V6Xi0j07Eiwm3FEjrj5YL32l+Gh1BgP
         iP10BFHav0aZR/9X/Kk0xlxdNhl78/VQPd1exx/GQBIxvWX5jAIfrH9C5eWgo29KGrSe
         619fPvqKOrPheMIs+TctthOOAYZRTkAw0t3zfBKCwABufi71Sa9GxxSyavajOpev9uFH
         2O/w==
X-Gm-Message-State: AOAM530N2oEXyYiDuNK7+a3A/AZg9glNtXEhcoDFV1Y9ELQCUAQ/6N0X
        6lhniRGxwtGRlLU96SW8cH85dWoC6gikQGSXA5vlmA==
X-Google-Smtp-Source: ABdhPJzxGsE9e1jC8Gr1xp08AKX2vrG1wP1od8sZP/jQ77AsygZ0FDZToBhxBE3p/zMQL5yqtqmTuuWILEt9xoEE8C8=
X-Received: by 2002:a05:6638:34a2:b0:32b:7d4f:8932 with SMTP id
 t34-20020a05663834a200b0032b7d4f8932mr9877917jal.317.1652186629374; Tue, 10
 May 2022 05:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220509110028.144226-1-robert.marko@sartura.hr>
 <20220509110028.144226-2-robert.marko@sartura.hr> <8e22cbf7-eee1-0ec7-10f9-3839ec80dfbf@linaro.org>
 <CA+HBbNE1w5w6c8MwMuSwCFzjnyKOQ7Y0MV4bPijJW3rekWLo4w@mail.gmail.com> <fde74400-34aa-df80-5af5-cb4ee89c8e6f@linaro.org>
In-Reply-To: <fde74400-34aa-df80-5af5-cb4ee89c8e6f@linaro.org>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 10 May 2022 14:43:38 +0200
Message-ID: <CA+HBbNGWbGu73JtCb68QMhF6o9KrcfZH2AtOL6jUAnxrmCBcsQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: marvell: add support for Methode eDPU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        shawnguo@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        kostap@marvell.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 1:46 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/05/2022 13:41, Robert Marko wrote:
> > On Tue, May 10, 2022 at 12:20 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 09/05/2022 13:00, Robert Marko wrote:
> >>> Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.
> >>>
> >>> They feature the same CPU, RAM, and storage as well as the form factor.
> >>>
> >>> However, eDPU only has one SFP slot plus a copper G.hn port.
> >>>
> >>> In order to reduce duplication, split the uDPU DTS into a common one.
> >>>
> >>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >>> ---
> >>>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
> >>>  .../boot/dts/marvell/armada-3720-eDPU.dts     |  14 ++
> >>>  .../boot/dts/marvell/armada-3720-uDPU.dts     | 148 +---------------
> >>>  .../boot/dts/marvell/armada-3720-uDPU.dtsi    | 163 ++++++++++++++++++
> >>>  4 files changed, 179 insertions(+), 147 deletions(-)
> >>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>>  create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
> >>>
> >>> diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
> >>> index 1c794cdcb8e6..104d7d7e8215 100644
> >>> --- a/arch/arm64/boot/dts/marvell/Makefile
> >>> +++ b/arch/arm64/boot/dts/marvell/Makefile
> >>> @@ -1,6 +1,7 @@
> >>>  # SPDX-License-Identifier: GPL-2.0
> >>>  # Mvebu SoC Family
> >>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
> >>> +dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
> >>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
> >>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
> >>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
> >>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>> new file mode 100644
> >>> index 000000000000..6b573a6854cc
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
> >>> @@ -0,0 +1,14 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >>> +
> >>> +/dts-v1/;
> >>> +
> >>> +#include "armada-3720-uDPU.dtsi"
> >>> +
> >>> +/ {
> >>> +     model = "Methode eDPU Board";
> >>> +     compatible = "methode,edpu", "marvell,armada3720";
> >>
> >> You need also bindings for the board compatible. Someone should convert
> >> the Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt to YAML.
> >
> > Ok, I can convert the SoC compatibles at least for now.
> > Any advice you can give me on how the handle the Espressobin boards
> > having multiple board-specific compatibles?
> > For example, Espressobin V7 has:
> > "globalscale,espressobin-v7", "globalscale,espressobin"
> >
>
> Documentation/devicetree/bindings/arm/fsl.yaml

Thanks, now it makes sense.

>
> >>
> >>> +};
> >>> +> +  sfp_eth1: sfp-eth1 {
> >>
> >> Generic node names, please.
> >
> > Can you give me an example of what would be appropriate here because the SFP
> > bindings example utilizes the same naming scheme as used here?
>
> "sfp" if you have only one sfp node.

There are 2 SFP nodes in total, that is why they are named according
to the ethernet controller
to which they are connected.
uDPU has 2 SFP slots while eDPU has 1, so one was moved to uDPU DTS.

>
> >
> >>
> >>> +             compatible = "sff,sfp";
> >>> +             i2c-bus = <&i2c1>;
> >>> +             los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
> >>> +             mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
> >>> +             tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
> >>> +             tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
> >>> +             maximum-power-milliwatt = <3000>;
> >>> +     };
> >>> +};
> >>> +
> >>> +&sdhci0 {
> >>> +     status = "okay";
> >>> +     bus-width = <8>;
> >>> +     mmc-ddr-1_8v;
> >>> +     mmc-hs400-1_8v;
> >>> +     marvell,pad-type = "fixed-1-8v";
> >>> +     non-removable;
> >>> +     no-sd;
> >>> +     no-sdio;
> >>> +};
> >>> +
> >>> +&spi0 {
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default";
> >>> +     pinctrl-0 = <&spi_quad_pins>;
> >>> +
> >>> +     spi-flash@0 {
> >>
> >> Run dtbs_check and fix the errors.
> >
> > Ok, will split the DTSI and eDPU commits and fixup nodes in between.
> >>
> >>> +             compatible = "jedec,spi-nor";
> >>> +             reg = <0>;
> >>> +             spi-max-frequency = <54000000>;
> >>> +
> >>> +             partitions {
> >>> +                     compatible = "fixed-partitions";
> >>> +                     #address-cells = <1>;
> >>> +                     #size-cells = <1>;
> >>> +                     /* only bootloader is located on the SPI */
> >>> +                     partition@0 {
> >>> +                             label = "firmware";
> >>> +                             reg = <0x0 0x180000>;
> >>> +                     };
> >>> +
> >>> +                     partition@180000 {
> >>> +                             label = "u-boot-env";
> >>> +                             reg = <0x180000 0x10000>;
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&pinctrl_nb {
> >>> +     i2c2_recovery_pins: i2c2-recovery-pins {
> >>> +             groups = "i2c2";
> >>> +             function = "gpio";
> >>> +     };
> >>> +};
> >>> +
> >>> +&i2c1 {
> >>> +     status = "okay";
> >>> +     pinctrl-names = "default", "recovery";
> >>> +     pinctrl-0 = <&i2c2_pins>;
> >>> +     pinctrl-1 = <&i2c2_recovery_pins>;
> >>> +     /delete-property/mrvl,i2c-fast-mode;
> >>> +     scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >>> +     sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> >>> +
> >>> +     nct375@48 {
> >>
> >> Generic node names, representing class of a device.
> > Ok, will rename in v2.
> >>
> >>> +             status = "okay";
> >>
> >> OK status is by default, why do you need it? Also, it goes as last property.
> >
> > It's not needed, I have not changed any nodes, they are just
> > copy/paste during the DTS split.
> > Will drop it in v2.
> >
>
> Hm, but the node names were different in original DTS, so this is not a
> simple split. In such case better to correct coding styles in one patch
> (node names, status etc) and then perform the split. The split should
> create the same output DTB, which is not the case here.

Understood, I did all of the fixups now before the split to make it clear.

Regards,
Robert
>
> Best regards,
> Krzysztof



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
