Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0854C4A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiBYQGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242557AbiBYQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:06:10 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD22211306;
        Fri, 25 Feb 2022 08:05:36 -0800 (PST)
Received: from [185.156.123.69] (helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nNd63-0001VJ-HI; Fri, 25 Feb 2022 17:05:31 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, p.zabel@pengutronix.de,
        cl@rock-chips.com, kishon@ti.com, lee.jones@linaro.org,
        kever.yang@rock-chips.com, jbx6244@gmail.com, vkoul@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        wulf@rock-chips.com, devicetree@vger.kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        david.wu@rock-chips.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v8 0/4] Add Naneng combo PHY support for RK3568
Date:   Fri, 25 Feb 2022 17:05:25 +0100
Message-Id: <164580511526.1386065.12014105022399448660.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 17:13:22 +0800, Yifeng Zhao wrote:
> This phy can be used as pcie-phy, usb3-phy, sata-phy or sgmii-phy.
> 
> Changes in v8:
> - rename 'mode' to 'type'
> - using devm_reset_control_array_get_exclusive
> - move rockchip_combphy_set_mode into rockchip_combphy_init
> 
> [...]

Applied, thanks!

[4/4] arm64: dts: rockchip: add naneng combo phy nodes for rk3568
      commit: 3cc8cd2d25954ed5794df2d190b81c7325c584e3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
