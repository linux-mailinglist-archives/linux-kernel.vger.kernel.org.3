Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA55B2270
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiIHPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiIHPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:35:27 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6F97521;
        Thu,  8 Sep 2022 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662651324; x=1694187324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hv+fwEQC5an/F9wHg1jEj2hUKGXL4NsmFsndC4TDfS8=;
  b=eGArf8+PhHqUIOCQHJ/OVyeqye+9AUyaE0kFr08F8pWfItW31Lu+Q2jV
   YJ4P+tCMyQAWjNwG1Qiff0zk+KoyNN8w/Enp3t8QAw+Eo3mCGeAwQWU7x
   Wajhzlayy4BmHAXJF1iThS5KDNd3V9kxqNbeqKZAv4lfMM/ZLVYM05qs0
   E=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="1052561225"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-8bf71a74.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:11 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-8bf71a74.us-east-1.amazon.com (Postfix) with ESMTPS id 09007C14D9;
        Thu,  8 Sep 2022 15:25:08 +0000 (UTC)
Received: from EX19D013UWB001.ant.amazon.com (10.13.138.52) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB001.ant.amazon.com (10.13.138.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:52 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 813484CC3; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 11/21] dt-bindings: hwmon: (mr75203) add "moortec,vm-active-channels" property
Date:   Thu, 8 Sep 2022 15:24:39 +0000
Message-ID: <20220908152449.35457-12-farbere@amazon.com>
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

Add optional "moortec,vm-active-channels" property to define the number
of active channels per VM.

This shall be useful to avoid exposing sysfs for reading inputs that are
not connected to any voltage source.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V5 -> V4:
- Fix typo in description (nou --> not).

V4 -> V3:
- Fix DT checker errors.

V3 -> V2:
- Add "moortec" prefix to property name.
- Add explanation why this change is needed.

 .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 9454576ebb73..5d4bf0edea5c 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -70,6 +70,15 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
+  moortec,vm-active-channels:
+    description:
+      Defines the number of channels per VM that are actually used and are
+      connected to some input source.
+      Maximum number of items - number of VMs.
+      Maximum value of each item - number of channels.
+      Minimum value of each item - 0 (which means entire VM sensor is not used).
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+
 required:
   - compatible
   - reg
@@ -91,5 +100,6 @@ examples:
         intel,vm-map = [03 01 04 ff ff];
         clocks = <&osc0>;
         resets = <&rcu0 0x40 7>;
+        moortec,vm-active-channels = /bits/ 8 <0x10 0x05>;
         #thermal-sensor-cells = <1>;
     };
-- 
2.37.1

