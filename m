Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D837447BE42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhLUKoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:44:07 -0500
Received: from aposti.net ([89.234.176.197]:53538 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhLUKoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:44:06 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] dt-bindings: iio: Document "label" property
Date:   Tue, 21 Dec 2021 10:43:54 +0000
Message-Id: <20211221104354.35073-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All iio devices can have a label, which will be carried on to userspace
as a sysfs attribute. This is useful when having several iio devices
that represent different instances of the same hardware, as the name
attribute would then not be enough to differentiate between them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/iio/common.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/common.yaml b/Documentation/devicetree/bindings/iio/common.yaml
index f845b41d74c4..a90ad7718ecf 100644
--- a/Documentation/devicetree/bindings/iio/common.yaml
+++ b/Documentation/devicetree/bindings/iio/common.yaml
@@ -32,6 +32,14 @@ properties:
       considered 'near' to the device (an object is near to the
       sensor).
 
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      All iio devices can have a label, which will be carried on to userspace
+      as a sysfs attribute. This is useful when having several iio devices that
+      represent different instances of the same hardware, as the name attribute
+      would then not be enough to differentiate between them.
+
 additionalProperties: true
 
 ...
-- 
2.34.1

