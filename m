Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF547497D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiAXK1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:27:08 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54612 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234210AbiAXK1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:27:02 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O73h7O014327;
        Mon, 24 Jan 2022 11:26:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=iYKk6pJjsYeuYCAO1v2lT4D7+S8Aij8LxEqK+fmKc9U=;
 b=3VfpNknBmpFA4l9jUY0xSVKIg3hcTgUqy9MfICRiA1N172J2WSWJPPjG+kPQkR1KBsTy
 +1NTnSklknxP09JY+rE9RVwcqdAdZtMUQ/X842Y8RKmqtFHlDVA2/joJcfKsf1ZceBfl
 C19x0SlKAeiHvw4f+kCUMmKG0P8b439NTjG3pi3hMvClLHZW7SBC35RbM8RLiIcs84b8
 PL2OFGGDVxSch45cnkDj/vV7/nLZ4tDdr4vDU1QiiBphzP2XYXByu0f3kyWh82L6GGMt
 fJi4ew1RX9FYqYTaHDLVLd3NEsJjpoJQuJAMODHl/IPAoBhl7DwvNb4coOCtlnHDJ2gs Ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ds9v1kcsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 11:26:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D5E45100034;
        Mon, 24 Jan 2022 11:26:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CDE892128C0;
        Mon, 24 Jan 2022 11:26:55 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan 2022 11:26:55
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 06/11] arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
Date:   Mon, 24 Jan 2022 11:25:19 +0100
Message-ID: <20220124102524.295783-7-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch "rpmsg: Move the rpmsg control device from rpmsg_char
to rpmsg_ctrl", we split the rpmsg_char driver in two.
By default give everyone who had the old driver enabled the rpmsg_ctrl
driver too.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..485c55f19d68 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1039,6 +1039,7 @@ CONFIG_QCOM_Q6V5_PAS=m
 CONFIG_QCOM_SYSMON=m
 CONFIG_QCOM_WCNSS_PIL=m
 CONFIG_RPMSG_CHAR=m
+CONFIG_RPMSG_CTRL=m
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
-- 
2.25.1

