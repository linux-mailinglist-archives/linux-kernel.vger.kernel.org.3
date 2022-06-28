Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6AD55C3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiF1JrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244939AbiF1Jqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1A25C4C;
        Tue, 28 Jun 2022 02:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D54DB617CF;
        Tue, 28 Jun 2022 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77708C341EE;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=KmE1n0kBTzhMcDi/Es4qlC1RvvMz696gfPuCpCdCwXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwuiQNtLKte3nUdoCxdKSDOuRdlj/40+1HS65mhF7M/yFot3TsdTn7O24tvybSWgC
         W8ISK3Ms8GdYha5G8nCAt23Yoswo5flJ6O7ezyLVvU+w/yIfP5bYo2xCXCIvS9hmrb
         S759Ga4sNfLrqyuwTyZZm/4mersiFwGydZr9UQPPhYtZJWpUAOv+X4uX19/5REBqjI
         1Qb/C2iiZ9mWBoXMilbVTGb1KIP4iaxbGqJ+AVrR7tl2cbPtQ5DYRptfDeEkfBxfo8
         gBjJPj0o96jsYKUX719G8Rq+8DKqK3LZH9jxhS1gPPZy9ZzwV9cbT401X7Z3UFIz4+
         tzfM/QEtoo3xg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HFG-Rk;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhang <dingchen.zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Zhan Liu <zhan.liu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/22] drm: amd: amd_shared.h: Add missing doc for PP_GFX_DCS_MASK
Date:   Tue, 28 Jun 2022 10:46:15 +0100
Message-Id: <3aee446a0e396fe3f338f270746939f6e803a4de.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol is missing documentation:

	drivers/gpu/drm/amd/include/amd_shared.h:224: warning: Enum value 'PP_GFX_DCS_MASK' not described in enum 'PP_FEATURE_MASK'

Document it.

Fixes: 680602d6c2d6 ("drm/amd/pm: enable DCS")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index bcdf7453a403..2e02a6fc1717 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -193,6 +193,7 @@ enum amd_powergating_state {
  * @PP_ACG_MASK: Adaptive clock generator.
  * @PP_STUTTER_MODE: Stutter mode.
  * @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
+ * @PP_GFX_DCS_MASK: GFX Async DCS.
  *
  * To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
  * the kernel's command line parameters. This is usually done through a system's
-- 
2.36.1

