Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F51D5030BE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354428AbiDOV1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353902AbiDOV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:27:06 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA68DFDDF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057794; bh=BtHo1QSoNl0+JSUijRm0h7RCZJK8XQ8GDtQ9CbzS1Bo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Sr+OvD4oxptIE5XVv2dS9J1hmkRl6mszXO4tHK5HsPLSNjVUN6SBc63Nx7CPL11eiaVKv1o3jwfd9iMCPVS6SqFCTVBdDop/PX3sm+r5HFCVkkwFpeIgTjJQerJ09i9b50zpLnwtfx1Nh0wKPBux+jL14q2MOkEtfQcbsN8XA7SI+4d+Q04pRb7Dbnk5FCxLxqrPSz6d7MnMzCYdP+U2L0CozAxffsf83Xm7KhHoXKsLu25MPJwf9Kc+pObS6FKzSfqKJE1Ojy1C0kBpsL0QTEmNUsJYCn6gbPeTljcbr8B9N+zUYMGpcyeoDbmaTRlPrg+suqGDzQey9Q5tL+KqhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057794; bh=zGUVlSW2BazDaoRCe5/ddaJe6wt10DJvcCkeAC8qviP=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=j579KO0H8ZJjh0gK3C9zEYlm/IRarOTjXvrddqz1Geq1h+QUcvAIxv9g9/Nm+PNqRTCUF+A7DMYcB6+pkL99ST9ab9WtcgFpWYAIG3xsBetw5IxpFSt/JXcOTIeTBcnPaIANEvZcNT/1x1PIDYkqHF8QT8/o0gzid7zOwHozJ88nUmbYsxODaAvOfPf2EqLJ2IOgSb5VK1u1pbKocWAAFmVS1/enVaeZ8WIywbsHzMVxDxGVLQKPImZWL1DjBuEypshfR/Ea4nddNmjx5b0iJ3NdYzMWRKDWWAntNmRfaJUXTLjTN063XZPZosFYHsqHGT6/stkczhTHogHUErqIoQ==
X-YMail-OSG: ES2H3FwVM1lXJlFIPi0CbYmfhop.PgzS6chq0X.osYo55WlKy8yj4nEKp28_RU9
 V9OB7FDnals2v8OXtbX8GKpIortwVdcpWYlKMcSOfv_y_Ly83cMQj9uU5RBt2RwN.YhptrxY2PQj
 FSMFfN2AoNwZuIpJfnVaHXpI4yuh0yug7Tbxn6.5r2eITJqCs_gc3BzchHf8a67BFx8U..FH.9of
 Wfk.spFIm75TFekMgvcU1PNuSyzETyHyOc89pYOpYCJEcTXR9rwiZ6fGG.TGoY7BvrTV1JEZercf
 LWNJUeeYe6a2eZWE7fz3U40nM.FtKfYJidxLeZw3y0Aw_L.OltUdkmFG80nBsb2fntZJcFeUqTEn
 UCL_z4stS1wXgM1RsJPx1MpAc.2r3ZBqHwfk7e7nHDzdkNILDGoST.0U.2xOpkbMtV9krUn8vuCY
 RGi4Vqb4VtrwaFrLlfq52INJ3Fb_L7BQAgGodmVvGzpDAw0NP_n14wwhiTwldwCLG9yC_zeH2c37
 uQPpf08Wu5ffmiV.RglAoZnCnrMGZb58KdmZW9LYR1cOod8wwRZkVwRvP5QjkbhKp3FazXHVNAna
 URjhGArzM5EuHLaTHs4Z_IgdV4pI3w8J98KhYaMYYRS3OnXXvju1JIuwEvxL3G1io9JAk3BdLeP2
 9117xoO1NBuAuxw2OS3dCwevtKAuKH4gkEluBRe8spTKff9LFiWHFkwOyqKakvqhIHdW0D.Y3LP8
 PTJYuhfEunAC7z3j.Zx9wSDFyfvDD3sEJRKzLA._cRJHni.z2dcs_BN4XSVqcDMPTztOMUtVOIVV
 Xo0vwSFaen4iqCGv88BogsjjIAX_503Uaq.QN93Ff7fetZD_zJknJP6TiIC7FO5XSt2o7pxUyBr2
 ESNEkCYsO.Ty8VHCI.S5gpyl9YkTWUOypZ.8wSPrY2HUIla5qZtA580fklih3Hz.EY1_asremE3o
 Fauj0ZL8lNOs92cP2hIHtekp9nfLaFyxWnsXkQM1o.YIej8t5M6TQqE6pQchNUVcwKz7LrZY3ex2
 AbxCApwT6MashujQssbl4dlxBfio_o9x4VTyTkTUTarOk_hSH29FPHVO1Zzd.3sqHMNboYA2AsrZ
 mG4o8nBIA90a7LflES2Pv7XOjt3c0Wy5QBgua6E4ieiSZZg8gqrZBYmuklFOoXBLq7wgHTVT2aF_
 j0uqPZ07DbwXBdi78K79v5zaVd6aIT9eaA_PAL_3wR1x0q2CoNc00POu9NjEY4Hg_Tl2AJWYtT5p
 jRN.P9O6rW9.cbp_drxaXIrOZP16vZ9MJgZCs0Wx4qPEq1rl04.LtHrM0QEXHW4WukFTq5uZ5gHw
 AKL.GFxgt0KjaIl3JQsAYoQ0e8DCnvN_Z9Mz6YS3BnLgCSq4znMpCqeLFmaNfNIHiWkyeioT8cwG
 dsoiF89Wj97i1k5CY.hsEHJT.Ar8cESa.Hv9NT2Su6x4axSN0p6MrirH4wZda6cdY89ApvfaH_xr
 X5V8aD68rI.VzqR7JDhjkBUPy4QR0UpFDAaY5W86uy73X7D.8sAH0aa10EgDeFbzm50FwHqv787M
 u7CGgbfNZzGuI23VEGCgwdHL1StXc3RyVdTXmyvE5r3ThYuhUtu4OluDV2I4KxRUmkIplZEz.g23
 aSKt0LIUwdEiy5vNrcdCPW1D.eMIhksGcuRDyEurrjtY5jZdS_JOsO3lm0hRiAmjz7vt1GaW5KQQ
 yzgEckawLaKWjuJ1ZOSpUujiixqzJxMQB0gJ4Ap5uSuNaqNXvRC3iN9KsdbAlaxd46Qz23voSf.h
 qpMC63xB_ULGawzZg_B_fO0nPA5k8E_H69kjeqsPFAYd71.lEthEP0tcwbMVqd6pr.3GLR263caj
 7lkEIaGbu55eycMzKlvktYrGrR8NnhyuZNlnKq41Xk1QHlGcluCP2n00b5Bm.S_kzzoDtpw3RT1j
 6RNGawzHVnrLUBDSPgwTIY08aCZc4y0HNm8UJEthno550P3CZuggTGuWw_LHLO.gVF.CL.MxeyOX
 Ia3wVMB7VFcxeTslHvbGeKm5XWuRe5DNA6G7.htkykCxR1KVSes5xcVUt8R4PbKB8sUD.01EGRC6
 js0_KRDFyZjFZ23UA.RuBLnYgMqh8VsAD4hud5Q4zoMLWx9TWU.ULOXBX32rBhNF_ydKnJERSbXC
 llvU4uKJPBWowl2_mkYRLJ66e6Mi1T48n8EPEmb7tJh4jyCILBWjekKq8n6Pcrdh7nGEO8pmtKBJ
 TmeBWeh0l5_wq2Fp8NIfUEQf9Uw7F52ZWyI9qroL.eyJFek9XLqZV_esZH4DE3ljZVLpmSK2PMz2
 3N94hAF5JksLUYfjtOB8u5kzvaCWi5bFTbsDnhzsO.OTnJHCxNRuu1FEa
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:23:14 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-9gvrn (VZM Hermes SMTP Server) with ESMTPA ID 0aa251bda2fc204a3bc01b852774ce09;
          Fri, 15 Apr 2022 21:23:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 10/29] LSM: Use lsmblob in security_ipc_getsecid
Date:   Fri, 15 Apr 2022 14:17:42 -0700
Message-Id: <20220415211801.12667-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
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
index 4f940ef06e51..4646ca90f457 100644
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
index 10b9dc253555..d125dba69a76 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2662,12 +2662,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index 6e6e44213d80..131c851dd681 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2012,10 +2012,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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

