Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09FE5849D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiG2CgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiG2CgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:36:20 -0400
Received: from out20-85.mail.aliyun.com (out20-85.mail.aliyun.com [115.124.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784BA52FE3;
        Thu, 28 Jul 2022 19:36:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1142877|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.091604-0.000316197-0.90808;FP=11801277814066224926|4|1|5|0|-1|-1|-1;HT=ay29a033018047205;MF=longjin@ringotek.cn;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.OgOkP57_1659062123;
Received: from localhost.localdomain(mailfrom:longjin@RinGoTek.cn fp:SMTPD_---.OgOkP57_1659062123)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 10:35:38 +0800
From:   fslongjin <longjin@RinGoTek.cn>
To:     corbet@lwn.net, twoerner@gmail.com, keescook@chromium.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        fslongjin <longjin@RinGoTek.cn>
Subject: [PATCH] Documentation: Fixed errors in the title level of coding style documents
Date:   Fri, 29 Jul 2022 10:34:54 +0800
Message-Id: <20220729023454.18085-1-longjin@RinGoTek.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Section 3, `Placing Braces and Spaces`. In the previous document, only
`Spaces` is written in the subtitle without the `Braces`. I think this
 may be a format error caused by negligence, so I fixed it.

Signed-off-by: fslongjin <longjin@RinGoTek.cn>
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

