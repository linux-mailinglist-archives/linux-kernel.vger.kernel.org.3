Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5B4593A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbiHOTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345067AbiHOT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 15:27:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C715B7BA;
        Mon, 15 Aug 2022 11:43:32 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIMqc8011181;
        Mon, 15 Aug 2022 18:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=o+kWYs+yHIy8cJ5iha1yG+ss0RBqFGfmFO2EG/z78kI=;
 b=YzTCk5ku3uS01TIBJHL3qfgMV0OF5s1/eXFwVlAW4tNZ1r0hZ9fcj1aaTqf6ccJ7MQjZ
 xxoeqEL2YNRbvQZM8EDPqP7bsrUp7DGeonrMKR/kPayaEaO6wixXqhsuGbM0ONqDONsg
 dR1anINkN4mPsa5LPNpZSpIpCUDYqRe7fOnApqcxj+b+kOOBlT08g4QPQrRYUeErgEho
 8qWCEUBcawgFz1GTWq/86359MNQuHIGmdbOZ2tVvn59wGw3gzqmsLsJMQhWJ5ULZcvub
 QmwOmv/vzqjgvOSQ0Ckc8VT/Cctn1Y7X3RJFPNUaN79Blblj6Y+VpxyxLm8VaAqRCDX+ nQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hx39re1vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 18:43:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27FIhPXj032220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 18:43:25 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 15 Aug 2022 11:43:23 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>
CC:     <quic_carlv@quicinc.com>, <quic_ajitpals@quicinc.com>,
        <quic_pkanojiy@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [RFC PATCH 14/14] MAINTAINERS: Add entry for QAIC driver
Date:   Mon, 15 Aug 2022 12:42:36 -0600
Message-ID: <1660588956-24027-15-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
References: <1660588956-24027-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eLtFVYPA1KkZOT3NJpgLgaV1Y-huBgCh
X-Proofpoint-GUID: eLtFVYPA1KkZOT3NJpgLgaV1Y-huBgCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=936 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for the Qualcomm Cloud AI 100 driver.

Change-Id: I149dbe34f1dbaeeca449b4ebf97f274c7484ed27
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd0f68d..695654c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15962,6 +15962,13 @@ F:	Documentation/devicetree/bindings/clock/qcom,*
 F:	drivers/clk/qcom/
 F:	include/dt-bindings/clock/qcom,*
 
+QUALCOMM CLOUD AI (QAIC) DRIVER
+M:	Jeffrey Hugo <quic_jhugo@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	drivers/gpu/drm/qaic/
+F:	include/uapi/drm/qaic_drm.h
+
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
 M:	Niklas Cassel <nks@flawful.org>
 L:	linux-pm@vger.kernel.org
-- 
2.7.4

