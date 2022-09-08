Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15805B221F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbiIHPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiIHPZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:25:15 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396FC80B70;
        Thu,  8 Sep 2022 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1662650715; x=1694186715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j9nLXsVxOy0JGDU7T6OUbxf37zFCWFjVBH7FijS2nao=;
  b=vd55KUJ5RKYkBCWgmKzZ3kigSx0EDquhN2F/GAilXX2ZmCWY/9BHXDez
   88jrgyCILA+stQUHGzmHBZmYuQ5MW/oXQIswdd2bel7JjxCHPO1EjLAcR
   X4KEy0CHOAcyKTlu+bT0G3QWuVeyUlz+FMaIFwUYW7sizqq7wRs68qvXL
   0=;
X-IronPort-AV: E=Sophos;i="5.93,300,1654560000"; 
   d="scan'208";a="242452851"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-0bfdb89e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:25:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-0bfdb89e.us-east-1.amazon.com (Postfix) with ESMTPS id 4B220E008A;
        Thu,  8 Sep 2022 15:25:09 +0000 (UTC)
Received: from EX19D013UWB004.ant.amazon.com (10.13.138.62) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Thu, 8 Sep 2022 15:24:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D013UWB004.ant.amazon.com (10.13.138.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.12; Thu, 8 Sep 2022 15:24:52 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Thu, 8 Sep 2022 15:24:52 +0000
Received: by dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com (Postfix, from userid 14301484)
        id 8294F4CAF; Thu,  8 Sep 2022 15:24:49 +0000 (UTC)
From:   Eliav Farber <farbere@amazon.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <rtanwar@maxlinear.com>,
        <andriy.shevchenko@intel.com>, <linux-hwmon@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <farbere@amazon.com>, <hhhawa@amazon.com>, <jonnyc@amazon.com>
Subject: [PATCH v5 07/21] dt-bindings: hwmon: (mr75203) add description for Moortec's PVT controller
Date:   Thu, 8 Sep 2022 15:24:35 +0000
Message-ID: <20220908152449.35457-8-farbere@amazon.com>
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

This changes adds a detailed description for the mr75203 controller and
for some of the analog IPs controlled by it.

Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V4 -> V3:
- New patch to add description.

 .../bindings/hwmon/moortec,mr75203.yaml       | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
index 8ea97e774364..5e41aed5891a 100644
--- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -9,6 +9,32 @@ title: Moortec Semiconductor MR75203 PVT Controller bindings
 maintainers:
   - Rahul Tanwar <rtanwar@maxlinear.com>
 
+description: |
+  A Moortec PVT (Process, Voltage, Temperature) monitoring logic design can
+  include many different units.
+  Such a design will usually consists of several Moortec's embedded analog IPs,
+  and a single Moortec controller (mr75203) to configure and control the IPs.
+
+  Some of the Moortec's analog hard IPs that can be used in a design:
+  *) Temperature Sensor (TS) - used to monitor core temperature (e.g. mr74137).
+  *) Voltage Monitor (VM) - used to monitor voltage levels (e.g. mr74138).
+  *) Process Detector (PD) - used to assess silicon speed (e.g. mr74139).
+  *) Delay Chain - ring oscillator connected to the PD, used to measure IO
+     based transistors (e.g. mr76008 ring oscillator at 1.1V, mr76007 ring
+     oscillator at 1.8V).
+  *) Pre Scaler - provides divide-by-X scaling of input voltage, which can then
+     be presented for VM for measurement within its range (e.g. mr76006 -
+     divide by 2 pre-scaler).
+
+  TS, VM & PD also include a digital interface, which consists of configuration
+  inputs and measurement outputs.
+
+  Some of the units have number of series, each series can have slightly
+  different characteristics.
+
+  The mr75203 binding describes configuration for the controller unit, but also
+  for some of the analog IPs.
+
 properties:
   compatible:
     const: moortec,mr75203
-- 
2.37.1

