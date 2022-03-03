Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAF4CBFB4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiCCON7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbiCCONx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:13:53 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DB18CC31;
        Thu,  3 Mar 2022 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646316786; x=1677852786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mw3l0iGOywkqPQnUnJMMMA0UyYwQBMd/QJwYxJQH7p0=;
  b=Qw0XZz4qj0lyluD0ZfsC5zMYDIgusdHnFS7uKVHox2b/D9dZwsP+8wq1
   S5saiqbw8Nzi74TT4LbN3lcM5i+IVgBT/FRq2VtchYp83osx8UnFN2DJC
   KF/QpsG7IT6jqx9Nj8C+nfjIWBUXA2ExRF45N5oaoLfUbhAbkXkjEQKEA
   5v07XretxI9NEukbY9NtRh10KkwEahV4All2UC7BJ5ERJ+5lC/PDsM+c3
   RZim1DW/UhCSyTLSD065y9gIxvqsSzK1g9fgg3rbbruXuqKhpJPfRw4So
   4FytA+2lmd8sDQcsyTxruu/5EBaY23y75fkRqaCq6Ff05UF5VQZ+4+DFH
   w==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643698800"; 
   d="scan'208";a="155125707"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 07:13:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 07:12:59 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 07:12:54 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2 5/5] dt-bindings: rtc: at91: Add SAMA7G5 compatible strings list
Date:   Thu, 3 Mar 2022 16:06:26 +0200
Message-ID: <20220303140626.38129-6-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303140626.38129-1-sergiu.moga@microchip.com>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings list for SAMA7G5.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
index 5a639c0ec2c0..d87aa67b442f 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.yaml
@@ -21,6 +21,10 @@ properties:
       - items:
           - const: microchip,sam9x60-rtt
           - const: atmel,at91sam9260-rtt
+      - items:
+          - const: microchip,sama7g5-rtt
+          - const: microchip,sam9x60-rtt
+          - const: atmel,at91sam9260-rtt
 
   reg:
     maxItems: 1
-- 
2.25.1

