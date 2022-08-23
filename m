Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954A59D207
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiHWH00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiHWH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:26:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBC62AB5;
        Tue, 23 Aug 2022 00:26:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N4kUPh019833;
        Tue, 23 Aug 2022 07:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=0xR3cyRD3C2g9deJD4LqveBJc09hQMPGu6r0uA37snk=;
 b=EvnLVGZ0pezRAp1ESTzVxpWMOH9wPn+P/GsiRFOGXo6xx2ew56RBsqjEw62nRxP0MTod
 8z0luzJqQH5KSx4XE3xNbwblk9GUIUqkxnLhiJaHpwk+eJ0aWXR/AHfNMz+wsxXk199c
 QJN4fuuQNicT/w/kDVEFQutqxygrpzbt7UEMaHpJcQhJD6W0YfWYdpXZ2bdeIq9Dnxa0
 dOdP67z/RQmwRkXllLIzoB/lL0gOqp4/jjje/JTWrkCDb1GaZUOEJmhXv9slvmegXg54
 CypOCWU2pyB6RoblfqrqtvYceqOJ1ojTX2Xwr2I6Y1ZFxj6iSAPlvpxShkET8LEs+I/W ZQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j4p7ps51h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 07:26:11 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27N7Q7bt027746;
        Tue, 23 Aug 2022 07:26:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3j2rpkjuxd-1;
        Tue, 23 Aug 2022 07:26:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27N7Q7qL027740;
        Tue, 23 Aug 2022 07:26:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 27N7Q6eb027739;
        Tue, 23 Aug 2022 07:26:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 60DB9481D; Tue, 23 Aug 2022 12:56:06 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@collabora.com
Cc:     stanimir.varbanov@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_vgarodia@quicinc.com, quic_majja@quicinc.com,
        quic_jdas@quicinc.com, Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] media: v4l2-ctrl: Add main 10 still picture profile for hevc
Date:   Tue, 23 Aug 2022 12:56:03 +0530
Message-Id: <1661239563-14346-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I3M_GkfxWXxb4ojFan6Nn8QeTnRaAP_9
X-Proofpoint-ORIG-GUID: I3M_GkfxWXxb4ojFan6Nn8QeTnRaAP_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_02,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=488
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230028
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add main 10 still picture profile for HEVC encoder.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
 include/uapi/linux/v4l2-controls.h                        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae..5b2da84 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2424,6 +2424,8 @@ enum v4l2_mpeg_video_hevc_profile -
       - Main still picture profile.
     * - ``V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10``
       - Main 10 profile.
+    * - ``V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10_STILL_PICTURE``
+      - Main 10 still picture profile.
 
 .. raw:: latex
 
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 5f46bf4..1159337 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -743,6 +743,7 @@ enum v4l2_mpeg_video_hevc_profile {
 	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN = 0,
 	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE = 1,
 	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10 = 2,
+	V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10_STILL_PICTURE = 3,
 };
 #define V4L2_CID_MPEG_VIDEO_HEVC_LEVEL		(V4L2_CID_CODEC_BASE + 616)
 enum v4l2_mpeg_video_hevc_level {
-- 
2.7.4

