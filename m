Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC9A570B55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiGKUZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGKUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08A357CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 786B46160D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20786C385A5;
        Mon, 11 Jul 2022 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571123;
        bh=JmPMr0UNPPF1GlXrFpz+iVGZIKjSFpWV9k4IbirRPBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlYMrICxqmmhFoXpZTNbJxuVcUnpORO3ZJXRfTMdKGS5N7Vtxd0zjqeW1iyjbOyCO
         gaeY/FyMy0Un+ad/GacAO6aUXMxgm8JM1u9QAjDOrhG+cKomDFJvSPmbDvZffnNBgZ
         sN8SWlq9BLBkuydTLryYhJAKe5xF85nmM4Ab3Xw8exklCFi75QEgl/dF2ao45BIqiW
         LsdyL8juHvH54PJjUCU802oMwvXD9O9oWGXqX6knGW9IviEK6HdghPePMd45u9MswX
         fuaTeTOd//+FBpGHPEemTVp+TR4k9QzODTJuKXKMSNTzyx29ECnDmLVLOkkhpXTDSk
         n0PWg2S2Oi8Bg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e7j-Di;
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
Subject: [PATCH 06/32] drm/i915: intel_wakeref.h: fix some kernel-doc markups
Date:   Mon, 11 Jul 2022 21:24:51 +0100
Message-Id: <d06a1fd8f9361edda39d1b15b6c7b2645c6a3fca.1657565224.git.mchehab@kernel.org>
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

Two documented functions don't match the kernel-doc comments,
as reported by kernel-doc:

	drivers/gpu/drm/i915/intel_wakeref.h:117: warning: expecting prototype for intel_wakeref_get_if_in_use(). Prototype was for intel_wakeref_get_if_active() instead
	drivers/gpu/drm/i915/intel_wakeref.h:149: warning: expecting prototype for intel_wakeref_put_flags(). Prototype was for __intel_wakeref_put() instead

Fix them.

Additionally, improve title for intel_wakeref_get_if_active().

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 drivers/gpu/drm/i915/intel_wakeref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_wakeref.h b/drivers/gpu/drm/i915/intel_wakeref.h
index 4f4c2e15e736..63e539c9b1f3 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.h
+++ b/drivers/gpu/drm/i915/intel_wakeref.h
@@ -104,7 +104,7 @@ __intel_wakeref_get(struct intel_wakeref *wf)
 }
 
 /**
- * intel_wakeref_get_if_in_use: Acquire the wakeref
+ * intel_wakeref_get_if_active: Acquire the wakeref if active
  * @wf: the wakeref
  *
  * Acquire a hold on the wakeref, but only if the wakeref is already
@@ -130,7 +130,7 @@ intel_wakeref_might_get(struct intel_wakeref *wf)
 }
 
 /**
- * intel_wakeref_put_flags: Release the wakeref
+ * __intel_wakeref_put: Release the wakeref
  * @wf: the wakeref
  * @flags: control flags
  *
-- 
2.36.1

