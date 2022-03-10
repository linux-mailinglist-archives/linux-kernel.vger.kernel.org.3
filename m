Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75FB4D55E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbiCJXwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbiCJXwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:52:35 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE4719E738
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956292; bh=j5PSxx7pxMuUob08WR476BkBCAlorDOEyvyzPeGaYoA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iTdfDZ8eI4pr+BhOrRpsZKPRbRKowKfHlxXR7D1YDdYl4tgmNhj+4b7h/oIOBYq5MFQXg650eV6zg+pF3GD56NEH0VGkz0RDBnX7d4Rwffbj3AXugKqhPUnpKaI1MlmdE1MElEPSJxggGBjx+H0bXd6q1AuspdSz7ZZfhEuNvCWw7GiVCKft0K40zPcmFiNtC00ZDA9VZEHD+zQstdG73NkAZiuOX5rc1jGLiHlBz+mv2mJlv+huGp1Gm7DABHtOTm7V38kccapJgkJDJuBqrFb0qnp2Rf0G2H6nmu5CbQYWwysjQC+NbIzjunW3uknmFqlpPTdJ+Co78HY2MnDWTw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956292; bh=DptinqG2ColU012LyJkUEyjlm8zZSqkDFpan41FTMsY=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=X656Ei2rV5uPy4DNbOhu99IUXqSqXhgmHfXxnhqfZgZOzhTWjARbV+6rgjqTCNT59rIDA2iekPjW4zgakdNXyd+ixa0A2m5fiVM6W0eif6AvC2pTPzC9LdS7h6uZTQtxif/IIXTjNYPNgzarIecekTTbcXVry+Wd4iJ7g84aZo4grcGcntwF29XlAvpunAmGosADsnhYbVr1zxA4NHu5BWai/t7bpagaUziuo2aj9Y11OrgSNaw8D/jikuT179xs+2Qv+5HRXlc5GWG8GwPCZap/T0UG1eYDhGWnmzhvZtJu9/H9xCMNrO2gNtgxp1EAhpKA+HXc3GGqAkTjgb4xvw==
X-YMail-OSG: .jbe92UVM1k2UuecCC1FC4xDqNgz00Ua_AT_g0exjcVYmn.Jp3nqylaF41Nl46b
 fCcWZM.aMMfCOWitJ3swWQhlrkh1995KC8Griq5vfv6xKVxFSAostnQPi_wNmpjVUMSQYRmaFJ4y
 3UrTInIoXqa8XTznJi2wk4B4VHnrhKqJJrDkO5O6VHhTDwvIzclXq16EoniFLuSODB376qL2TCkU
 a7kFMHmBkl.UE1e.AzLame22qzIVo8LiZNAESUyPAnirdcU9zNz1Rl9WZOr.0T9DWLiyL1ANO3v6
 sagazADYM9dzW6W76SqnUDi_VojuzSEbWZO45xiUPwdk_0ozb2Q7W442ZEJkLG4WUL2QWGFDZoTk
 aG3yYTwjQwXngHDtAWWVMuCCAElUFpGgzhzriGyRhmWRMh5rurXRxIrf7Izcdv913Ju6qlrbomop
 nn2o2DHfXLqCWzzEUyAKs0ykfsFLKOCMwzMbzqauxxNJFUcqWAZ3PwR4BDSWnHu_6ea8Sbyyo6pJ
 FnqRPWYjqNWZ_qBH0hBxz1yUFXV7WXi5VMK2ImKQuYLxZoIoSbT3uSYl_lWvMYH5bGKNQsqInA6W
 SoEVLb7oQ8Yh9DE5LvhLcF8NPYRfOjhI.aq_gIf8OANW6fIW0bOUw770HHU.dhFhe4EDaBL_5Q3w
 O95Gwv39zfU0NhRAMj8fn9hxik57IprX5_vKUvcGFFUb_JUPfBlVTt0MDeDzG.PxzHIkCMId7sOw
 oIzBCS76LwWXMG_dOWsFf8jNomV4JfHL3I272aWG2XKCCVfaKLjPLQB.E0xWTCdioZ1dN60YjqNc
 n4n00l7.4TsRnZjlsX1r_g70sCq16w.X69YbbOJuYmY6AbkYrWwqMOyRlYbXM0RpskLkpJt85PsK
 ePiCuKDUQWI56xYQmtvprlbJSe_4QOSGeUZdq2qBSKHU_3t10EF1uGSloXvBVivHry2nfMxLjvhl
 n9jnHqZamn6lWEA6RAELXKwVeiEmBJxdHAoIH2lcZtVO.tkj.GBcVIijlKo.I1n0OFv1DDDrnZvm
 mlzRbX_GP7fibkhZ9NYuGbQODOs5Fep9uquhncpGkpUdIhIUvIn8cuqk5TQC5BRZNEsu9flAGIDx
 S5aYMaDEzD9GBAY3U0yb8yUJEBj5hkT7Km72SEpACOoqTqyfBPZrCbSV6PJcUZTT44rXr0yTXFmK
 neK1cLdK3PGpAugzWLhZuV9_OvBb0rmixXNj1UdN4C_N3no0N3b8qKjoO3vy4pn6oaJ3tML6c5RB
 FlbMl5iR4ATfsfPcFDQTFURhA.j4l5Y87FWf3AYUn0oIIacbFaTflH9r9PomkhasT1ZY8kwWjJ9Q
 lILWGmEcbqfIQVdzboWlzpJahkxJmCCzm12wd6D26eh7nc6FkwbscZBJc01D9ADii2QCJY4qipV0
 k05ShEEMcfQ9_BHPlD9J7CuMoaVgY1Nwcn0Pdd7qOhQR0SW32sZbZW5.qaNT1k_vmDjDQK1KVUPo
 7MUXa22E8BJKJjSajSqVu_jgH4YEymHHTInHnxkfUf27BLRGX037TnuvC_9.md5o9udqF92FG4R2
 .7bBROnWjjjyB2siMhQvjTrsSRYXLdswy41p_H12L.ctpSUhkkl_jPyoyX218HDyMiUViK2rxnaS
 vMD9.1pc5wtGp2ChHKvB1AxD1ucWC.nasbtZ5pt0psda5xtpISsMTQu5d0MsN5vEaZBlnfv400Cx
 TkR01L4dJU2DGc6YGKlL7UFj5tFE_ZxrEmK99bEi65eMJBTtUk3M8escSkx214FraFOBs3_WiqG0
 uRg5j7pTxqrMiuIZezRKguv6VChtH53ebeK6vW0yFUWAdzjbj95oQr8olIF61beXT1NN_8Dms5e1
 VXAyDOajMM1zPcaBZfZuL.PPK.K8vg67qWPxO8UbnqdWjYNZYGjtWBollGJifaZe.sZRzIQcrj9g
 Vd36767nBGjM.AVi7gXdP_y8OALEaCMZx9Acacxe2aTf2dEn59EoP6nWS_Y1z9ohCsBuEhdOmsG5
 8p2J._aKOliIk4Ob_fS4O3dU9u7KlVhohAdZSKIQy5iPjKfZYCiyW1LahO.468GxPGSBwyNaJnfY
 EqYtGWi1F.ToSbTok5foAvkW2PjHs1NsVRuWcNWeV_I.9IO.y3tutPpYD0YnIrzJtkePWQ6u8XgQ
 Sk_Fvp7gwc4xRH_VHYulPIbSiO_902E7ItY7N7OlXs7wXj_5pUOsCarEe.SV33FlvZUBAhCo01u5
 B.tFxFDwbfCpF4DmyNfZygjXCmTJNXS4S38LAAYPq3KdylmMNkOND7.loNOfq4u1ZY8NvIXQ8ubn
 cTqBPzjwQrS2WuaQmi7DzdSu6YRgQ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:51:32 +0000
Received: by kubenode514.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 02d0d7342d647b4cf843030be84eedee;
          Thu, 10 Mar 2022 23:51:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 10/29] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu, 10 Mar 2022 15:46:13 -0800
Message-Id: <20220310234632.16194-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index a104ec0759c2..1814516509ec 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -520,7 +520,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1277,9 +1277,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 5edb16cb12e0..598e0de45b04 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2610,12 +2610,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index ffdd366d2098..815200684bcf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1999,10 +1999,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.31.1

