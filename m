Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE08646B54B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhLGIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:12:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42136 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232116AbhLGIMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:48 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B740pnI018749;
        Tue, 7 Dec 2021 09:08:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=WVV3d8UaMvdSQRl6d9OtZ06ffGfZw5TE8gaN7pqT5gE=;
 b=5IYwRgNuM8xgjt4uEFyCZpygaLh+OUzl5iFZTdNwX00Ro3l/oUZhRQjLwD29+cecy6Js
 TG5rT5YTn2AUx+8y8kxFKCOyhUIQ/5Cu9Ss5nb1pvqynKO6r+8Sg2u9JihWcIFKvayS6
 TwHgwrnlZCvGVCMPmr/y7oBf+Ivze8OfBP05rSIka9lR22/2eqjRwh9u+qlE6uXgPuK6
 jqH0RmWBtSLY0PW/DdIepXfatXSbltBuDgk3/eILau6fv6o98BiIPeHnEKb3aYLvT8Jl
 devkhN6cvTdDEAhlqc5E41xTGzmUFpWDNzQ8aXIRBv6vSrxMELyjakRUIzfmE47P5++o Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csp32bc95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:08:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 412E1100034;
        Tue,  7 Dec 2021 09:08:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 388F22220AF;
        Tue,  7 Dec 2021 09:08:56 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:08:55
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 04/13] arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
Date:   Tue, 7 Dec 2021 09:08:34 +0100
Message-ID: <20211207080843.21222-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
References: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
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
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 0daa9c0d298e..b76d2a2ea0a2 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -242,6 +242,7 @@ CONFIG_QCOM_Q6V5_PAS=y
 CONFIG_QCOM_Q6V5_PIL=y
 CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_QCOM_COMMAND_DB=y
-- 
2.17.1

