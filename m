Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1735730B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbiGMIPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiGMIMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:12:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83628EA16E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 90FE0CE1E78
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230F4C341D3;
        Wed, 13 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657699952;
        bh=891ODzFxtaIaukcP3khje0yCWAcvp3ViN+oLtx5T5AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5rg0nky4D+N3R3jfJz5vlQvMUqaFWQ44W3wW4bvy11+fZcJNF4Kq+z2NDVQX+JJS
         qHITqTyWgEsx9c8JLklQjtSnXKmdBcvZ32ZJHXFiSg+HG/gCcnbUH7Ea3Yxe+bqtAX
         1t6NOWJEyZPbZk+NMGF4pg6kRRJtqHXB0r9G4TpiwjaJ876oyL1uIXRglubZ9Q4qok
         O6kzeTos3fnDjMeHjcRg+M/f/wn1FUhevRZjcf/ZH6haXPLxAcPNx+G5mys6vHbJA/
         VXOdyFPlyRVxx5bd4vxse7vtfvyekD2NIt+rpULEzdgkwOElv3SwaW6b0cHL06jKfJ
         ET/a7P5JMGNjQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oBXTx-004zsw-GA;
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
Subject: [PATCH v2 09/39] drm/i915: intel_wakeref.h: fix some kernel-doc markups
Date:   Wed, 13 Jul 2022 09:11:57 +0100
Message-Id: <781e207ffe403a21f67a3f8c3bd39725d229cf0e.1657699522.git.mchehab@kernel.org>
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

Two documented functions don't match the kernel-doc comments,
as reported by kernel-doc:

	drivers/gpu/drm/i915/intel_wakeref.h:117: warning: expecting prototype for intel_wakeref_get_if_in_use(). Prototype was for intel_wakeref_get_if_active() instead
	drivers/gpu/drm/i915/intel_wakeref.h:149: warning: expecting prototype for intel_wakeref_put_flags(). Prototype was for __intel_wakeref_put() instead

Fix them.

Additionally, improve title for intel_wakeref_get_if_active().

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/

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

