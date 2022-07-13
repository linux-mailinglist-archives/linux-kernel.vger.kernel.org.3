Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D9573055
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiGMIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4314E95FF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FA5661A43
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43186C341E1;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=fbuGcI6aeIF16Eab+5tuZImNSWo6j8w5k+U1/9xveHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuAkL/38GAZcc8DVLwIsDfLEIwQNzdtBx+z2GDQAJFbfSU4wjm0FgwEyM4h20ELKD
         m1IZvjOkozaSUq/EtlwAfG3fbL9ZM+Qg+3JspV/o3GRu4+I21//su1tKNO/5+DOX2v
         F1uli5zMSxf4e7iyanZs7dXj7WLtGYQGj5Q1dr0qaBueKnr8wK0vJC+50c1fFf+CzT
         ueGa+GQqzhYXYUmmyt+VNR67CpJ6o0biPuJNqZ9PHk3NyyHiuJ3j7WPgjdTj1MUBCM
         xX5Lt7vx7N0zGnvvoMyB2pg0ynRmYq9wnquRo6bUq7KYI93uvfrpYQbEfg/PYpQaXN
         TjVqlmtWeaiKw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zuB-Sm;
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
Subject: [PATCH v2 28/39] drm/i915: i915_deps: use a shorter title markup
Date:   Wed, 13 Jul 2022 09:12:16 +0100
Message-Id: <12353a958aa1b280bba3bc6937caa107edf81dee.1657699522.git.mchehab@kernel.org>
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

The DOC: tag waits for a one-line short title for the doc
section. Using multiple lines will produce a weird output.
So, add a shorter description for the title, while keeping
the current content below it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_deps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_deps.c b/drivers/gpu/drm/i915/i915_deps.c
index 297b8e4e42ee..df6af832e3f2 100644
--- a/drivers/gpu/drm/i915/i915_deps.c
+++ b/drivers/gpu/drm/i915/i915_deps.c
@@ -11,7 +11,9 @@
 #include "i915_deps.h"
 
 /**
- * DOC: Set of utilities to dynamically collect dependencies into a
+ * DOC: Utilities to collect dependencies for GT migration code
+ *
+ * Set of utilities to dynamically collect dependencies into a
  * structure which is fed into the GT migration code.
  *
  * Once we can do async unbinding, this is also needed to coalesce
-- 
2.36.1

