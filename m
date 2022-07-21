Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576FC57CF59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiGUPgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:36:09 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852D10FE;
        Thu, 21 Jul 2022 08:35:58 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LAYWag012603;
        Thu, 21 Jul 2022 17:35:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=1pXeUjG+IPyOm6QGGzSeGLbNATZDNTkP9GyMkLtpAIs=;
 b=BXngkdNSBM0ivcOYXRuoTCDWItCd88muHKpepp19Ax6AOds9FeyyYogQhYbMBUroUiDi
 qXmN3PKWXTy3VDyh6QTPIfxX0hogZp9vhA8lP8rcRbboOV0p18bZX1D7fisKS8z/osAx
 tQs+uOcT76hVFceYAMti+uZyZVC0BD5ieUO7R86Rg9wS1uFhymicl82qmEqcdP8pu+gS
 H0MxZrV5NH0HJ2TiOFyaeayWXu3V7dslYoNCXairoEx9qFt4qN0yjwfRwvH/Vrsm9epx
 8TrhwQpryeRSMI98WJXZvPQ2uWGfGflaYES7OUSLpgzUfZMgrwMQI3mkrBCW+W9Ds3Fq eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hf55vher2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 17:35:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA7BE10002A;
        Thu, 21 Jul 2022 17:35:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A5B14226FDC;
        Thu, 21 Jul 2022 17:35:37 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 21 Jul
 2022 17:35:37 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/2] ARM: dts: stm32: add SPI on STM32MP13 platform
Date:   Thu, 21 Jul 2022 17:34:53 +0200
Message-ID: <20220721153455.3805586-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds DT entries related to all spi nodes for the
STM32MP13 platform.

Alain Volmat (2):
  ARM: dts: stm32: add spi nodes into stm32mp131.dtsi
  ARM: dts: stm32: add pinctrl and disabled spi5 node in stm32mp135f-dk

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 23 ++++++++
 arch/arm/boot/dts/stm32mp131.dtsi        | 70 ++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp135f-dk.dts     |  7 +++
 3 files changed, 100 insertions(+)

-- 
2.25.1

