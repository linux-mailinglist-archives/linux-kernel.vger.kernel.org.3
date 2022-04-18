Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7693B505B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbiDRPpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbiDRPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:45:16 -0400
Received: from sonic313-14.consmr.mail.ne1.yahoo.com (sonic313-14.consmr.mail.ne1.yahoo.com [66.163.185.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D05A09A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294675; bh=WA7cBcTlw5+Fmu57VfsVv1NsvknaIqAVso2hQjxqg1Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JrczAAylXf8kfZF0Zy97cJHPo0ZSBpex3k9Ny0gzZ0SjMYrwEZFBAK2SIhFoQ0i8pokA0M8Uhp/1ZQXXsXKaZgnWTEMeh0Kx0p2XQzP3CfbtH6TUhYBYot5ThS7lRSzD229UObGtHPUqHhCziBQJhQVHSKGezexWx6hIhRFBIkZnQ7lKkr/sUSCyLU2zo3Ry4xipiiwacx94P7WiZKPwaWFixKAPvcUsh33xqqZQ2XCTtkVeBO3RhICTiSdVTE+HyRslsn3gQiahh/rdjAh2qmQ9OFChSSeJtDxY8HguYeIsI27VLj+wJGRwPVW0ChVp50wihZ2sXs0k2BQgmPz82g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294675; bh=E6+07JP7tOPkhBl+mPulPDhVT4tgC1jPbQbZy00eMY9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ioD7t2+mcrptncvhp9L6d/JEgtkejvNT/5upJCyL985Nvc/9LybyX7Zzp6CWbeE6xCKPADlgMGevJhCtkcSz/kOUohvVf+Wm8IWIWYXqZVXY4bN63BdE3S9hc0gycxwPisIPsJmzi9JYmj4wZ2dvdAfELewpsb2K+SbWa0ZhIkC4PrfLMTqw4ELSyCTGg7zmovTk7L5kKSLbjalzO1VG+fCZRyqk6b5ICyA0LcbdvYub2//mLCe+DMhYYqUNbJXcl1M6FzE1v5j7UiGY2uY0SjjyklWgLzAR78HEiOMECp+CdfycvbMEazj9EG++JHtgF+vgbXzjWozAB00TKcGGtQ==
X-YMail-OSG: QC_ZqB0VM1nhWxY_nQxqpOLVW6dkL6ydzrtdgq6bsYN3Q023c.EgVvtsjZ079dC
 Ek9sx58fXYWKtX5UL2IxNUK_BYXccZMwdh50WrCHDs01b6GeBhIju7HW8jWIE54VWNaPjnL1Yg0j
 kIlbBZ4gEStwJtUC_H4.NIfFQkbhykHjjICe0m0cGMvJJZ04GdnHVuKI5DYL0Fpysj4qIwodUbWx
 rFKA2UJgdonoFCxfa1Fxm1fBMUXHqBLtVMK1wYAAhk.3rNyYfHdGbbR6qXYMREisug5MRasf3xxW
 Alx_LVzDjXiNRmbAIhsPoirBQJ3hRo02PKpTU4gXZadLDng55H2907SELQ5Ff7gYLmsd8.jYsStW
 i5k2n049yP2ah4Aq9dRW.ya0J5msmeMuQO5NKSXYxwfFc8ztE4bkJBCnCCAHKI58.b65eu4mHO0I
 uS00TP9pliWqTC_aBxA0gVax2r.5fjtpkiD8qr.APcwVZu8jaf2eKsuFTJ448P2j9_vOR7ZKbwDl
 cfTdyHMScmTFvQWb21KwDNE4U23iyoU7i0FPNZqRsnJ6olc9zs2mYzgZfhjXEaWVafmkCzhwkgO_
 VN9gyZ9g43UUH1Z2EG966gzFAjBG682IfgXKkZ3wjSb9iQCLGXv1jW1Q4kU2INRGjkKIF9wFM2Fy
 JhyPSygio9N6zqdrvgCN3bmPxJQ2vKaigNYeb.VNnimsiszaZWY15R3w7DtR0yPn3.X_QMfY2JM6
 DxTYGNUyNjvkxobP2yKr4r7AIXZ8Q9ROnIutzST0YKVKEcfmER5I8.HUUWiK9yQnl1VhuwEWyq86
 AsTWotB7h_t0RmM_cFx5K70.qd0euRQjYgTcmEvFyCBa5sKeTU3hJ8Yui7BbdjqVDhqkmOJdy5Fe
 eDZeeusrZXKY57Vfocr8SZZq44NEtNKYd.F8DWhnVboHAWmu.gDG0GuOsk4kr4i81FnyjRRPhq02
 ujHOySlGOGdfKeuYId9Lb5loJVQUc1.UQOYijOYG5nlj6WzIbJxzQpJjuO8ot212BYYEnJ9wbhY6
 e1KBMsmVNtI3pdGUWvSEI5ZnKWIx3dXOY.Mz_g9m30TpMTqZ0WnCKObZ9QAQP2KKWAVjPQOOK5LG
 0gnCmHH1AmQE6IPe6KPFl6srjFCfnxE_EVII_tIG5bk2wjXDg.bSgY.p4brGFQyf0z9RZdwzvisq
 ZuC_g7iYaTqerU4ODqXTLQnOWPl5.Z5SJszCQi_FQAUOOmmk_7ygiwMiTk.MyUAIS5tgiZS3KsV_
 npu0RgQlPRXHWORwZUo4MJ9x0gwfP4AsxZ4q0Eqg.obInmZsacLE6OZ9xpBgGFyUDWrXYo0nz7Te
 QsqDdgU0PlGYg.SkjA3ojcRsGQjU4w5wn1c6_PtC5NXJ82XgdlgzRS5JZDSdF2w28yOuUaojFGxQ
 UGL4W3KRqd6Ln0Lya1g3oDkMsrFv43vu4KHXdkqzZy5rurZZ3A.jMKlp7WPf6QkZHyqzKiThun8u
 vMrSNvVksuad0VjhQJzFU_41nMWyxsxoKqM2gGd0F6D6XgSFSuVHBmcm679VBYgd61YxdmP9VvUz
 DsFlWYb9AfUBB73_sIWFT6R1DNO3VYVS.ZIoCrY1A0G1qFFntjhZnGV1hUXbQjC4dCXYrirorK5h
 NvP5qKsCfmsG25c0RQ.m.q1kUC0M3tcxAdRrwZ1QK5Ucsjq5WvFHH8bESSzKv3YByUP_FfEUxbAd
 YAP6lMouJZB1W1H8HXhDSLO3Dz8rmS0KA75R2TzUsYP14mU4CE2wxAyTfNwqPyXSrcw.7f7uNDvG
 hB1n8JUuND4QRgwGH76B66I01zN6mF_OSLfG1HpTJo1xepTm0swgcxxTb8IcLouAx7HaMQJU5TGC
 CLFK.GJaHkIfq45kbPKdDP1HhUgiXXN3wNXPAUb_7UNkEdT7Z.wzr1HQ5ixGK_UNBrFYV8GqvSLn
 fdGP19WhWEa0.fuO0aUSg2xU.wyoPLSwii_fRqVuXM9mgNPMvf_coxqk3e8A6576SsJgNraf3WU2
 lyNUP8.NSy1TqcEGyRFpHi260LGnBwH_U.j.W5JBct1pMv_hVwo56z.n3GH_ojSmoB7vKJ9U_7uF
 rOkvXEsh7.VCi2YVlFZUJKi6COcKShx4JjZsFgr5UIbRvH6Egp2dFz7Yg1m7XiaR7CenuWhsR14l
 jRUlAe1qbi95xorjS.2Grp9YXQSnQDTrka1V38ZiuaWdSQtVC2o7My3mjnw5OCcMvN0z1xVwo0RI
 fJJ6BZiLvStbDqG16Ubr.KdPuzYah2hzBrR69yzcRLY4vhHZS.E7bqkIY.OynI191_.POVxIZEz0
 0IkPLlBn_d0CubMhC4EZagDUf4KfeL7IxdvYAaf_S6uu8lB2hJofNJM6fFcE-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:11:15 +0000
Received: by hermes--canary-production-gq1-665697845d-2b87j (VZM Hermes SMTP Server) with ESMTPA ID 325f6f931fdc97e0cc6b332f80cb9e73;
          Mon, 18 Apr 2022 15:11:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v35 21/29] LSM: Extend security_secid_to_secctx to include module selection
Date:   Mon, 18 Apr 2022 07:59:37 -0700
Message-Id: <20220418145945.38797-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
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
index dc66f3f48456..2150016492be 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -184,6 +184,8 @@ struct lsmblob {
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+#define LSMBLOB_DISPLAY		-4	/* Use the "interface_lsm" slot */
+#define LSMBLOB_FIRST		-5	/* Use the first slot */
 
 /**
  * lsmblob_init - initialize a lsmblob structure
@@ -615,7 +617,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1470,7 +1473,7 @@ static inline int security_ismaclabel(const char *name)
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
index a885ebdbb91e..28ff7a5f90bd 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1464,7 +1464,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context);
+						       &context, LSMBLOB_FIRST);
 			if (err)
 				return err;
 		}
@@ -2176,7 +2176,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context);
+	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
 
 	if (error) {
 		if (error != -EINVAL)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 802de65259d8..231631f61550 100644
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
@@ -1425,7 +1425,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt,
+						     LSMBLOB_FIRST)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1593,7 +1594,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
index 07660c7dd342..5d72d2f41562 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -353,7 +353,7 @@ static int ctnetlink_dump_secctx(struct sk_buff *skb, const struct nf_conn *ct)
 	 * security_secid_to_secctx() will know which security module
 	 * to use to create the secctx.  */
 	lsmblob_init(&blob, ct->secmark);
-	ret = security_secid_to_secctx(&blob, &context);
+	ret = security_secid_to_secctx(&blob, &context, LSMBLOB_DISPLAY);
 	if (ret)
 		return 0;
 
@@ -663,7 +663,7 @@ static inline int ctnetlink_secctx_size(const struct nf_conn *ct)
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
index f60a0b6240ff..844955b2e163 100644
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
index 910a03f15b0d..8deee7e176a9 100644
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
index 64073d807240..be6682768760 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2347,20 +2347,36 @@ EXPORT_SYMBOL(security_ismaclabel);
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
2.35.1

