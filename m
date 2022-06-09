Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67EF544B3B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiFIMEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiFIMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECBB6CAB1;
        Thu,  9 Jun 2022 05:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AF2611EF;
        Thu,  9 Jun 2022 12:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF68FC3411B;
        Thu,  9 Jun 2022 12:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654776237;
        bh=9kTzn0qoKbzpSZBZwJ3hRTAeGUs08b6TwBRYb0Trzgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvYDJzaTK6JtVLzHeWDbEIv8yJ/Uzi2vHsMgE/8LyHwH/bxTAcW33Ztl2HemDeXxR
         kJ4KyjHdy0xTrNSzUYl9eygDYkMJ8/4I7Sld3tEpEaygy3t13bAZJe/DgeoqCc4yD8
         RpxLQFq3MXciJAAyFDjQ+bave5diZ0Ny9ZigwCflCf+6pp56aznUx4ArEIGGyVyDoZ
         CzxIyfkiBwhLhogx+9va5HikdBXPHrKDT0mDl6/2M7mChgNZrDjeZMOn2ADnaTRu+d
         mPqWb6wwKSwkHkWMm+YLc5r0P81ty6TVtU7452lgAXcj05+YxI3v0kBrbdqML8M9OL
         2SvclJUvFu4Zg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1nzGtF-00014D-NZ; Thu, 09 Jun 2022 14:03:53 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/3] phy: qcom-qmp: clean up v4 and v5 define order
Date:   Thu,  9 Jun 2022 14:03:36 +0200
Message-Id: <20220609120338.4080-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609120338.4080-1-johan+linaro@kernel.org>
References: <20220609120338.4080-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the QMP v4 and v5 defines by moving a few entries that were out
of order.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index eb5705d1e32c..626be0ccede2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -577,8 +577,8 @@
 #define QSERDES_V4_COM_LOCK_CMP1_MODE0			0x0ac
 #define QSERDES_V4_COM_LOCK_CMP2_MODE0			0x0b0
 #define QSERDES_V4_COM_LOCK_CMP1_MODE1			0x0b4
-#define QSERDES_V4_COM_DEC_START_MODE0			0x0bc
 #define QSERDES_V4_COM_LOCK_CMP2_MODE1			0x0b8
+#define QSERDES_V4_COM_DEC_START_MODE0			0x0bc
 #define QSERDES_V4_COM_DEC_START_MODE1			0x0c4
 #define QSERDES_V4_COM_DIV_FRAC_START1_MODE0		0x0cc
 #define QSERDES_V4_COM_DIV_FRAC_START2_MODE0		0x0d0
@@ -1106,8 +1106,8 @@
 #define QSERDES_V5_COM_LOCK_CMP1_MODE0			0x0ac
 #define QSERDES_V5_COM_LOCK_CMP2_MODE0			0x0b0
 #define QSERDES_V5_COM_LOCK_CMP1_MODE1			0x0b4
-#define QSERDES_V5_COM_DEC_START_MODE0			0x0bc
 #define QSERDES_V5_COM_LOCK_CMP2_MODE1			0x0b8
+#define QSERDES_V5_COM_DEC_START_MODE0			0x0bc
 #define QSERDES_V5_COM_DEC_START_MODE1			0x0c4
 #define QSERDES_V5_COM_DIV_FRAC_START1_MODE0		0x0cc
 #define QSERDES_V5_COM_DIV_FRAC_START2_MODE0		0x0d0
@@ -1134,8 +1134,8 @@
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
-#define QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
 #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
+#define QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
 
 /* Only for QMP V5 PHY - TX registers */
 #define QSERDES_V5_TX_RES_CODE_LANE_TX			0x34
-- 
2.35.1

