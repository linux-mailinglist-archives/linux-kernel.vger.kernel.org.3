Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A763155B225
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 15:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiFZNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 09:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiFZND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 09:03:27 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8E11A1D;
        Sun, 26 Jun 2022 06:03:25 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id e7so6568923vsp.13;
        Sun, 26 Jun 2022 06:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=wgB3yUfs+v8g1TK2ZKMTbiAV4yHoQXrOoYl0KZd3ozw=;
        b=gv1z+h+lb+BPXB5dtpuaCPm7IHDPOMHHu38I+CqG7GWyjUE2jHcZt7K3GW2JlI5wmN
         /NNRxIpTXAhlABzIRHLbiIFIqAswboQq15NKWfdd/UFZoF29eLab9eYfAs/CIpT3WGS4
         hrM5XHMU9SpcsMPo0EIstpmZG3iFhyti53z9lprzLdk0gLfz1f9GQxUvuhVDuDVX9/6w
         L9W3QbIX9ChdCNaRlcAiJTYDYbuoOdANkfcxajoc4XUHayQWcpPfkwuVmp3+m5QUvqT+
         yWCLLMa5ALK/ceFeIAgvoCv73S8ZCIm0Mm69zuY/tspnG4WfHBVVOYsUHyA5O2uVjhH+
         9HxQ==
X-Gm-Message-State: AJIora9i2RTGfIYSdFY0dIH/fzvUcNl5ACjliVFtKdfB5wTL+v6avgJ8
        KwDgaN8aJEODcB5ipR9OYgnCFj4AYuYpjg==
X-Google-Smtp-Source: AGRyM1uSCtYwflAqUfI+mjEcLwjsAAkaPthSJxyWVYfO88aTrNWZLZDLaLvoeiAxSuNmoTtmhyu4kA==
X-Received: by 2002:a67:15c7:0:b0:354:5037:dbf5 with SMTP id 190-20020a6715c7000000b003545037dbf5mr2639185vsv.28.1656248604282;
        Sun, 26 Jun 2022 06:03:24 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id r1-20020a1fa801000000b0036ca2afd7c9sm1356068vke.0.2022.06.26.06.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 06:03:24 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id m188so3344285vkm.3;
        Sun, 26 Jun 2022 06:03:23 -0700 (PDT)
X-Received: by 2002:a1f:5f8f:0:b0:36b:fdd7:7788 with SMTP id
 t137-20020a1f5f8f000000b0036bfdd77788mr3044394vkb.22.1656248603691; Sun, 26
 Jun 2022 06:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220621034224.38995-1-samuel@sholland.org> <20220621034224.38995-5-samuel@sholland.org>
In-Reply-To: <20220621034224.38995-5-samuel@sholland.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 26 Jun 2022 21:03:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Mrn88+w5kCbMn7Z23-UdyrTG-Q2cboPswMj=9z4HgrQ@mail.gmail.com>
Message-ID: <CAGb2v64Mrn88+w5kCbMn7Z23-UdyrTG-Q2cboPswMj=9z4HgrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: axp22x/axp809: Add GPIO controller nodes
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:42 AM Samuel Holland <samuel@sholland.org> wrote:
>
> These PMICs all contain a GPIO controller. Now that the binding is
> documented, wire up the controller in the device tree.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> (no changes since v1)
>
>  arch/arm/boot/dts/axp22x.dtsi | 18 ++++++++++++++++++
>  arch/arm/boot/dts/axp809.dtsi | 19 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
> index a020c12b2884..5c233c84be92 100644
> --- a/arch/arm/boot/dts/axp22x.dtsi
> +++ b/arch/arm/boot/dts/axp22x.dtsi
> @@ -67,6 +67,24 @@ battery_power_supply: battery-power {
>                 status = "disabled";
>         };
>
> +       axp_gpio: gpio {
> +               compatible = "x-powers,axp221-gpio";
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               /omit-if-no-ref/
> +               gpio0_ldo: gpio0-ldo-pin {
> +                       pins = "GPIO0";
> +                       function = "ldo";
> +               };
> +
> +               /omit-if-no-ref/
> +               gpio1_ldo: gpio1-ldo-pin {
> +                       pins = "GPIO1";
> +                       function = "ldo";
> +               };
> +       };
> +

We have

    reg_ldo_io0: ldo-io0 {
            pinctrl-names = "default";
            pinctrl-0 = <&gpio0_ldo>;
            /* Disable by default to avoid conflicts with GPIO */
            ...
    }

in axp81x.dtsi . Should we add it here and for axp803.dtsi as well?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
