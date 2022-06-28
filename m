Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC09A55CB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiF1BKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiF1BKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:10:37 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E923150
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378634; bh=cINYRIEm7On8a/CVsfa2sypfglBPAmRHsjL+mt7OzHw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QTYyxbOice5Q9QrLwoX//ofHsE9ql+8UyM40QV8eSJgCxn91TNzcL3fARgT24W+HEZHkTj0rVoDG/DgJcnhePhhZT8oh9ilw2MF1nKXfp4I/BRtPv8TRp7mijMJSj0mcKbcG+97HvLuBCGwvbIdtmrpPynjtXqiPM7F575o+wK1rB62teetYBtdZWF7+Jm38Dkk9OP2SCVJjHyWay7OWivxGNUwn8jWC0+ypju06k9QXSmPAM280jBMyLDaD3kjb67KzUM06qFMfWx/kogC6WctlGYKPhv0cXZw1+RhRICD5ZpHQTF9Q4jDjG+YwJzdWiJjdt8wV4g+J0IlJIx9zrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378634; bh=XW5arIOQpcEVsR6FPsPxLYNFd1bwug/EMIEBUP6CWDD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Bcs9rk9jwFpb8Nd7lmiugrX3cF6XbspH3oqfmC/z125bP3tQ67TMuWn+Btmv28HbH43I1gzWWupfQ1sUHaevUqw5RNNOtCvJ5slS+lNcndXFsgkTT+wK542h9Pa3l72apGPrAbdJyxmMCYqM6u6ZBT5mLvWSDGHoYM5cB7Oaz7QsID3whlbsTKmmQeb6a2HA3wq//fPWwIkSEkqdvW9IwAFF/JfcFo4YDCskW6RtkhjYT4QzPINLdeLTVcZllKh3Nq3Zc4RhI+ZprV6yTgR9y6teRC0H1vb66GXxAMCzPnz8A5W1j/YXuGw6fF/MlHQI5VnLGGKesqlei52UQc79WQ==
X-YMail-OSG: cHQImXQVM1kbQ5.tLs87ZO2O_NJMWfEj7LI.CJbJzcya9xwIcXaq8OdM8ho9aqX
 i1Ljq7Th7FMSWhEccALz1KkSVJ_UvfJ6UWMlz5OOHsCKECj7owx7KmnOV3qjBuuqC9AegC9Gk3wr
 j.0Q82XgX07.2_q7ji1.trTB6brkWUcAC0p2cat5LWn7s2d5.8Id_HTRSFSbJCS7PGzue6GR7vcb
 D_AKvPp72znzkPNwIQ.pW4Nmn6dGbOp1zuPyiGmhJewwyQRhmK3W_93R_yytUBdCzcOavR9ZIVSB
 AmkBXIbsFrWDX1ahIDd09_iynHEhYOheChGcd4I.cY48jkJeG.MSTgUqBTl2I4t7_wCinm2u1Wux
 5p2PiYJ6syYmnrtqsy2FYMJehSgJFzr3kXaP3gADCiCB5rnyHvKolkaC3WJtrC7dN3QmS9sWoi_E
 ibklKOBEZ.x9sz6z4V5BjhIC4EdfcAzPbe1wI7vudkfAWyQPEuBec0dvU.Y25uonQU2jT96uz9nK
 7tm4BO6jAlflDC1s5DLl9gJIQJckJrlvvM_Lm7KPBVypk1.PjUmzKI_hALjZ9dv3KsBjBvwRns8N
 C7KBmcuQFOX4tt7GGdEXsI8DbLdurFWq0mnWvr.JS3xhQLhXpgN5IEOVsAmyfeOz8I.gDgpF.nMp
 ETBKeSswKd4APJ0rWFv4Sg.fWGLmxx0QPmqWDq8TvXYmqB9AMVgxF8bek6OnO8UTSo1FuA1f8MrN
 o1wgO..krchXC8JgqcFRv4YXOuvyp0sSGZ6aqBG4wkEp0BHt.lpNN5y7.tiVANyrUoAQsiiNQRX_
 Ul6QXsVaNYWsm59CJ7kxiJszQt7phHzkiDp9OtM1y8ZGxrE.IZzZqAXw.Mdt917ziDmo68qwT4Y3
 3u65ari81a90wfhgCiFjZk2leKljA2S.g_9fq44JlZDMWADjlorc5SGP937wfdeaHxX5KANLII82
 xoJeHCzSecODCRfD.rN_KztiGYy_T3bhATypd35sBLesEnSbkgkxTFCfqo6dhx6DzZIEjr0d2ylP
 h72eqT2wL3MGiqC.O1P3fV0eJYPEcB.8h0O3cUcKSXIh0n_8_Dh1MmthOMSB13q22XVHLHotGNSk
 kLMxtXYDben.bmCQleLMzAdZ0ddgWK9xrFBdZIH42oPf0sYGCszdafFpCDlmmpHoEPKvKJQvmAAm
 xCcDD.3r8wdG4Ex5IXbwKHLQokFqytJ6wBSJcCXjxIcZIB3aqaOG7R5FtWzBaeerW_phGoyOclYZ
 LPH4szmG30Dr5tP87zKdhnEyjvmW3va0yaeDrBUWaRqYTRJoPqR3OU1q8e9e5GWLe1WnGvL.tsW_
 TQNS4jy1PXf5SGK.Np1VhhZk0Jh1PUg_FBz8sTq3J5jym.NhA0FKv6ZjHZC3SXIMhR9nWFYOicUh
 qvki1K6zi1Cuip.6MceJ3ROgUk2oICDMcNUAATzy_TT9zqPKs85tkK86bI_z2ZnHbQUuvfeCXSb.
 XwrX7Xmwmj4.fAgd22T.hjQ22jU_wJgPyD76oaDmGj_gf_OTrgoZqW20UVKlnouZ8zM1FECvgj.I
 hWmJX2YTOBZVVPIUDAJxJV0H07BhMhtQYEEbHx18Dt0aFs6zc5Y3__rOPYDqZO7H8tDL2yUXkeRV
 t.LRuS8uZPEJF9B9k.5p.7NHrR_mEjTM4e36eqX6rVNZKGlmrj.oMj5iCHD7Ibn.4D7obXfSbYE1
 ftC_CkhSjhA2Dp6k7EVfiP21oI9_339yhxgvCAcPpsKE.MHZdXIFzLiYpIXfNrJ5zEJ6McTO2oZF
 QCBVr6F6a.A48pM8HN82KGZX1Z5GDcvN_1O8uq2GDFUwXMHdM.j0d9l2iz344hRh_ZWfYuKIh9K8
 65i9b0QaYanqJPqMYBOQ90.p_ASQdWC7Y_aYUXsmFk4A5_HKzWvbNr7D0KfkKi.yeVBZogLuDaXS
 _p4t7Gpo0N9PCg1aI58JdGS4N2PG5Ol7TYIEtLQQkXESPkay5Yif59ihSHqh_jpIsPubQkNxq_qt
 s28bIcldeY9618KREoAvrjVzG7D9w31TD7nO_oayoZX1Vf9_CTHZ8UDzEzwH0ELliHmofYWyW9SY
 grvcdfh1_iTvLNzz2BpMfc5X6cRaPPqBNyaqgYqHwVJcUWWtWlPiBWvkKFaVzyWqj2qwEa69AEWn
 v2fDp0VdS2GYee__UFYx.sQyo2tf26zTwP07B2IYI63k9d04eJt9G9V4Wgq8OqJcUvtpIMho5_T_
 ymjsYO9oQdlKVFSqo6S3LkSPkn8CESODJaBIYYfSLK3FfNHJpf2YZaQQZBaj0iJazgqo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:10:34 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e584f9a769c6d1ee8a468863bbdfebe6;
          Tue, 28 Jun 2022 01:10:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v37 22/33] LSM: security_secid_to_secctx module selection
Date:   Mon, 27 Jun 2022 17:56:00 -0700
Message-Id: <20220628005611.13106-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
index a4d08b47cbc3..5ebc3ec6948c 100644
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
@@ -628,7 +630,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1482,7 +1485,7 @@ static inline int security_ismaclabel(const char *name)
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
index 6500d97ce9ad..99439dcc75fc 100644
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
index 25a6c2a5b4b3..318529b1f930 100644
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
index 96a89fd5802b..a9a56be58e73 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2353,20 +2353,36 @@ EXPORT_SYMBOL(security_ismaclabel);
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
2.36.1

