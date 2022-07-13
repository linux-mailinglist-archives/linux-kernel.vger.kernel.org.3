Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87018573044
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiGMINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiGMIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B63E95E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C96619E4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246C1C341D6;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=/PaxiN5HkOwyVUhkxftwWgzAT/MNna5OTFK/g/W4MZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDQV9r8nsXMzoxcsN2XYoy0zq28ACHNPKzcmwl5m7WDPHyiUuBguSvUgr9IdIMb2m
         mtfMj3DdVN2XmuU4zuT5CT5ChlyIZ6ytP3XNwPY0gp/BWHdX9yYJZ0k82oWR1pGCpy
         LWE2UBASspK+VXFNAw6xyG26AzySLDoR2+Ua/yMTYIEtMjOSU96RwheQR3A+DkAbWy
         09iMETIr6imFYPa5ufYfZGGy/TFRZsYFQuONCR9G/jVj+Uib6sVspw2rHuIthw/+Ro
         piOtNteUKj+8/FZtic1AvDx1Q7kXC/12YJuThuvoFEoT8zx2InI9Us3dspUQgW80Cm
         IgdDyAk2QK1Yg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004ztd-NH;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/39] drm/i915: i915_gem_wait.c: fix a kernel-doc markup
Date:   Wed, 13 Jul 2022 09:12:08 +0100
Message-Id: <7506a4fc57d2bf064f6a35d70c8cd7885082863e.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return codes for i915_gem_wait_ioctl() have identation issues,
and will be displayed on a very confusing way. Use lists to improve
its output.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
index 4a33ad2d122b..1fd5cff552ed 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -210,23 +210,25 @@ static unsigned long to_wait_timeout(s64 timeout_ns)
  * @data: ioctl data blob
  * @file: drm file pointer
  *
- * Returns 0 if successful, else an error is returned with the remaining time in
- * the timeout parameter.
- *  -ETIME: object is still busy after timeout
- *  -ERESTARTSYS: signal interrupted the wait
- *  -ENONENT: object doesn't exist
- * Also possible, but rare:
- *  -EAGAIN: incomplete, restart syscall
- *  -ENOMEM: damn
- *  -ENODEV: Internal IRQ fail
- *  -E?: The add request failed
- *
  * The wait ioctl with a timeout of 0 reimplements the busy ioctl. With any
  * non-zero timeout parameter the wait ioctl will wait for the given number of
  * nanoseconds on an object becoming unbusy. Since the wait itself does so
  * without holding struct_mutex the object may become re-busied before this
  * function completes. A similar but shorter * race condition exists in the busy
  * ioctl
+ *
+ * Returns:
+ * 0 if successful, else an error is returned with the remaining time in
+ * the timeout parameter.
+ * * -ETIME: object is still busy after timeout
+ * * -ERESTARTSYS: signal interrupted the wait
+ * * -ENONENT: object doesn't exist
+ *
+ * Also possible, but rare:
+ * * -EAGAIN: incomplete, restart syscall
+ * * -ENOMEM: damn
+ * * -ENODEV: Internal IRQ fail
+ * * -E?: The add request failed
  */
 int
 i915_gem_wait_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
-- 
2.36.1

