Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779E95533EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350959AbiFUNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347916AbiFUNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:44:33 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3E9240A8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:44:22 -0700 (PDT)
X-QQ-mid: bizesmtp76t1655819046tiho5ors
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:44:03 +0800 (CST)
X-QQ-SSF: 0100000000700060B000D00A0000000
X-QQ-FEAT: im3L/SzDuHb+PBZItGUN4C+pdaOOhthsGIesY3yK58ihyIqmNp54sUmkdtCEa
        QA0tSBX3cSGjcsBF2tKvehCUfKLhLM4/ddodxQcB0JMjzzp92vlxdD0m9L6l4Xb//+QO7+u
        fb6fSEGPfFhzRvj1Wq48aHwboOspe+kGf+5Ht6awAY38fdgvXBzpXqt4orDtaJTLEBhugKQ
        fiBl0EY7mqgwxNTXbfVXgilSoz2EX+PNCkMaDsdK04zNyWyq6H5u+WYx/NZRDhVfZaF4dPm
        5sFu2jNP4YFG3zuQj/xe14Z+LEGG62ogi/n4E8DTjKO4VnVdMvtONOUQYwRgfcD4MMkLC8i
        ylHU0c3qizjAukpLlg3Fb8NCTW5pw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] drm: panel-orientation-quirks: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:44:01 +0800
Message-Id: <20220621134401.10290-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/drm_panel_orientation_quirks.c
line: 196
* GPD Pocket, note that the the DMI data is less generic then
changed to
* GPD Pocket, note that the DMI data is less generic then

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index df87ba99a87c..7a9eeed239f3 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -193,7 +193,7 @@ static const struct dmi_system_id orientation_data[] = {
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
 	}, {	/*
-		 * GPD Pocket, note that the the DMI data is less generic then
+		 * GPD Pocket, note that the DMI data is less generic then
 		 * it seems, devices with a board-vendor of "AMI Corporation"
 		 * are quite rare, as are devices which have both board- *and*
 		 * product-id set to "Default String"
-- 
2.17.1

