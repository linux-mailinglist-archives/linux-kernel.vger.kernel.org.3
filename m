Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2C557FCCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiGYJ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiGYJ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:58:00 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4BF17049
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:57:58 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id d124so1704002ybb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQbkePjTZTGBHhHNdPkVayN1pzQM5oP8jjbvr/Dc6xc=;
        b=GKsMNthIl/nHv3s4pIAp4//iOle4vnauGjgQk5AiuZ/cN1ovOSttLGtV2WfD96BLIu
         U+HSskxdf09TYHGZnrR1NXnuQGq/VTyyawhImCx0qQYbk6hHsbuNOVdnj+c7/xYF4JTv
         O2/DrdAJDxBRjx11t/OjFDIlclwqmUqt1K6p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQbkePjTZTGBHhHNdPkVayN1pzQM5oP8jjbvr/Dc6xc=;
        b=XAEhBLCEH1nEiUQTsrs9Wr7ndHeGdZQB5g2vYKrE8MFRs5P8rDtOTeCxZZPlKSKAD2
         8H5XZlf/KpmwOM4I8DVLWh0DwRNQ/0AfTq5jmvgtcgdyx/dwOPW9N712Th8AdvxoXgFS
         NabPLOPKsEFwP2pqcOXofIBfHKmsG8jUNHNfrfRmXgHaZZGEp+RwNALCuYZI+KgkwgBv
         m52jvrArkU51yNRCBGOrW+6NgKI93XhmXy0NSlWW0ElaP3LueiFxuldnXeI7olEL9kQX
         CknHud32zWMHARhx5/EljNNV2VfosmLjHf4QIg1vh9cq9droo86J2oyWis667yko3dgg
         umAQ==
X-Gm-Message-State: AJIora8GlW2s7iHTE8t5bvwN7rJgTKaJLtdJMuZQd92pzUl1vXjT5Rs6
        ByKML+vIQ4duFTEaWiVGkqoHeRFaBjB9umFQpTZy0Q==
X-Google-Smtp-Source: AGRyM1vpw8Qdjvlaj8NOuT0GEe5Ha3tFWQOx0/4AUrT7WihQIvnc7eW1QgGSAz+MsXJC8OkWSPB0iyyHgW/yyITv/Vc=
X-Received: by 2002:a25:d852:0:b0:66f:259c:17b6 with SMTP id
 p79-20020a25d852000000b0066f259c17b6mr9047848ybg.438.1658743078168; Mon, 25
 Jul 2022 02:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com> <20220721145017.918102-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721145017.918102-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Jul 2022 17:57:47 +0800
Message-ID: <CAGXv+5FR-HdPc-_c18Svdx0aviR-+b4ikf6MfbzaLWCcF1catA@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] arm64: dts: mediatek: cherry: Enable keyboard PWM backlight
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

n Thu, Jul 21, 2022 at 10:53 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a pwm-leds node to enable the PWM controlled keyboard backlight.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index ca9955a97f8f..9086a440a995 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
>  #include "mt8195.dtsi"
>  #include "mt6359.dtsi"
>
> @@ -31,6 +32,18 @@ dmic_codec: dmic-codec {
>                 wakeup-delay-ms = <50>;
>         };
>
> +       led-controller {
> +               compatible = "pwm-leds";
> +
> +               keyboard_backlight: keyboard-backlight {
> +                       default-state = "off";
> +                       function = LED_FUNCTION_KBD_BACKLIGHT;
> +                       label = "cros_ec::kbd_backlight";
> +                       max-brightness = <1023>;
> +                       pwms = <&cros_ec_pwm 3>;
> +               };
> +       };
> +

This didn't work for me. However using "google,cros-kbd-led-backlight"
under the EC did. That might be a better option.

ChenYu

>         memory@40000000 {
>                 device_type = "memory";
>                 reg = <0 0x40000000 0 0x80000000>;
> --
> 2.35.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
