Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7A94D43F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbiCJJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241056AbiCJJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:54:15 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45CBE9C;
        Thu, 10 Mar 2022 01:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646905981; x=1678441981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/CKKh3POM+OwTtOgQF4Jp8Ls8i/luVYOEHzUs8doLs=;
  b=X7UsTWUq5/r8N1IMnIPVcDSVpCY9vsmH6SAsrnGcWYtitE2HNpGqOvGI
   YtBfd9NS9PgKcyXe+dmk2D/Io4nOKtP5Oewks5jFM2ggkD+hy9/SmRb50
   xjN+zzCqxla8f/BGsIDarppxc8IbSBwfnIe9SNMt6twdtb8W1g+SDERHI
   s2y5UesZft+tzVHbs4wmJpE4+bHJbSlypS/QRcRqrHdMaxQjn83IePmy1
   QnGPrS2b5F9HQsygh6wwI0MDDJ2/LKi01yM529RfDinNNZL4YMyiCYCYd
   ckFl626tQDwXXVVziDE8L9IOmUrqYVJ9dBp6+unRskH/SWnzn6JGpgDW8
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643698800"; 
   d="scan'208";a="155948572"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 02:53:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 02:52:59 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Mar 2022 02:52:57 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 10/13] dt-bindings: media: microchip,xisc: add bus-width of 14
Date:   Thu, 10 Mar 2022 11:51:59 +0200
Message-ID: <20220310095202.2701399-11-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095202.2701399-1-eugen.hristev@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
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

