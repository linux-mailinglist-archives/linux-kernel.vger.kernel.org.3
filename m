Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A158C5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiHHJcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242515AbiHHJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8894D1022;
        Mon,  8 Aug 2022 02:31:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2787vSja029651;
        Mon, 8 Aug 2022 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=EqjUu1ViC86S24Shu/oJ19D1224dS9VXRPGlfKc5Zrw=;
 b=egDkynNz+D+3BBxSpgGLmTuq1NI+WKpCgV7Qi7tX+C1VXGrHFZFYYolt18MIfP10OuVi
 cKHwVFXkQpIN7g9OXLOif+3ARbBNypNUhw4VRQp0pV+bOBZF4pEbXK2Dh5ue307ll3m9
 3/t2J3QIhiUy0b6YX6hjM1UIfABSEA1FCFngnj9V49JpCcG6Sa3Q04B8XRG+G2vlS3W6
 a6WVKXAZthqlD64mmF5plDExz5o7WcOSUlSix8eN6emGx5zkAOblermu+U/XdfVHMVde
 ZqpK/Jg+YqeuCJ1dasLyb3bzcB32PdS6mrmSSwiqTqfpUDlZpQtZ8TseYNEZNMrx0ZfR wg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hshfttysy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:30:57 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789UsJi018419;
        Mon, 8 Aug 2022 09:30:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpkw-1;
        Mon, 08 Aug 2022 09:30:54 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789UspP018414;
        Mon, 8 Aug 2022 09:30:54 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789Usc9018413;
        Mon, 08 Aug 2022 09:30:54 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 3D221900883; Mon,  8 Aug 2022 15:00:53 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH V2 1/7] venus : Add default values for the control
Date:   Mon,  8 Aug 2022 14:58:28 +0530
Message-Id: <20220808092834.29775-2-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220808092834.29775-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220808092834.29775-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S704NM2gPJCcP8CQroQbf-QdkxKmILcR
X-Proofpoint-GUID: S704NM2gPJCcP8CQroQbf-QdkxKmILcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_06,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=832 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080047
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

V4l2 encoder compliance expecting default values of colorimetry 
for the control.

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index ea5805e71c143..aa44c0b3ceb57 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -352,6 +352,10 @@ static const struct v4l2_ctrl_ops venc_ctrl_ops = {
 int venc_ctrl_init(struct venus_inst *inst)
 {
 	int ret;
+	struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering = {
+		{ 34000, 13250, 7500 },
+		{ 16000, 34500, 3000 }, 15635, 16450, 10000000, 500,
+	};
 
 	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
 	if (ret)
@@ -580,7 +584,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 
 	v4l2_ctrl_new_std_compound(&inst->ctrl_handler, &venc_ctrl_ops,
 				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
-				   v4l2_ctrl_ptr_create(NULL));
+				   v4l2_ctrl_ptr_create((void *)&p_hdr10_mastering));
 
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
-- 
2.17.1

