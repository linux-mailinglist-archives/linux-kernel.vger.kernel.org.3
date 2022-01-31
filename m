Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E04A4C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380656AbiAaQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiAaQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:55:02 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jan 2022 08:55:01 PST
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914BC061714;
        Mon, 31 Jan 2022 08:55:01 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 09D8F1BF204;
        Mon, 31 Jan 2022 16:54:56 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH] dt-bindings: ltk050h3146w: replace Heiko Stuebner by myself as maintainer
Date:   Mon, 31 Jan 2022 17:54:39 +0100
Message-Id: <20220131165439.717713-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Heiko does not work at Theobroma Systems anymore and the boards using
those panels are downstream, maintained internally by the company, so
let's relieve Heiko of maintainership duties.

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
index 63d2a00348e9..a40ab887ada7 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Leadtek LTK050H3146W 5.0in 720x1280 DSI panel
 
 maintainers:
-  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
+  - Quentin Schulz <quentin.schulz@theobroma-systems.com>
 
 allOf:
   - $ref: panel-common.yaml#
-- 
2.34.1

