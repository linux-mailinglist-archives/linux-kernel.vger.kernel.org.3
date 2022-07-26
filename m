Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F845819A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiGZSXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiGZSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:23:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC45129CB7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+7t/7eAOvi8kAxMn65dXL5tgH7liqj/5NHPtUP/lMtI=; b=pAqbxLvpfzTFr1RX7FKZOOenJu
        fQASXOaguX5weGrJTPL/0MdF5aDoGdczDr/KHCDN84mFJs+mvbfv5kQNKyQm9tzcFu138DfGU8mK5
        Ksy6EzgNzIXPg7yGTC/VqrDQT3m6Tw/ASh5sKGxGtBmxS1ziqAHZuhD0R1Aj0d6Ua27+85Kd4+Bt9
        2N1Mwxfqa2qo2nT8kJjh/YAffcJnaGu36OFjCTKGrNsK2jXbUlChrVA9246W9GyJVe4ecMgpQufCv
        SD1IBaySgilNopilgOlVAvL0d0b8H/ZzxYO6FbtXOQm0UWGyYc/25HzGRcr2k8gzY+nP27ogPh5cg
        +Fb4xDRg==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oGPD5-007aEh-VD; Tue, 26 Jul 2022 20:23:12 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 4/4] drm/amdgpu: Document gfx_off members of struct amdgpu_gfx
Date:   Tue, 26 Jul 2022 15:21:52 -0300
Message-Id: <20220726182152.123649-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726182152.123649-1-andrealmeid@igalia.com>
References: <20220726182152.123649-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments to document gfx_off related members of struct amdgpu_gfx.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1b8b4a5270c9..8abdf41d0f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -332,12 +332,12 @@ struct amdgpu_gfx {
 	uint32_t                        srbm_soft_reset;
 
 	/* gfx off */
-	bool                            gfx_off_state; /* true: enabled, false: disabled */
-	struct mutex                    gfx_off_mutex;
-	uint32_t                        gfx_off_req_count; /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
-	struct delayed_work             gfx_off_delay_work;
-	uint32_t                        gfx_off_residency;
-	uint64_t                        gfx_off_entrycount;
+	bool                            gfx_off_state;      /* true: enabled, false: disabled */
+	struct mutex                    gfx_off_mutex;      /* mutex to change gfxoff state */
+	uint32_t                        gfx_off_req_count;  /* default 1, enable gfx off: dec 1, disable gfx off: add 1 */
+	struct delayed_work             gfx_off_delay_work; /* async work to set gfx block off */
+	uint32_t                        gfx_off_residency;  /* last logged residency */
+	uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
 
 	/* pipe reservation */
 	struct mutex			pipe_reserve_mutex;
-- 
2.37.1

