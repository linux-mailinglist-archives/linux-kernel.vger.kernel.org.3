Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA23573053
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGMINd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40E7E95FA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3D2961A3F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4A0C36AE5;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=/9olzBx4OUc50koFFZQ+bGSBLR49rSjkVapHkfF/H3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZNX4s+1P1th8a5vh9jjL3Y1YoLYk5P8KrcIeNBVMClqfBQQbpQIoJSqvOtX3QPC+
         icweIoHf0GtgMsvyovvwQOFfDsLoSFlsSAFWRZ83X0w5mcn6fHbcU8yc4/cmKxV6Ew
         X6c3t+BEEKDmaOX1pdpXWI47xwcCHh0H/Sn8VS9vm45SdreaLW/GvqnhENGPK5jAyi
         B9jw5dh63MlC+3Ovza6nuAHVvzvEA40E1JZ57Nkhf6mvZgeLMKyTTFYJKvYQSdnuwa
         DstkDSbgkqbia+gyaDq+DO4+KMNb7eOIqGIU9UxKguCMiszLhLR8mlr9ntZ9G11MfM
         /FjlPOy0Do5sQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004ztt-QU;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 24/39] drm/i915: dvo_sil164.c: use SPDX header
Date:   Wed, 13 Jul 2022 09:12:12 +0100
Message-Id: <002a8d51244a70572744de86cacbdae293e7d503.1657699522.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657699522.git.mchehab@kernel.org>
References: <cover.1657699522.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This file is licensed with MIT license.	Change its license text
to use SPDX.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/dvo_sil164.c | 32 +++++------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/dvo_sil164.c b/drivers/gpu/drm/i915/display/dvo_sil164.c
index 0dfa0a0209ff..12974f7c9dc1 100644
--- a/drivers/gpu/drm/i915/display/dvo_sil164.c
+++ b/drivers/gpu/drm/i915/display/dvo_sil164.c
@@ -1,30 +1,10 @@
-/**************************************************************************
+// SPDX-License-Identifier: MIT
 
-Copyright © 2006 Dave Airlie
-
-All Rights Reserved.
-
-Permission is hereby granted, free of charge, to any person obtaining a
-copy of this software and associated documentation files (the
-"Software"), to deal in the Software without restriction, including
-without limitation the rights to use, copy, modify, merge, publish,
-distribute, sub license, and/or sell copies of the Software, and to
-permit persons to whom the Software is furnished to do so, subject to
-the following conditions:
-
-The above copyright notice and this permission notice (including the
-next paragraph) shall be included in all copies or substantial portions
-of the Software.
-
-THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT.
-IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
-ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-
-**************************************************************************/
+/*
+ * Copyright © 2006 Dave Airlie
+ *
+ * All Rights Reserved.
+ */
 
 #include "intel_display_types.h"
 #include "intel_dvo_dev.h"
-- 
2.36.1

