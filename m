Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86284982C4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiAXO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:58:49 -0500
Received: from foss.arm.com ([217.140.110.172]:36882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbiAXO6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:58:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466C46D;
        Mon, 24 Jan 2022 06:58:46 -0800 (PST)
Received: from e126387.arm.com (unknown [10.57.5.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31A433F7D8;
        Mon, 24 Jan 2022 06:58:45 -0800 (PST)
From:   carsten.haitzler@foss.arm.com
To:     dri-devel@lists.freedesktop.org
Cc:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch, steven.price@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/arm: Fix hdlcd selects to add DRM_GEM_CMA_HELPER for build
Date:   Mon, 24 Jan 2022 14:58:16 +0000
Message-Id: <20220124145816.2466883-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

Without DRM_GEM_CMA_HELPER HDLCD won't build. This needs to be there too.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 drivers/gpu/drm/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
index 58a242871b28..9eaceb981d92 100644
--- a/drivers/gpu/drm/arm/Kconfig
+++ b/drivers/gpu/drm/arm/Kconfig
@@ -6,6 +6,7 @@ config DRM_HDLCD
 	depends on DRM && OF && (ARM || ARM64 || COMPILE_TEST)
 	depends on COMMON_CLK
 	select DRM_KMS_HELPER
+        select DRM_GEM_CMA_HELPER
 	help
 	  Choose this option if you have an ARM High Definition Colour LCD
 	  controller.
-- 
2.30.1

