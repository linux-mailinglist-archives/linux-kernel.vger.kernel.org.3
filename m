Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63A857302C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiGMIMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiGMIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B698E95E9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA85D619D9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D46C341C6;
        Wed, 13 Jul 2022 08:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=wjH7jlko3UeUSoDYiiYc2kFPAoQY3M729gZF+d6bkKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MR88FALX7zT9KVTOCT3YsTnjQueAK7gubYXl+J9n2L4muFg/V57lCrPuV+83JmGKD
         qF4JxtiU9vdKbLNeNbTJ585Obr1FAuPTKWjZakLs0g1hrWOXos2fv7EmyLxcQTdv4x
         KxdShRB3PdjXb/KcrhJDUrPt5Zf6bgAap8cBtruRvpPhTCwXbV0KcPPPV/kxVPhivm
         vGcwAsBFKeKrq1A2Xe2U6pUzU3bE/njmdIpxRgq17A22ucGzly7an+SFuxO3/wWYvP
         qnp3YNhxHsx4DzkAwsbAyBYHQzpwx2QPftFdATCeXfqUK8ctXZ7uT86Zz0RT2wi+rX
         C0bWcaqvv24Sg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zsY-AL;
        Wed, 13 Jul 2022 09:12:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 01/39] drm/i915/gvt: Fix kernel-doc for intel_gvt_switch_mmio()
Date:   Wed, 13 Jul 2022 09:11:49 +0100
Message-Id: <72db6b58c1f223e326f84978267ba064eaf67ff0.1657699522.git.mchehab@kernel.org>
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

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Fix the following W=1 kernel warnings:

drivers/gpu/drm/i915/gvt/mmio_context.c:560: warning: expecting
prototype for intel_gvt_switch_render_mmio(). Prototype was for
intel_gvt_switch_mmio() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/gvt/mmio_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/mmio_context.c b/drivers/gpu/drm/i915/gvt/mmio_context.c
index c85bafe7539e..1c6e941c9666 100644
--- a/drivers/gpu/drm/i915/gvt/mmio_context.c
+++ b/drivers/gpu/drm/i915/gvt/mmio_context.c
@@ -546,7 +546,7 @@ static void switch_mmio(struct intel_vgpu *pre,
 }
 
 /**
- * intel_gvt_switch_render_mmio - switch mmio context of specific engine
+ * intel_gvt_switch_mmio - switch mmio context of specific engine
  * @pre: the last vGPU that own the engine
  * @next: the vGPU to switch to
  * @engine: the engine
-- 
2.36.1

