Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D912E57BEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiGTTfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGTTfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:35:43 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3DB84D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:35:38 -0700 (PDT)
X-QQ-mid: bizesmtp91t1658345619tlxc36xd
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:33:26 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: +bXiSo2NuBdrFYQDLwG0mkbTmkYoUp0G4ZKwN7IgFJwdFj8YlnEZ78Ce/Npke
        nw39G9HLqWuqKsFNKux4+eVnuakvTR7zG8DVV5Q6G4Yp3SzyxrROZp+bXDnakoHb0kgkqP/
        ew8aEhDI7hdvPYIToPyaaC0tV5NGiT5C8RiaqvMCgpmrBCqh5Fqt+E56fTSmwUt6v1I8lJh
        eHtvWBG0U8WmD0Khe/o8GT5gaPodJnbxfBEO0uMg+ZTIv0H9I7j37TZz7bmVyGo+V1jEv/O
        GHjAmYdDGpuKEcCJITsOSl3w9V9FQCG31/pgOkIscXTYTRG51jK4P9hUtyR3fxCyZwzthyp
        4mUH9/cMVdZ/kUHd5xD+K7sMfCEFtg4/rWTiEUJomYP8B5LB/nOmtKNbaG8qw==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] kernel:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:33:23 +0800
Message-Id: <20220720193323.7848-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/mconsole_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 8ca67a692683..de40e7822fa6 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -283,7 +283,7 @@ struct unplugged_pages {
 };
 
 static DEFINE_MUTEX(plug_mem_mutex);
-static unsigned long long unplugged_pages_count = 0;
+static unsigned long long unplugged_pages_count;
 static LIST_HEAD(unplugged_pages);
 static int unplug_index = UNPLUGGED_PER_PAGE;
 
-- 
2.30.2

