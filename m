Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D284A827C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350151AbiBCKgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:36:19 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:12391 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350079AbiBCKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643884570; x=1675420570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=igCpq2ed9uEKRilOyfTmFH7ElwS1UppY/1wLHiQoOMg=;
  b=VVF6UrX2IO+Kl6BvVH/snDqk5s4mcHbXZ5i84OfetAotVM0NIqPUNYnV
   F4sl9B6MhcuaiBcZTwpy3Xu3S0FG27M3iZoDUml3mCPIulIRNcoF3MSPp
   rh7AVK+v8KCdJouFa5u+lPbCtBHmNIC773iBbuF2jwUAxEp+TA5nkE4em
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Feb 2022 02:36:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 02:36:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:35:48 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 3 Feb 2022 02:35:43 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V5 2/6] bindings: usb: dwc3: Update dwc3 properties for EUD connector
Date:   Thu, 3 Feb 2022 16:04:31 +0530
Message-ID: <48672133dbd76b2b274533b030233e7ba2db8fa6.1643880577.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1643880577.git.quic_schowdhu@quicinc.com>
References: <cover.1643880577.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ports property for dwc3 node. This port can be used
by the Embedded USB Debugger for role switching the controller
from device to host mode and vice versa.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index d29ffcd..2d831db1 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -332,6 +332,12 @@ properties:
     items:
       enum: [1, 4, 8, 16, 32, 64, 128, 256]

+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      This port is used with the 'usb-role-switch' property to connect the
+      dwc3 to type C connector.
+
 unevaluatedProperties: false

 required:
--
2.7.4

