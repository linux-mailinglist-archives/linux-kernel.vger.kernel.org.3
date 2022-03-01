Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3B4C8FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiCAQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbiCAQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:13:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754E5381AB;
        Tue,  1 Mar 2022 08:12:46 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e10so3742339wro.13;
        Tue, 01 Mar 2022 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCu9DONguPVLG9KShu2urgawLVKj86g3lH15A0jHk78=;
        b=Ht/F5O9IDN9+Y9LPlvZocbFNBP2xIyG7hL2sSDvBc3JinqPTnk8rZ6okvBFEt9jh7S
         dBEsmahv1gj6yx/Amyam1GXt+k/zIUXicffnQijOKoJnqmShbJW4S1yGK+O8yr0rUD1z
         pdMmxgoGGBN9tczYsRCOJ9XlcuE8/9bqD6u+Ow7oM6Y23lOFDiu4pbDgSdbXaEO0NfN3
         9tzzvqaua+fhoqpkXTdElMHtH5OC266ueaksC7TGo3KMQuxT2q23NqcSmG8F509bfiyW
         KlKodZ/l/6HIWfLs+k3ve/lKGINVMp3FvDby8n0xqdC/vTFPw9DnRH2HJCicgrz7gQFW
         DgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCu9DONguPVLG9KShu2urgawLVKj86g3lH15A0jHk78=;
        b=Bw8BjI5rpHsxnLMOkOCGMZJQrV1dKHYOAIHy9AylNLSnO+q8TA8vk9W4yj+dQbAOs0
         Hk8wnqPPH1w4ZfhcQr52fLHlvKACfJiTJ+R9I3YCYiYVRWPiwGydmmefuTN6g2jCockR
         FyNSoXTFFutZzRRMtuoce4ZYYIucWeWPWzv0WG7CKaJtiyQUEmkYNk6VNTn52gbQBcKM
         0O4NNO1H27BjSV7qRbbmBOg4SN2tTCyWA39TNjFUAmdguz+KOVOJAWVz2XzIsla3NsM4
         hPiVd+qgUnDsfkRxa/E61m/WcN45MLhOXPxulX4eURVfF0eD47F3CIf6UNW3gX6el+pm
         NVdA==
X-Gm-Message-State: AOAM532oww8Xek/2KwwAyOAD+Krx6PZr/q1193IcYkxBpU8/sFSniCde
        Sx8v4R+zrfMi3CPE+ZWqqqIkWL1le/oO6JVz37M=
X-Google-Smtp-Source: ABdhPJwLwDboy/fqrYPZ/JgOHB8oEAMqMilpm2ldz68+Nx9YmiJS2JkE5/sX29DL8EiP9ORlIZXovmMcBpgwhFG62D8=
X-Received: by 2002:a5d:550d:0:b0:1ed:c155:6c2a with SMTP id
 b13-20020a5d550d000000b001edc1556c2amr19993743wrv.470.1646151164906; Tue, 01
 Mar 2022 08:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20220228132523.2679099-1-michael@walle.cc>
In-Reply-To: <20220228132523.2679099-1-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 1 Mar 2022 17:12:33 +0100
Message-ID: <CAEyMn7aTKTguzEd-UNNb+-a30t5YBzkhXXBEKL360q10x-t9vg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mn-evk: add QSPI flash
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael

Am Mo., 28. Feb. 2022 um 14:25 Uhr schrieb Michael Walle <michael@walle.cc>:
>
> There is a 32MiB Micron MT25QU256ABA1 serial NOR flash on the EVK board.
> Add a device tree node for it.
>
> Tested on a 8MNANOD3L-EVK.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index c3f15192b76c..dc75d6d13bb3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -110,6 +110,22 @@ vddio: vddio-regulator {
>         };
>  };
>
> +&flexspi {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flexspi>;
> +       status = "okay";
> +
> +       flash0: flash@0 {
> +               compatible = "jedec,spi-nor";
> +               reg = <0>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               spi-max-frequency = <166000000>;
> +               spi-tx-bus-width = <4>;
> +               spi-rx-bus-width = <4>;
> +       };
> +};
> +
>  &i2c1 {
>         clock-frequency = <400000>;
>         pinctrl-names = "default";
> @@ -267,6 +283,17 @@ MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22   0x19
>                 >;
>         };
>
> +       pinctrl_flexspi: flexspigrp {
> +               fsl,pins = <
> +                       MX8MN_IOMUXC_NAND_ALE_QSPI_A_SCLK               0x1c2
> +                       MX8MN_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B            0x82
> +                       MX8MN_IOMUXC_NAND_DATA00_QSPI_A_DATA0           0x82
> +                       MX8MN_IOMUXC_NAND_DATA01_QSPI_A_DATA1           0x82
> +                       MX8MN_IOMUXC_NAND_DATA02_QSPI_A_DATA2           0x82
> +                       MX8MN_IOMUXC_NAND_DATA03_QSPI_A_DATA3           0x82
> +               >;
> +       };
> +
>         pinctrl_gpio_led: gpioledgrp {
>                 fsl,pins = <
>                         MX8MN_IOMUXC_NAND_READY_B_GPIO3_IO16    0x19
> --
> 2.30.2
>
