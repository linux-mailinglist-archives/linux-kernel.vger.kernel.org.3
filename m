Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BD157FA83
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiGYHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiGYHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:53:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49BB12A96;
        Mon, 25 Jul 2022 00:53:28 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26P7F7Ua006897;
        Mon, 25 Jul 2022 09:53:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=/c2SOaFDssMPCp7DtxoyF6Nnd04FfjVIa2AavwMvoS4=;
 b=mSuuRGMTt+KiljIA6hxz8GIqxmsBMwCLU98dLkRL5SlQorffUR1JvT5XphCDTlMhQb5c
 ORKbmxeVu5XBINqI4Z5sr5kWNfGWEl+Hp5Ebq22Ljhdk5yK1+QT2jSwUp2hD2WTmszVa
 G0o5K25b22Mh/S2nfEytfLeTpjUjq1X11KR5D6QNwluKFbKTfgxwR8GKv8U+zHXKR5uy
 UppWE/tKVagW5eNE75oXlmcgy5VTHwl2cMkfvAVMbwaIO6p1727npd55T71vYvsM3sEf
 o1Nyht1zgZkFcAsHf9RoZM905jlG31HJsG+bm1Pyal3Z/DnEq7nB/aZcAXqOeCYh1i20 gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hg6dkg5e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 09:53:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B5EFE10002A;
        Mon, 25 Jul 2022 09:53:18 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AEF952122FA;
        Mon, 25 Jul 2022 09:53:18 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 25 Jul
 2022 09:53:18 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/2] ARM: dts: stm32: add SPI on STM32MP13 platform
Date:   Mon, 25 Jul 2022 09:52:53 +0200
Message-ID: <20220725075255.429869-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-23_02,2022-07-21_02,2022-06-22_01
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

v2: reorder all node properties, starting with compatible and reg

Alain Volmat (2):
  ARM: dts: stm32: add spi nodes into stm32mp131.dtsi
  ARM: dts: stm32: add pinctrl and disabled spi5 node in stm32mp135f-dk

 arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 23 ++++++++
 arch/arm/boot/dts/stm32mp131.dtsi        | 70 ++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp135f-dk.dts     |  7 +++
 3 files changed, 100 insertions(+)

-- 
2.25.1

