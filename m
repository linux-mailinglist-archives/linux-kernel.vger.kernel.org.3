Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3D4950D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376471AbiATPBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:01:36 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33175 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359550AbiATPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:00:54 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C02DB200005;
        Thu, 20 Jan 2022 15:00:51 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v10 4/6] dt-bindings: display: Add compatibles with major versions only
Date:   Thu, 20 Jan 2022 16:00:22 +0100
Message-Id: <20220120150024.646714-5-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are lots of different versions of the logicvc block and it
makes little sense to list them all in compatibles since all versions
with the same major are found to be register-compatible.

Add common compatibles that only list the major version instead.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../devicetree/bindings/display/xylon,logicvc-display.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
index fc02c5d50ce4..3b8184d3ef9c 100644
--- a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
+++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
@@ -30,7 +30,10 @@ properties:
   compatible:
     enum:
       - xylon,logicvc-3.02.a-display
+      - xylon,logicvc-3-display
       - xylon,logicvc-4.01.a-display
+      - xylon,logicvc-4-display
+      - xylon,logicvc-5-display
 
   reg:
     maxItems: 1
-- 
2.34.1

