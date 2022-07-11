Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC58570B57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiGKUZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGKUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550003C162;
        Mon, 11 Jul 2022 13:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5A6661624;
        Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D765C341E8;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=Rnb3XsY7y8hfUZ7l/im7d9PJX0mQos0rnISe9eN8yZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRvsc5Nhss+tKjP2ySpmWTjHUU+dZWTOzVTeWLZtlPaxMHY7GQKEe9AZufYAu/el6
         AoygpXqYq3sfn1kF4PkHKGqxFH2ukwETIMAnjByLX+KzFfOEsrbMqCFC/fJ5U2/exL
         VV1r0WeeGy9+ii02JoED3bwM6Hjy2xtRnKKyD9KC14bp58D1KWUWx6RE2LUt7ns1nP
         CHfTG9i1cKOuYc2UTfhjQVY2J7PAFCv/wjJzwOAdMCbg5e9gCYOxQATucpvgIEMAHP
         tqO07gHzXMPI+7JicCMfSFBQi+E3ohR6MusX6gIoXZjKg+IVtDvdFghhouOW8sG/S+
         ENUyjYV5R5qmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e8z-Rf;
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
Subject: [PATCH 26/32] docs: gpu: i915.rst: display: add kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:11 +0100
Message-Id: <1289783c1e0d6e652205e0ecd3e05172bac7cb1e.1657565224.git.mchehab@kernel.org>
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

There are several documented kAPI at the display side that
aren't currently part of the docs. Add them, as this allows
identifying issues with badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 4e59db1cfb00..2ad7941a79f2 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -100,6 +100,56 @@ Display FIFO Underrun Reporting
 .. kernel-doc:: drivers/gpu/drm/i915/display/intel_fifo_underrun.c
    :internal:
 
+Atomic Modeset Support
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_atomic.c
+
+Display Power Domain
+--------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_power.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_power_map.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_power_well.c
+
+Misc display functions
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_backlight.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_crtc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_connector.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_display_debugfs.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dp_link_training.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dpll.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_dpt.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_fb.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_fb_pin.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_gmbus.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_lvds.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_opregion.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_snps_phy.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/intel_tc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/display/skl_scaler.c
+
+
 Plane Configuration
 -------------------
 
-- 
2.36.1

