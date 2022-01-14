Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0827148E2AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiANCuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:50:07 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:7251 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiANCuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:50:06 -0500
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 21:50:05 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.89]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb61e0e2ba96c-c4caf; Fri, 14 Jan 2022 10:40:59 +0800 (CST)
X-RM-TRANSID: 2eeb61e0e2ba96c-c4caf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvrnew05-12026 (RichMail) with SMTP id 2efa61e0e2b9821-0e0b1;
        Fri, 14 Jan 2022 10:40:58 +0800 (CST)
X-RM-TRANSID: 2efa61e0e2b9821-0e0b1
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spdxcheck.py: Fix a type error
Date:   Fri, 14 Jan 2022 10:40:58 +0800
Message-Id: <20220114024058.74536-1-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused variable "col", otherwise there will be a type error
as below:

typeerror: not all arguments converted during string formatting

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 scripts/spdxcheck.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index ebd06ae642c9..f3be8ed54f6d 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -200,7 +200,7 @@ class id_parser(object):
                 tok = pe.tok.value
                 sys.stdout.write('%s: %d:%d %s: %s\n' %(fname, self.curline, col, pe.txt, tok))
             else:
-                sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, col, pe.txt))
+                sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, pe.txt))
             self.spdx_errors += 1
 
 def scan_git_tree(tree):
-- 
2.31.1



