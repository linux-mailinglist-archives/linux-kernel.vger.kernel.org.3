Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54755839A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiG1HnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiG1HnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:43:01 -0400
Received: from out20-206.mail.aliyun.com (out20-206.mail.aliyun.com [115.124.20.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55960685;
        Thu, 28 Jul 2022 00:42:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1063008|-1;BR=01201311R191S62rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.168038-0.000676144-0.831286;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=longjin@ringotek.cn;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.OfhcAno_1658994164;
Received: from localhost.localdomain(mailfrom:longjin@RinGoTek.cn fp:SMTPD_---.OfhcAno_1658994164)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 15:42:55 +0800
From:   fslongjin <longjin@RinGoTek.cn>
To:     corbet@lwn.net, twoerner@gmail.com, keescook@chromium.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        fslongjin <fslongjin@vip.qq.com>, longjin <longjin@RinGoTek.cn>
Subject: [PATCH] Documentation: Fixed errors in the title level of coding style documents
Date:   Thu, 28 Jul 2022 15:42:24 +0800
Message-Id: <20220728074224.155298-1-longjin@RinGoTek.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fslongjin <fslongjin@vip.qq.com>

In Section 3, `Placing Braces and Spaces`. In the previous document, only
`Spaces` is written in the subtitle without the `Braces`. I think this
 may be a format error caused by negligence, so I fixed it.

Signed-off-by: longjin <longjin@RinGoTek.cn>
Signed-off-by: fslongjin <fslongjin@vip.qq.com>
---
 Documentation/process/coding-style.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 03eb53fd029a..2a26bcb9f391 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -120,6 +120,9 @@ that breaks the ability to grep for them.
 3) Placing Braces and Spaces
 ----------------------------
 
+3.1) Braces
+***********
+
 The other issue that always comes up in C styling is the placement of
 braces.  Unlike the indent size, there are few technical reasons to
 choose one placement strategy over the other, but the preferred way, as
@@ -231,7 +234,7 @@ Also, use braces when a loop contains more than a single simple statement:
 			do_something();
 	}
 
-3.1) Spaces
+3.2) Spaces
 ***********
 
 Linux kernel style for use of spaces depends (mostly) on
-- 
2.20.1

