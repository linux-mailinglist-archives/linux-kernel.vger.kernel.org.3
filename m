Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA44F48DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385212AbiDEVxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457599AbiDEQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:14:05 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF315701;
        Tue,  5 Apr 2022 09:12:07 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235Dkb0A024619;
        Tue, 5 Apr 2022 18:11:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=YYuFJUbBGAhIAF7jE0NLyDCpsVggjgUfUTeXHBPg+6w=;
 b=ED8nOSlV3isg8Qq3bH+Bvfd8Zt5/XefkPF98Txb9noYRKAH3Rze4l63NHwHyqa/6URl/
 lw9ENLxj1Fi62hSYxf3QHs5jELIVPXwwMl2GvTkMLEswQTUWO8npUP6GWqOpLqqRnBc1
 j32HrcFyGLFc1j8MVcnl3PaIj56tqvgDb3EorPiUaQ4mie5YPtoxtbSyeBQgHQUfE1rm
 k51gX6HAfaqEDv2u72GkKrYuRuEBreAllIlID8GwFealdE6fX3x03an97GDAl8IPwfQD
 PYWJmxCyRZJNZWl1ZLQ6GvEHP7T7U7MEIDVl0iXE7K9fUgbSlrcmN/g3VTD4vOajfvuJ +g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3f6dcgu3xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Apr 2022 18:11:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A0EE10002A;
        Tue,  5 Apr 2022 18:11:52 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CE962278AC;
        Tue,  5 Apr 2022 18:11:52 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 5 Apr 2022 18:11:51
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <arnaud.pouliquen@foss.st.com>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
Subject: [PATCH v3] arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
Date:   Tue, 5 Apr 2022 18:11:14 +0200
Message-ID: <20220405161114.1107745-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_04,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 617d32938d1b ("rpmsg: Move the rpmsg control device
from rpmsg_char to rpmsg_ctrl"), we split the rpmsg_char driver in two.
By default give everyone who had the old driver enabled the rpmsg_ctrl
driver too.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---

This patch is extracted from the series [1] that has been partially
integrated in the Linux Kernel 5.18-rc1.

Update vs previous version:
- Add missing "---" separation marker after "Signed-off-by".

[1]https://lore.kernel.org/lkml/15be2f08-ba03-2b80-6f53-2056359d5c41@gmail.com/T/
[2]https://lore.kernel.org/linux-arm-kernel/CANLsYky1_b80qPbgOaLGVYD-GEr21V6C653iGEB7VCU=GbGvAQ@mail.gmail.com/T/
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 50aa3d75ab4f..3f8906b8a2ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1053,6 +1053,7 @@ CONFIG_QCOM_Q6V5_PAS=m
 CONFIG_QCOM_SYSMON=m
 CONFIG_QCOM_WCNSS_PIL=m
 CONFIG_RPMSG_CHAR=m
+CONFIG_RPMSG_CTRL=m
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_GLINK_SMEM=m
 CONFIG_RPMSG_QCOM_SMD=y
-- 
2.25.1

