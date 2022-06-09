Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1EE544B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245027AbiFIMEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiFIMEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9F368FAD;
        Thu,  9 Jun 2022 05:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31D93B82D47;
        Thu,  9 Jun 2022 12:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2DEC341C5;
        Thu,  9 Jun 2022 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776237;
        bh=S5g9QkaioS1LmOyC7q+wI7Npt3iFDlZoTjKlFeUKQyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRP1l9UCWUpMb/BJtM/d3o+moasB/Qk6d2QgT+ptF0OZqPWudpIkDSs7UfvgMNu2s
         NgAhXD0D9vA1LQhNjNLW6be1b3apg6SFCQFl5ODb7H92NW1a5YU0Kacu6FNLBrYHWW
         abUQMWF4rk4mWNhKnxXr9BDTVPh6Y0U6OGoeyOKOA9lIkv0p+WPRUPkWyLW48u8hi5
         JToQYwB1i1F158Fd3Es3vfj0mXDLAxz917nK7p9Yx9YXKgcCfS64yvKvtZxGQxSAkf
         AN3H4VITH0LX2xrbaSE8ZeI0AK46zJ6Z+U2q3ekV5CGCfGHJEq6SZftgffOJ1iW2yK
         ZQVEwcsSYMi5g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nzGtF-00014H-T1; Thu, 09 Jun 2022 14:03:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/3] phy: qcom-qmp: clean up hex defines
Date:   Thu,  9 Jun 2022 14:03:38 +0200
Message-Id: <20220609120338.4080-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609120338.4080-1-johan+linaro@kernel.org>
References: <20220609120338.4080-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use lower case hex consistently for define values.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index 6d410826ae90..3a4f150dd499 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -30,7 +30,7 @@
 #define QSERDES_PLL_CP_CTRL_MODE0			0x080
 #define QSERDES_PLL_CP_CTRL_MODE1			0x084
 #define QSERDES_PLL_PLL_RCTRL_MODE0			0x088
-#define QSERDES_PLL_PLL_RCTRL_MODE1			0x08C
+#define QSERDES_PLL_PLL_RCTRL_MODE1			0x08c
 #define QSERDES_PLL_PLL_CCTRL_MODE0			0x090
 #define QSERDES_PLL_PLL_CCTRL_MODE1			0x094
 #define QSERDES_PLL_BIAS_EN_CTRL_BY_PSM			0x0a4
@@ -44,7 +44,7 @@
 #define QSERDES_PLL_DIV_FRAC_START3_MODE0		0x0e0
 #define QSERDES_PLL_DIV_FRAC_START1_MODE1		0x0e4
 #define QSERDES_PLL_DIV_FRAC_START2_MODE1		0x0e8
-#define QSERDES_PLL_DIV_FRAC_START3_MODE1		0x0eC
+#define QSERDES_PLL_DIV_FRAC_START3_MODE1		0x0ec
 #define QSERDES_PLL_INTEGLOOP_GAIN0_MODE0		0x100
 #define QSERDES_PLL_INTEGLOOP_GAIN1_MODE0		0x104
 #define QSERDES_PLL_INTEGLOOP_GAIN0_MODE1		0x108
@@ -270,11 +270,11 @@
 #define QPHY_RX_MIN_HIBERN8_TIME			0x140
 #define QPHY_RX_SIGDET_CTRL2				0x148
 #define QPHY_RX_PWM_GEAR_BAND				0x154
-#define QPHY_PLL_LOCK_CHK_DLY_TIME_AUXCLK_LSB		0x1A8
-#define QPHY_OSC_DTCT_ACTIONS				0x1AC
-#define QPHY_RX_SIGDET_LVL				0x1D8
-#define QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB		0x1DC
-#define QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB		0x1E0
+#define QPHY_PLL_LOCK_CHK_DLY_TIME_AUXCLK_LSB		0x1a8
+#define QPHY_OSC_DTCT_ACTIONS				0x1ac
+#define QPHY_RX_SIGDET_LVL				0x1d8
+#define QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB		0x1dc
+#define QPHY_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB		0x1e0
 
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
@@ -639,7 +639,7 @@
 #define QSERDES_V4_TX_TRAN_DRVR_EMP_EN			0xb8
 #define QSERDES_V4_TX_TX_INTERFACE_MODE			0xbc
 #define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0xd8
-#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0xdC
+#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0xdc
 #define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0xe0
 #define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0xe4
 #define QSERDES_V4_TX_VMODE_CTRL1			0xe8
-- 
2.35.1

