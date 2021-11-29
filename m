Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A2461C81
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348265AbhK2ROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:14:12 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:38454 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346043AbhK2RMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:12:09 -0500
Received: from Monstersaurus.local (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A78F42A5;
        Mon, 29 Nov 2021 18:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638205730;
        bh=e1y61Mgloav2WdMgYxa58Sf1c4wfZ5W8NCesGLzRmeQ=;
        h=From:To:Cc:Subject:Date:From;
        b=a50gaqYsQ7CGeI3zThv3Y6H2CM4T6xRO1Zoz931+bKqe7ac4N7QcpDUVmbNidR5eV
         IrzNVlTzXncfvjzbOTe9jZ2QPwVvDgDPa8zLs+ft5FN677t3Q0jfL1vqX882snbeFH
         2NVc/D243yXhozVETZLeJ2ttvnhhbzGnVGAqf0/Q=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm: rcar-du: Add DSI support to rcar_du_output_name
Date:   Mon, 29 Nov 2021 17:08:45 +0000
Message-Id: <20211129170845.2269532-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI output names were not added when the DSI pipeline support was
introduced.

Add the correct labels for these outputs, and fix the sort order to
match 'enum rcar_du_output' while we are here.

Fixes: b291fdcf5114 ("drm: rcar-du: Add r8a779a0 device support")
Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 5612a9e7a905..5a8131ef81d5 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -544,10 +544,12 @@ const char *rcar_du_output_name(enum rcar_du_output output)
 	static const char * const names[] = {
 		[RCAR_DU_OUTPUT_DPAD0] = "DPAD0",
 		[RCAR_DU_OUTPUT_DPAD1] = "DPAD1",
-		[RCAR_DU_OUTPUT_LVDS0] = "LVDS0",
-		[RCAR_DU_OUTPUT_LVDS1] = "LVDS1",
+		[RCAR_DU_OUTPUT_DSI0] = "DSI0",
+		[RCAR_DU_OUTPUT_DSI1] = "DSI1",
 		[RCAR_DU_OUTPUT_HDMI0] = "HDMI0",
 		[RCAR_DU_OUTPUT_HDMI1] = "HDMI1",
+		[RCAR_DU_OUTPUT_LVDS0] = "LVDS0",
+		[RCAR_DU_OUTPUT_LVDS1] = "LVDS1",
 		[RCAR_DU_OUTPUT_TCON] = "TCON",
 	};
 
-- 
2.30.2

