Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2B47393D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbhLNADx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:03:53 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:40489
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235317AbhLNADw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440231; bh=opWqcFPSxyokgZUudrSgvYovvIvPsi6Mx4b4A7biD50=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=mKybigpinBVH7JAFBePRxcFvBHGf3r1lFRCbgWa8h01OIkwcvi24XWX1Z1CRcG1Nhhwaf1FJPl8JpKtjY/fkW+z+7dT8XKxEk4eG+iKRm52gxjNXDXrKIvZp6wL1BscAsTzFdFSKr5A3HfRxm2jeR+m+gMAzbxvy5X6q70QEu5qA2zsr0En8EAS+MVvk7INGzOHGm/JP/pxxILAcKM0T83RhcnAUO2tzSSJoJqIFqGBT+aNLcJHWwMY3rTUJfnYoo2dv3FHd/VHl4nSexV6lS8z62+mBxQ43iwWUOsqkKUmWa0ARnc7Bs83Dr3oakhz8f8NBuHuPD1+ls/oAfg0dhQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440231; bh=j/SpVQlb8vX0W95slJ+QL8BxVFKvGcXeM6o2FYInyuG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oShJS7BlWTXMjcOgjibAw3Tc4DqmtNuUlp48FZmxQ58o4pzp2HFdXA7FNAZZDG4QHTQPjGG0ni7DQCDkGGA4Q4O5xggD/E45ziZTdvt0O2H/zlLHFI46v8VWqXdFQ0Lpjd7fq7sFdBOIM1Aqfdh196rqEfv2FwPAo2O/GAhkFlq/V7PmqKS0Ghz84lcfMJScuYrQvNV9IMrQKjN78IVuhGnI3tdJDN/I9qv/jqWSsPpjTS+tDblVHZQZNCR2xh+4gcc1AGIyJ0MY5wbzUWfZtH2DBQEvPDhnxwtfWklDgmBpaZU7HKXvru4wMeoufZiu3HU23cCmngm3iODfUS/SNg==
X-YMail-OSG: oyfZnNkVM1kRn5dqnny_kzVh7.H.PEBzcbsoR4X4adBNH8vmAENDT5VMiqdHRBy
 gP7i6.rUAYe04bbe0AqQ6TuS1kl2nOsuWUE9crNdv5fPOzelpOToI8vp7K85uwHjfjR4hEx4b44w
 MO3A5f2LS4RUDOS2W8OkDLc2IQ5Hyex5tdDY_4_PG0VaiFJwqb._WY8WNBzOIGOw_QREU3BTdXf_
 639VJql7O7fhGpceeO3E7pOP3FhIrsn7bDgiAvLp943hE_OpRARwEOE6h.zkYHzazrAhMbUGp0vc
 RR7GdHV_LJsQmCzQ4d7_1SgC2ZGT6VfDaFEiCTN4ZVRe4guOgsa11z.GY.JTwNnUiqK8vFtyS8Id
 5K0HLz.sf.6pCBBr.KbaB.mu9lD71T04hxZqunkw.4m9xLGlW8Z_bwxZiW77QDhKVvBsGHDqhWvz
 o0MrZlBPJ5CTtF615cClfKAC7mHfNdJunv5drk2V4IaarLu8ZhFYrD2GnOavkkhlAD7LhXrTPV6t
 eon_vTwthkdvao8LGU1DLLyGfZgF2BeBoV.augArRluMEVyQZom5S8Mn4MBe.RIRU7A86SDZv.gZ
 X0O3Fj0Vpe3akuGE3rizKbArJb8mEx5LBZssRd.zUXQczF4JiTra6atuXuxjUkL88.9NlLEnhjmk
 2WyT_xGa68xHEBHrgdNcpB.Kz_NYSHmUOGU5zSnQ4CAURS89BFtthFvTrti6nG2iM9M5aDXXCGwr
 r6WP3a9Wp5hz8xlm0J6PDR0EP4tHUkEHDTBkrAKh7QxevddebGLpKynEedD28yMorKA3aviP2Wls
 r8U_AJOSGAjnTR3.VyDgHDxM4cGvla_k.FJvaSblCyATQW9w3nGakpZCoWuyUQYGQRPhL7MU0abn
 vBjHzxCcHjUsRntmJQacBauGtTBufjXfrP0IumZfQjVRdoNf0MovptlDcwr6rX0edmtGVOz0Ir78
 nYEbh2xs48g1ODrGsVRBEi7wlwOVj.Y3.UH_i1VN7B8MwB2D3fECiMeI6HQ2BVBSUNNEanmncyCs
 Bilr8VvvfLoXElDqOGGyAvEAQ6osOH.bcBE.WqrqsRbxcNZFkBlonzzPw6wnUl_G02q1RqM.UIqA
 sGVw3RflYiFKQLyQOgyG6pn99C2CX2NwV1Oed3f9YM96_QGvKcSdJ7kZtioxy3DPX9vd.6WL33mm
 LSNFf2e2.7tY_F52RQxmuFkZH5EpizIPlqpoHGuv2amKmE7zMX4hbFCMh_1VP3pMBr_Dw4W4_lRY
 oWMeYoO3e3yYJXfcfXOkNA33HyWr0fwJMum8XRhT76TI15j8KmEiSIkQ6ZBKOM5HPuyjy8FBabTC
 Pzhd94C9ceUL22GtYgXZa5OB.Xu3NrEPX6XA8B0POYE7j_7fXzsyyeoVOS8SfUJ5im24AHfZtqBq
 F69wcqTAkNZYz2UkK1F7gVsySHUO7a8xzkyS73EpnaIydRQoSFVhEjfmltDujGDnOpD717kWvTu9
 8L4BzGlqaJlNnqRpRMvdUpXbPA_WctrZZGkwqujz4sfHrwcWvc6zk_z.YEdna.rezSV8kOeMHZgC
 .e6xcU3DYnFpwWTl7QUrM0r3UPBhBbvjs4rM5Pu_VYR9TEDUyyvLeYf7VXrEejR1HR8_IhjEv0Cn
 LctjHMNpewD06oihDIUs3I9qnxD9obm6byzvQQIL4_fjWXn7N3hlrLwc7vWElBJdP3ELoJhBk4Qp
 3cimtKPnNO8UmHwOYqQpNznCJmOxnnI0RWorFuRSoLlt6g4NLqA0tGDen9xaPr1d8IudTXL4RY4X
 ySmtGhZiBOgfTK0YoTv7QgOb0OjUWGrnpwyU4QTfYKzgxke0sEnt0aF3hKpzfGUd.FAJFItDagdq
 jC0luG3bCERZCsZaz1jySACn0EZmUI10TI8qObvRs8ullfRxLEyQD9Xa7BketNCO3ju9Q9JMXxlk
 AUcpd11vIjAP9OOD6jryaRgLtuoRQYrxBCoguf.f7ftE.021LlhFpz7NwXJDW3lw3I8LwHLjym3Z
 KIgH2MaSY3adteYjaXAn4YUSxIqjoHY6_IjgI_.v.R61dCOCerB0zKcZC.wP01heVBmsBW.M1RWq
 NBEWbgsSqB1u3l3Uwhn8I7hm3jjca3wNtyHS8z.uXzW4HSyUSwGEnTnOHCYaoQqx_64_sspxq0EY
 2xwuk9ClrZMe7_.FIAazLy9EdcM3sMgaUpDrb4tL.PtO4NleJH0jomPaII1C94IMoQj8xeywm2iY
 d0UcYMONuGyeG743OKSjcXF5D2LWd.5COJWyBWeoibUpvikVqrp3DyobjtZekfxVeA4R1p0bevfk
 LMDogS7L3xZcGHDdWyLESow--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:03:51 +0000
Received: by kubenode548.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 45ca1362a2d7953997a5dcea844bd3a0;
          Tue, 14 Dec 2021 00:03:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v31 21/28] LSM: Extend security_secid_to_secctx to include  module selection
Date:   Mon, 13 Dec 2021 15:40:27 -0800
Message-Id: <20211213234034.111891-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
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
index e15fb8575c81..13cb1ae1ce6b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2721,7 +2721,7 @@ static void binder_transaction(struct binder_proc *proc,
 		size_t added_size;
 
 		security_cred_getsecid(proc->cred, &blob);
-		ret = security_secid_to_secctx(&blob, &lsmctx);
+		ret = security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_DISPLAY);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
 			return_error_param = ret;
diff --git a/include/linux/security.h b/include/linux/security.h
index e29d2894928d..bec8505f2ce5 100644
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
@@ -598,7 +600,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1459,7 +1462,7 @@ static inline int security_ismaclabel(const char *name)
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
index 841123390d41..3c6e88a9ff62 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1443,7 +1443,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
 
 		if (lsmblob_is_set(&audit_sig_lsm)) {
 			err = security_secid_to_secctx(&audit_sig_lsm,
-						       &context);
+						       &context, LSMBLOB_FIRST);
 			if (err)
 				return err;
 		}
@@ -2138,7 +2138,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	error = security_secid_to_secctx(&blob, &context);
+	error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
 	if (error) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index a3de97beba21..2cf39de8f961 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1123,7 +1123,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx)) {
+		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1369,7 +1369,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsmblob blob;
 
 			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt)) {
+			if (security_secid_to_secctx(&blob, &lsmcxt,
+						     LSMBLOB_FIRST)) {
 				audit_log_format(ab, " osid=%u", osid);
 				*call_panic = 1;
 			} else {
@@ -1532,7 +1533,7 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 		struct lsmcontext lsmctx;
 
 		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx)) {
+		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
 			audit_log_format(ab, " osid=%u", n->osid);
 			if (call_panic)
 				*call_panic = 2;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 47d1085e037e..ebbde7d9d8bc 100644
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
index e4a0d1c8ac55..e4f33fd86916 100644
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
index c8825e89a21e..541a49d5be9d 100644
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
index 69343275c54b..ea43bfd14544 100644
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
index 60e36324568f..a70269367827 100644
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
index 1b9e1189d74b..a1dec90d7757 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2331,20 +2331,36 @@ EXPORT_SYMBOL(security_ismaclabel);
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

