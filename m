Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3535AC5B6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbiIDRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiIDRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:22:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F8D32DAF;
        Sun,  4 Sep 2022 10:22:28 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUtKC-0000tW-4g; Sun, 04 Sep 2022 19:22:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: (subset) [PATCH v5 0/5] RK3568 PCIe V3 support
Date:   Sun,  4 Sep 2022 19:22:18 +0200
Message-Id: <166231195329.2423948.2237968885556290321.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825193836.54262-1-linux@fw-web.de>
References: <20220825193836.54262-1-linux@fw-web.de>
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

On Thu, 25 Aug 2022 21:38:31 +0200, Frank Wunderlich wrote:
> This series adds Rockchip PCIe V3 support found on rk3568 SOC.
> 
> Compared to PCIeV2 which uses the Naneng combphy, PCIe v3 uses a dedicated
> PCI-phy.
> 
> Frank Wunderlich (4):
>   dt-bindings: phy: rockchip: add PCIe v3 phy
>   dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
>   arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
>   arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
      commit: 4e441643b32249b4dac89be063255957f3d2938c
[4/5] arm64: dts: rockchip: rk3568: Add PCIe v3 nodes
      commit: faedfa5b40f095d09040c3a040e2f8dee4a36b4b
[5/5] arm64: dts: rockchip: Add PCIe v3 nodes to BPI-R2-Pro
      commit: 86973ae0355bc302d5e4c10fa382f6801feb4b90

As stated in the separate mail, I've added the -regulator
suffixes to the regulator node names.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
