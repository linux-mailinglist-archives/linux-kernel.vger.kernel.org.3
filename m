Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D010570B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiGKU0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGKUZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF64E630
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C312B81215
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AB6C341D3;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=3lAjOtZKG1Fsuzuu547FeZgxDGSHEVrd4ycZakefxQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OhYuzbhYp9t7p0QqTKMcJi4FdczRgYqUlbfQ1ZD6YzlQPXXHOtXAvu3UxRYlyG9Ez
         /Lff//0mZmams33pJGRj+yD0Ic85dV6R7dQPWUt7gb9flyr5X3+KDcDnbnLbfpqsgg
         CrqkW3OxeAbSEMNY3ug/ddNnmoZRIHrpxTQ2soCN2vcfiZZ1+A0E9aeMO/7iX5ID7e
         sLwgaxCfJJRb8UKVe54OsPsDJG7x1NAhbYfk1H4pHbReTmaEv/G4Y1cyJQs1FssZid
         K1WVMTX/E1dY2/VYO9qZqoHc9HZlvXL/bp38voRWC1F2QfoEIqT/cNJO5qaPnrMHJd
         F7LUU/L2Eg5GA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e87-JL;
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
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/32] drm/i915: skl_scaler: fix return value kernel-doc markup
Date:   Mon, 11 Jul 2022 21:24:59 +0100
Message-Id: <7d22a4d16d7b3670ce090d6040f3bdc9a524f2a0.1657565224.git.mchehab@kernel.org>
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

The way it is, it produces this warning:

	Documentation/gpu/i915:150: ./drivers/gpu/drm/i915/display/skl_scaler.c:213: WARNING: Block quote ends without a blank line; unexpected unindent.

Use list markups to suppress the warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/display/skl_scaler.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c b/drivers/gpu/drm/i915/display/skl_scaler.c
index 4092679be21e..59099f793d3e 100644
--- a/drivers/gpu/drm/i915/display/skl_scaler.c
+++ b/drivers/gpu/drm/i915/display/skl_scaler.c
@@ -208,9 +208,9 @@ int skl_update_scaler_crtc(struct intel_crtc_state *crtc_state)
  * @crtc_state: crtc's scaler state
  * @plane_state: atomic plane state to update
  *
- * Return
- *     0 - scaler_usage updated successfully
- *    error - requested scaling cannot be supported or other error condition
+ * Return:
+ * * 0 - scaler_usage updated successfully
+ * * error - requested scaling cannot be supported or other error condition
  */
 int skl_update_scaler_plane(struct intel_crtc_state *crtc_state,
 			    struct intel_plane_state *plane_state)
-- 
2.36.1

