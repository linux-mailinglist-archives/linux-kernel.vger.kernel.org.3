Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CE545846
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345785AbiFIXPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346004AbiFIXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:13:38 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360662209
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816399; bh=+w8d8SSgp3WoriyVLe5ON4bNhwG+o5YI9UfN3UFFwsw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mOjvYSFcKlrNx5G3Um3IWhgEPOoJLgtqoDh7qMoGFnoVyMrnspagl6SmXBPGvZjmG573bpixbc26MaQrsT6umllLm+r0ztHL2GqIg4xMdQAqar9cHW37vaNr2d3oVbnUMa0jnwgZFzAdxdrOgcbcJEVEWZjMETs7zVxzQlO5jf9N/I1VjW+K3uSaZE9xBDmQOWaEo/EocymW5f2KSsv5VfycyUpLGrzawtVn7uZ7/taQ469eIesdX/N0jJ5WWuol8hcEB9i+/YGYq335knrXeHiG7erXrskCib13A16osHTJr1WsPxlArCRYgjZvXoQ3zUQJzfhfYi+A16e9liF2Sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816399; bh=nbUs1gVVWIe6zaC8K7TjMVhSJ3F7IeBCtgr5DKUnAoL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ucSZlJA4muy2L9ThA68S52mmrR8wb5+bmsehV9SfFM+SItYUj1wH2p2+UAs+3i/OfJXCunf+yYz7Sff/BnhPCN4A6TDdrzh/qoZzchjk/zPpvzdrd07A3FuSi7HVQVzoPz7JnidrOYk2Mt82UtKRMZsZibM3ZM5f0eLEPHzwTBxUPoq5D/qMVMLQNEYWz8E4H5XZlpvIuiDnLJIIHpnESGPrRBh0jM2MZTOM5RfQdHDUZ88F2uz9Gj1PFSE0nM09Q8I/qvfEvOgrf/UZiQYapXrXnLxdVJEOZwnlNeuR3cyE5dzz7ItyqOW4yZnlt2FvHnq/R1JN1jK7bvnwfg9jCQ==
X-YMail-OSG: I0dxNS4VM1nVJx8kximkNoq8rdeNcUEhiFej1MpnmWPgY.RnnSXnH6lxbASv3To
 uOEU9mGl51tZgawdNkMiKxnpJoRno1uAsPf3selZUxgcoSPAGx6yXjHrTQe.UQZl0_hP8f_DV4Wl
 NNgBO_GMer1AUlfQxHubZKijMn6vm9uXOLOcDcnxpxZhWIqosHYh51WWHTx748Yz3lUOtLz6h_aJ
 Pxxn3VbKWj8PBmrLisctJhWLXn5pjkEppwxhWgohk0YKzMdioLKUL_JgN8yZqev0_AZ4HEf_gSJ5
 xTOSOnO6dSJRFunYDawFwQhQzS.zc6ZyrehwnAHZeubNraUOUFhTnEeP7Upvqv_rm4J98n4MoDCj
 OpNZW0IOFMsLqKzMlfrA7qn4Og5ASa0WeHLoKkurkCnp.dN1rTY3jJEGuxcBp43c9f0EORjdxuqU
 PIZ7r0Qx3ah9P01NF0ai2cW2HiSykCaI1HjUB.mUTGmy0QA3Y_f6by8_fPBwlvP20c6K4C.7i0DT
 7Lt0WUhA9widWrweiTrmhSyzjZyA_JnnVrISYJLg9uZT4VTGHRs2wzdsQeMJq2haZfSfP.hF5Y3t
 HnRoHCymXpOSIqzr2F0YUAIVlDN59JjkFNo_TWThmJHUnaSroD7q340f4djB8ifXF8NvtKCdPt4o
 f20itIY6_h9KD9j_MOsDxagQYMKrka18jQJJUh463FuhUlVFLfrrnzWnD78fEwYAkMJ2X9oKT2IQ
 G9blzVak6QaWcWIZqlb3lmJeVckyGdmeyAeL2eOsLnm0mHg_T.y7I8smdbVEzX3xuqeOrgKltrF2
 B16PHvXjHkgJX3eBI0374eeUZaG1wlKq8oewTBY1kpWmrxvgGGp36c6ysaIEmH3pqokZoLEOVe0H
 bTtXeY1CDYuyHcTw_.8F9eh3.46c62a4JE_Cup1nFsGWstGuKZyXHka4E_Ant0dj2M.4JQFVRRnO
 ZMRktwzy.ZH8k5YYlSrQ_G2YRMfqdwp.Jeu_KFmco7FI7fOUCvhEOtDJhUwRpWPd8xHO1vFaV2jm
 m8.yqi2R2y1qwAl8uFUCv2K8.108D6A4leyTb9HWrgz09h9OQX9_O25FPyrj6vR7h8mHk.4Qtyss
 dZNdid_7ikSYADJ2xGvIfpDhbMBzrEMTrnep..NxHaeOVrosOoQd5CwMxEodztmLnbib7YFqhYbW
 YSTGd.71A__Mejk7GaSV3wF5aRSjnqOpJJgVRfakBCN9zeJglI1JZ04tRr7FfR2BjsFPqMmEsjBR
 dsfbXS9FcNqWZSbd8pO1OZYRjGNs4NA6tERNrUkNDL4HfVBj8pNlDKCRaFaMIiQBelda1uSqKS1H
 pZJ4CGNCuAJ1i9A4Sg9UuYQbHlnC9BJ7FOEnLD.wDex7.dZKKNjEouYBkE5kYJgPwTrOrrWbtesW
 nynhLurs7.xLNUpv2di8LUFWw57YxTdCYCdZo7Gf4Bu1Upw32YB0dopUHKAhk_aSrplJdMsD3MUC
 sWRIDsuz2kGy8HvjK34NclgJLC8RJ2ZhT7P.YLtTqYPRz3UJHLL3HJFDmZXbxUFghb0edpyVdg3c
 eSf4dlbxnh.tSAkO80ZS9HrPLeN0l2UFtznkxsG37Qr1yAu0RL74clVzRI7avtLo4uuHYWIkg1pJ
 Vouw0cCpZbjq3NaaXWncHc8TZvuT5dZ5zr9XuVwzW4h8U87okUbsQlApl3mALktmVJlMAdKuykTn
 BoAQEEypH7Yp.fl_KvdjJ_1tE6TQYXxpFo1SW0vllv.fifX7BOjnMOW3oTSa.y8w_mUSH0B13GKh
 0ZVIGCHjQsgREDEzU1dk_X5mipwpO0Xg6XrKYSu3KAjfAZJQCG48pN3UOD0Pmx6jcao.18e6YgdU
 3H3fxfgHwYYcGBUIachyF743bnUJr_To0f.hhIaIE14v3qDzV5mQ5MLwTT1a4YlVNIj.Mlf9h4bb
 VQ6GOhO34kiud2GTHCBwxEpgzT_lIJ1gm4d3AUjAr52mNAlJMf9l7ha92J6CLhBoa4xVsxq6uZI8
 of3zIlarSZ0p0sV9GFm5_PAyaRZK0kwVKkn6YG0YEIemxWVvzCC6zY8v0IpPKGQFQqV2zTT8Mc1g
 VHhhRPQrR3YtMNDPyn6Alo8PZ_CopzU423lCB75IALdw2IuKjGUcMUgXsETT4T2unkOwEtuVzIRK
 tDkUUez8PsAb784JHS3Z3CEUqQWQHz30E6NJPD8jEmcR3uBYCe7QYBmPFqe3nTD5R7FXaS5Q.CKz
 F6PCplJht_7Np.xQsXYKMYelkwwMe8NufQDmz8TFjJH1sZ8X81rCRYhkaIn9MfMMyDsl9DGVnNqV
 _D6VKdMe1mOSXxAO9NWT_5ElSaioAm9fIFjDNHdMSM.meOg4QnMaLJTDbX3o-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:13:19 +0000
Received: by hermes--canary-production-gq1-54945cc758-szwwf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f409ca26a6c68d04d9ee89cddfc02e1;
          Thu, 09 Jun 2022 23:13:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v36 22/33] LSM: Extend security_secid_to_secctx to include module selection
Date:   Thu,  9 Jun 2022 16:01:35 -0700
Message-Id: <20220609230146.319210-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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

The integrity IMA subsystem has chosen to always use the
LSMBLOB_FIRST behavior, regardless of the lsm_display values.

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
index f2a0faf6d9c6..06c9263108a8 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3057,7 +3057,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &blob);
-		ret = security_secid_to_secctx(&blob, &lsmctx);
+		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
 		if (ret) {
 			binder_txn_error("%d:%d failed to get security context\n",
 				thread->pid, proc->pid);
diff --git a/include/linux/security.h b/include/linux/security.h
index 1884c45f3d84..1efd34a8f75f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -186,6 +186,8 @@ struct lsmblob {
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+#define LSMBLOB_DISPLAY		-4	/* Use the "interface_lsm" slot */
+#define LSMBLOB_FIRST		-5	/* Use the first slot */
 
 /**
  * lsmblob_init - initialize a lsmblob structure
@@ -617,7 +619,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1471,7 +1474,7 @@ static inline int security_ismaclabel(const char *name)
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
index 8551ce71e6c9..200406c33617 100644
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
index 8bd6ce5f9e93..14d0d4f705eb 100644
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
index 5003acf79794..8921e269c381 100644
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
index a01967c66078..579feb93af49 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2345,20 +2345,36 @@ EXPORT_SYMBOL(security_ismaclabel);
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

