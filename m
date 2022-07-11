Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4344570B99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiGKU05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiGKUZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E89B50183;
        Mon, 11 Jul 2022 13:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC0C6B81223;
        Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412B1C341DD;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=OSO6ejWnnUoc5otDMF/W0MkHHWHT3ycWD8ycMnZEBb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1Pg+upYwFWFjLPEZvT4GDwufhDwhW95VBaCZK9Xb2t8xv3+E9qwZjc/vlgWLm6lp
         kbL0bzUuafivfNQ/73KLxUmZ3jb51dHabYYyG1b9JBqHqfdYpoW+y8Sp1SaEigeBSM
         bzpjzibRmkt22NDcZftWnyaZ3LK6h8FCO55fiN/qF4XnVedXv3hRrAp0TsVfTWwbuS
         GvmVmmLZa9ghioKMISpM3Z67vNSGr0jm94wLsYU7H36/YsENjq7UNlkr+zjv5Jy7Du
         Y80L2NFddxYLQGLeLqydyh0j5SceT4M1D5AkzseOhZwmo7l33oMFTwS/pitkTxExwM
         ckASa52gqkLQw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e9B-Tk;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 29/32] docs: gpu: i915.rst: GVT: add more kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:14 +0100
Message-Id: <fc356e3a7b9cb51391afca3dad3ffb06dc0b5741.1657565224.git.mchehab@kernel.org>
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

There are several documented GVT kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 70f2f4826eba..3ee121a0ea62 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -58,6 +58,47 @@ Intel GVT-g Host Support(vGPU device model)
 .. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
    :internal:
 
+Other Intel GVT-g interfaces
+----------------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/aperture_gm.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/cfg_space.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/debugfs.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/display.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/edid.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/fb_decoder.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/firmware.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/gtt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/handlers.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/interrupt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/kvmgt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt_mmio_table.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/mmio.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/mmio_context.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/opregion.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/page_track.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/scheduler.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
+
 Workarounds
 -----------
 
-- 
2.36.1

