Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3D5961AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiHPR63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiHPR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:58:27 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534797A50A;
        Tue, 16 Aug 2022 10:58:25 -0700 (PDT)
X-QQ-mid: bizesmtp75t1660672699tjx496j5
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:58:08 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: 83ShfzFP0oBfXPjbvoBDh05AY293R7I3p4PxOapQ/oj9Qccgz39w9ubSlsBB/
        jLiwnA/xVDvzf3P0bRgrViL3Kx/ie919kpwmw7ZCxeNThkng80I0k+ZAYQhI7JqabZCo/LP
        M/eK8g42ZeE8rVKboNRIU1qXq2Yrysl6KSLBQc3eGzOadDEuUlBfxTOru9+/eLgp0IyVtqD
        0eNR5HDyNq0e1nck9qGWuFduPcA23Qgbf29C8di28xwkuDfH4lgz2DYZIEvor+zL72QRAn7
        0Gj5Jm/VjbN+FTDkMGsDkGjcXAl+7Zz1JGnDimOLhq3C4j5+vv30cNJYuQ05t+eVGjBQLSk
        gZ5W5gozR/XfmA0E0ahdoNfF58uHL6EsabRSh7IbMUJloDZFvRWkxc7V1VqTkC8WiAN8YBf
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] selinux: Variable type completion
Date:   Wed, 17 Aug 2022 01:58:07 +0800
Message-Id: <20220816175807.8447-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 security/selinux/hooks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index beceb89f68d9..13f3271d2c6a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2392,7 +2392,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	return 0;
 }
 
-static int match_file(const void *p, struct file *file, unsigned fd)
+static int match_file(const void *p, struct file *file, unsigned int fd)
 {
 	return file_has_perm(p, file, file_to_av(file)) ? fd + 1 : 0;
 }
@@ -2404,7 +2404,7 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 	struct file *file, *devnull = NULL;
 	struct tty_struct *tty;
 	int drop_tty = 0;
-	unsigned n;
+	unsigned int n;
 
 	tty = get_current_tty();
 	if (tty) {
-- 
2.30.2

