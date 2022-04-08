Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6684F99E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiDHPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiDHPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:54:48 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E224975
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:52:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 66so8091261pga.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U2m6sZvhn5jXhSxSuuwgVSE4PMt55EOgxxP4khF/1Ec=;
        b=rqYiT3mO7OAW/9pQb4Bv0jmpQfS3eQThb0XDj5b3ab7mzXEjdprjcShcxuFmmXYxPw
         JJdr4ZfdWgGPOYTo2KE8ojdNMognZ5Bx7rp+PFZ2PfJpp0HkoKyvF90wCoZ4HN/eP7iO
         nE1jkN09Bd203oHQTIed9RNZ39dBBGBvh8DY/oEV9y2K2nAXLtT7eWaUtXDoF2hxvzwP
         j7ExPvqldNrnhmOYGu8Gf05hnfDKnqgyOvGAoaDgD6tUhDMUCFRe2DnOXIguQYGAtHIo
         urdkVcXhNch9/79pJgcEQF1zCr2mZLdlhWzi03SrrAklbRF6H/5d4cMhsumVv3mF81Ih
         pwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2m6sZvhn5jXhSxSuuwgVSE4PMt55EOgxxP4khF/1Ec=;
        b=MgG8SXctu+WgOzGNEizOUUB5pcFKvYqas6ESmpL1GFUW5hEfZ2i40OZ0bB3H6nIg+e
         o2kSF375GCxIXlE+ShJeqcUIBgQbmnfnr6VmKepT0Cm9p3Nmh+HdZ4HxbIuF//Xd8dba
         hzrmm+b4E06mGZ+j8iDiR1En1Ir573N6/Bnn5Ja7ow9xUOp2xq/0sbu+O+fqYDnYCue5
         0H8SDGhDva+dbV/RGTKj1cNBJuKGMQe8eJ5areuYKC8upaNllSE+je5OM8w4ByaGMnKW
         cYvqzju9d0EoTsVSBAt3iKU9bcFQ43RXSwAF7+QNQopTPN03kigKZqgDtBttJHsuMfWM
         1VLg==
X-Gm-Message-State: AOAM533y8gH7elv110mIStvdL48MxsqHBAo0sJenqZSNslV8VwW3F2Ie
        uhAe9MbtTs/W7Tdtz/kn0s9dJMWmgz7lW2epnY/mbPTvxR1OiA==
X-Google-Smtp-Source: ABdhPJy9FQ6uYwPaN5CUJzHIkvpy40btXyZUV19mC607ZSdEGApt8HLJXEX4FQYr0a/7rGStv07GV6WmG+tncDWPau0=
X-Received: by 2002:a05:6a00:1307:b0:4b0:b1c:6fd9 with SMTP id
 j7-20020a056a00130700b004b00b1c6fd9mr20103097pfu.27.1649433164360; Fri, 08
 Apr 2022 08:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220407210411.8167-1-tharvey@gateworks.com> <20220407210411.8167-2-tharvey@gateworks.com>
 <be7fd7be-c65a-215c-df96-5a6eed52b5e7@linaro.org>
In-Reply-To: <be7fd7be-c65a-215c-df96-5a6eed52b5e7@linaro.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 8 Apr 2022 08:52:32 -0700
Message-ID: <CAJ+vNU1D5GowKH97mpS+zT97XTavbKfijt6P8KEHN8-DD+gtYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 12:13 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 23:04, Tim Harvey wrote:
> > The Gateworks GW7400 is an ARM based single board computer (SBC)
> > featuring:
> >  - i.MX8M Plus SoC
> >  - LPDDR4 DRAM
> >  - eMMC FLASH
>
> Thank you for your patch. There is something to discuss/improve.
>

Krzysztof,

Thanks for the review!

> (...)
>
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/linux-event-codes.h>
> > +#include <dt-bindings/leds/common.h>
> > +
> > +#include "imx8mp.dtsi"
> > +
> > +/ {
> > +     model = "Gateworks Venice GW74xx i.MX8MP board";
> > +     compatible = "gw,imx8mp-gw74xx", "fsl,imx8mp";
>
> Deprecated vendor prefix.

thanks - I wasn't aware 'gw' got deprecated. I will update to 'gateworks'.

I'm in the habit of using 'make dtbs W=1' to check for errors. Is
there something better I should be using that would catch this?

>
> > +
> > +     aliases {
> > +             ethernet0 = &eqos;
> > +             ethernet1 = &fec;
> > +             ethernet2 = &lan1;
> > +             ethernet3 = &lan2;
> > +             ethernet4 = &lan3;
> > +             ethernet5 = &lan4;
> > +             ethernet6 = &lan5;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = &uart2;
> > +     };
> > +
> > +     memory@40000000 {
> > +             device_type = "memory";
> > +             reg = <0x0 0x40000000 0 0x80000000>;
> > +     };
> > +
> > +     gpio-keys {
> > +             compatible = "gpio-keys";
> > +
> > +             user-pb {
>
> Generic node names please, so "key-0" or "user-pb-key" (although adding
> specific parts is really not needed, because you have the label).

ok

>
> > +                     label = "user_pb";
> > +                     gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <BTN_0>;
> > +             };
> > +
> > +             user-pb1x {
> > +                     label = "user_pb1x";
> > +                     linux,code = <BTN_1>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <0>;
> > +             };
> > +
> > +             key-erased {
> > +                     label = "key_erased";
> > +                     linux,code = <BTN_2>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <1>;
> > +             };
> > +
> > +             eeprom-wp {
> > +                     label = "eeprom_wp";
> > +                     linux,code = <BTN_3>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <2>;
> > +             };
> > +
> > +             tamper {
> > +                     label = "tamper";
> > +                     linux,code = <BTN_4>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <5>;
> > +             };
> > +
> > +             switch-hold {
> > +                     label = "switch_hold";
> > +                     linux,code = <BTN_5>;
> > +                     interrupt-parent = <&gsc>;
> > +                     interrupts = <7>;
> > +             };
> > +     };
> > +
> > +     led-controller {
> > +             compatible = "gpio-leds";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_gpio_leds>;
> > +
> > +             led-0 {
> > +                     function = LED_FUNCTION_STATUS;
>
> LED_FUNCTION_HEARTBEAT

yes, thanks for catching this

>
> > +                     color = <LED_COLOR_ID_GREEN>;
> > +                     gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "on";
> > +                     linux,default-trigger = "heartbeat";
> > +             };
> > +
> > +             led-1 {
> > +                     function = LED_FUNCTION_STATUS;
> > +                     color = <LED_COLOR_ID_RED>;
> > +                     gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
> > +                     default-state = "off";
> > +             };
> > +     };
> > +
> > +     pps {
> > +             compatible = "pps-gpio";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_pps>;
> > +             gpios = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> > +             status = "okay";
>
> No need for status.

ok. What is the best way to know if a binding uses status or not?

Documentation/devicetree/bindings/net/fsl,fec.yaml for example does
not mention it uses status, yet it does.

Best Regards,

Tim
