Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B357FBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbiGYIzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiGYIyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:54:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8F815700
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:54:53 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f73so18885740yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edgunyjtUM379vg3Bw9QbusNXUwODwix7GBUlK2cBH4=;
        b=LAb3jJwXo2g1wMoTMaTk8qlGLk+BgqSTGQMYheh5JIlQkSBkMyLupvlRq+isJx3pGe
         6mK2Z47OXKdGrfS/+rGV0Pfig8Q30++HmZDcoK2OQoQCWqS4MXIvnPVqUXHKvZsb5ngR
         domi0dPdGdVLhUXtW4uS4OhEJm19M2vQCvhSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edgunyjtUM379vg3Bw9QbusNXUwODwix7GBUlK2cBH4=;
        b=vlL+muJaK364nduPi2X9NoZt1V1HPDCXC1HkLpTYH72LvItnbY7xt7WL70jjfFB0Uu
         itmsUMrfomrdL9/mPSDIjPdfpsCE1s9G3cBr5Az6K2mF1fDNd/pFO/i5R8dQ5zQ8Edim
         dgE6vx8tHYTtodVY8fsRJemtKhKijc0LgetxPGAEx4qolNblftWNfp/D3BCYapW1RpWG
         0wN0IM0dk7nLADUdIxebcKp3abiEVeD00mPWtZdQK/ot5ThNmB3Wn0KxGptlZupqYxuH
         JuV5twtoC8Jv+l5iU6lT4nrkMIrcoXLupzpp2xv672umN+YrZlnwW/KKUo7Esd8I3G7/
         f3HA==
X-Gm-Message-State: AJIora+Cq8gmbJ629MCeJ8yYj9IRprwMy5loh0z01BBkkfxiZQonZly+
        g87y2+2wCrtKz8x3++CY4D7iijdIwZY+gxTrFQPtNH8tmvoX0w==
X-Google-Smtp-Source: AGRyM1s7JTPi63hLlXsZJp0NKHyjAYonLbIzzXNGyMHT8kVwt4FrTCIiemN3v706SuLB6YiD2mVG51cNjmaxho6Bf8A=
X-Received: by 2002:a25:9f87:0:b0:669:4345:a8c0 with SMTP id
 u7-20020a259f87000000b006694345a8c0mr8500898ybq.472.1658739292656; Mon, 25
 Jul 2022 01:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com> <20220721145017.918102-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721145017.918102-5-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 16:54:41 +0800
Message-ID: <CAGXv+5FutJb_MRwSVgjV7tByBvfq3AFsSxs6ETUZaNzrfpywgg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: mediatek: cherry: Enable secondary
 SD/MMC controller
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

On Thu, Jul 21, 2022 at 10:51 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> As of now, all of the boards based on the cherry platform have a
> usable secondary SD/MMC controller, usually for SD cards: enable
> it to allow both booting from it and generally accessing external
> storage.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 2853f7f76c90..8859957c7b27 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -17,6 +17,7 @@ aliases {
>                 i2c5 = &i2c5;
>                 i2c7 = &i2c7;
>                 mmc0 = &mmc0;
> +               mmc1 = &mmc1;
>                 serial0 = &uart0;
>         };
>
> @@ -227,6 +228,24 @@ &mmc0 {
>         vqmmc-supply = <&mt6359_vufs_ldo_reg>;
>  };
>
> +&mmc1 {
> +       status = "okay";
> +
> +       bus-width = <4>;
> +       cap-sd-highspeed;
> +       cd-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
> +       max-frequency = <200000000>;
> +       no-mmc;
> +       no-sdio;
> +       pinctrl-names = "default", "state_uhs";
> +       pinctrl-0 = <&mmc1_pins_default>;
> +       pinctrl-1 = <&mmc1_pins_uhs>;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
> +       vmmc-supply = <&mt_pmic_vmch_ldo_reg>;
> +       vqmmc-supply = <&mt_pmic_vmc_ldo_reg>;
> +};
> +
>  /* for CPU-L */
>  &mt6359_vcore_buck_reg {
>         regulator-always-on;
> @@ -575,6 +594,49 @@ pins-rst {
>                 };
>         };
>
> +       mmc1_pins_default: mmc1-default-pins {
> +               pins-cmd-dat {
> +                       pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> +                                <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> +                                <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> +                                <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> +                                <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> +                       input-enable;
> +                       drive-strength = <8>;
> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-clk {
> +                       pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> +                       drive-strength = <8>;
> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +               };
> +
> +               pins-insert {
> +                       pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
> +                       bias-pull-up;
> +               };
> +       };
> +
> +       mmc1_pins_uhs: mmc1-uhs-pins {
> +               pins-cmd-dat {
> +                       pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
> +                                <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
> +                                <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
> +                                <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
> +                                <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
> +                       input-enable;
> +                       drive-strength = <8>;
> +                       bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +               };
> +
> +               pins-clk {
> +                       pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
> +                       drive-strength = <8>;
> +                       bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +               };

I wonder if pins-insert should be duplicated here. And there's no
difference between the standard and UHS pinconfigs. One would expect
higher drive strength on the UHS set, if two sets were required.
So maybe we should just have one set, and use that one for both
the default and uhs states.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

> +       };
> +
>         nor_pins_default: nor-default-pins {
>                 pins-ck-io {
>                         pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
> --
> 2.35.1
>
>
