Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434E04A7CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348162AbiBCARg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:17:36 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:40383
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233081AbiBCARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847454; bh=J2ETGMG8Q3KLYZLvPCboWzQEzt0aSOzPc/R4UsPJsXY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=rR+a4LkLTr6KmIiE+Z6ebXGouo2hy8IjEIWz5CvYJw3aEokLDlJJskYIpZdakie/IxplYra46ANq0M2mRuw+pXArjLbfAgvQO3AbbCDXpsIJJ1Fo+DeSdk2xto9pLIsOKs/rv/b2si4J1QLSZRK1B+4OMPS706ArpVBefNSEJaNQoezr0ndFJ9Z8y6DqD3zkF4aA+nDFpakYLJPYp61cBzIt3i1dSmIs6iqESxxT/Vxb9KBNEWrDgo3iyzMnf3pdg3RDjyH++JBZdfNreabO4GRB/10EllHmkzuyZLV5ERkv+C1A7vzXR4t10PXfjbGKAG7Z8C+Snfuz7Ey/zFMZZA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847454; bh=flGtNyhd0aSA9os0RiIdNjyfm8H95n9IttpvsON2lat=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oMAirc/Mzn2oIHmdGEKxyz6IRsQsuXoq6LSO08a7gNwSpDnX1w7JGSfLVejvNk+DE2uXmOO1n1pDx7gGj052IqXPiinHKqltoe9+rTFqdo++kiC6zVn6STx25YycC82H/VxhsMM0xPNx8+Qmc1Sz8Klcw0V1UyE0MJ65jaXvhlETn99q3GbuKkk71KY7fSe3Y5bjxX4zURSrHTS6h1BaWcIC2uY0wyLOiLCHz/lRtrfNZd+sfXmFGjB85vSzvhvavzfvxSa4vEGjlHQXMYNLohLFW7k5Bmerm0RLn1Hogpe6pIl+4I7f06lrJ7AYlA2OoYrW/PxfFnV8ke3kDdssVg==
X-YMail-OSG: 7yHTR1kVM1mR0MeUnbb.mwmmSyOEsWNvmcMtzlIM5VPbalZ6pg7tfO.AVbBudXK
 e5aHzFN3vPn63PTK5fj66lYNMNo5TWdmd4Gpsm2jQXxsZzQYzFJYsqdxdCR6LwyeMFII2qcwMFvm
 Vi3zNq0SFWstqSxVmnNVAnzQiB48ToskXKb_KghkIDyyQX8pXXPlpIOug31WBeBdli7MhWqIB..d
 sOpXIH1y2YqTEXg911_.heL6_VdddiFbNw2pCzSiyDfI.TwJfTPO7JXC6xEyfxPbNzZ5avU9PqIY
 EpskouSvrgGcuK5RFZot8qnM_f1maYejmFxEYzoF59cxHg4QcWMIocxNxU3GAE2i6iRSReV7lJu3
 CDUtfsAysSJEABEeMI59lXcfnZ5x4mZmkUW3RSpYzwhjFwbhLg_BvvDudpGX0WMTxvmF8vh9pjI4
 T.Ni9RtdUr_dwoawnmw6jsn.pJbZ0pIEpRuVct7RG9cQf5tteOGibso6EsqlHXZxjm1syc662yA_
 8mi73II8GiovPNcRQXsparoRHTOsRQaJxLQRP6GK1ltlqsCuS6_O2wjeJhMX1EnrY2l4FT5b4Hmg
 ongNNDgIR4gyjuTVyBHeqfu4NqxDMT_ERYIn5vN2GHu3qSoYo0CQWCoTDeOC91v077UXnc9S37Zm
 B.wL86FN0amKN335wmtdTvzyvaHmbBHY.z2nqrnig6OhnG1BNtKIMR9cgi8bkdnCYEGJpiZw3fKf
 wKE7o0cjl2qeJIEnH70f_g1pPpIhKn0LqhYABHF9_28SD1CivPgFfaqb_jIJFR8hwo5AtowtcGy3
 bBgj57AgAIBLG_0dMuJ.PEiBwaGmsBOx9CdZFFPupsZPC_UD8AmuNdqsemjkg2vKtiVlM1QdeHkL
 ZkvkFPAxfzxoy3f3k06Lu6.FBWByFkwYdbApCka39a4VnbcM2TaKWDdPNRfnJJdwXx.9o1kLRYDD
 suo8uJ6ya.vAeTxCfDt_hPi3CSe.m4dY.vdCXkqbF5ubtFDmyXTtkWX0b3nBldRL__kRYSpBewD7
 dpuJ1cwoFRNeBo2S2tBYxc8EZ2LnBwaVTIOcATpGO7Rv1DNEVpxbZ2.totxwYZcn2ODbQxOPstBg
 ZHMziUNCI6ZPmIppUkpL18NboRve1Zq.IdlFq3YlbobAlDAa.hU6Rl497ac1wTWAgkmbitIxEWXS
 Wj6yVgEPRV99G8m0DGdzVuJ.f_i4PiTU4yC6LjwVgHQtWB4uYG4hkBpFEWdr16YMx2biyvxGnq1d
 0HHwe71mA.nr5.AwzV_280BpRDWTnoNdQ7lB3.ucCOXPpD1DVbiBC_B_2WHwW_6kjcYwVehhc854
 fqqv8UPa59jrUKqJ8hPeqNdibi1HlQk2IK6tLClu_tvhFnnJhWjUKVeVUPiyoBaoeL_2okedwgKS
 ABRHFO9lKM3Wab_cbgHiSYR_5TvvhWILymQjh1CFVTTRXuVc9rS0jYIGCxm0Kr1uBaQIlPP_MHss
 p9NNjoc9sXxjK2RDxiSiEWSKF.velbZGkaLkIl_cJoBmdSGXnhAWFuXJapyoKGjznNhZ0p3bfeZI
 yMYX_gxxg3KJ823AQVLUzA4q8Q.4oJcJCJstCkyC_5IqbaLuzG.lm7xYELPQf0PCBTayspfGosi3
 IYdQTNvOBCTAgd40UKOtDy4u08hTjXAZCvuDtMAh5qypjE3PZTXMl0M_l7YssG9IVxDIGS0Oti45
 CVi060JtiTDkH20zRNQHZ.5LMnC8ohhYPXCAnJRzN_qte9Zud3DtNMaFY0.93vov2KJpwWAbnop4
 QFoYhv0uJX2FuQEvlBhCOVE7NEW0ZlAVrXnAMuShr8JnKoATjmVKD8Hx9sSPs5uIH6Upq9gViZ74
 3Qk8dJM2r0xZv91J._kHXrIDpJ5AqQSauQ_pbrCTPoBdkNfHAQvYU5wG0TSNolmoI7buPW.QO.B1
 PGWriyS395y_8yuXhlFBNmD.zuZsZ4fXsF7Rv1uVcbRGRrK3CcH2bSoRuGRamWxtURNyVuLRpunQ
 VAK5srXgGA3Mo17jKyusOQ0xrMvFJ9159XfNYvFpIjxMnXMG0DzjIXpF_Ue9RJa9ZiyDsB3lEv.s
 21Sk57WDUTBb0QEbT.xF.Gf4OOxaTCcp0TX2l7XMCIxTWaN4qtJhRDUGwnf5qIuENYMldZfS4kV2
 3CGTQlSBkRNOGurvN3H4VBiRexHWZinFnV2IlKiKxTACCG5eYYP4gpJXXh7tqIEzpXkit2V6PKc7
 GVYz8XMXXUSjsUX_WNU_qAUVm0RdOqTI6yh58XAbb2y7eN4BSXPicBGCr6onAu_ytcjcmgsYrZm8
 NfWj7cKpNt0lykwbmY7d6Qlz5Z6r1zLE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:17:34 +0000
Received: by kubenode507.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7850c669e06bf97c405e8be9f36de1d9;
          Thu, 03 Feb 2022 00:17:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v32 21/28] LSM: Extend security_secid_to_secctx to include module selection
Date:   Wed,  2 Feb 2022 15:53:16 -0800
Message-Id: <20220202235323.23929-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a parameter to security_secid_to_secctx() to identify
which of the security modules that may be active should
provide the security context. If the parameter is greater
than or equal to zero, the security module associated with
that LSM "slot" is used. If the value is LSMBLOB_DISPLAY
the "interface lsm" is used. If the value is LSMBLOB_FIRST
the first security module providing a hook is used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c                |  2 +-
 include/linux/security.h                |  7 +++++--
 include/net/scm.h                       |  2 +-
 kernel/audit.c                          |  4 ++--
 kernel/auditsc.c                        |  7 ++++---
 net/ipv4/ip_sockglue.c                  |  2 +-
 net/netfilter/nf_conntrack_netlink.c    |  4 ++--
 net/netfilter/nf_conntrack_standalone.c |  2 +-
 net/netfilter/nfnetlink_queue.c         |  2 +-
 net/netlabel/netlabel_unlabeled.c       | 11 +++++++----
 net/netlabel/netlabel_user.c            |  2 +-
 security/security.c                     | 20 ++++++++++++++++++--
 12 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 259f5e38e6ba..d59c4ebf7e22 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2983,7 +2983,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &blob);
-		ret = security_secid_to_secctx(&blob, &lsmctx);
+		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index e2939418789f..39e113574ba7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -184,6 +184,8 @@ struct lsmblob {
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+#define LSMBLOB_DISPLAY		-4	/* Use the "interface_lsm" slot */
+#define LSMBLOB_FIRST		-5	/* Use the first slot */
 
 /**
  * lsmblob_init - initialize an lsmblob structure
@@ -596,7 +598,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1450,7 +1453,7 @@ static inline int security_ismaclabel(const char *name)
 }
 
 static inline int security_secid_to_secctx(struct lsmblob *blob,
-					   struct lsmcontext *cp)
+					   struct lsmcontext *cp, int ilsm)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index b77a52f93389..f4d567d4885e 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -101,7 +101,7 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 		 * and the infrastructure will know which it is.
 		 */
 		lsmblob_init(&lb, scm->secid);
-		err = security_secid_to_secctx(&lb, &context);
+		err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, context.len,
diff --git a/kernel/audit.c b/kernel/audit.c
index 03824cca058c..0fad7317cb09 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1440,7 +1440,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context);
+						       &context, LSMBLOB_FIRST);
 			if (err)
 				return err;
 		}
@@ -2152,7 +2152,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context);
+	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
 
 	if (error) {
 		if (error != -EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7858da40a767..e091d03f9184 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1132,7 +1132,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx)) {
+		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1378,7 +1378,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt,
+						     LSMBLOB_FIRST)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1541,7 +1542,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		struct lsmcontext lsmctx;
 
 		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx)) {
+		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index ad5be7707bca..9b5c44dec1e9 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -140,7 +140,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 		return;
 
 	lsmblob_init(&lb, secid);
-	err = security_secid_to_secctx(&lb, &context);
+	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
 	if (err)
 		return;
 
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 9626e2b0ef12..e919c35f85fd 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -347,7 +347,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	 * security_secid_to_secctx() will know which security module
 	 * to use to create the secctx.  */
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return 0;
 
@@ -657,7 +657,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
 	int len;
 	struct lsmblob blob;
 
-	len = security_secid_to_secctx(&blob, NULL);
+	len = security_secid_to_secctx(&blob, NULL, LSMBLOB_DISPLAY);
 	if (len <= 0)
 		return 0;
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 36338660df3c..cb4b8b636f6a 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -180,7 +180,7 @@ static void ct_show_secctx(struct seq_file *s, const struct nf_conn *ct)
 	struct lsmcontext context;
 
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 2aff40578045..6babdf5fce18 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -316,7 +316,7 @@ static void nfqnl_get_sk_secctx(struct sk_buff *skb, struct lsmcontext *context)
 		 * blob. security_secid_to_secctx() will know which security
 		 * module to use to create the secctx.  */
 		lsmblob_init(&blob, skb->secmark);
-		security_secid_to_secctx(&blob, context);
+		security_secid_to_secctx(&blob, context, LSMBLOB_DISPLAY);
 	}
 
 	read_unlock_bh(&skb->sk->sk_callback_lock);
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 3aab71ba3841..b53cf90bb6f4 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -437,7 +437,8 @@ int netlbl_unlhsh_add(struct net *net,
 unlhsh_add_return:
 	rcu_read_unlock();
 	if (audit_buf != NULL) {
-		if (security_secid_to_secctx(lsmblob, &context) == 0) {
+		if (security_secid_to_secctx(lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -491,7 +492,8 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 					  addr->s_addr, mask->s_addr);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -550,7 +552,8 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 					  addr, mask);
 		dev_put(dev);
 		if (entry != NULL &&
-		    security_secid_to_secctx(&entry->lsmblob, &context) == 0) {
+		    security_secid_to_secctx(&entry->lsmblob, &context,
+					     LSMBLOB_FIRST) == 0) {
 			audit_log_format(audit_buf, " sec_obj=%s",
 					 context.context);
 			security_release_secctx(&context);
@@ -1120,7 +1123,7 @@ static int netlbl_unlabel_staticlist_gen(u32 cmd,
 		lsmb = (struct lsmblob *)&addr6->lsmblob;
 	}
 
-	ret_val = security_secid_to_secctx(lsmb, &context);
+	ret_val = security_secid_to_secctx(lsmb, &context, LSMBLOB_FIRST);
 	if (ret_val != 0)
 		goto list_cb_failure;
 	ret_val = nla_put(cb_arg->skb,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 951ba0639d20..1941877fd16f 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -100,7 +100,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 
 	lsmblob_init(&blob, audit_info->secid);
 	if (audit_info->secid != 0 &&
-	    security_secid_to_secctx(&blob, &context) == 0) {
+	    security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST) == 0) {
 		audit_log_format(audit_buf, " subj=%s", context.context);
 		security_release_secctx(&context);
 	}
diff --git a/security/security.c b/security/security.c
index c9459c4754f3..b694eca9d4f1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2334,20 +2334,36 @@ EXPORT_SYMBOL(security_ismaclabel);
  * security_secid_to_secctx - convert secid to secctx
  * @blob: set of secids
  * @cp: lsm context into which result is put
+ * @ilsm: which security module to report
  *
  * Translate secid information into a secctx string.
  * Return a negative value on error.
  * If cp is NULL return the length of the string.
  * Otherwise, return 0.
  */
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp)
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm)
 {
 	struct security_hook_list *hp;
-	int ilsm = lsm_task_ilsm(current);
 
 	if (cp)
 		memset(cp, 0, sizeof(*cp));
 
+	/*
+	 * ilsm either is the slot number use for formatting
+	 * or an instruction on which relative slot to use.
+	 */
+	if (ilsm == LSMBLOB_DISPLAY)
+		ilsm = lsm_task_ilsm(current);
+	else if (ilsm == LSMBLOB_FIRST)
+		ilsm = LSMBLOB_INVALID;
+	else if (ilsm < 0) {
+		WARN_ONCE(true, "LSM: %s unknown interface LSM\n", __func__);
+		ilsm = LSMBLOB_INVALID;
+	} else if (ilsm >= lsm_slot) {
+		WARN_ONCE(true, "LSM: %s invalid interface LSM\n", __func__);
+		ilsm = LSMBLOB_INVALID;
+	}
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-- 
2.31.1

