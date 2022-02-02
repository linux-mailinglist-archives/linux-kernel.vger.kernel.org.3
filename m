Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0784A7C45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348276AbiBCAFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:05:23 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:45418
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234378AbiBCAFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846721; bh=U7o6iu0aiGNCT9KjovMFIdMhHKxbc+wRz9jMKeUUcUk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cXK0efDBffWpAPUqtHSXOtbf0YDzJ41uzKe5mmY323BDuzu9rjpxdByzCEHNZzqJmmuBRWhi/2tUhza0vmPgJY6mjIhAK+jiQAP0oa+u+J9DbRW6FrXR9agsyRxkb6dIrpSNg39vOQEZEqncZBz1JxOkQj7mMK00ODcyP3p/3rXG/Sy3m+/DwDmBxCMM+Kt/IotGqwfZYw8so1vVtREWDmrAr4+3OhP8OkRyWk42NTyFKzU9f4QWs/uTHoPZJrSMutXKrosfmOqaaRfBMKaK4csdW23GWsF3deMSz5aRKYK7337vTkP7bSs3Yd7kmdg9av6O70OWlU031opkRenLUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643846721; bh=fi+il9McI471DpB8qWLNOMb2tseOdryw7+GaU32Ly/B=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=orEpZIxgqLG1dx8ZrJ5koLs4scji3e5Z5WmCCEqx2wiPP6sARE6nq3LmMipuabVxQYb1Se4FULC/6xIf5EDnaE6STvT5q/cb/8E7nUTCMY8PhtuVCdqQY82PC4EdJnFV/iLaltYljpmNONpxFW/4GHLm9ftVXc2q0Gjr5RV/j3XcwHAgQOv/BNEARDJvU/M5/QYfUUcKAkf4fVmUfEOxNF+ZQFLAl6tp7R0rJ+1Zh8Bv+dF3Xr7+TEEFNfpPzEmC0kJ5peVBprRt1N9eCtrYaSNkMc2y4sXYCS7us9BctSli51WJbH/5+84r+qmxwJXgNsN0GQew6SYNJn6lYjZYKA==
X-YMail-OSG: oyybyQ8VM1krzzjVGyPBWEwJFGABFQm8dk6BvgoXLcFd0vfJZOT0wv_6aEdXD6r
 Md3whcA0V154Z3BASctJ8gU0o9X35Mccp7KVXwWBWo4dFB9QZFc5JaxvTklwOyWO.qJiNv6eo_j.
 vKUuZb4o6kDAPIQhHpYxu.xEt_yGSA7AoEhugtbyBIZg7s6JhVGpsKfwREUPaEBPRwDRVPbXlw.g
 BgITsZr4OxZfD2QBU5ncmGMIhResjrBGd0j7PgTPhB8t47TQI9brUSG9In0HYHVns26qi.J9z3xE
 MJIXqUq9uY0B3jORdCVY0MgIQWEGTfGiPCGEVINxJLEcg9IbFV2x_pTKJjWHJoj0FNK4Bpv3Otja
 tbux0AjbTr62cqE_1z_hMprYSQ6IJOZfd8.DOwTXbzzN3WO1Ej1Q7UxC9h6FWQKxTuzcVDCwLvrf
 9rWd35QI3nYbJnZZ0YxtWLrHp0DIdgDQNl67dcMHf0HVUW1tmr_oUrEOWpo6DH4AVUbcFL__CEEB
 v.21rbNcl8lVrnCAlL7SwyGCzyQupsMEC22AZSagqy77Lz1Dt50KkDZV_UOySb3fn_BdkLTgndfd
 Mkm6mT4HUZCrAYDwa1aJgfzKwtVeqXvCGi3lxc25Y25nHhzZan.gWwO3Jj8raRDw5XecEAHuRGwW
 9Jq6B_oM7QDSAJWn6X4u9lnP0QQPVulSoze_X2k5v.HoWiqrmBkcQSwhrIFoDHsoAq1Bc4XXRcdo
 3Y5rqVsLhNfpU6FRER2i74kzqI0DRIXyp8x1itZ0i6Wy4UnbLUS4WWgN2Dwq08eQLWwGn0DZWlNz
 Opa.lpurC50osWgceejFlWhsJstFW5p_MesADnHErrCpU9ogVPg.4TgUwKu94LXKDHq3Y.bZZMMb
 u4Lv2memOx.uuVXYqXi14jR8L_tp2lrGR9DgYuV93U_HWF2bly3kyQaaAjtF_7TXs_6LfCcL5I3N
 HKqHpwaZ7prk0JTPMjUSt4dEd5hOJKfkY_11WedOvEpW36w8bXm6.mVsLI0kyqNzvM_Ai5N3BRA8
 qHEPbPIvZEx9ttYnMa_Tm9zD4TQRSxVi8HdqHmI0YboEcY9WD4TPOdn7geJvRwpwHCyjNOHU0RIN
 Ha_DJmab_g9KDvudU5XULBEIKllmhdu5t_1ulNTbFweRIV4.1ruirC9KIFOH7wIvWdPy0jqw_6qL
 9_RKCDOhTpDPs0rC2CDisYvvgT.aKYa2cH6IDIwFuCjDb8YNqgGdxsvZZtHK1u8kuYGxnCqZaLbG
 I_jMFqZTGD1HSzFPDy4S4fB5AZK7E5uVnKIRJS8_xGnw4gXrj4KQ9nESgASAgmfBtKWjxTJPM2DA
 qC_N2Zgy5WUEe4K.6kkzlp5sURP3YkBIzvTKxmrLKOD3kszdJav520HcKG.co77DWVcfbnCOEs9L
 9_y8sSzR82ALMVOLo6r.lzItrbjrcC0Rz6UojhmyNlf.amypZI_kgrh3sRSOUnYNNUubjhaO2yDY
 3zzijB3VV13sdtAVSG3SXD.69EIAt0Tg1cK8mcFIkNuRxZeKJMA07HsIyQjyivQPZvpjll6w_q2D
 goq8kFHG0jS_XGymYtVhORtWkix9BIUDy1vW.pcfsXLNPgp9NWSq270ip6fGyBcsj1SFRA6jPNn8
 Zpkb9mEfGRbbnZtTcgIkzpTd_C3F2W9leUEWbOkxS0k.qCzjdyRMOfZ_psXNjwifh6zvoOIj4C3G
 t2u6VmQFtvWJo..ylN3enX8dRWBax9P6tpPh3UQHQqbBGzcqOpGyU5mmjYyFMXgvDSAQjrz8DC8j
 A6Y.5hbqts_SPnw0UJtLuVygVx3doYbmsYlzz.APazcn2HvdImyw7HorboZnFOt4eKk.sdLzRGBk
 HUqmDPxYaIsl5l0ZV3yD0D9owVb83eWhfbUbuGaSLl6H7xpfrhztyHVOdLd0ysHj7FKAwda5nGB7
 ZfVGpaSzMlOZe1az4LLOyAeFlzcArKi2SBqILVDFPEyjokZ7QPq_vAvxAd6YkNaWKVMcH2_5E_Qo
 Crsu.kMBZtOstiWqfqwhg7XQUzKFm7L3loccdNLqn.xgJcJZNkdnUhEtPSQJMfMpV9DvfbSGlWbV
 InnJDf9H7Uw_ZgbyJOP_11caFW1JTHB9Tdjml1ZgVVbpdz6Cefdoqb1Q_swByWh9lar7VRSwVxj.
 w89eQzqQbfaee.Msf9G_iVY18rSUTSHzz5nHpnxl6Jf7w9IDtw7Xzh_2fj1bUi64j.kTB3ROaFEC
 mG1pIICgeGnz1xcYmSlX47WcS6jGSa02HRByFIgISJxBhBU3wOzU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:05:21 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cfd0a79a651ddfd5d30c37da48c43da1;
          Thu, 03 Feb 2022 00:05:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v32 10/28] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed,  2 Feb 2022 15:53:05 -0800
Message-Id: <20220202235323.23929-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 44843d665f35..62178dd4ec08 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -519,7 +519,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1276,9 +1276,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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

