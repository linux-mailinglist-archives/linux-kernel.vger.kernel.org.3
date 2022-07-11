Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E96570B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiGKUZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGKUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A57B32EF1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD021615DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1019EC341CD;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=bXMFov/Bg+gXhXFAPZsN2vr4FlCksYPMpkdasMmUlrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jdiHz0gm9HDa6XIdwt4KprXlWibz76PTd/uinwRJMaD8+yKHvx2/7jmIPTGJS5quN
         UXpXW+v6ZTI4JbJM+V1FLxs8+Lzi3UnRYZPptyKSHmInL+KbYKfJms7230Bs1MYPMw
         /3WeNit5gwqvBGuimg14jOmH68jpVr6jHxyuffsqglw0ybCO9q/HWDY5xfSfG7QaZM
         HRYu3iBnjK1/7Zr4ff9YRpS6l9SIAw+fMnpGJICx/p2pdZGOlEcjx2gzxESd55eJPB
         E2PQqclLeAQN40cg9bT8Ofyq4iY0d+G1gy4fNm+71BYX5+9RCUPXMW3txXpqvMjTlw
         F+f9JP2xUouyw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e81-Hy;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lee Shawn C <shawn.c.lee@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/32] drm/i915: intel_dp_link_training.c: fix kernel-doc markup
Date:   Mon, 11 Jul 2022 21:24:57 +0100
Message-Id: <fcda0c1f321d59d4c193d4b123a5d8f24dae0011.1657565224.git.mchehab@kernel.org>
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

The return code table is not properly marked, causing warnings
and being badly parsed by Sphinx:

    Documentation/gpu/i915:130: ./drivers/gpu/drm/i915/display/intel_dp_link_training.c:183: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/gpu/i915:130: ./drivers/gpu/drm/i915/display/intel_dp_link_training.c:186: WARNING: Definition list ends without a blank line; unexpected unindent.

Use table markups to fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/intel_dp_link_training.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index 9feaf1a589f3..23a269fcf6ca 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -177,12 +177,14 @@ static int intel_dp_init_lttpr(struct intel_dp *intel_dp, const u8 dpcd[DP_RECEI
  * transparent mode link training mode.
  *
  * Returns:
+ * ====  =====================================================================
  *   >0  if LTTPRs were detected and the non-transparent LT mode was set. The
  *       DPRX capabilities are read out.
  *    0  if no LTTPRs or more than 8 LTTPRs were detected or in case of a
  *       detection failure and the transparent LT mode was set. The DPRX
  *       capabilities are read out.
  *   <0  Reading out the DPRX capabilities failed.
+ * ====  =====================================================================
  */
 int intel_dp_init_lttpr_and_dprx_caps(struct intel_dp *intel_dp)
 {
-- 
2.36.1

