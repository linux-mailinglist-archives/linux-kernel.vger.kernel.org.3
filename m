Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4BD58C5A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbiHHJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242522AbiHHJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D275C2AF0;
        Mon,  8 Aug 2022 02:31:06 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2788f6ZJ031248;
        Mon, 8 Aug 2022 09:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=/6p8yu1bFhRi+qcP9tpphH1LILmMm3nn/xeYRPhSjsI=;
 b=UfMYJTvjCb6kUlhRcltoFF2Jc9JOtpMkIj+R5ypP6C0GRqTf7L0d4AdVaOetNmsLzKNn
 rVDL/GvCQUh/B31hVt9rQtXtonSL0UcGOI9xxj6ze8ohvqChI8mxDUOtFvTYVvsyBq9h
 bIXzFHEcVjWB90NEeD9hGApdnonDQm740ztU2dBTA29CMlb+SS64lqwXJOgU7SGPFfWx
 MPLdP8/zHEBXJo6Wqy+HtqBneIDYwislG/7YmFYQWh5ePp6xpBIjyy0URPpnK5JijpBQ
 J3nMs0hdl0LYgd9L5hjmBxzpW2ydO2F4yOQxMzDPt571HeFZaloSqEyHYZajkDWbvQpB jQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hshkeb075-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:31:03 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789UsJk018419;
        Mon, 8 Aug 2022 09:31:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpmt-1;
        Mon, 08 Aug 2022 09:31:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789V0Qs018487;
        Mon, 8 Aug 2022 09:31:00 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789V08Z018485;
        Mon, 08 Aug 2022 09:31:00 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 94AD0900883; Mon,  8 Aug 2022 15:00:59 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH V2 6/7] venus : Remove the capture plane settings for venc_g_parm/venc_s_parm
Date:   Mon,  8 Aug 2022 14:58:33 +0530
Message-Id: <20220808092834.29775-7-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220808092834.29775-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220808092834.29775-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c5hK37UG3HUHYeapTfkOkpKBgmLpvqKj
X-Proofpoint-GUID: c5hK37UG3HUHYeapTfkOkpKBgmLpvqKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_06,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=940 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
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

From: Viswanath Boma <quic_vboma@quicinc.com>

v4l2 compliance expecting settings for out buffer only and the same
values will be propagated to capture buffer setting by h/w encoder .
settings on cpature plane are optional , required only if
offline-encoding supports.

error details : fail: v4l2-test-formats.cpp(1350): !ret

Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 966f41f3603ec..16f0abb0d76c6 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -390,7 +390,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	struct v4l2_fract *timeperframe = &out->timeperframe;
 	u64 us_per_frame, fps;
 
-	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
 	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
 
@@ -422,7 +422,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 {
 	struct venus_inst *inst = to_inst(file);
 
-	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
 	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
 
-- 
2.17.1

