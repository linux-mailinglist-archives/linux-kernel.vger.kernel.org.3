Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667A647C0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhLUNdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:33:47 -0500
Received: from aposti.net ([89.234.176.197]:39034 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231741AbhLUNdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:33:46 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2] dt-bindings: iio: Document "label" property
Date:   Tue, 21 Dec 2021 13:33:39 +0000
Message-Id: <20211221133339.66766-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "label" property, which can contain a descriptive label
that allows to uniquely identify a device within the system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Reword description and commit message
        - Use > instead of | for proper multiline handling

 Documentation/devicetree/bindings/iio/common.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/common.yaml b/Documentation/devicetree/bindings/iio/common.yaml
index f845b41d74c4..49f9f62dbb3e 100644
--- a/Documentation/devicetree/bindings/iio/common.yaml
+++ b/Documentation/devicetree/bindings/iio/common.yaml
@@ -32,6 +32,12 @@ properties:
       considered 'near' to the device (an object is near to the
       sensor).
 
+  label:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: >
+      Optional descriptive label that allows to uniquely identify a device
+      within the system.
+
 additionalProperties: true
 
 ...
-- 
2.34.1

