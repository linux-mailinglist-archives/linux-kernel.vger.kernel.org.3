Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA17475945
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhLONDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:03:49 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:17522 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbhLONDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:03:46 -0500
DKIM-Signature: a=rsa-sha256;
        b=Xcnpz43d96ixOhjKbIoz3nTN2XBOCLGnbSwJl4kORqdvEhoYA6m1nWexJxQ7kHKxNPQ/eJ4b9L+QykT1WZt0EtgExyUrDLngL/bv8eBDALkWVa42uUt51/rZxjS3wpg9OpknHzbKvGolVaRxDaaEeeDiphADSa89diXfkI99j4k=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=gp9G8fD9SvFvFKbEi5b+RrRGNoHnTtCoegum1Bq3PVo=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id 12DAD7E034F;
        Wed, 15 Dec 2021 21:03:41 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Yaqin Pan <akingchen@vivo.com>
Subject: [PATCH 2/2] dt-bindings: usb: document snps,dis_split_quirk property in dwc3
Date:   Wed, 15 Dec 2021 21:03:24 +0800
Message-Id: <20211215130325.19017-3-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215130325.19017-1-akingchen@vivo.com>
References: <20211215130325.19017-1-akingchen@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUMaTxpWSx4ZT08ZGkkYGR
        1NVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OBw6KRw*Sj5LLTJRMREXHE80
        ODAKCR9VSlVKTUhCTkxIT0lKTElIVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSUpPTDcG
X-HM-Tid: 0a7dbe30fd74d999kuws12dad7e034f
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
 
+  snps,dis_split_quirk:
+    description:
+      When set, change the way host controller schedules transations for a Control transfer.
+      Needed to avoid emurate some devices fail.
+    type: boolean
+
   snps,is-utmi-l1-suspend:
     description:
       True when DWC3 asserts output signal utmi_l1_suspend_n, false when
-- 
2.17.1

