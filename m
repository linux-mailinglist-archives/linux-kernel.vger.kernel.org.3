Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C7573093
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiGMIOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiGMIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65E9EA14B;
        Wed, 13 Jul 2022 01:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C83619D9;
        Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBD9C36AF9;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=oeUAgri78ROskx4GT92wiPTQ1aSED1G9dqbJdK0O9Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1fYWa2M1tIbvIK/i2Oajw6aMlo6P5X5cCk4s6fmDnL66apHU+FRP6BY0E901w9Te
         ER0Bi26aDT6NILklmJvVCe6UqvjGR1eEKUs7Y4qtEBXrefJeRjrN1EpE8jMwKYjd8T
         TwmUq0t0iR9Hpz1Gmsz1krujZBVy3NfLxr5IikAU0D2OSGBa+iRm4MZBN6lyQ4M58q
         5xROTUcdsOFqV6c0/goZWMY7V2dbSnrWaQ3LPXR0ln6xr7p3yvjnpMLxFCmo68vmf6
         RY7WMD1kRvDPHlxMPhouFkhXwAA7Te5DErsNVbq0ThkY+3dgpzY2QMGRV6VHlju4MR
         km39hzhA9G3GQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTy-004zuq-4I;
        Wed, 13 Jul 2022 09:12:30 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 39/39] drm/i915: add GuC functions to the documentation
Date:   Wed, 13 Jul 2022 09:12:27 +0100
Message-Id: <d9d2ba7ac39f89fc196447891b43ed70a8c6dcaa.1657699522.git.mchehab@kernel.org>
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

Currently, functions inside GuC aren't presented as part of the
GuC documentation.

Add them.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index 9862d504df4d..8c21a90d8b5a 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -768,6 +768,9 @@ GuC
 
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc.h
 
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc.c
+   :internal:
+
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/abi/guc_actions_slpc_abi.h
 
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c
-- 
2.36.1

