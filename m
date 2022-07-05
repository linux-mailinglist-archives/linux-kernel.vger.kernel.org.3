Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EEE56604D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiGEAkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGEAkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9892BEA;
        Mon,  4 Jul 2022 17:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25C4E616ED;
        Tue,  5 Jul 2022 00:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD839C3411E;
        Tue,  5 Jul 2022 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656981606;
        bh=SP8Jaem1tPIKC61mxYfgYhbEnJ0OUuIXySTXu0B8/J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQ1EZQO59cjvnku9rPPMRRLGYX9sCwIw7GGDkayK1eKN9UzbL6bRbTbzz8DVm8fWZ
         n1NDsUpT7LhXoKmX/ZTm8BDcsriryl3BG7moNtSmaPzmjytHc5GyDqxLQW2GWqXKd2
         U1jiha42NBbsbbmdINYFFRlHogMTxwbJfxODx5IStmMQ4Qzvj9fSvDbl7h5cb3RpmK
         FZgMbIV1GHxjpUFTvqUsiaQ0C/skH46cF2vN3/22l3wcoF8JdhgSDI0bFz/pGRee4C
         WMAofjVrFJDp8pbwJB8H8dxlEwrhYIXTm4Xfy5giTfCuVifST8kNCUgbrnuxTGpqH5
         nkM1TnJyy8BLA==
Date:   Tue, 5 Jul 2022 08:39:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/14] dt-bindings: arm: freescale: Switch fsl,scu
 from txt to yaml
Message-ID: <20220705003955.GO819983@dragon>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
 <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e515289-9d3c-9c61-950d-09c14b33c8c2@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:51:06PM +0200, Krzysztof Kozlowski wrote:
> On 29/06/2022 18:44, Viorel Suman (OSS) wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> > 
> > Changes since v5: https://lore.kernel.org/lkml/20220616164303.790379-1-viorel.suman@nxp.com/
> >   * Updated according to Krzysztof Kozlowski comments
> > 
> 
> My comment a about removal of each part of TXT bindings in each patch,
> was not addressed. Your approach makes it more difficult to read patches
> and makes sense only if each subsystem maintainer will take the patches
> (separately). If the patches are going through one tree, then better to
> remove the TXT gradually.
> 
> So the question - who is going to take each of the patches?

I can take the series through IMX tree if that makes the most sense.

Shawn
