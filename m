Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F62F534A61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbiEZG2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiEZG2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:28:32 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A9BC6EB;
        Wed, 25 May 2022 23:28:30 -0700 (PDT)
X-UUID: 1fcc9c13c4904a2fb9047121447749a4-20220526
X-UUID: 1fcc9c13c4904a2fb9047121447749a4-20220526
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <pengfuyuan@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1815677509; Thu, 26 May 2022 14:31:21 +0800
X-ns-mid: postfix-628F1E05-2327746001
Received: from localhost.localdomain (unknown [172.20.4.120])
        by cs2c.com.cn (NSMail) with ESMTPA id 1B8DE3848645;
        Thu, 26 May 2022 06:28:21 +0000 (UTC)
From:   pengfuyuan <pengfuyuan@kylinos.cn>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, pengfuyuan <pengfuyuan@kylinos.cn>
Subject: [PATCH] radeon: Fix spelling typo in comment
Date:   Thu, 26 May 2022 14:27:57 +0800
Message-Id: <20220526062757.1155581-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling typo in comment.

Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 include/video/radeon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/video/radeon.h b/include/video/radeon.h
index 005eae19ec09..72f94ccfa725 100644
--- a/include/video/radeon.h
+++ b/include/video/radeon.h
@@ -750,7 +750,7 @@
 #define WAIT_DMA_GUI_IDLE			   (1 << 9)
 #define WAIT_2D_IDLECLEAN			   (1 << 16)
 
-/* SURFACE_CNTL bit consants */
+/* SURFACE_CNTL bit constants */
 #define SURF_TRANSLATION_DIS			   (1 << 8)
 #define NONSURF_AP0_SWP_16BPP			   (1 << 20)
 #define NONSURF_AP0_SWP_32BPP			   (1 << 21)
-- 
2.25.1

