Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D8567692
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiGESeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiGESeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:34:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAC71ADB5;
        Tue,  5 Jul 2022 11:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C0FB818C2;
        Tue,  5 Jul 2022 18:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F60C341D1;
        Tue,  5 Jul 2022 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657046049;
        bh=kIyot3zMyMDO8B1YVidHQ7qgbvG3Xa6UO0gOQL2C6Jg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JsU79BmfynIReY3T89cOgEH/6tFNiBBDFqKBs8oXNQm6/+g5IkfnSz6lnxKwnFqNS
         1j47RNad0YhesCc/SIiouNRpyt21tXxp+7UujB4zP8xtmbwRtNJauDkGspmgUyDhgl
         fn9thf0FJV9aayLYjrKzsPTW4fWtqpM+dZ3RveMpUH7WbnRHfbzb18F0miRMtdvQQg
         STNIB53IAwMygQuY6izE+2HL9mzZsy2/DnNlSXpayAhlmHiEb92zuAdqA/GH/jWeIU
         Jv7618fva2U+QU/c6uDzeyF1fZYZvuxpgXK3qTZ+hcZqIl+t9mRe/sRlTrt7BFed4l
         OpSgj1Sj26zAw==
Received: by mail-vs1-f49.google.com with SMTP id h7so12788288vsr.11;
        Tue, 05 Jul 2022 11:34:09 -0700 (PDT)
X-Gm-Message-State: AJIora9OmprPX2zAR5He1YiIY879nxCd15nKzisOw36K+FdtQEVDd53T
        u2U/rkYqhJcRMauGSRv2NZ54vf6RdkWSuCmyBQ==
X-Google-Smtp-Source: AGRyM1uIXQO86wcgJn/AvE4+AWlqrvIba5lSJyE0SPqE7mHdOeHYb1wL3dEnTAICHhhvz3Q4xUajqxFIJ9dC4e0p4xY=
X-Received: by 2002:a67:d194:0:b0:357:8ea:5554 with SMTP id
 w20-20020a67d194000000b0035708ea5554mr562557vsi.0.1657046048517; Tue, 05 Jul
 2022 11:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <20220629164414.301813-3-viorel.suman@oss.nxp.com> <f0634bf0-77e9-939e-693f-31d50af4768c@linaro.org>
 <20220630123754.esbuac4pfktlseh2@fsr-ub1664-116> <78faf75d-80b7-7a0e-e306-6351dbe5133c@linaro.org>
In-Reply-To: <78faf75d-80b7-7a0e-e306-6351dbe5133c@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 5 Jul 2022 12:33:57 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0GJBTVkS12XTvUKphMH4XuQ5AS1-QHMw6ULgpWbZBQQ@mail.gmail.com>
Message-ID: <CAL_Jsq+0GJBTVkS12XTvUKphMH4XuQ5AS1-QHMw6ULgpWbZBQQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux
 yaml file
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:33 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/06/2022 14:37, Viorel Suman (OSS) wrote:
> > On 22-06-29 19:53:51, Krzysztof Kozlowski wrote:
> >> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> >>> From: Abel Vesa <abel.vesa@nxp.com>
> >>>
> >>> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> >>> we need to split it between the right subsystems. This patch documents
> >>> separately the 'iomux/pinctrl' child node of the SCU main node.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> >>> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> >>> ---
> >>>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 68 +++++++++++++++++++
> >>>  1 file changed, 68 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> >>> new file mode 100644
> >>> index 000000000000..76a2e7b28172
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> > [...]
> >>> +      fsl,pins:
> >>> +        description:
> >>> +          each entry consists of 3 integers and represents the pin ID, the mux value
> >>> +          and config setting for the pin. The first 2 integers - pin_id and mux_val - are
> >>> +          specified using a PIN_FUNC_ID macro, which can be found in
> >>> +          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer CONFIG is
> >>> +          the pad setting value like pull-up on this pin. Please refer to the
> >>> +          appropriate i.MX8 Reference Manual for detailed CONFIG settings.
> >>> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >>
> >> Look at fsl,imx8mq-pinctrl.yaml. Each item is described (items under items).
> >
> > Added them initially, but later dropped because of some logs like
> > "pinctrl@xxxxxxx: usdhc1grp:fsl,pins:0: [...] is too long" shown by
> > "make dt_binding_check dtbs_check DT_SCHEMA_FILES=[...]/fsl,scu-pinctrl.yaml"
> >
> > Same logs are shown for "fsl,imx8mq-pinctrl.yaml". Will add the items description in the next
> > version.
> >
>
> The fsl,imx8mq-pinctrl.yaml should be correct and I don't see the reason
> why dtschema complains in some of the entries. It's like one define was
> not correct... I'll take a look at this later, but anyway keep the same
> as fsl,imx8mq-pinctrl.yaml even if it complains.

The issue is that 'fsl,pins' is problematic for the new dtb decoding
because it has a variable definition in terms of matrix bounds as each
i.MX platform has its own length (typ 5 or 6). The tools try to work
around it by figuring out which size fits. That works until there are
multiple answers which seems to be what's happening here.

The easiest solution I think is to just strip the constraints in
occurances of this property. I'll look into that.

Rob
