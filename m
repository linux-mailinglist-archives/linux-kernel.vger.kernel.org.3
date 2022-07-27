Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46B583276
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbiG0Sxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiG0Sxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:53:38 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDCB37199
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:50:45 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4LtLsw27PrzDrcR;
        Wed, 27 Jul 2022 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1658944244; bh=zbwgeQ5hriDb14EBkFwdfcA3AJe/6WClqClywvs3M3U=;
        h=From:To:Cc:Subject:Date:From;
        b=l3kGSShaffShsr1Yw1c/ftEYNYmfsVM/reNxGYtLgMvDMvZ2BxFmqewdidZUZ6UgK
         cI5Y4+uoOYECLH8pVOSdQCuGq9ELRPTGpOpXZq1ZTdNaPEECK9J1toqXgQzNIFbXlg
         aoS68REqPsdA4+Eif4g2doQNuzge1LWpJGcfemOM=
X-Riseup-User-ID: 969055C4E704636E320363B262450B830023C93B5222C48DCD5FBFCAD5BF868F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4LtLsq1t7nz1yQc;
        Wed, 27 Jul 2022 17:50:38 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH] drm/amd/display: Remove unused struct freesync_context
Date:   Wed, 27 Jul 2022 14:50:33 -0300
Message-Id: <20220727175033.453620-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All references to struct freesync_context were removed, so remove the
struct freesync_context itself and its entry on struct dc_stream_state.

Signed-off-by: Maíra Canal <mairacanal@riseup.net>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index c3d97206ed89..f87f852d4829 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -48,11 +48,6 @@ struct dc_stream_status {
 	bool is_abm_supported;
 };
 
-// TODO: References to this needs to be removed..
-struct freesync_context {
-	bool dummy;
-};
-
 enum hubp_dmdata_mode {
 	DMDATA_SW_MODE,
 	DMDATA_HW_MODE
@@ -184,9 +179,6 @@ struct dc_stream_state {
 	struct rect src; /* composition area */
 	struct rect dst; /* stream addressable area */
 
-	// TODO: References to this needs to be removed..
-	struct freesync_context freesync_ctx;
-
 	struct audio_info audio_info;
 
 	struct dc_info_packet hdr_static_metadata;
-- 
2.37.1

