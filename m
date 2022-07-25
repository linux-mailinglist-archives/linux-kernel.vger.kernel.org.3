Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6A657FDCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiGYKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbiGYKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:45:06 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA31901E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:45:02 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31d85f82f0bso104680367b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aKx3Msrq+s+y9mYNcxVF8vbFN9EPmo0z/oU2A68VSY=;
        b=QBB0Eo5EkZYi16jq5eoMKCYzhmlpCg73Eory7A6lJ34fORy0V3Be8MFgNEC2OlizZm
         oTz8bW7m8pX9m1CofV63J+vzldeuK7qhseQqQmq0rirQhhQgXHnCWgpYlfhS40bk8at0
         /GXXBLDkwuZ0ZPjwG2li2/KVG1Hpw8sAjUMTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aKx3Msrq+s+y9mYNcxVF8vbFN9EPmo0z/oU2A68VSY=;
        b=LN9kV5L6GjhyCJVY9R6rIMKhmq6KWVXNwOvTSgR3WETKhLI0/Lr54+VkNqTxVOuFb/
         KYeqch8mLRdnDYPnpxOvr5aEvVwJxyoQ1KBXBlFJeRCiD56C8PX/8jhBLw4UYWS3CIAi
         f26B7NDi22KJGeG38ZYoOYCPDj2C/If3YLkMnXh8kUofWG5T99LBz5ONnt2As9/YiHWh
         Jr5pNmMWY3afGSKBi2cxly6RzhUYovSiUGO+wdmKzYs7mYJcH+nu+QEHPGZxcs+mYORG
         3fA41x0A5DrBNGKb3u0qjwNd4NJvFsqls9M2NUXfCsgUTwzsf7dsSRDGm8otlAsJul6S
         UlmQ==
X-Gm-Message-State: AJIora/tlD+cpMkDroGcO7RgCPYOp7hnvXaSgWtKK4nyWpvLS3XgRRja
        RvQPMQOqvc/ktBi0VsF6GiIZakb8VZZu3JfGfLFptA==
X-Google-Smtp-Source: AGRyM1t5wl38LCFoE0KK1Lk3m9hfYWYsWTC9fAO+AnUHo26LJJheP9DxfS3VlGBsVu5iHs135JZ76usF6EvrEVoAwbs=
X-Received: by 2002:a81:1e52:0:b0:31e:9401:ef34 with SMTP id
 e79-20020a811e52000000b0031e9401ef34mr9192015ywe.273.1658745901650; Mon, 25
 Jul 2022 03:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com> <20220721145017.918102-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721145017.918102-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 18:44:50 +0800
Message-ID: <CAGXv+5E+6aCz3dxsfCqZAOkcmqDp0YWngsv-OZ23NDYhuZSfHw@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] arm64: dts: mediatek: cherry: Enable DSP, audio
 codec and sound card
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:53 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All machines of the Cherry platform have a working DSP (integrated
> into the MT8195 SoC), and audio support, some with a different audio
> codec: specifically, some using Realtek's RT5682I and some RT5682S.
>
> Write a configuration for all the audio bits to enable functionality.

I think we're still missing some code for SOF that implements the
machine_select() callback, plus the firmware has to be fetched from
the ChromeOS rootfs.

It might make sense to have SOF disabled for now. Removing the adsp
reference and the overriding dai-link entry from the sound node
should do the trick.


ChenYu

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  10 ++
>  .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  10 ++
>  .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  10 ++
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 117 ++++++++++++++++++
>  4 files changed, 147 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> index 3348ba69ff6c..2d5e8f371b6d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> @@ -10,6 +10,16 @@ / {
>         compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
>  };
>
> +&audio_codec {
> +       compatible = "realtek,rt5682i";
> +       realtek,btndet-delay = <16>;
> +};
> +
> +&sound {
> +       compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
> +       model = "mt8195_r1019_5682";
> +};
> +
>  &ts_10 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> index 4669e9d917f8..2586c32ce6e6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> @@ -10,6 +10,11 @@ / {
>         compatible = "google,tomato-rev2", "google,tomato", "mediatek,mt8195";
>  };
>
> +&audio_codec {
> +       compatible = "realtek,rt5682i";
> +       realtek,btndet-delay = <16>;
> +};
> +
>  &pio_default {
>         pins-low-power-hdmi-disable {
>                 pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
> @@ -30,6 +35,11 @@ pins-low-power-pcie0-disable {
>         };
>  };
>
> +&sound {
> +       compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
> +       model = "mt8195_r1019_5682";
> +};
> +
>  &ts_10 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> index 5021edd02f7c..f54f9477b99d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> @@ -11,6 +11,11 @@ / {
>                      "google,tomato", "mediatek,mt8195";
>  };
>
> +&audio_codec {
> +       compatible = "realtek,rt5682s";
> +       realtek,amic-delay-ms = <250>;
> +};
> +
>  &pio_default {
>         pins-low-power-hdmi-disable {
>                 pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
> @@ -31,6 +36,11 @@ pins-low-power-pcie0-disable {
>         };
>  };
>
> +&sound {
> +       compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
> +       model = "m8195_r1019_5682s";
> +};
> +
>  &ts_10 {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 58349d4c3c8b..ca9955a97f8f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -25,6 +25,12 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       dmic_codec: dmic-codec {
> +               compatible = "dmic-codec";
> +               num-channels = <2>;
> +               wakeup-delay-ms = <50>;
> +       };
> +
>         memory@40000000 {
>                 device_type = "memory";
>                 reg = <0 0x40000000 0 0x80000000>;
> @@ -116,9 +122,49 @@ scp_mem: memory@50000000 {
>                         reg = <0 0x50000000 0 0x2900000>;
>                         no-map;
>                 };
> +
> +               adsp_mem: memory@60000000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x60000000 0 0xd80000>;
> +                       no-map;
> +               };
> +
> +               afe_mem: memory@60d80000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x60d80000 0 0x100000>;
> +                       no-map;
> +               };
> +
> +               adsp_device_mem: memory@60e80000 {
> +                       compatible = "shared-dma-pool";
> +                       reg = <0 0x60e80000 0 0x280000>;
> +                       no-map;
> +               };
> +       };
> +
> +       spk_amplifier: rt1019p {
> +               compatible = "realtek,rt1019p";
> +               label = "rt1019p";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&rt1019p_pins_default>;
> +               sdb-gpios = <&pio 100 GPIO_ACTIVE_HIGH>;
>         };
>  };
>
> +&adsp {
> +       status = "okay";
> +
> +       memory-region = <&adsp_device_mem>, <&adsp_mem>;
> +};
> +
> +&afe {
> +       status = "okay";
> +
> +       mediatek,etdm-in2-cowork-source = <2>;
> +       mediatek,etdm-out2-cowork-source = <0>;
> +       memory-region = <&afe_mem>;
> +};
> +
>  &i2c0 {
>         status = "okay";
>
> @@ -152,6 +198,17 @@ &i2c2 {
>         clock-frequency = <400000>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c2_pins>;
> +
> +       audio_codec: codec@1a {
> +               /* Realtek RT5682i or RT5682s, sharing the same configuration */
> +               reg = <0x1a>;
> +               interrupts-extended = <&pio 89 IRQ_TYPE_EDGE_BOTH>;
> +               realtek,jd-src = <1>;
> +
> +               AVDD-supply = <&mt6359_vio18_ldo_reg>;
> +               MICVDD-supply = <&pp3300_z2>;
> +               VBAT-supply = <&pp3300_z5>;
> +       };
>  };
>
>  &i2c3 {
> @@ -256,6 +313,11 @@ &mmc1 {
>         vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
>  };
>
> +&mt6359codec {
> +       mediatek,dmic-mode = <1>;  /* one-wire */
> +       mediatek,mic-type-0 = <2>; /* DMIC */
> +};
> +
>  /* for CPU-L */
>  &mt6359_vcore_buck_reg {
>         regulator-always-on;
> @@ -463,6 +525,34 @@ &pio {
>                 "AP_SPI_FLASH_MOSI",
>                 "AP_SPI_FLASH_MISO";
>
> +       aud_pins_default: audio-default-pins {
> +               pins-cmd-dat {
> +                   pinmux = <PINMUX_GPIO69__FUNC_AUD_CLK_MOSI>,
> +                            <PINMUX_GPIO70__FUNC_AUD_SYNC_MOSI>,
> +                            <PINMUX_GPIO71__FUNC_AUD_DAT_MOSI0>,
> +                            <PINMUX_GPIO72__FUNC_AUD_DAT_MOSI1>,
> +                            <PINMUX_GPIO73__FUNC_AUD_DAT_MISO0>,
> +                            <PINMUX_GPIO74__FUNC_AUD_DAT_MISO1>,
> +                            <PINMUX_GPIO75__FUNC_AUD_DAT_MISO2>,
> +                            <PINMUX_GPIO0__FUNC_TDMIN_MCK>,
> +                            <PINMUX_GPIO1__FUNC_TDMIN_DI>,
> +                            <PINMUX_GPIO2__FUNC_TDMIN_LRCK>,
> +                            <PINMUX_GPIO3__FUNC_TDMIN_BCK>,
> +                            <PINMUX_GPIO60__FUNC_I2SO2_D0>,
> +                            <PINMUX_GPIO49__FUNC_I2SIN_D0>,
> +                            <PINMUX_GPIO50__FUNC_I2SO1_MCK>,
> +                            <PINMUX_GPIO51__FUNC_I2SO1_BCK>,
> +                            <PINMUX_GPIO52__FUNC_I2SO1_WS>,
> +                            <PINMUX_GPIO53__FUNC_I2SO1_D0>;
> +               };
> +
> +               pins-hp-jack-int-odl {
> +                       pinmux = <PINMUX_GPIO89__FUNC_GPIO89>;
> +                       input-enable;
> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +               };
> +       };
> +
>         cr50_int: cr50-irq-default-pins {
>                 pins-gsc-ap-int-odl {
>                         pinmux = <PINMUX_GPIO88__FUNC_GPIO88>;
> @@ -707,6 +797,21 @@ pins-low-power-pupd {
>                 };
>         };
>
> +       rt1011_pins_default: rt1011-default-pins {
> +               pins-spk {
> +                       pinmux = <PINMUX_GPIO94__FUNC_GPIO94>,
> +                                <PINMUX_GPIO100__FUNC_GPIO100>;
> +                       output-high;
> +               };
> +       };
> +
> +       rt1019p_pins_default: rt1019p-default-pins {
> +               pins-amp-sdb {
> +                       pinmux = <PINMUX_GPIO100__FUNC_GPIO100>;
> +                       output-low;
> +               };
> +       };
> +
>         scp_pins: scp-default-pins {
>                 pins-vreq {
>                         pinmux = <PINMUX_GPIO76__FUNC_SCP_VREQ_VAO>;
> @@ -779,6 +884,18 @@ cros-ec-rpmsg {
>         };
>  };
>
> +&sound {
> +       status = "okay";
> +
> +       mediatek,adsp = <&adsp>;
> +       mediatek,dai-link =
> +               "DL10_FE", "DPTX_BE", "ETDM1_IN_BE", "ETDM2_IN_BE",
> +               "ETDM1_OUT_BE", "ETDM2_OUT_BE","UL_SRC1_BE",
> +               "AFE_SOF_DL2", "AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&aud_pins_default>;
> +};
> +
>  &spi0 {
>         status = "okay";
>
> --
> 2.35.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
