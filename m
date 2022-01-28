Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4449F4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiA1HsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:48:02 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:59291 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbiA1Hr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643356078; x=1674892078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CZb7FgsvZcQC+yHWZeLqlTqR9wYyW6QeoNxNC+3lJr0=;
  b=qiOUfPyG4w7jx1SdnVAdnf9tVNuzNqoz2h4P+5UFakDl3iesqitQDZYZ
   7j5yvn2XTad6Em7ZTVmdV7EfXx3ZgchtNR2bbpX6YNNXJK8Ax447Wh5Bn
   b0wR8t0skoVdr0PQDh4Q/9JH25I6DeuwI0e2u+2PlgFv+e+v7amO6xpUf
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 23:47:57 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:47:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:57 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:47:52 -0800
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
Subject: [PATCHv2 4/9] soc: qcom: llcc: Add missing llcc configuration data
Date:   Fri, 28 Jan 2022 13:17:11 +0530
Message-ID: <143d11bacaca086406fdd10fc32f91eccd943527.1643355594.git.quic_saipraka@quicinc.com>
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

Add missing llcc configuration data for few chipsets which
were not added during initial post.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index e845d3919ef3..a791213a99e0 100644
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

