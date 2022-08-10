Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9358F4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiHJXa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiHJXaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:30:00 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485498FD55
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 16:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+7t/7eAOvi8kAxMn65dXL5tgH7liqj/5NHPtUP/lMtI=; b=pYnj2wc3dKklpInsGJAB6JOMxK
        RisYrT54Mjn3hO7kYTNobeqKnjZeRV1LjM0LCfKx9FUuGDWMHLdwPeoO9Y2lM2zXRJQ5VpgSfR3wy
        PVjjHqoaOCu60lckijE5fAPa+ogOQ0RMyw/Q9fhi5Tlaq0dGouHesKsU/MRzAriDZ0f83iXpoNJyc
        B3ghaHF/kBAvOwRiMedh0MDLA+6z3lcGj47WLcsX1BNE0Jl2ihxaOtHyPu807Rhviy8yiAHVrXutJ
        gffrmqdSNoNuHJUUmC2rDWmGvNQP1YQ2Is33xeR53dPYd3ZDvD/uEaV0uZjVbvW+Gn+W5+RTY6peO
        0MUNUnKg==;
Received: from [191.17.41.12] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oLv94-004r9g-EZ; Thu, 11 Aug 2022 01:29:50 +0200
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
Subject: [PATCH v3 4/4] drm/amdgpu: Document gfx_off members of struct amdgpu_gfx
Date:   Wed, 10 Aug 2022 20:28:58 -0300
Message-Id: <20220810232858.11844-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810232858.11844-1-andrealmeid@igalia.com>
References: <20220810232858.11844-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

