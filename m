Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDF4F0CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 01:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376659AbiDCXbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 19:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCXa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:30:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7837D13E94
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=F+Um7ld6EmxP0HBmSMTv2gxtaiTsplYMSOL9xPsFLbQ=; b=fBRmr7ifhtoCS23gSy41z85P6M
        z/hurqhTfoKIjAMmgaBZSctAXMxGvKMJk85ro+sWiXnPQWXdSh6PCdD3RynXFq7YQ5MeUmMTvCgqj
        Zp3MXZ08rdRA6hcoP1ejYho9gMqjm8kKvETqKDi05NJ6QvwO8kMp5a2sB2cmyWzOcK1saaH2jtKA6
        ogoSv0ZVMuWJAK2S3+Eyu0pJScGyVW5GXPP3C5YJoPDGWkG4Zf8AUXGqlXEth6lViv10fX2ebSK1O
        5KDKA/OImn/fkUNXxIRBmJgHnImDV4kTCGBDFok7RaQsKtsUIEXOXVu0niZbxBkN5TR9mxbaHF9dx
        zfvnxNmw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nb9ea-00CXHm-Ps; Sun, 03 Apr 2022 23:29:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/format_helper: fix a kernel-doc typo
Date:   Sun,  3 Apr 2022 16:29:02 -0700
Message-Id: <20220403232902.1753-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the incorrect name of a function parameter was used
in the kernel-doc notation, so just change it to the function's
parameter name to quell the kernel-doc warning.

drivers/gpu/drm/drm_format_helper.c:640: warning: Function parameter or member 'vaddr' not described in 'drm_fb_xrgb8888_to_mono_reversed'
drivers/gpu/drm/drm_format_helper.c:640: warning: Excess function parameter 'src' description in 'drm_fb_xrgb8888_to_mono_reversed'

Fixes: bcf8b616deb8 ("drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220401.orig/drivers/gpu/drm/drm_format_helper.c
+++ linux-next-20220401/drivers/gpu/drm/drm_format_helper.c
@@ -624,7 +624,7 @@ static void drm_fb_gray8_to_mono_reverse
  * drm_fb_xrgb8888_to_mono_reversed - Convert XRGB8888 to reversed monochrome
  * @dst: reversed monochrome destination buffer
  * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @src: XRGB8888 source buffer
+ * @vaddr: XRGB8888 source buffer
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
