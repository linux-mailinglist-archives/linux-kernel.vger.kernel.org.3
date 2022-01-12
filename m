Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169D748CC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357132AbiALTwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:52:06 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33214 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356567AbiALTvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:21 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 93EFCCDFB7;
        Wed, 12 Jan 2022 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016545; bh=MNjITzwZLGiO65HqfkpFso4zWkx/alLclG/PQK0PQm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hpi5fWHim/KbZeecfjBrNP/fnt4BJVqEgy/2Amju4H3JrWNoWQHMOEWUe0uVK0DpK
         HwgbMVI9dSkUeoX4C9GQphaSrrla6DNvDYWEqvboULxqhfIFr3wR3F263Fs3bNcTgL
         v+Ub74yLKPyHq+PYZVVsw8IFwjyDCtLA7yaR2DhE=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] phy: qcom-qusb2: Add compatible for MSM8953
Date:   Wed, 12 Jan 2022 20:40:51 +0100
Message-Id: <20220112194118.178026-3-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for MSM8953 QUSB2 device which reuses MSM8996
configuration.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 032d02bf50c5..7529a7e6e5df 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -911,6 +911,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
 	}, {
 		.compatible	= "qcom,ipq8074-qusb2-phy",
 		.data		= &msm8996_phy_cfg,
+	}, {
+		.compatible	= "qcom,msm8953-qusb2-phy",
+		.data		= &msm8996_phy_cfg,
 	}, {
 		.compatible	= "qcom,msm8996-qusb2-phy",
 		.data		= &msm8996_phy_cfg,
-- 
2.34.1

