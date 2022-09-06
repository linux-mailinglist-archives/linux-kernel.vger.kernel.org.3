Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7CE5AE982
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiIFN2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiIFN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:28:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B374B8C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:28:35 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MMR1J3btRzZchQ;
        Tue,  6 Sep 2022 21:24:04 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 6 Sep 2022 21:28:33 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] audit: remove selinux_audit_rule_update() declaration
Date:   Tue, 6 Sep 2022 21:25:08 +0800
Message-ID: <20220906132508.112248-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selinux_audit_rule_update() has been renamed to audit_update_lsm_rules()
since commit d7a96f3a1ae2 ("Audit: internally use the new LSM audit
hooks"), so remove it.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/audit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index d6eb7b59c791..c57b008b9914 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -245,8 +245,6 @@ struct audit_netlink_list {
 
 int audit_send_list_thread(void *_dest);
 
-extern int selinux_audit_rule_update(void);
-
 extern struct mutex audit_filter_mutex;
 extern int audit_del_rule(struct audit_entry *entry);
 extern void audit_free_rule_rcu(struct rcu_head *head);
-- 
2.17.1

