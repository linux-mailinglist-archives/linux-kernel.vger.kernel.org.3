Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0324BA23F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbiBQOBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:01:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbiBQOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:01:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018162B101B;
        Thu, 17 Feb 2022 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106442; x=1676642442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/CKKh3POM+OwTtOgQF4Jp8Ls8i/luVYOEHzUs8doLs=;
  b=1xz39sK3DDobDrjxNIoUr1AID1yvrT+wGOWF/MCqYen84oiI9nuV+MnK
   c9uq1k1QeXdaCjUcG10R4emD+lMxMwXVI2lF9pnXTvrq3NlN7oSxWC9gp
   7nZwgB4qhp18bNzKuCBMMcZBfLT4Pf8muoW8xIXui3Y6HFrHn8N6Yeqky
   3pTt6D00PboahkQn71FVRSAn+UZWr9vEvHowSr6B3yeHrh4PLRwlU5TbK
   pqG3QnmIaTvbcLOnFvInXeyViYYBvEfZzMvud+C/7RQDo6W5LMi0tLEGr
   ELDBhN+bntynb1Jh8zy5pCH5xakWFdAyXsa5oeOhxgCbtlEdcM4twsF/L
   Q==;
IronPort-SDR: /HLd2XTUhR5gJQslo8ozSBGqhqh95+cUP8yEg1/kJVLpyiF1W1fqdM7QzM3W0TCOW54oA5DkWa
 L7TcK6876CGiGPUsPR7J0GBnvmsBwavJhZSRr1nFEvwWoBrRjcsE5Z1dqXQf2sqM9JEVKJ/qr7
 Pll8iVLGoBn6Hw44uFjPmN824wzJLLtOgxCW7gsrfflt/VK81jESKL8uQp7NP/h0jRQgqU0RCG
 oS9j4rOZJCnMozGlzWCmszHBbfpXxDniDZzCVEJSNQVEn1iZ20E6hfPWkIMJSC7PFiL2w8uNc4
 rZb41lUV0kzXukxQk4GkuqR+
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="149064476"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 07:00:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 07:00:41 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 07:00:21 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 10/13] dt-bindings: media: microchip,xisc: add bus-width of 14
Date:   Thu, 17 Feb 2022 15:56:42 +0200
Message-ID: <20220217135645.1427466-11-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip XISC supports a bus width of 14 bits.
Add it to the supported bus widths.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/media/microchip,xisc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/microchip,xisc.yaml b/Documentation/devicetree/bindings/media/microchip,xisc.yaml
index 086e1430af4f..3be8f64c3e21 100644
--- a/Documentation/devicetree/bindings/media/microchip,xisc.yaml
+++ b/Documentation/devicetree/bindings/media/microchip,xisc.yaml
@@ -67,7 +67,7 @@ properties:
           remote-endpoint: true
 
           bus-width:
-            enum: [8, 9, 10, 11, 12]
+            enum: [8, 9, 10, 11, 12, 14]
             default: 12
 
           hsync-active:
-- 
2.25.1

