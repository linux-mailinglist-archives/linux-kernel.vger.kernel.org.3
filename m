Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB30457CEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiGUPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:30:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865626ED;
        Thu, 21 Jul 2022 08:30:09 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26L9eg42006844;
        Thu, 21 Jul 2022 17:29:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=AI3xjtjTZIAaatsI0ZacNwbn9jQQKBbOlZvWXacEyzI=;
 b=Ywh/qznhcuPD7PalYsxWAlC7nt9WTMTteEIqKBvKzjlkExXDHWgZmgtxO0QHXQSVXXTS
 z5WY3s91IvM1NVIxEPOpjsiAcqTmUttLLhEroZsOPue5ZNX7NWl34EEuqiZbim9j9SR3
 3NCM4PQH6piaI2dYXwbvu6oAiCoU8XHnbeqKLJAkoKg2YSiuU4LUYwXI94g86SuHkt0s
 SvpI28xhuy3vySrMAgLgcUb3jyohFwNDia0O6IZqCPFuHI8XDnC/EU3NzlA4/fw6UgmR
 xNqNy8EkLilBIG9nl/E+UnMvowSsJDPRPKA6rUwbUkKJqIkR5pVZ/tZlQqAL0H2LQtGV dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnp6du3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jul 2022 17:29:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1600110002A;
        Thu, 21 Jul 2022 17:29:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1151B226FC6;
        Thu, 21 Jul 2022 17:29:52 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 21 Jul
 2022 17:29:51 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/2] ARM: dts: stm32: add i2c in STM32MP13
Date:   Thu, 21 Jul 2022 17:29:31 +0200
Message-ID: <20220721152933.3805272-1-alain.volmat@foss.st.com>
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

This series adds all i2c nodes for the stm32mp131 platform and
enables i2c1 and i2c5 on the stm32mp135 discovery board.

Alain Volmat (2):
  ARM: dts: stm32: add i2c nodes into stm32mp131.dtsi
  ARM: dts: stm32: enable i2c1 and i2c5 on stm32mp135f-dk.dts

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 34 +++++++++
 arch/arm/boot/dts/stm32mp131.dtsi        | 90 ++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp135f-dk.dts     | 26 +++++++
 3 files changed, 150 insertions(+)

-- 
2.25.1

