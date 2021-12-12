Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103824718E5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhLLGYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhLLGYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:24:31 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB20C061714;
        Sat, 11 Dec 2021 22:24:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 67AF6424CD;
        Sun, 12 Dec 2021 06:24:25 +0000 (UTC)
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
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH v3 3/3] drm/simpledrm: Add [AX]RGB2101010 formats
Date:   Sun, 12 Dec 2021 15:24:07 +0900
Message-Id: <20211212062407.138309-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212062407.138309-1-marcan@marcan.st>
References: <20211212062407.138309-1-marcan@marcan.st>
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
 drivers/gpu/drm/tiny/simpledrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 2f999915b9aa..b977f5c94562 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -571,8 +571,8 @@ static const uint32_t simpledrm_default_formats[] = {
 	//DRM_FORMAT_XRGB1555,
 	//DRM_FORMAT_ARGB1555,
 	DRM_FORMAT_RGB888,
-	//DRM_FORMAT_XRGB2101010,
-	//DRM_FORMAT_ARGB2101010,
+	DRM_FORMAT_XRGB2101010,
+	DRM_FORMAT_ARGB2101010,
 };
 
 static const uint64_t simpledrm_format_modifiers[] = {
-- 
2.33.0

