Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F364D84C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242333AbiCNM3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbiCNMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:20 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A369CEF;
        Mon, 14 Mar 2022 05:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJ5wXrhL/9ylQnMvdM2Q4vFxfquXxlOyQHpUBbVVNgI=;
  b=a3jhw+wo/Cs8m0TeWfe+JUWEyIsLOIAuZ+eUSQ/fY1nkQeScgGRbVVDX
   Y/WQfE3t4AAGmGm7CwfaPzKr4JZeP1e/7BOTm4hxIDSf9lP03Pj6cEyhv
   7gd50CPjNwFMpGcf26wvWl/Xn8HrwUP+ftNfv8ZuM9a2EnFliHV4CSk4t
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25997357"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:54:00 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     kernel-janitors@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] drm/amdgpu/dc: fix typos in comments
Date:   Mon, 14 Mar 2022 12:53:47 +0100
Message-Id: <20220314115354.144023-24-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314115354.144023-1-Julia.Lawall@inria.fr>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various spelling mistakes in comments.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/gpu/drm/amd/display/dc/bios/command_table.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index ad13e4e36d77..0e36cd800fc9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -456,7 +456,7 @@ static enum bp_result transmitter_control_v2(
 		if ((CONNECTOR_ID_DUAL_LINK_DVII == connector_id) ||
 				(CONNECTOR_ID_DUAL_LINK_DVID == connector_id))
 			/* on INIT this bit should be set according to the
-			 * phisycal connector
+			 * physical connector
 			 * Bit0: dual link connector flag
 			 * =0 connector is single link connector
 			 * =1 connector is dual link connector
@@ -468,7 +468,7 @@ static enum bp_result transmitter_control_v2(
 				cpu_to_le16((uint8_t)cntl->connector_obj_id.id);
 		break;
 	case TRANSMITTER_CONTROL_SET_VOLTAGE_AND_PREEMPASIS:
-		/* votage swing and pre-emphsis */
+		/* voltage swing and pre-emphsis */
 		params.asMode.ucLaneSel = (uint8_t)cntl->lane_select;
 		params.asMode.ucLaneSet = (uint8_t)cntl->lane_settings;
 		break;
@@ -2120,7 +2120,7 @@ static enum bp_result program_clock_v5(
 	memset(&params, 0, sizeof(params));
 	if (!bp->cmd_helper->clock_source_id_to_atom(
 			bp_params->pll_id, &atom_pll_id)) {
-		BREAK_TO_DEBUGGER(); /* Invalid Inpute!! */
+		BREAK_TO_DEBUGGER(); /* Invalid Input!! */
 		return BP_RESULT_BADINPUT;
 	}
 

