Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0544898BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245589AbiAJMix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:38:53 -0500
Received: from comms.puri.sm ([159.203.221.185]:56914 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245525AbiAJMik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:38:40 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 67E5BDF912;
        Mon, 10 Jan 2022 04:38:40 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sDB5YdZFhPxl; Mon, 10 Jan 2022 04:38:39 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     mchehab@kernel.org, robh@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        geert@linux-m68k.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/2] dt-bindings: media: hynix,hi846: add link-frequencies description
Date:   Mon, 10 Jan 2022 13:38:04 +0100
Message-Id: <20220110123804.377944-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220110123804.377944-1-martin.kepplinger@puri.sm>
References: <20220110123804.377944-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

link-frequencies is required but only mentioned in the example. Add
it to the description.

Fixes: f3ce7200ca18 ("media: dt-bindings: media: document SK Hynix Hi-846 MIPI CSI-2 8M pixel sensor")
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
index e61255cf3fb9..6b917337ceac 100644
--- a/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml
@@ -68,8 +68,11 @@ properties:
                   - const: 1
                   - const: 2
 
+          link-frequencies: true
+
         required:
           - data-lanes
+          - link-frequencies
 
 required:
   - compatible
-- 
2.30.2

