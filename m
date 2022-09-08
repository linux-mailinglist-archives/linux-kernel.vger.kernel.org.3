Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A6C5B2211
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiIHPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIHPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:13 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7AD642E9;
        Thu,  8 Sep 2022 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650712; x=1694186712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hDSb+XpejSXznSrruCvll2dsJubMtNUBJt/0MMJvvvw=;
  b=E+NgY3MNEjoOmdjQ+QCXPq/AWjAvSqrZm6n+hdb5aU+PRr+IYO2fZwCW
   mSbOV+BvOvXBNTO9wveC+/Cwdn16LSpt6pMb9B64oJOxOzU4wi6Jecj6j
   SpYHTrNRgNd4Okl34bHe1pWHp2rX/6mhPKeqtmB9LI8hBn8oe7ulbzbEL
   0=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="242452848"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-828bd003.us-east-1.amazon.com (Postfix) with ESMTPS id 01FEC80FC4;
        Thu,  8 Sep 2022 15:25:08 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:51 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Thu, 8 Sep 2022 15:24:51 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:50 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 7A8A84D7B; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 16/21] dt-bindings: hwmon: (mr75203) add "moortec,ts-series" property
Date:   Thu, 8 Sep 2022 15:24:44 +0000
Message-ID: <20220908152449.35457-17-farbere@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908152449.35457-1-farbere@amazon.com>
References: <20220908152449.35457-1-farbere@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional "moortec,ts-series" property to define the temperature
equation and coefficients that shall be used to convert the digital
output to value in milli-Celsius.
Supported series: 5 (default) and 6.

Series 5:
  T = G + H * (n / cal5 - 0.5) + J * F
Where: G = 60, H = 200, cal5 = 4094, J = -0.1, F = frequency clock in MHz

Series 6:
   T = G + H * (n / cal5 - 0.5)
Where: G = 57.4, H = 249.4, cal5 = 4096

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Remove constraints in free-form text descriptions.

V3 -> V2:
- New patch to introduce "moortec,ts-series" property.

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index d6b03a6d7043..df849517464e 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -91,6 +91,15 @@ properties:
       Each channel should not appear more than once.
     $ref: /schemas/types.yaml#/definitions/uint8-array
 
+  moortec,ts-series:
+    description:
+      Definition of the temperature equation and coefficients that shall be
+      used to convert the digital output to value in milli-Celsius.
+    minimum: 5
+    maximum: 6
+    default: 5
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - reg
-- 
2.37.1

