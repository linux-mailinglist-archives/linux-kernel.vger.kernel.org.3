Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB156B9D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiGHMgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbiGHMgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:36:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237417C1A6;
        Fri,  8 Jul 2022 05:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D856271D;
        Fri,  8 Jul 2022 12:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DE9C341CB;
        Fri,  8 Jul 2022 12:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657283771;
        bh=hq0+B/dAKE6KAtx/w8/pzHOgIoBA3D5lqFzL4AAZuD0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oszWAku0C+PsBkcHAWimhkDNHJmcX4DGcNbiIuPC97mm+hQp3UNk68L+XMeRTGwyi
         iRpcSXZKS/mWe/Q7AIGIujWDCIHszuz369g9mKkKm5lpdFtXwj4zD8oDnBvv59RRxa
         h9EZsRzRFunJJa1pT+K1aIImOmqlGe3VmpTmnbthscUIY52de6/UAmcJ7g0H5+0Qcu
         cgOhf5uWTsaaTskZUL1wOECszcwH1v4us+aJju3wULm3dkUgC85zccKr3gpnrA/JzG
         i5Cce56flAuxGHq3aWpM0iKuGqjWZRk+qkHMf765TQurQHKnlY8I5GZPy8BFAnQS+v
         4xvVp0DSbOyMg==
Date:   Fri, 8 Jul 2022 20:35:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
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
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 00/15] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <20220708083952.GV819983@dragon>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:50:07PM +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Changes since v7: https://lore.kernel.org/lkml/20220704161541.943696-1-viorel.suman@oss.nxp.com/
>   * added missing Reviewed-By: 
>   * Defined "mboxes" and "mbox-names" sections in scu-key.yaml as schema.
> 
> Changes since v6: https://lore.kernel.org/lkml/20220629164414.301813-1-viorel.suman@oss.nxp.com/
>   * The series updated so that each patch making the conversion removes
>     the piece being converted, then finally the patch adding fsl,scu.yaml
>     removes the last pieces, as suggested by Krzysztof Kozlowski.
>   * Updated ocotp and system-controller node names in the existing DTS
>     files
> 
> Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
>   * Updated according to Krzysztof Kozlowski comments
> 
> Changes since v4: https://lore.kernel.org/lkml/20220615105834.743045-1-viorel.suman@nxp.com/
>   * Missing SoB added
> 
> Changes since v3: https://lore.kernel.org/lkml/20220609143423.2839186-1-abel.vesa@nxp.com/
>   * Examples included
>   * Included Abel's patches fixing thermal zone, keys and power controller names.
> 
> Abel Vesa (12):
>   dt-bindings: clk: imx: Add fsl,scu-clk yaml file
>   dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
>   dt-bindings: input: Add fsl,scu-key yaml file
>   dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
>   dt-bindings: power: Add fsl,scu-pd yaml file
>   dt-bindings: rtc: Add fsl,scu-rtc yaml file
>   dt-bindings: thermal: Add fsl,scu-thermal yaml file
>   dt-bindings: watchdog: Add fsl,scu-wdt yaml file
>   dt-bindings: firmware: Add fsl,scu yaml file
>   arm64: dts: freescale: imx8: Fix power controller name
>   arm64: dts: freescale: imx8qxp: Add fallback compatible for clock
>     controller
>   arm64: dts: freescale: imx8qxp: Fix the keys node name
> 
> Viorel Suman (3):
>   arm64: dts: freescale: imx8qxp: Remove unnecessary clock related
>     entries
>   arm64: dts: freescale: imx8qxp: Fix the ocotp node name
>   arm64: dts: freescale: imx8: Fix the system-controller node name

I'm preparing material for the next merge window, so just picked the
series up.  If there is more outstanding review comments coming up,
let's address them with follow-up changes.

Shawn
