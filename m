Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550975B0281
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIGLIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiIGLHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:07:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33706A2D9D;
        Wed,  7 Sep 2022 04:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88B68B81BEC;
        Wed,  7 Sep 2022 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A67C433D6;
        Wed,  7 Sep 2022 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662548868;
        bh=cKltEdwxXdRYkvuQBWDP7L9mLOiwe+E4LaksbiwdMQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5SN92UL+aJA7QzJw4j4Hxh66TpRG2Mppk+Rp0KAV5SvsRV4EGk048wk6Ep3p4lHe
         Wh4Qo8xBq9G5RwaHPE993a5z0/svges1E2ztGm7jgfxJKlsqc89xfSYOZErPF5j10n
         sDK2zBGmTM7fBF+rCloYDzCkMlurS9TuSQpmdRHITC/FA+oWaYtBQ57Hz9lY1JRH7M
         rSrPUrPN0Bw3z5klyhwhEQTPo1zuFHNNbqWikKIXnVavUnoGhHhdt3axaidCzVJfTn
         izqqDhjD3u4H4w+MG8q0zSRaYHQ6Xbun/s7Cf4cMtb9rAs+hc2VZ3cIT8szeUZa/3M
         BRKxmBXFIpjJg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oVsuO-0004z1-Ix; Wed, 07 Sep 2022 13:07:52 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/16] phy: qcom-qmp-pcie-msm8996: drop unused defines
Date:   Wed,  7 Sep 2022 13:07:18 +0200
Message-Id: <20220907110728.19092-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220907110728.19092-1-johan+linaro@kernel.org>
References: <20220907110728.19092-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop defines and enums that are unused since the QMP driver split.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 27 +------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
index a5b9a81541c4..49df846c31e6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
@@ -36,35 +36,13 @@
 /* QPHY_PCS_STATUS bit */
 #define PHYSTATUS				BIT(6)
 #define PHYSTATUS_4_20				BIT(7)
-/* QPHY_PCS_READY_STATUS & QPHY_COM_PCS_READY_STATUS bit */
+/* QPHY_COM_PCS_READY_STATUS bit */
 #define PCS_READY				BIT(0)
 
-/* QPHY_V3_DP_COM_RESET_OVRD_CTRL register bits */
-/* DP PHY soft reset */
-#define SW_DPPHY_RESET				BIT(0)
-/* mux to select DP PHY reset control, 0:HW control, 1: software reset */
-#define SW_DPPHY_RESET_MUX			BIT(1)
-/* USB3 PHY soft reset */
-#define SW_USB3PHY_RESET			BIT(2)
-/* mux to select USB3 PHY reset control, 0:HW control, 1: software reset */
-#define SW_USB3PHY_RESET_MUX			BIT(3)
-
-/* QPHY_V3_DP_COM_PHY_MODE_CTRL register bits */
-#define USB3_MODE				BIT(0) /* enables USB3 mode */
-#define DP_MODE					BIT(1) /* enables DP mode */
-
-/* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
-#define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
-
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 #define POWER_DOWN_DELAY_US_MIN			10
 #define POWER_DOWN_DELAY_US_MAX			11
 
-#define MAX_PROP_NAME				32
-
-/* Define the assumed distance between lanes for underspecified device trees. */
-#define QMP_PHY_LEGACY_LANE_STRIDE		0x400
-
 struct qmp_phy_init_tbl {
 	unsigned int offset;
 	unsigned int val;
@@ -112,11 +90,8 @@ enum qphy_reg_layout {
 	/* PCS registers */
 	QPHY_SW_RESET,
 	QPHY_START_CTRL,
-	QPHY_PCS_READY_STATUS,
 	QPHY_PCS_STATUS,
 	QPHY_PCS_POWER_DOWN_CONTROL,
-	/* PCS_MISC registers */
-	QPHY_PCS_MISC_TYPEC_CTRL,
 	/* Keep last to ensure regs_layout arrays are properly initialized */
 	QPHY_LAYOUT_SIZE
 };
-- 
2.35.1

