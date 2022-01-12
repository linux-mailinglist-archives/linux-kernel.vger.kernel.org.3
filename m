Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C4748C861
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355230AbiALQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:32:51 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349855AbiALQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:32:49 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CBGCPj019089;
        Wed, 12 Jan 2022 17:32:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=nJFFg7Jg5nwGSZI7zTj0mF4qnxKp4dp2BsQXGHK2x1Q=;
 b=YxLVdyrTPlAlEgOnlj6octXuB8eH7jxiTb151QaR07OwTIkxKtutY0KmU278cnXSVCtw
 LYBj3NsIuYzOhM9rJajTdiffmVeXHzx0k2AcGYiwjhp3DtUW27T14BWb+BLhYeMLkGqL
 aPbISc8luhrNp9/AL3iCz/HCbXUNZfvrYsrqUKwNqJSGsHB0ATN2o8aB5iX5CFh6Ihaf
 CB24RWDZcVhSYzTrt9TqKLe3lZlvBC/U0Ww1lrOLpv1nkuaNlX92fzu9oAP66uIwLFZh
 kg0IRpXfviir2bke16thGRFHBQkF+mOBVtYEW/R4Dus+BODa5k/rRovywriShJEPI2XS Cg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dhtg9u810-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 17:32:33 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E31A100034;
        Wed, 12 Jan 2022 17:32:33 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 24E5F24B8B1;
        Wed, 12 Jan 2022 17:32:33 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 12 Jan 2022 17:32:32
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 00/10] ARM: dts: stm32: update sdmmc nodes
Date:   Wed, 12 Jan 2022 17:32:16 +0100
Message-ID: <20220112163226.25384-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patches series brings updates for SDMMC nodes on STM32MP13
(max frequency, pins slew-rates, sleep pins, and controller version).
The sdmmc2 node is also added as STM32MP13 embeds 2 SDMMC controllers.

The compatible for sdmmc nodes is also updated for both STM32MP13
and STM32MP15, to align with bootloaders DT, and after arm,pl18x.yaml
has been updated [1].

[1] commit 552bc46484b3 ("dt-bindings: mmc: mmci: Add st,stm32-sdmmc2
    compatible")

Gerald Baeza (1):
  ARM: dts: stm32: update sdmmc slew-rate in stm32mp13 pinctrl

Yann Gautier (9):
  ARM: dts: stm32: add st,stm32-sdmmc2 compatible on stm32mp151
  ARM: dts: stm32: add st,stm32-sdmmc2 compatible on stm32mp131
  ARM: dts: stm32: increase SDMMC max-frequency for STM32MP13
  ARM: dts: stm32: update SDMMC clock slew-rate on STM32MP135F-DK board
  ARM: dts: stm32: add sdmmc sleep pins for STM32MP13
  ARM: dts: stm32: add sdmmc sleep config for STM32MP135F-DK
  ARM: dts: stm32: update SDMMC version for STM32MP13
  ARM: dts: stm32: add SDMMC2 in STM32MP13 DT
  ARM: dts: stm32: add sdmmc2 pins for STM32MP13

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 81 ++++++++++++++++++++----
 arch/arm/boot/dts/stm32mp131.dtsi        | 20 +++++-
 arch/arm/boot/dts/stm32mp135f-dk.dts     |  7 +-
 arch/arm/boot/dts/stm32mp151.dtsi        |  6 +-
 4 files changed, 94 insertions(+), 20 deletions(-)

-- 
2.17.1

