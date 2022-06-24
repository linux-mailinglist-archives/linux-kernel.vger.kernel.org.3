Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EED155969E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiFXJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiFXJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:27:37 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73B77FE4;
        Fri, 24 Jun 2022 02:27:36 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25O7qemY003113;
        Fri, 24 Jun 2022 11:27:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=usLNLotBGToCxJsJXsHAoM3bXkIn5CHECuPg1mXKElQ=;
 b=EPRVskc/YVHx0Ckg3qx6WjkgSp1H8a6m2eEErT1aU5At0w36rnxGCZ6Ck7IY1akfMjWQ
 lLxGY5sE5ZAJCC/3EU4ZXnKIFSWvU58VORz9eX+JFY6aYWoStJHHoosHv/DG0CX8Uk3u
 jtf4n7I2TqfCYwXVHPo7uhCWZNF4WUrWi57zoPKTS88q+8D6rORQtAAKiOjzJkcZatJ7
 WRpybOYFt0hNKieVGICag5DaHAjhdDPhGc2ou6Lu4YoGUKgNeDkL+sVG4wfuDjhp2dBN
 stoPY7WQxDEsTQJtO0SG0IcIGjL0eiUqv0i7VfDyf0j152mWnVSskmsOCKDaIPgeU01P fw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gvn8s7r4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 11:27:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 367E010002A;
        Fri, 24 Jun 2022 11:27:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 307922138D8;
        Fri, 24 Jun 2022 11:27:18 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 24 Jun
 2022 11:27:17 +0200
From:   <gabriel.fernandez@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Subject: [PATCH 0/3] SCMI Update for STM32MP15 boards
Date:   Fri, 24 Jun 2022 11:27:12 +0200
Message-ID: <20220624092715.1397827-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_05,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Update for SCMI version of ST boards:
- delete fixed clocks because there are now provided by SCMI
- add missing SCMI impact for DSI IP on DK1/ED1 STM32 board
- fix peripheral clock for CEC 

Gabriel Fernandez (3):
  ARM: dts: stm32: use the correct clock source for CEC on stm32mp151
  ARM: dts: stm32: DSI should use LSE SCMI clock on DK1/ED1 STM32 board
  ARM: dts: stm32: delete fixed clock node on STM32MP15-SCMI

 arch/arm/boot/dts/stm32mp15-scmi.dtsi      | 6 ++++++
 arch/arm/boot/dts/stm32mp151.dtsi          | 2 +-
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 4 ++++
 4 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.25.1

