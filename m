Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085DE565D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiGDSKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 14:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGDSKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 14:10:38 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71689636A;
        Mon,  4 Jul 2022 11:10:35 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C715EE000A;
        Mon,  4 Jul 2022 18:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656958234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bbTMYur9hGe+to/gtv00HbU/WaQ6VXCyohWjpUEuf0E=;
        b=eyxcpojn5k/20aWTArkinYNnHoOORfNkzn+tGURVbE2BmPQ8FhFXfE3NbRa9CF1Pdate3e
        52J3akmoXPD4S9uhzJb8PV6ZzGOK5pw9KLefDDwa5QSagsUjzHvBUheJMg+3uk4PItYtaJ
        lsRujrtpvnARhqrh8tTcik9rTHEbj1VuG8jGvLRcaP4YL8OfuTopouHTblRrHI/92GERCB
        1myPKjPf2gU2TjxW8diEIN/YKIiuNTHSUfK3dzJj8V7LErA3q1cNE/divpVopVx8qQp8VY
        4dhQgBKBN//kXCCWTr8+QTQOwob06pEsMaJ0QR4m4OAW6IkbgDEB2y7zgQ5VOg==
Date:   Mon, 4 Jul 2022 20:10:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
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
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v7 06/15] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Message-ID: <YsMtFhctM19giyAj@mail.local>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
 <20220704161541.943696-7-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704161541.943696-7-viorel.suman@oss.nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 19:15:32+0300, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'rtc' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

You had a reviewed-by, please add it in the subsequent series or it may
be lost.

> ---
>  .../bindings/arm/freescale/fsl,scu.txt        | 10 ------
>  .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 31 +++++++++++++++++++
>  2 files changed, 31 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 1a06f627b125..6c0161fa4adf 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -62,12 +62,6 @@ i.MX SCU Client Device Node:
>  
>  Client nodes are maintained as children of the relevant IMX-SCU device node.
>  
> -RTC bindings based on SCU Message Protocol
> -------------------------------------------------------------
> -
> -Required properties:
> -- compatible: should be "fsl,imx8qxp-sc-rtc";
> -
>  Watchdog bindings based on SCU Message Protocol
>  ------------------------------------------------------------
>  
> @@ -116,10 +110,6 @@ firmware {
>  			  &lsio_mu1 1 3
>  			  &lsio_mu1 3 3>;
>  
> -		rtc: rtc {
> -			compatible = "fsl,imx8qxp-sc-rtc";
> -		};
> -
>  		watchdog {
>  			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
>  			timeout-sec = <60>;
> diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> new file mode 100644
> index 000000000000..8c102b70d735
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: i.MX SCU Client Device Node
> +  Client nodes are maintained as children of the relevant IMX-SCU device node.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8qxp-sc-rtc
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rtc {
> +        compatible = "fsl,imx8qxp-sc-rtc";
> +    };
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
