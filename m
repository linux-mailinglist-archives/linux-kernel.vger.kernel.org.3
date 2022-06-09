Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356635457F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbiFIXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbiFIXG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:06:56 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C026CE7A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816013; bh=tUCJ/kOy69U6y+seycCErXJBdtaMYUhJx4dUkjd6VCs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=jcfDUpqGR/1du2i+a0NvpQQqrsOc9E7p/vtm8SAs2l8uW4q8JzGSexl+CER7SI+x/O3KMEv/H5AXrcIxoRDsyqVu7Sio2ueh5j9H+Fps4qNiB9PJBVjSWiTiizusllIxrs0478Uswo0JcWaJKoi1lz4Nzvb1f6qVgC5flaSEvtPlti2jLRtdOSoxaZYPUH3xaaTk5wxNng+pTZJ/Z/P2/wOagZeZUpse5Y17bb2x+ypsA9wOFgiZKYCSop9PGcGWQkP57OWHxlZ5goZ3geIlbHdgCtDkzaDqgqpqcu4w/f4/5yhlT/j2Om/phJnkD0okTMv9Et4Xj4bOwnjBYTL6dA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816013; bh=OjBxQK6ED+V8nIrLEGt6qmEvE7ROyI/Bd6snOGwRepa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=X0NTJDToS09m51tWOf8mGZjxjlc9l7kH2gcNghyTxdcFcMgco76WM2ixF05JY3R3nlXpzweohw9sTxiemjjF5aVtco1CuqaQKfxYb8V2ybIUb47cf/tto9iB8HlAJAPFsHRULjO+VfwhIWbeVZJqrBPAml5Xh+jH4NMK0oZEIYyJ4mO6O7bETc5ber7sUB8SYmeNCjAyyiXgigrp7S2hDf47sC7gAMxe8src6kfgHhcpaSwATCBlD86QDayy6dYV5pO+u/CjujEef70b3MnGldOf7tanlFJqNbz/ZfC+mqStJwgIrlkctjxDJMl83H6ln893exq+MVMw3x9XbgKiAQ==
X-YMail-OSG: szfutXoVM1mboMjdGNApmTElysmZfRtlohF68cZlam6iEaC4pNdYxtgalCyme1G
 KvADI1V4tNpbkd55a1Vdi7osSg3CgWanBLIoO1WX4bSz3zGHqWkstXKg7ju1attctiPAOXQd1YY5
 bb2YMI63Y5gNAbV5ez6QVUQ.I4Uop1T4YdLtybKITvxe.dg5B54vgZHqgW_l0Rdyyv_YZAVWLoFG
 FvSACvfxjdiPwI_QtDIAw2nQF3r2doAznE.X18dTuL_L93VKh2FUxoBHlWoJ8pxOe_90Kij8KNSC
 os.6rYS628WgOdpCqBey_14j.u4lOwJ65Puj8g1Ry.So1F5UxSYtIPamqbaSH_lcnjfonmOMcpQK
 ltHwDSsD12tGoR7zabCEmGckx5EU_sdluwxBKpqRdXy3mPJV1CafBdhIOzGOrfLmoEoI8Am_qHf6
 7Vii7BXm77XcrfD.Mp6aCrD7VlyFAMCbLN1.WVlTb9cVqMiRrS64le4GwdvHXRt75RZRCDJvk2M5
 omyzZu1ZQtUrjsg26ubbNnZQLBUeKnj4IfG_5avmwj0Df5WrxrzLTohW1Wk.QaiwE5XER_g9d6SC
 C0NhonU3n1jTPspNbFNKSbR35G.IOrWw4gfEQZRXlYkjwvIqBczM3ItWBjcn0WAVWwArh_TxWXYS
 1vSGUL.mhnJR3xHG57iB2R1rg4btWv35hqzBVoeRNGiM8mYP8tkkoh0FsrXk_q31HmLoRKle6LOW
 00eKQqteL9t_55w0eL0Eh5XYVnkZCJehr5vt9wNI7v1n4UgWfDvAtGfc.BA1bZs920tSqyrT7Xqk
 TdVC90UzZ25yLyQP9QH.KoUjhkQK9AdC5tR4t98l7W1BPdQtBxgyQ22rvdBZ3jytB10MzkbV9zwk
 sto73IDGFmNyQ0BEplMhKbAKBahOoJOME10f0cvwTuDrbFXeCrg21MmOrVDRugK2JXFm8T9ABV6t
 MeHMWBAaExofgt3AsO0CaFv..PEicwitNq3t44GlPos_VVHMeIh9Plh5.L7strbd.M9eaCV.CyHZ
 BILc1GTQ2cGXMNkUvMJEZ1S6Vn5rDbgPjz4ifMrVI0blt6G1v09NcU8CpIdMx.E2s2HpwAdM6tCS
 CxiK..6gKucfgvSXBhJLNDSZEoWNE7sNJehhtLqgV42v_VzPNU5Oou54I3Y7zhSlLsFt5DFibAXW
 qmei3mafdsLjn8ggAGWLWMNZ5vcSWAJUYX0ORWrT0AXiA91CqSgH.PuuBhWu93PgeBe2RLDCii.y
 vt6BFbdZVScWW6hkRgvDM1NAn9U3iinZcUxpS6Wdw6ni63GivHN46sDOKLJXC2C9t6nc3RgZcDgM
 gYfwUTLQh2BjGB82FNj492HEQIbjK4fMowSBjQgSSBjSikkRoWI4R5U1dmpM4L8udadZGLOPYhGg
 SNb0SQGZzoangZIIaLQk1jRYXKcbYeGhBD2jRZyivrdMjEBLCFmc29GY5M6gO4er8vkKtL8EXuEi
 eQvvXC057gWXWhGaJ71FJR49N.c_WzQ0loUOhBTMrOof7EhwDlSTftndMIE.2ZIUeHAWjJkpojQa
 YYzpHZz4LxdSm8O3u9gnpntMS8cycmRDgIfRTbhbwsNw2JdH5u9ftUX16M_A7F1Pt0dSo7vfGNgB
 S8hVePEo.K7jsQXB5ZKwR1GJzQEsM0PzsS.hoTlogRnMDj.jDHF_WCqVg1YJF6Y2WSVfit5AhXLR
 pJAfjPTOT3N_j.ddboVLD56wYwMmUjcdLHhon.RTZ.8Bh19N4WqZ_7RF.jgaVG2RF0httFQjjDNH
 KSNaygl63Hu_HCgsr3jcarcMe.GGgTdjo5dd8dLZOsrN3KrHccwLNj0VzP4FTAKi2wVuyH0lEfxd
 K0SjyWe2RrYduxLFXgQ4UJVtOZq4xsoFXpBbjc_Q4P8IcZA7lOvG3lJ_XxTgq0O_UHNZO19pBzAE
 fphqkm9r7YgMdyQfML5PL3viYIxRwLNg1upNDjDZ9xBwVg_P0jlOSZJb_9umPQf6OptZS8DJYVGl
 ch3SS9Y81inuOrLY3jePb1pFjvYYNebp4Ygk2dIzmjz2azR_VvSN40hXuxVVfm2hchAjJc8MYUhq
 prfwKTeu64QnQW_0Uf9xBpOdNZWsNud3fAqR2xeQf.iDPa89_bvbflJ0P7fMKultkgiTcuyBkyNy
 LNU4xo.MZPzATYoMXWHdJOz5uE7OnU_mF5QCnZ7yKnnhTqpAsDXsc75tvf2FHHgmxr.ZAswTTpb_
 Nc1SW4AbBa4f4Hx9mpm966MNNbAZk8pp9WbMmG4XTfrGg7FP65Ub45X7rdYLR7TfRin3jaQ7i9Ah
 .sa_cSke_DlRwr.pGEMVKN8zFBJTCY8BJR4FPlB9KbyqENrsydOxfxq_LxA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:06:53 +0000
Received: by hermes--canary-production-ne1-799d7bd497-2pzdr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b20ca8b25547b2b344a65fa8c4e3e611;
          Thu, 09 Jun 2022 23:06:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 10/33] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu,  9 Jun 2022 16:01:23 -0700
Message-Id: <20220609230146.319210-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index e8e4a7a1029b..029c23719a5c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -522,7 +522,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1279,9 +1279,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 58e3f39f47ab..0986ded8e798 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2668,12 +2668,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 552a08750843..1e9c06607c39 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2006,10 +2006,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.35.1

