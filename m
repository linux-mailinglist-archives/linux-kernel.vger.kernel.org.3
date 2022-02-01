Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF14A60FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbiBAQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:07:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41048 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240804AbiBAQHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:07:35 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211CNAwv030142;
        Tue, 1 Feb 2022 17:05:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=LErjSzLlzd1bZwa3rCfJ3gG9bX5m/yeoFgqt1O1gyfE=;
 b=211qr4V34spBmewxNvOD0qkiQ2Z6sCsysazdl1zx5DKp2XjPJg1uVkw1cFNRqKvucTk2
 gW9SEFqxo4iPOUlLsVHMCd/frtlzzYhgtBPMNS4sHN2GKA/64/9b/hMIWQvfb4iHagT0
 TL2uJFGlOApSFjPxhEDrznzFrHD6ESRT3pe699iLKf4Q25dWqeTv9X+sJWkb1dfnlGUa
 xgoQS4/zudMe4pmd3y0RMcZAj9YsgSxumeb7eaUpmtGLB+cL4c1h/xUBpiu2ZW92yzdj
 EJyfN4ghCDxFCrFmhsO4df+zRHGa2RnSAbRdVLrDXxclbeuHDuYS7tTyRjcq2rhNTI/h 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dxk0rx0w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 17:05:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D279E10002A;
        Tue,  1 Feb 2022 17:05:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C492C2248DE;
        Tue,  1 Feb 2022 17:05:13 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 1 Feb 2022 17:05:13
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/2] Add DMA and MDMA support on STM32MP13x SoC family
Date:   Tue, 1 Feb 2022 17:05:04 +0100
Message-ID: <20220201160506.348701-1-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_08,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables DMA1 and DMA2 routed on DMAMUX1, and MDMA on
STM32MP13.

Amelie Delaunay (2):
  ARM: dts: stm32: add DMA1, DMA2 and DMAMUX1 on STM32MP13x SoC family
  ARM: dts: stm32: add MDMA on STM32MP13x SoC family

 arch/arm/boot/dts/stm32mp131.dtsi | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

-- 
2.25.1

