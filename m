Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806BD570BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiGKU12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiGKUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:25:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918E51A2E;
        Mon, 11 Jul 2022 13:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65CA2B8123F;
        Mon, 11 Jul 2022 20:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8912C341C0;
        Mon, 11 Jul 2022 20:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657571125;
        bh=68mGlwaA0EtgA4nJuAvhd7iYXVxtW3CSXJug597Q8rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBSTj4IN8j0qXmrjuDC6FgYUE8xR3y7Un/6+x7oa4EOA9god2bnLQgJKxUJPeY8Y+
         IB17n0LDvBK20uIn65DOpGMlBIOn8RAPMpCNIoJdjTqb7RaPn7BqlQvp0uJh/k33wO
         w4n8TlW2nUAl4WRnI41fuEifCDVPrVYQJmJU6VZU9vJhht8fid9zVxnL/ODiPdHasK
         tAJn91z7P32HnXIwOpTI0HTIjHh5ml50ayvvcTvSUCd+hEwOOht9BMx1I3a8+uByYg
         Rbsu6unLS2GpfhvkdgiQCpj/e6AfGtiQUdYa9sizfAe10VOUtQQD9uqsAS6mN9lX39
         NVSx4TrPIY0Mg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oAzy3-004e96-T1;
        Mon, 11 Jul 2022 21:25:19 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/32] docs: gpu: i915.rst: GuC: add more kernel-doc markups
Date:   Mon, 11 Jul 2022 21:25:13 +0100
Message-Id: <a22fbe2ea7ca57099f2aadf29fbce6b896fc53c5.1657565224.git.mchehab@kernel.org>
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

There are several documented GuC kAPI that aren't currently part
of the docs. Add them, as this allows identifying issues with
badly-formatted tags.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/32] at: https://lore.kernel.org/all/cover.1657565224.git.mchehab@kernel.org/

 Documentation/gpu/i915.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
index afd8c0e3c689..70f2f4826eba 100644
--- a/Documentation/gpu/i915.rst
+++ b/Documentation/gpu/i915.rst
@@ -596,6 +596,28 @@ GuC
 
 .. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc.h
 
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/abi/guc_actions_slpc_abi.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ct.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_hwconfig.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_uc.c
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h
+
+.. kernel-doc:: drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c
+
 GuC Firmware Layout
 ~~~~~~~~~~~~~~~~~~~
 
-- 
2.36.1

