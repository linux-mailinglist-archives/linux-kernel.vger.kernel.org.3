Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05E570B92
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiGKU0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiGKUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85ED4F6A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B106C61657
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E795C341D1;
        Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571125;
        bh=ijCPUHCQ+PvIvqv0lj0eAF28GMG83iZ88gPn2azWN00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuT7CaQRkdWFb8J/EDSonrTwNrneFh4vQzZa34mfbf3abyiL9uJB0RNLTsPkHeCg9
         Gvy/qehbvXma6MzykQXN6Q3bAWc9AgkVRyK737bGrBp4jccYBKwaoDhHHmVQ68qfkL
         QxNqwvTJi2HNVQLXX5pxdT9uId/imH0kHyPC4xg6F6hJ6PoR8puYgEKWx1mJr4pdTP
         xp4QpPXQmhDIu74KD0OzuNfbuv0W0qDQDEhsz7OshIbocDgDlNWJs/g9txY5KijQMz
         LEXa5jPSdb82yxhavdHFzgrH+8LNGXx1r4ih4RoBXA7oxqc2FReW+kwZEV2CdgUHhq
         7aqWQhvXVAkKw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e8I-LS;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/32] drm/i915: i915_gem_wait.c: fix a kernel-doc markup
Date:   Mon, 11 Jul 2022 21:25:02 +0100
Message-Id: <54d781157866d7dc4f656b50500f228dca4070ed.1657565224.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657565224.git.mchehab@kernel.org>
References: <cover.1657565224.git.mchehab@kernel.org>
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
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gem/i915_gem_wait.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_wait.c b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
index bdba05492582..7b4e216a295b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_wait.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_wait.c
@@ -176,23 +176,25 @@ static unsigned long to_wait_timeout(s64 timeout_ns)
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

