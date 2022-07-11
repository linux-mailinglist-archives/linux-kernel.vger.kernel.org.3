Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1EC570B64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiGKUZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiGKUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC153C8CC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2095861636
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41607C36AE5;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=65qOd5DFjDe/qVWtarr6Nxd+MxmQ6nZSdo6RdJ6BocM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0iNmJBViO8cFrlyt+hSSoJiEKaJti4AaEzWE1zfZOf9bBxlEx2BcQJo0pd1Rzoua
         WbiJxUyHnrIqA8UJVXb4njgcy1GuZoXQeUdHUtYw6T5fH37Z+71lH20Uah18puHdIT
         Txg29te4cdt54sxj0n4a6P4X1qe68l++lmEaNniy35s1RHkV95X8z8VfrarF8MBFGL
         T08x9jClqdQz7MeMoZHCD9emJx7rFSl/fm3Uy3V3chhL0E5GSeVDuqxixWvNf2bW5F
         oIAENWDULV6bGtxCqLDvRtnKmG0D28JQyLS654yR0n+/qOQ1RmFG0TkHkpgYX8xBiA
         goyt2XV3dXDMA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e8r-QR;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/32] drm/i915: i915_scatterlist.h: fix some kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:09 +0100
Message-Id: <a48b876cae63a31b562ddaaf1903d1a1715349b7.1657565224.git.mchehab@kernel.org>
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

Building docs currently produces this warning:

	Documentation/foo/i915:159: ./drivers/gpu/drm/i915/i915_scatterlist.h:73: WARNING: Inline strong start-string without end-string.

That's because @foo evaluates into **foo**, and placing anything
after it without spaces cause Sphinx to warn and do the wrong
thing.. So, replace them by a different Sphinx-compatible tag.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/i915_scatterlist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
index 2e112362e4f1..0c7ffcfaff5b 100644
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

