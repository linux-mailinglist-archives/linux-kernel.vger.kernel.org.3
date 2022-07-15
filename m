Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD39D578260
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiGRMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:32:00 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC765205F7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:31:55 -0700 (PDT)
X-QQ-mid: bizesmtp64t1658147496tsq7f7fx
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:31:34 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: NGMqyHdgFPa1Gj72Kw5wrqYn+EJjFCyEoyJqb7OCrR7aLICFqKVdIJFb3ATVj
        C+akZGMII4OLL9eHCAYABUr8spJh1l4x5J3HDJIclhlgdZ3uK5TI5sYXhlR9/6lq33Z2D9c
        K4P2Nh6uXx4L7QAXMULEBsy9xky1OJ1KkI0BB2IQGRCuqu1SPAwTKA/fN7obPKwy5m/ZRjd
        Y+3IoPXOy9Dkld8AAFhb3LNhvls0uU50sGBojgTrIU5r9e2jP+I+oHxMNmqDWrd6RqiVltd
        MEfarR3ZT3zvBIhdIq3E6TuSTSbe47R7h7468G30Z80YUt7kz0EM11VOd++CUYkLb7KT+tu
        eauBgw4cP38wGC63O30hru9w4UUDBNqS+4I7frgncznO7Qwsw11rkQnXPIF1v6f6Extnhe6
        5VHEu6cs2cQ=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     anton.ivanov@cambridgegreys.com
Cc:     richard@nod.at, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] um: Fix comment typo
Date:   Fri, 15 Jul 2022 12:29:38 +0800
Message-Id: <20220715042938.15291-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `in' is duplicated in line 172, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/um/kernel/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index e7c7b53a1435..91485119ae67 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
 );
 
 /*
- * This list is constructed in parse_iomem and addresses filled in in
+ * This list is constructed in parse_iomem and addresses filled in
  * setup_iomem, both of which run during early boot.  Afterwards, it's
  * unchanged.
  */
-- 
2.35.1

