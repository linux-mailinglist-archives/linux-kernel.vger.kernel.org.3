Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13F458C5AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbiHHJcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbiHHJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF57F2AEA;
        Mon,  8 Aug 2022 02:31:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2789SNTm018149;
        Mon, 8 Aug 2022 09:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=XBOEaXslQ/ov0WLTHJmjpnPH5ylY2kyXViGO9O2x9Jo=;
 b=M3I6VRPBq87Gdserp2BkArkcYQLXlyUm73wy4LvXuG/6OShIL/91oD0DzP3Z2dpFRSzz
 o1M1VzTnm84fiOOkeRWTe/jf/ljq1tybSe9JTa20ho7F0eL5iXxlArZDXbVXvqFsETiL
 IdtpOoKCVOgaauymsOfee53Psch97U0yN4Q+yAWckYubbQd4zxAA+tV3Ce+H1iUdKvQi
 o22E5YvYP2EdpiR/uYo1rG+8VG7NfzD0jD3OY43VwE+sHiBogUC8w1n7F2bZgXDZA+Ds
 ZJ3eA6Tnr6M4B5MTentsWRppgArUXeQiEmKUpaHmLxDhm9UDGSftMaq+3YXWJB7sRj1H uQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hshfttysx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:30:56 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789UqTX017987;
        Mon, 8 Aug 2022 09:30:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpkn-1;
        Mon, 08 Aug 2022 09:30:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789Uqmw017982;
        Mon, 8 Aug 2022 09:30:52 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789Uq8n017965;
        Mon, 08 Aug 2022 09:30:52 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 61FB0900883; Mon,  8 Aug 2022 15:00:51 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH V2 0/7] Fixes for Encoder Compliance issues.
Date:   Mon,  8 Aug 2022 14:58:27 +0530
Message-Id: <20220808092834.29775-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220712122347.6781-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wiKhS9YaeYDuSRuDqr-bQXKaVTjxqiq6
X-Proofpoint-GUID: wiKhS9YaeYDuSRuDqr-bQXKaVTjxqiq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_06,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=958 mlxscore=0
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

From: Viswanath Boma <quic_vboma@quicinc.com>

Fixes for Video Encoder complaince issues .
Tested on v5.15 kernel and the chrome/client binary details -
				 v4l2-compliance 1.22.1



Dikshita Agarwal (1):
  venus : Addition of support for VIDIOC_TRY_ENCODER_CMD

Stanimir Varbanov (2):
  venus : Add default values for the control
    V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
  venus : CAPTURE Plane width/height alignment with OUT plane.

Vikash Garodia (1):
  venus : Allow MIN/MAX settings for the v4l2 encoder controls defined
    range.

Viswanath Boma (3):
  venus : Addition of control support - V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
  venus : Addition of EOS Event support for Encoder
  venus : Remove the capture plane settings for venc_g_parm/venc_s_parm

 drivers/media/platform/qcom/venus/venc.c      | 26 ++++++++++----
 .../media/platform/qcom/venus/venc_ctrls.c    | 35 ++++++++++++++++---
 2 files changed, 50 insertions(+), 11 deletions(-)

-- 
2.17.1

