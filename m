Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839F955550B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376806AbiFVTsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359444AbiFVTsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:48:14 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E492DD60;
        Wed, 22 Jun 2022 12:48:09 -0700 (PDT)
Received: from [46.183.103.8] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o46KG-0004LY-G0; Wed, 22 Jun 2022 21:47:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     soc@kernel.org, Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, openbmc@lists.ozlabs.org,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Tony Lindgren <tony@atomide.com>,
        Joel Stanley <joel@jms.id.au>, linux-arm-msm@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-aspeed@lists.ozlabs.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-input@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-omap@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
        Nishanth Menon <nm@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: (subset) [PATCH v3 00/40] dt-bindings: input: gpio-keys: rework matching children
Date:   Wed, 22 Jun 2022 21:47:36 +0200
Message-Id: <165592714968.3933570.9891201783444800337.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 17:52:24 -0700, Krzysztof Kozlowski wrote:
> Merging
> =======
> 1. dt-bindings: rebased on top of Rob's:
>    https://lore.kernel.org/all/20220608211207.2058487-1-robh@kernel.org/
> 
> 2. DTS patches are independent. They can be picked up directly by sub-arch
>    maintainers, by Arnd or Olof, or eventually by me (if you wish).
> 
> [...]

Applied, thanks!

[26/40] arm64: dts: rockchip: align gpio-key node names with dtschema
        commit: 517ed0ffd3cc691bef747288d51d01d2705b2251

        In the pinenote dts the original patch changed "cover" to
        switch, so to keep the cover information intact, I changed
        the node to "switch-cover" ... similar to other "switch-lid"
        instances in some other Rockchip devicetrees.

[27/40] ARM: dts: rockchip: align gpio-key node names with dtschema
        commit: 271e2c92285075a890c58cba9ad5979a8959f6ff
[28/40] ARM: dts: rockchip: rk3288-tinker: correct gpio-keys properties
        commit: e5a3cbe8b45b0a436a39cc969b7bcc8353248018

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
