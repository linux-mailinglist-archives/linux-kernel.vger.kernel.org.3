Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDDB51800A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiECIuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiECIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:49:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D635ABB;
        Tue,  3 May 2022 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651567559; x=1683103559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/CKKh3POM+OwTtOgQF4Jp8Ls8i/luVYOEHzUs8doLs=;
  b=O34AD+BA2epE45bU59Z0YyDpQO30Rw82T6AdUuGPpQvz7JqUQSDhZwp2
   xcJb0yDhxGTstnDVXGSbNVmXwJGeSt7VoUvDVgPqAKeH5Uc2DICKd+bw6
   w0/Vwoiz85CqzDkU+/BSsHhanuihys7unHwGx04nbpMDJ55aDoMSCRb5N
   S9eBgTR66D0WUWxASb6BkbKE8OdkzLHfvXEvx/6Ukp+8rmgWwaZGJ+FG+
   HjukJYDPNrUAytcJs9ylpGV7Vkz+ptH0y80DxkNNl5zkg4z9rVYXT/eDw
   gVsF70qd68A6w2kZIIwM7xNYTwmKo3NfN7muxxeZ52hyJdGY6Mp4YjZK8
   g==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="162525584"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 01:45:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 01:45:58 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 01:45:46 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jacopo@jmondi.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v10 8/8] dt-bindings: media: microchip,xisc: add bus-width of 14
Date:   Tue, 3 May 2022 11:44:21 +0300
Message-ID: <20220503084421.40682-9-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503084421.40682-1-eugen.hristev@microchip.com>
References: <20220503084421.40682-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

