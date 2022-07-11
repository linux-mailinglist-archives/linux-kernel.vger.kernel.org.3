Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151EA570B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGKUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGKUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE55A3C8C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71863B81208
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B18AC341C0;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=OjD8Yz9UzTzgG3RG67dsf3NiVnBD+9tO+AINCZ654a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bwbwfTsWqSl9CjGQhFHIyg7zWeQ2QO57aLRlgOpmPe7iOX4Z8SF5yv8pVhFtVyNbu
         Pr1IZ/lhEbkwwVC1JecuODFe2LSSPM/zcsMTSo3WVi8NMm59JCkiHNQ5Fes9EvUPYh
         6AUoQvzDvSz6CFwduOfMIEEq6+ZlBIP9vk6bBUjv2zBgdj5+iV5qu5srSCmrTm3iLI
         H/9sJUUnBiqySZHwA6sYjLfL9aGdPl2TV4HWPUEPV0fBr2BlEX8VZdmxGdOzmHyqQ5
         dCGum0NxThwvAULWVj8vgXshfF4eUn+ZLhV+hFjz6Vn6NkaSZLpDTXvZgAHLZyugnO
         89qni2QCs9oTA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e84-Ie;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        =?UTF-8?q?Juha-Pekka=20Heikkil=C3=A4?= 
        <juha-pekka.heikkila@intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/32] drm/i915: intel_fb: fix a kernel-doc issue with Sphinx
Date:   Mon, 11 Jul 2022 21:24:58 +0100
Message-Id: <715c9d4674cdcbc07da5b63221f41319f1d2acfd.1657565224.git.mchehab@kernel.org>
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

We can't use %foo[<something>] as this produces a bad markup.
Use instead, the emphasis markup directly.

Fix this issue:
	Documentation/gpu/i915:136: ./drivers/gpu/drm/i915/display/intel_fb.c:280: WARNING: Inline strong start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/intel_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fb.c b/drivers/gpu/drm/i915/display/intel_fb.c
index b191915ab351..fe72c75a9c79 100644
--- a/drivers/gpu/drm/i915/display/intel_fb.c
+++ b/drivers/gpu/drm/i915/display/intel_fb.c
@@ -276,7 +276,7 @@ lookup_format_info(const struct drm_format_info formats[],
  * @cmd: FB add command structure
  *
  * Returns:
- * Returns the format information for @cmd->pixel_format specific to @cmd->modifier[0],
+ * Returns the format information for @cmd->pixel_format specific to **cmd->modifier[0]**,
  * or %NULL if the modifier doesn't override the format.
  */
 const struct drm_format_info *
-- 
2.36.1

