Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A24DBC05
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347539AbiCQBEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiCQBEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:04:51 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3D1BEBA;
        Wed, 16 Mar 2022 18:03:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7OxGLH_1647479011;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7OxGLH_1647479011)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 09:03:32 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     jmorris@namei.org, serge@hallyn.com, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix some kernel-doc comments
Date:   Thu, 17 Mar 2022 09:03:30 +0800
Message-Id: <20220317010330.82929-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

security/apparmor/domain.c:137: warning: Function parameter or member
'state' not described in 'label_compound_match'
security/apparmor/domain.c:137: warning: Excess function parameter
'start' description in 'label_compound_match'
security/apparmor/domain.c:1294: warning: Excess function parameter
'onexec' description in 'aa_change_profile'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index a29e69d2c300..d71023f5c9c4 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -119,7 +119,7 @@ static inline unsigned int match_component(struct aa_profile *profile,
  * @profile: profile to find perms for
  * @label: label to check access permissions for
  * @stack: whether this is a stacking request
- * @start: state to start match in
+ * @state: state to start match in
  * @subns: whether to do permission checks on components in a subns
  * @request: permissions to request
  * @perms: perms struct to set
@@ -1279,7 +1279,6 @@ static int change_profile_perms_wrapper(const char *op, const char *name,
 /**
  * aa_change_profile - perform a one-way profile transition
  * @fqname: name of profile may include namespace (NOT NULL)
- * @onexec: whether this transition is to take place immediately or at exec
  * @flags: flags affecting change behavior
  *
  * Change to new profile @name.  Unlike with hats, there is no way
-- 
2.20.1.7.g153144c

