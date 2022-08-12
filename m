Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD43C5910FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238455AbiHLMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbiHLMtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:49:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB91AEDAA;
        Fri, 12 Aug 2022 05:49:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C8osJ7032012;
        Fri, 12 Aug 2022 12:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=C0wasrZycPbCPZaxTfUUfBh6Rrwzc1Yyug8IVeG5w0U=;
 b=HGN6jo8JPbJ6wUV9E8NrLn+kgoO0tmR9glg+tcyWy16HyGqL8HbfX52mW5jWQvY4RJ6w
 R7QxNfF+3j8qA3AcFEoP27aPAoi1bIUzXyRVczOcLgBqh2zZ80joMcPQ5+oX7l/Z0AfA
 sFZW710fHlmX00PfMf2hx90C+yw46+r85CJOg1ZUVUM/x9MS8Cay9MutWM6WrXlvKmyM
 uirhOTIWi3p+me4RkbrKR7tkSvP2h3sDiWS8jGU3Xf/Iv4DmmN8iLtN21RaD10eoIQU3
 eGwOaiNn2/lkHAG2zyi9WFtRpIPIBU24u0d8Y5OY7l0QRaYPdLXL/BiFWpXdPRhuUzNL eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hwa8d2687-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:48:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27CCmOGv003325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 12:48:24 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 12 Aug 2022 05:48:19 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v4 3/7] remoteproc: qcom: Add compatible name for SC7280 ADSP
Date:   Fri, 12 Aug 2022 18:17:42 +0530
Message-ID: <1660308466-410-4-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
References: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nBT_3Ib9ql59K4fykTJxVTjIeseFdfPW
X-Proofpoint-ORIG-GUID: nBT_3Ib9ql59K4fykTJxVTjIeseFdfPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_08,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update adsp pil data and compatible name for loading ADSP
binary on SC7280 based platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
Changes since V3:
	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
	-- Update sc7280 compatible name entry in sorted order.
Changes since V2:
	-- Initialize is_adsp_sb_needed flag.
	-- Remove empty proxy pds array.

 drivers/remoteproc/qcom_q6v5_adsp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index d0b767f..6d409ca 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -701,6 +701,22 @@ static const struct adsp_pil_data adsp_resource_init = {
 	},
 };
 
+static const struct adsp_pil_data adsp_sc7280_resource_init = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mbn",
+	.load_state = "adsp",
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+	.is_wpss = false,
+	.adsp_sandbox_needed = true,
+	.auto_boot = true,
+	.clk_ids = (const char*[]) {
+		"gcc_cfg_noc_lpass", NULL
+	},
+	.num_clks = 1,
+};
+
 static const struct adsp_pil_data cdsp_resource_init = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
@@ -739,6 +755,7 @@ static const struct adsp_pil_data wpss_resource_init = {
 
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,qcs404-cdsp-pil", .data = &cdsp_resource_init },
+	{ .compatible = "qcom,sc7280-adsp-pil", .data = &adsp_sc7280_resource_init },
 	{ .compatible = "qcom,sc7280-wpss-pil", .data = &wpss_resource_init },
 	{ .compatible = "qcom,sdm845-adsp-pil", .data = &adsp_resource_init },
 	{ },
-- 
2.7.4

