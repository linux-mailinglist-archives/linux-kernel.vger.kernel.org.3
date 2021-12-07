Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83F746B3EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhLGHei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:34:38 -0500
Received: from marcansoft.com ([212.63.210.85]:35654 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230204AbhLGHeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:34:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 90DB441F7F;
        Tue,  7 Dec 2021 07:31:01 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v2 3/3] drm/simpledrm: Add XRGB2101010 format
Date:   Tue,  7 Dec 2021 16:29:43 +0900
Message-Id: <20211207072943.121961-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207072943.121961-1-marcan@marcan.st>
References: <20211207072943.121961-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the format used by the bootloader framebuffer on Apple ARM64
platforms.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 2f999915b9aa..edadfd9ee882 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -571,7 +571,7 @@ static const uint32_t simpledrm_default_formats[] = {
 	//DRM_FORMAT_XRGB1555,
 	//DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_RGB888,
-	//DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_XRGB2101010,
 	//DRM_FORMAT_ARGB2101010,
 };
 
-- 
2.33.0

