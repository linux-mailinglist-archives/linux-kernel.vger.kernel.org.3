Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A658250FA87
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiDZKfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349120AbiDZKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:35:00 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE1B1117D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:13:30 -0700 (PDT)
X-UUID: 839b2cb5bfb342069a8d8897af33cbe3-20220426
X-Spam-Fingerprint: 0
X-GW-Reason: 11109
X-Policy-Incident: 5pS25Lu25Lq66LaF6L+HMTDkurrpnIDopoHlrqHmoLg=
X-Content-Feature: ica/max.line-size 106
        audit/email.address 1
        meta/cnt.alert 1
X-UUID: 839b2cb5bfb342069a8d8897af33cbe3-20220426
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1529660238; Tue, 26 Apr 2022 18:10:05 +0800
From:   oushixiong <oushixiong@kylinos.cn>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Clements <john.clements@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Jiawei Gu <Jiawei.Gu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, oushixiong <oushixiong@kylinos.cn>
Subject: [PATCH] drm/amd: Fix spelling typo in comment
Date:   Tue, 26 Apr 2022 18:11:26 +0800
Message-Id: <20220426101126.1417207-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: oushixiong <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 7bd763361d6e..b7a1e2116e7e 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -3,7 +3,7 @@
 *  File Name      atomfirmware.h
 *  Project        This is an interface header file between atombios and OS GPU drivers for SoC15 products
 *
-*  Description    header file of general definitions for OS nd pre-OS video drivers
+*  Description    header file of general definitions for OS and pre-OS video drivers
 *
 *  Copyright 2014 Advanced Micro Devices, Inc.
 *
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
