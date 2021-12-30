Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50373481CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhL3OEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:04:51 -0500
Received: from mail-m17657.qiye.163.com ([59.111.176.57]:10718 "EHLO
        mail-m17657.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbhL3OEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:04:47 -0500
DKIM-Signature: a=rsa-sha256;
        b=KUEDStXckAtztTshgFDnh7jDmwNopP7UVG9mB2OULMJB25jtSA+9eNgAeP1+QK2xC6ww/GByqZ6fNeirXkGbjbO0Ccr1Ok4mYLcfXAPT87ydfvYM4SXJ+aCeGEWdvpqkR1h6MN//qO5OQsGSXq9J/SKwwLMnxBhIt6kmn0Uvw3E=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=xpKKS0qqZkQyHog/qbonODBiKgIt7QbYO2CMS+1sO7I=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17657.qiye.163.com (Hmail) with ESMTPA id 78B822802C1;
        Thu, 30 Dec 2021 21:59:25 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH v3 2/2] dt-bindings: usb: document snps,sprs-ctrl-trans-quirk property in dwc3
Date:   Thu, 30 Dec 2021 21:58:31 +0800
Message-Id: <20211230135832.23005-3-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230135832.23005-1-akingchen@vivo.com>
References: <20211230135832.23005-1-akingchen@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRoaSxpWHhhIHR9PTxoYSU
        kdVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nio6MRw*PT5KNREtCR0oHyks
        TQgwCR1VSlVKTU9LQ0xJTE1OQkNPVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSUlLTDcG
X-HM-Tid: 0a7e0ba3691dda03kuws78b822802c1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add snps,sprs-ctrl-trans-quirk property for dwc3 controller

Signed-off-by: Yaqin Pan <akingchen@vivo.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 41416fbd92aa..7a127f0cb530 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -226,6 +226,12 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,sprs-ctrl-trans-quirk:
+    description:
+      When set, change the way host controller schedules transations for a Control transfer.
+      Avoid failing to enumerate some devices due to usb compatibility issues.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.17.1

