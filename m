Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A22580EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiGZIIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238233AbiGZIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:08:05 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B322F2F390;
        Tue, 26 Jul 2022 01:08:02 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q6Wn8d006752;
        Tue, 26 Jul 2022 10:07:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=DxSWau7EA7rpbtVckvWdUL4zS864AWpmRNAojK/nARc=;
 b=m/unKQNZEUZXM+DdwW9CiY7QC2ynGE+RLeNCfs5QiZlGiPXw7PMsKD8Xz4Gf2CfH3Klb
 VWsNtj/Yx0yyoSuw4IwVUwomBhn5sMu/OwPGXfRarfAGnKlO4ty7f11WGEjyuceY7G4K
 SBNKb5NUIGkkxy39rKSfPwm9oFIR/S6uDQS7B9qUBKPL20OQ031gT6WAo7ogB5cXaYtj
 Xj5+Sj3yf8hww115aojdh0WKjD0FtVAqPJBIGP4pA24VvVZNzrkWzVnzcN8+C6lMKfY1
 2j6bC3GQV8SF9HCypUgkdbbzxjHmGlDle+LiBWRBxD9/zDJQ/CIJ1T0H8aJqjYtRYVY0 oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hg8b0xank-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 10:07:33 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E9AB9100039;
        Tue, 26 Jul 2022 10:07:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3E2E2128A3;
        Tue, 26 Jul 2022 10:07:32 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 26 Jul
 2022 10:07:32 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mka@chromium.org>, <alexandre.torgue@foss.st.com>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <arnd@arndb.de>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: enable USB onboard HUB driver
Date:   Tue, 26 Jul 2022 10:07:08 +0200
Message-ID: <20220726080708.162547-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726080708.162547-1-fabrice.gasnier@foss.st.com>
References: <20220726080708.162547-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_02,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB onboard HUB driver, used on STM32MP1 boards.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ce9826bce29b3..d0f16b7f682bf 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -861,6 +861,7 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
+CONFIG_USB_ONBOARD_HUB=m
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=m
 CONFIG_NOP_USB_XCEIV=y
-- 
2.25.1

