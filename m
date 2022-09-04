Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026065AC5B1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiIDRWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIDRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:22:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D95C32DA8;
        Sun,  4 Sep 2022 10:22:26 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUtKC-0000tW-KT; Sun, 04 Sep 2022 19:22:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: (subset) [PATCH 0/3] Add support for the RK356x variant of the Inno CSI DPHY
Date:   Sun,  4 Sep 2022 19:22:19 +0200
Message-Id: <166231195329.2423948.9487093007732976186.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 11:15:24 +0200, Michael Riesch wrote:
> This series adds support for the variant of the Innosilicon MIPI CSI DPHY that
> can be found in Rockchip RK356x SoCs.
> 
> Please note that only the basic operating mode is supported, in which all four
> CSI lanes are controlled by the Rockchip ISP. Split lane operation (e.g., two
> lanes to ISP and two lanes to VICAP) is not supported.
> 
> [...]

Applied, thanks!

[3/3] arm64: dts: rockchip: add csi dphy node to rk356x
      commit: b6c228401b2565b7bd59ad7418074145cdaa316a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
