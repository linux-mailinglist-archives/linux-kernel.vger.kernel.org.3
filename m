Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E853B573049
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbiGMINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiGMIMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D422FE95FB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8F0E61A46
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402E9C341DE;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=rPCuDXD0Hs3qni0sAYw6TvtO021wF0gkjGy1+YtdrKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhtnKs/qXLn2HSmQMtB4tzglqymc6o4exuk4uKhT0Jhv6i9kmh98xNkyqyeYGtJE4
         SRvaZifSKa7QVFCW7OgeOHRki2sr7Y8BGEwBsFd4jTd5+EU5RWtIyd2CYHdTiCzopW
         OEyF1S4etRR/UIgt6GdBykzEVqo2oT4qNSQkFWFu2Xzuwq1TVwNgEXTdAKzNuDo9Ov
         VO4rwYUh9prNB8Uy4PYP7WWpQj2CyBuCpctGGxtJla+nuVX7bkD7Dzy0u5uncL4oxv
         dp3fTGMEnCcM6io6dTUF3TN//Ss9lMP5Mmhhul0IxxdWdVdXy9LvdKGIHnjOh9Gt63
         T4AV2y+Bxm9/w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zu7-SF;
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
Subject: [PATCH v2 27/39] drm/i915: i915_scatterlist.h: fix some kernel-doc markups
Date:   Wed, 13 Jul 2022 09:12:15 +0100
Message-Id: <a8448975d949b77379939e11ccbb794d8fcbeee7.1657699522.git.mchehab@kernel.org>
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

Building docs currently produces this warning:

	Documentation/foo/i915:159: ./drivers/gpu/drm/i915/i915_scatterlist.h:73: WARNING: Inline strong start-string without end-string.

That's because @foo evaluates into **foo**, and placing anything
after it without spaces cause Sphinx to warn and do the wrong
thing.. So, replace them by a different Sphinx-compatible tag.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_scatterlist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
index 0b8bf4be4330..5b5c4eee0f44 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.h
+++ b/drivers/gpu/drm/i915/i915_scatterlist.h
@@ -70,7 +70,7 @@ static inline struct scatterlist *____sg_next(struct scatterlist *sg)
  *
  * Description:
  *   If the entry is the last, return NULL; otherwise, step to the next
- *   element in the array (@sg@+1). If that's a chain pointer, follow it;
+ *   element in the array (``sg@+1``). If that's a chain pointer, follow it;
  *   otherwise just return the pointer to the current element.
  **/
 static inline struct scatterlist *__sg_next(struct scatterlist *sg)
-- 
2.36.1

