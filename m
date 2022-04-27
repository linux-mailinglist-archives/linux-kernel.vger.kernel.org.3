Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1EA511916
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiD0Ou1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiD0OuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:50:25 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4823B022;
        Wed, 27 Apr 2022 07:47:10 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23R81IgO015990;
        Wed, 27 Apr 2022 07:47:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=ZkjC2O2JTugw9NVlaPZOH795JPuDrcFrT3UCFSc94C8=;
 b=gblrv+uWpteFiCXmO12s0asmfmfQ/oNTPiwG0EhGTsXrdDMF06MnRnmA2Pi4a8u4ndd2
 f2HJPNtD1eSXzCW0iV+kyhRpk1nJQF/yWGyWMt0530ltGAq/Zzmb6evNRMd1o3EglKQm
 uByAHhWG5yVuYbMb9zZ5z4Kk+gghhSu7tAJdqPrNb8UxdhdhPuYUIa9K/x0oBW+BPFPu
 EBN53dStfxECcePHPfa2cTq1A1P4McbxOPBAGf1C8cVFWKM/bS9G4VJ/EW17AhkbGMKS
 JIniBpJLHLzmwHqKnkVZqccd1mbbqOoGQRFvOfTBVHwhLYl/VpWNc2m+kad7kdQsFIO2 Sg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3fprt4k6u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 07:47:08 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 27 Apr
 2022 07:47:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 27 Apr 2022 07:47:06 -0700
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id D08FA3F7063;
        Wed, 27 Apr 2022 07:47:05 -0700 (PDT)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <rric@kernel.org>,
        <cchavva@marvell.com>, <wsadowski@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 2/5] dt-bindings: gpio: gpio-thunderx: Describe pin-cfg option
Date:   Wed, 27 Apr 2022 07:46:17 -0700
Message-ID: <20220427144620.9105-3-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427144620.9105-1-pmalgujar@marvell.com>
References: <20220427144620.9105-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1rhJ-vk_rVehFRlKEshunqQkzaFeuKHx
X-Proofpoint-GUID: 1rhJ-vk_rVehFRlKEshunqQkzaFeuKHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pin-cfg to configure GPIO Pins

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 Documentation/devicetree/bindings/gpio/gpio-thunderx.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-thunderx.txt b/Documentation/devicetree/bindings/gpio/gpio-thunderx.txt
index 3f883ae29d116887e702ead20b26a25f9d2349d5..05f0be98afdcae941ff8a24c3fdabd8af83ccb87 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-thunderx.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-thunderx.txt
@@ -14,6 +14,9 @@ Optional Properties:
                     "interrupt-controller" is present.
   - First cell is the GPIO pin number relative to the controller.
   - Second cell is triggering flags as defined in interrupts.txt.
+- pin-cfg: Configuration of pin's function, filters, XOR and output mode.
+  - First cell is the GPIO pin number
+  - Second cell is a value written to GPIO_BIT_CFG register at driver probe.
 
 Example:
 
@@ -24,4 +27,5 @@ gpio_6_0: gpio@6,0 {
 	#gpio-cells = <2>;
 	interrupt-controller;
 	#interrupt-cells = <2>;
+	pin-cfg = <57 0x2300000>, <58 0x2500000>;
 };
-- 
2.17.1

