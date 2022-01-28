Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010F49F4AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbiA1HsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:48:23 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:52504 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347088AbiA1HsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356088; x=1674892088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9N939L5bTT/411X3QULr7Ra4GvC9w/0f6usLMuRsYo=;
  b=hSRgNMbx6fIBYXzpdCqNsjbJtF0GXBeZNNEzbko2S4Mk1FQtgFmchv8L
   nuY9yDbQxXSexvV0JETsNHUGhG9owi6qIOvrmVyXOXvn1LBH9CC2t25Gn
   6WnWnfDdPSUQq41jjtuI/6IQDnamtN1G3LtYqL7uemjc/xRwO3Q+Lcncx
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jan 2022 23:48:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:48:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:48:07 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:48:03 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv2 6/9] soc: qcom: llcc: Add configuration data for SM8450 SoC
Date:   Fri, 28 Jan 2022 13:17:13 +0530
Message-ID: <fec944cb8f2a4a70785903c6bfec629c6f31b6a4.1643355594.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1643355594.git.quic_saipraka@quicinc.com>
References: <cover.1643355594.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC configuration data for SM8450 SoC.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c       | 34 ++++++++++++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index ea93740cc671..53816e66d877 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -226,6 +226,32 @@ static const struct llcc_slice_config sm8350_data[] =  {
 	{ LLCC_CPUHWT,   5, 512,   1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 1 },
 };
 
+static const struct llcc_slice_config sm8450_data[] =  {
+	{LLCC_CPUSS,     1, 3072, 1, 0, 0xFFFF, 0x0,   0, 0, 0, 1, 1, 0, 0 },
+	{LLCC_VIDSC0,    2,  512, 3, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_AUDIO,     6, 1024, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0 },
+	{LLCC_MDMHPGRW,  7, 1024, 3, 0, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MODHW,     9, 1024, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_CMPT,     10, 4096, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_GPUHTW,   11,  512, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_GPU,      12, 2048, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 1, 0 },
+	{LLCC_MMUHWT,   13,  768, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 1, 0, 0 },
+	{LLCC_DISP,     16, 4096, 2, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MDMPNG,   21, 1024, 1, 1, 0xF000, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_AUDHW,    22, 1024, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0 },
+	{LLCC_CVP,      28,  256, 3, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_MODPE,    29,   64, 1, 1, 0xF000, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_APTCM,    30, 1024, 3, 1, 0x0,    0xF0,  1, 0, 0, 1, 0, 0, 0 },
+	{LLCC_WRCACHE,  31,  512, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 1, 0, 0 },
+	{LLCC_CVPFW,    17,  512, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_CPUSS1,    3, 1024, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_CAMEXP0,   4,  256, 3, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_CPUMTE,   23,  256, 1, 1, 0x0FFF, 0x0,   0, 0, 0, 0, 1, 0, 0 },
+	{LLCC_CPUHWT,    5,  512, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 1, 0, 0 },
+	{LLCC_CAMEXP1,  27,  256, 3, 1, 0xFFFF, 0x0,   0, 0, 0, 1, 0, 0, 0 },
+	{LLCC_AENPU,     8, 2048, 1, 1, 0xFFFF, 0x0,   0, 0, 0, 0, 0, 0, 0 },
+};
+
 static const u32 llcc_v1_2_reg_offset[] = {
 	[LLCC_COMMON_HW_INFO]	= 0x00030000,
 	[LLCC_COMMON_STATUS0]	= 0x0003000c,
@@ -285,6 +311,13 @@ static const struct qcom_llcc_config sm8350_cfg = {
 	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
+static const struct qcom_llcc_config sm8450_cfg = {
+	.sct_data       = sm8450_data,
+	.size           = ARRAY_SIZE(sm8450_data),
+	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v21_reg_offset,
+};
+
 static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
 
 /**
@@ -714,6 +747,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
 	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
 	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
 	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
+	{ .compatible = "qcom,sm8450-llcc", .data = &sm8450_cfg },
 	{ }
 };
 
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index beecf00b707d..0bc21ee58fac 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -35,7 +35,12 @@
 #define LLCC_WRCACHE     31
 #define LLCC_CVPFW       32
 #define LLCC_CPUSS1      33
+#define LLCC_CAMEXP0     34
+#define LLCC_CPUMTE      35
 #define LLCC_CPUHWT      36
+#define LLCC_MDMCLAD2    37
+#define LLCC_CAMEXP1     38
+#define LLCC_AENPU       45
 
 /**
  * struct llcc_slice_desc - Cache slice descriptor
-- 
2.33.1

