Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958B94A4C69
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380596AbiAaQrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:47:51 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:59831 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380519AbiAaQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:47:49 -0500
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id DD7AB240010;
        Mon, 31 Jan 2022 16:47:44 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 3/3] dt-bindings: ltk050h3146w: add compatible for LTK050H3148W-CTA6 variant
Date:   Mon, 31 Jan 2022 17:47:23 +0100
Message-Id: <20220131164723.714836-3-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
References: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The LTK050H3148W-CTA6 is a 5.0" 720x1280 DSI display, whose driving
controller is a Himax HX8394-F, slightly different from LTK050H3146W by
its init sequence, mode details and mode flags.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
index 3715882b63b6..63d2a00348e9 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - leadtek,ltk050h3146w
       - leadtek,ltk050h3146w-a2
+      - leadtek,ltk050h3148w
   reg: true
   backlight: true
   reset-gpios: true
-- 
2.34.1

