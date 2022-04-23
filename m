Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49BA50C607
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiDWBct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiDWBcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:32:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0E1135380
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=x2bd6S4bmTTvHUq69Na2qRGHtShuyYBXZEOPRIIgd8E=; b=hn+LOYPKMgtXSUvCJARi8nm8Ap
        /jovlbudM4XvOs3vv2peO9+0ewMjqvx6sl43o7E0XBcPv9RJ7ApMXWSOeiSRKigkC90RZm6u9/2or
        ZNG2sQRK1CvHX2o3qwAFJwIPt/qErClQsyp+Ai0DMMAQFdEac/3sba3iNf2Zxh8cvtalNw2bgLftg
        9sOr7cgX66O5MsJW27sMKFTKKkOjklM9RiSBiqJTpASv4xUdcDQlhZmOM9oHNjQVoFwW8MhVcUHlQ
        Qdo+uVQhVB3aylrTd42+F5G0eK9aqZvCi52jo79x9mmOtIW/N1ZAeHEb7g4LVaqt/J/yTdirK9C2N
        b4oBG80Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ni4an-00377U-9S; Sat, 23 Apr 2022 01:29:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Robin Chen <po-tchen@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: fix non-kernel-doc comment warnings
Date:   Fri, 22 Apr 2022 18:29:43 -0700
Message-Id: <20220423012943.12133-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings for a comment that should not use
kernel-doc notation:

dmub_psr.c:235: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Set PSR power optimization flags.
dmub_psr.c:235: warning: missing initial short description on line:
 * Set PSR power optimization flags.

Fixes: e5dfcd272722 ("drm/amd/display: dc_link_set_psr_allow_active refactoring")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Robin Chen <po-tchen@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -231,7 +231,7 @@ static void dmub_psr_set_level(struct dm
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
-/**
+/*
  * Set PSR power optimization flags.
  */
 static void dmub_psr_set_power_opt(struct dmub_psr *dmub, unsigned int power_opt, uint8_t panel_inst)
