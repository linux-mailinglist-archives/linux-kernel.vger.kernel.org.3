Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272AC51885D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbiECPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbiECPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:23:13 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 344313BBD0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:19:00 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-ij1yUGGCMnKDlADZxWlefg-1; Tue, 03 May 2022 11:18:40 -0400
X-MC-Unique: ij1yUGGCMnKDlADZxWlefg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD0EC1D14E24;
        Tue,  3 May 2022 13:40:29 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AF2B9E89;
        Tue,  3 May 2022 13:40:26 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Containers <containers@lists.linux.dev>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 4/4] ipc: Remove extra braces
Date:   Tue,  3 May 2022 15:39:57 +0200
Message-Id: <37687827f630bc150210f5b8abeeb00f1336814e.1651584847.git.legion@kernel.org>
In-Reply-To: <cover.1651584847.git.legion@kernel.org>
References: <87sfprudal.fsf@email.froward.int.ebiederm.org> <cover.1651584847.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style. In the previous commit, I added braces because,
in addition to changing .data, .extra1 also changed. Now this is not
needed.

Fixes: 1f5c135ee509 ("ipc: Store ipc sysctls in the ipc namespace")
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/ipc_sysctl.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 5a58598d48c8..ef313ecfb53a 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -222,42 +222,41 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(ipc_sysctls); i++) {
-			if (tbl[i].data == &init_ipc_ns.shm_ctlmax) {
+			if (tbl[i].data == &init_ipc_ns.shm_ctlmax)
 				tbl[i].data = &ns->shm_ctlmax;
 
-			} else if (tbl[i].data == &init_ipc_ns.shm_ctlall) {
+			else if (tbl[i].data == &init_ipc_ns.shm_ctlall)
 				tbl[i].data = &ns->shm_ctlall;
 
-			} else if (tbl[i].data == &init_ipc_ns.shm_ctlmni) {
+			else if (tbl[i].data == &init_ipc_ns.shm_ctlmni)
 				tbl[i].data = &ns->shm_ctlmni;
 
-			} else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced) {
+			else if (tbl[i].data == &init_ipc_ns.shm_rmid_forced)
 				tbl[i].data = &ns->shm_rmid_forced;
 
-			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmax) {
+			else if (tbl[i].data == &init_ipc_ns.msg_ctlmax)
 				tbl[i].data = &ns->msg_ctlmax;
 
-			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmni) {
+			else if (tbl[i].data == &init_ipc_ns.msg_ctlmni)
 				tbl[i].data = &ns->msg_ctlmni;
 
-			} else if (tbl[i].data == &init_ipc_ns.msg_ctlmnb) {
+			else if (tbl[i].data == &init_ipc_ns.msg_ctlmnb)
 				tbl[i].data = &ns->msg_ctlmnb;
 
-			} else if (tbl[i].data == &init_ipc_ns.sem_ctls) {
+			else if (tbl[i].data == &init_ipc_ns.sem_ctls)
 				tbl[i].data = &ns->sem_ctls;
 #ifdef CONFIG_CHECKPOINT_RESTORE
-			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id) {
+			else if (tbl[i].data == &init_ipc_ns.ids[IPC_SEM_IDS].next_id)
 				tbl[i].data = &ns->ids[IPC_SEM_IDS].next_id;
 
-			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id) {
+			else if (tbl[i].data == &init_ipc_ns.ids[IPC_MSG_IDS].next_id)
 				tbl[i].data = &ns->ids[IPC_MSG_IDS].next_id;
 
-			} else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id) {
+			else if (tbl[i].data == &init_ipc_ns.ids[IPC_SHM_IDS].next_id)
 				tbl[i].data = &ns->ids[IPC_SHM_IDS].next_id;
 #endif
-			} else {
+			else
 				tbl[i].data = NULL;
-			}
 		}
 
 		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set, "kernel", tbl);
-- 
2.33.3

