Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD549524770
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351236AbiELHx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbiELHx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:53:56 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17D5326F7;
        Thu, 12 May 2022 00:53:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VCziySh_1652342031;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VCziySh_1652342031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 May 2022 15:53:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     jmorris@namei.org, serge@hallyn.com, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix aa_str_perms() kernel-doc comment
Date:   Thu, 12 May 2022 15:53:50 +0800
Message-Id: <20220512075350.31163-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @start and remove @state in aa_str_perms()
kernel-doc comment to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

security/apparmor/file.c:260: warning: Function parameter or member
'start' not described in 'aa_str_perms'
security/apparmor/file.c:260: warning: Excess function parameter 'state'
description in 'aa_str_perms'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index e1b7e93602e4..137c99bb5d4a 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -247,7 +247,7 @@ struct aa_perms aa_compute_fperms(struct aa_dfa *dfa, unsigned int state,
 /**
  * aa_str_perms - find permission that match @name
  * @dfa: to match against  (MAYBE NULL)
- * @state: state to start matching in
+ * @start: the state of the dfa to start matching in
  * @name: string to match against dfa  (NOT NULL)
  * @cond: conditions to consider for permission set computation  (NOT NULL)
  * @perms: Returns - the permissions found when matching @name
-- 
2.20.1.7.g153144c

