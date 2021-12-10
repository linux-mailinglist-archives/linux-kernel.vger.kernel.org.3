Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530E64705D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbhLJQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:40:08 -0500
Received: from smtpcmd12131.aruba.it ([62.149.156.131]:42331 "EHLO
        smtpcmd12131.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbhLJQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:40:05 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id vislmYA0XYYTXvisnmI449; Fri, 10 Dec 2021 17:36:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1639154189; bh=mkGS2q8RyS56q3UnbtIPVxrl5TGGrT8hrrl5YrYfP2k=;
        h=From:To:Subject:Date:MIME-Version;
        b=no+2oMBBM5eBQnF/85/1wZQZ12o0WXrflSnOXOj35vzUVUan0foeWBaoU2ZL7Xow+
         36YgZaHTDxqf8u1vIXkFt2YNidupKSnOJJH+vQDL79erWvKIQgtaJoF9NEX7TmmhQt
         DQkAcVviGylciLeUpjVRATSHKYrXwlRcBkuRn0+fSsAvaxNs2uW3nxe56bmlDiE18F
         Zz5ZpYEYnzGI7bB2HouPj0eaDKFckQWa7j1vAO7jtxVn4CSnjILDMiFpzND/5QeWRM
         Vgor7x9lMcWsVVoB2jiRuoPMY3yxg9MdjGbXyfO7kaL8kTXyBx4CYnTHkK2oBaMjlU
         t205FNDfxEjwA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 2/2] drm/panel: panel-simple: add bus_format and connector_type to cdtech_s070wv95_ct16 panel
Date:   Fri, 10 Dec 2021 17:36:23 +0100
Message-Id: <20211210163623.1063057-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210163623.1063057-1-giulio.benetti@benettiengineering.com>
References: <20211210163623.1063057-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJNrrbQYla2HqVHWbA09kx4xx3WwZymz1asPPI3y7ILhWC40d7HUBXZ+sPF+SMjUOtAvRq0r0IYp36jyc0d9vBE32Ur9ESJSB27c0yuW5F9MM2sURGcF
 Iay99tUvuchhNxgAuADlVvVUJeNy92m3BPnEHX+woQ4fvTiRmAOWuG5QKAPPSQg5HZRFqxlWn92IkkyWaXZnFz+W6snqCljiSNyS6h8cMSyMnesenqQiXptP
 Pkki+VLrgovwk/U5AtgBG+UwxWNJn0SxQLD8Clfejx87gHZEhZ9lpbqM7Ss8pDsZygT4ZoyciY5H/AmmCy6QBP7pYjffOy2FVfaDYDDFCwv+Fkwd3uYN+rmw
 TXrGR1eZ8ZHtBuQsTRnds3i9LGJsyY2oUF8/4fv+HTJX3+Ea6yjrRSiN2a4IMb40DocSr4pIBvsJtHcQZ72CxI3tXh4xiw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bus_format and connector_type to cdtech_s070wv95_ct16 panel.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c8ad713865cb..dc300ace4d68 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1295,6 +1295,8 @@ static const struct panel_desc cdtech_s070wv95_ct16 = {
 		.width = 154,
 		.height = 85,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
 static const struct display_timing chefree_ch101olhlwh_002_timing = {
-- 
2.25.1

