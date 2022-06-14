Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221354A3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbiFNB40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiFNB4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:56:20 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FED331923;
        Mon, 13 Jun 2022 18:56:17 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 25E1tbuD014131-25E1tbuG014131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 14 Jun 2022 09:55:42 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mudongliang <mudongliangabcd@gmail.com>, cocci@inria.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dev-tools: modify SPL reference URL to actual SPL doc entry
Date:   Tue, 14 Jun 2022 09:55:27 +0800
Message-Id: <20220614015527.82900-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mudongliang <mudongliangabcd@gmail.com>

This patch modifies SPL reference URL from old Coccinelle documentation
(doc root) to actual SPL doc entry on new Coccinelle page.

Signed-off-by: mudongliang <mudongliangabcd@gmail.com>
---
v1->v2: modify the title and commit message according to Bagas Sanjaya
 Documentation/dev-tools/coccinelle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 9c454de5a7f7..d9976069ed12 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -66,7 +66,7 @@ The wiki documentation always refers to the linux-next version of the script.
 
 For Semantic Patch Language(SmPL) grammar documentation refer to:
 
-http://coccinelle.lip6.fr/documentation.php
+https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.html
 
 Using Coccinelle on the Linux kernel
 ------------------------------------
-- 
2.35.1

