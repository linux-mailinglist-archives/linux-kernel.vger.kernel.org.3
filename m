Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5A4705D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbhLJQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:40:07 -0500
Received: from smtpcmd12131.aruba.it ([62.149.156.131]:55715 "EHLO
        smtpcmd12131.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbhLJQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:40:05 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vislmYA0XYYTXvismmI42k; Fri, 10 Dec 2021 17:36:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639154189; bh=7QfRhQQnlCEgknaEeOJk7injUfpmrQE+35+P/xSdOb8=;
        h=From:To:Subject:Date:MIME-Version;
        b=QcWgMSTG4+C25Mom93z0+9Ug8/89dCVcmRzyXbjDksFrcD2Ko8vj1xHQETBTBZdNQ
         yye0BFqgyuCJUYMr9FCsuWKY8zfrVwlqW35mmrEKUcI9sfqJceDDS7KQk+5Uykr4QM
         Tnw1bkWW1hkC4+n1koLQrKT3gvKeFsRcfR520bcDZBV+HHRxQqM4aEDn/dQIlrKkVG
         xHW8zrZxRw1PokY3BTc93vVXAQ1I6+1mELNhHSctSxDVu1He/4AlPyTVo+qIUbdvk7
         1I371tv0JjT83PTg7jzbPEgGrFdHbJ8NMSswprG7Wx9Smx1jLl8VwQyP2c1fyJkc85
         lB+/S3dsfoVVw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 1/2] drm/panel: panel-simple: add bus_format and connector_type to cdtech_s043wq26h_ct7 panel
Date:   Fri, 10 Dec 2021 17:36:22 +0100
Message-Id: <20211210163623.1063057-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJNrrbQYla2HqVHWbA09kx4xx3WwZymz1asPPI3y7ILhWC40d7HUBXZ+sPF+SMjUOtAvRq0r0IYp36jyc0d9vBE32Ur9ESJSB27c0yuW5F9MM2sURGcF
 Iay99tUvuchhNxgAuADlVvVUJeNy92m3BPnEHX+woQ4fvTiRmAOWuG5QKAPPSQg5HZRFqxlWn92IkkyWaXZnFz+W6snqCljiSNyS6h8cMSyMnesenqQiXptP
 Pkki+VLrgovwk/U5AtgBG+UwxWNJn0SxQLD8Clfejx87gHZEhZ9lpbqM7Ss8pDsZygT4ZoyciY5H/AmmCy6QBP7pYjffOy2FVfaDYDDFCwv+Fkwd3uYN+rmw
 TXrGR1eZ8ZHtBuQsTRnds3i9LGJsyY2oUF8/4fv+HTJX3+Ea6yjrRSiN2a4IMb40DocSr4pIBvsJtHcQZ72CxI3tXh4xiw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bus_format and connector_type to cdtech_s043wq26h_ct7 panel.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index eb475a3a774b..c8ad713865cb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1215,7 +1215,9 @@ static const struct panel_desc cdtech_s043wq26h_ct7 = {
 		.width = 95,
 		.height = 54,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 /* S070PWS19HP-FC21 2017/04/22 */
-- 
2.25.1

