Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC9472D03
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbhLMNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:15:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60924 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhLMNPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:15:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04874B80ED7;
        Mon, 13 Dec 2021 13:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B571C34601;
        Mon, 13 Dec 2021 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639401309;
        bh=cZk+G/uxRdIcbS2qNHDTMvTAAHkt6iWHVXw+x9mtf1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pF+jHNSMao4zvFaYgX3+GJAXuQFv0OanSosnITkQs70StQQ+aYiheXr1f+slSMCl5
         +gS3ZqJszfK2RRfkC7IBb8sZTA3hWUUigfwthydOEvqrKdUtnCZKGk/wYjr2B0nsw/
         jrywZ+A7bQohMCabyvwxKtkvCYcfQcuM6rl+LoWl9NwVcmOmWaodL0tTSWbpeWMh2t
         7OLk9NOt+pZPXeC0RE3Ix+JJ+KuS4HbCovcaJD84BRfPaSdH3jv6H1uYNfPOJMaHoK
         rDMTYs83dDuZGv+YTC77gJcb3efyhHpMSWnhLHe3xpcVwougEi7wVfZnhHLyFxEZyY
         H0ccv95hvjm2w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] phy: qcom-qmp: Add SM8450 USB QMP PHYs
Date:   Mon, 13 Dec 2021 18:44:50 +0530
Message-Id: <20211213131450.535775-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213131450.535775-1-vkoul@kernel.org>
References: <20211213131450.535775-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the USB DP & UNI PHYs found on SM8450. This is same as
the phy version used on SM8350 and sequences turned out to be same, so
use the same table from SM8350 for this as well.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index a959c97a699f..13a249ec8ab6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -5777,6 +5777,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sm8450-qmp-ufs-phy",
 		.data = &sm8450_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8450-qmp-usb3-phy",
+		.data = &sm8350_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,qcm2290-qmp-usb3-phy",
 		.data = &qcm2290_usb3phy_cfg,
-- 
2.31.1

