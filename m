Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8563C49F41A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346698AbiA1HKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:10:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13489 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346690AbiA1HKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643353831; x=1674889831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7jQAC51Kn4cEryaFdUyTc7Y/WdXpTu2OtxjAFqzTgI=;
  b=uN0FPVme/g3OpFj0mbydkp2cOZZg712MGGXe0g6mC7yPd0AODV/FRaE/
   00QffL1qJuUZE4z7sqhzwzWEUcCPnHFCf9e+icisfcYeLZlcYJNk25nkF
   4i9Titf/DJft//USjqAwJZcJxlbBkcSbg/uJyNMQa65pZSevtHUkr5R3e
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jan 2022 23:10:30 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:10:30 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:29 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:25 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCH 4/9] soc: qcom: llcc: Add missing llcc configuration data
Date:   Fri, 28 Jan 2022 12:39:28 +0530
Message-ID: <547065fed7889b3aa02b8ff5437ceaa40fb7d8c5.1643353154.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1643353154.git.quic_saipraka@quicinc.com>
References: <cover.1643353154.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing llcc configuration data for few chipsets which
were not added during initial post.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 79fce5a2ff06..d14d20d824b2 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -244,21 +244,25 @@ static const struct qcom_llcc_config sdm845_cfg = {
 static const struct qcom_llcc_config sm6350_cfg = {
 	.sct_data	= sm6350_data,
 	.size		= ARRAY_SIZE(sm6350_data),
+	.need_llcc_cfg	= true,
 };
 
 static const struct qcom_llcc_config sm8150_cfg = {
 	.sct_data       = sm8150_data,
 	.size           = ARRAY_SIZE(sm8150_data),
+	.need_llcc_cfg	= true,
 };
 
 static const struct qcom_llcc_config sm8250_cfg = {
 	.sct_data       = sm8250_data,
 	.size           = ARRAY_SIZE(sm8250_data),
+	.need_llcc_cfg	= true,
 };
 
 static const struct qcom_llcc_config sm8350_cfg = {
 	.sct_data       = sm8350_data,
 	.size           = ARRAY_SIZE(sm8350_data),
+	.need_llcc_cfg	= true,
 };
 
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
-- 
2.33.1

