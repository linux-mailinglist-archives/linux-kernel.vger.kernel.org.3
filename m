Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B6647AB2A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhLTOQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:16:48 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:43060 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbhLTOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:16:46 -0500
DKIM-Signature: a=rsa-sha256;
        b=R9zqtvJhUW6wbOwr/rcpDxVdDEncsssB78Mnjwf/WsGg7R8l16nN7hl0CMp5FqaUQX+gziCS6rOWq3gUhU+zK7wfom0BpKYClVcB5nI1Znxc1xGCiYVJGOUXT/MJrB/DdzdlOcRu+DbMVvFDoWaYCWIBzwTwsHxMorA83wQp1R0=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=+ZGwriAJuyiQ/6DWrKMeVo79MPMyTH9IttdMkKzZ/T4=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.250.176.229])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id D8AD67E0328;
        Mon, 20 Dec 2021 22:16:43 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH v2 2/2] dt-bindings: usb: document snps,dis_split_quirk property in dwc3
Date:   Mon, 20 Dec 2021 22:16:29 +0800
Message-Id: <20211220141629.14282-3-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220141629.14282-1-akingchen@vivo.com>
References: <20211220141629.14282-1-akingchen@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIZTUlWGENJSkxMS0lDSR
        gaVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6Tzo6GD5LEyoPLUtCLA0Z
        GjUaCQ9VSlVKTU9LS0tCQ0tPSEJLVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOS1VKTE1VSUlCWVdZCAFZQUlKQ0g3Bg++
X-HM-Tid: 0a7dd833a95bd999kuwsd8ad67e0328
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add snps,dis_split_quirk property for dwc3 controller

Signed-off-by: Yaqin Pan <akingchen@vivo.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 41416fbd92aa..e9615ca8f447 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -226,6 +226,12 @@ properties:
       avoid -EPROTO errors with usbhid on some devices (Hikey 970).
     type: boolean
 
+  snps,dis-split-quirk:
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

