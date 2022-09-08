Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E9F5B2209
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIHPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIHPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:08 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3F79690;
        Thu,  8 Sep 2022 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650709; x=1694186709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpzOxoGNQ6tnnJxPNM+PQd7AzPUO8y2q0RM8YZJxdzc=;
  b=Awgoq7KGjGWOcpP3BaxPVHfxqLKZxAszuAO8fLbTG6bokVC9weyMG69U
   tIpW3cv9ML/3GTZN5NZ2zGrjH7dHFQFJUoLf7/TSVpKdKsye/vGKwuhHk
   vW7+0kumN/dYcINeKqMARs4reQGRwFRJrD307+gzoqJAWpb+pPxBX4UaT
   8=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="242452725"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:24:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com (Postfix) with ESMTPS id 48D1AC030F;
        Thu,  8 Sep 2022 15:24:52 +0000 (UTC)
Received: from EX19D013UWB002.ant.amazon.com (10.13.138.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:51 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX19D013UWB002.ant.amazon.com (10.13.138.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:51 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:50 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 78F774D16; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 13/21] dt-bindings: hwmon: (mr75203) add "moortec,vm-pre-scaler-x2" property
Date:   Thu, 8 Sep 2022 15:24:41 +0000
Message-ID: <20220908152449.35457-14-farbere@amazon.com>
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

Add support for mr76006 pre-scaler which provides divide-by-2 scaling of
the input voltage, so that it can be  presented to the VM for measurement
within its range (the VM input range is limited to -0.1V to 1V).

The new "moortec,vm-pre-scaler-x2" property lists the channels that use
the mr76006 pre-scaler.

The driver will use this list to multiply the voltage result by 2, to
present to the user with the actual voltage input source.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- Rename "moortec,vm-pre-scaler" to "moortec,vm-pre-scaler-x2".
- Added mximum number if items in description.

V3 -> V2:
- Add "moortec" prefix to property name.
- Change property format to be a single u8 array.
- Fix typo: scalar --> scaler.

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 5d4bf0edea5c..d6b03a6d7043 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -79,6 +79,18 @@ properties:
       Minimum value of each item - 0 (which means entire VM sensor is not used).
     $ref: /schemas/types.yaml#/definitions/uint8-array
 
+  moortec,vm-pre-scaler-x2:
+    description:
+      Defines the channels that use a mr76006 pre-scaler to divide the input
+      source by 2.
+      The pre-scaler is used for input sources that exceed the VM input range.
+      The driver uses this information to present to the user with the actual
+      value of the voltage source.
+      For channels that are not listed, no pre-scaler is assumed.
+      Maximum number of items - total number of channels in all VMs.
+      Each channel should not appear more than once.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+
 required:
   - compatible
   - reg
@@ -101,5 +113,6 @@ examples:
         clocks = <&osc0>;
         resets = <&rcu0 0x40 7>;
         moortec,vm-active-channels = /bits/ 8 <0x10 0x05>;
+        moortec,vm-pre-scaler-x2 = /bits/ 8 <5 6 20>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

