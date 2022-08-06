Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA958B6BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiHFQUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 12:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiHFQUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 12:20:35 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470E5F4B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 09:20:34 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id KMXQotp2J09yuKMXRo5kMg; Sat, 06 Aug 2022 18:20:33 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 18:20:33 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Input: bma150 - Fix a typo in some comments
Date:   Sat,  6 Aug 2022 18:20:32 +0200
Message-Id: <a331a6244a1dfbf34dc85f1be6995fa91500c801.1659802757.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some extra '0'

s/BMA0150_RANGE_xxx/BMA150_RANGE_xxx/
s/BMA0150_BW_xxx/BMA150_BW_xxx

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/bma150.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bma150.h b/include/linux/bma150.h
index 31c9e323a391..4d4a62d49341 100644
--- a/include/linux/bma150.h
+++ b/include/linux/bma150.h
@@ -33,8 +33,8 @@ struct bma150_cfg {
 	unsigned char lg_hyst;		/* Low-G hysterisis */
 	unsigned char lg_dur;		/* Low-G duration */
 	unsigned char lg_thres;		/* Low-G threshold */
-	unsigned char range;		/* one of BMA0150_RANGE_xxx */
-	unsigned char bandwidth;	/* one of BMA0150_BW_xxx */
+	unsigned char range;		/* one of BMA150_RANGE_xxx */
+	unsigned char bandwidth;	/* one of BMA150_BW_xxx */
 };
 
 struct bma150_platform_data {
-- 
2.34.1

