Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A154D562E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbiCJX7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiCJX7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:59:05 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660C9A777E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956680; bh=i2dn2sGdFwxB+wuWuFr8AlZTakbfKjayCTv+Mnj6KNs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lZq0ZtJBkGu/AJh9WN5pJ8F13cI9ZvnJOBznZqnlcT5N8n+WwuH3QVAU51kS0NYnja31suPsOmEXTLl6yGxW46LUTe9wORSrJWT3HipBE7D4jPym8zGzQrRdhWWEs4Ba9dgS1qJMh5+vj15VMd9w0qbdZs4oXCe7WQdlBY7RCNaUix8u/NqVqX2LSZDacroVhUQsvKrIiEDJC7FSL5XlZEAoGcOP6gPOpLo/VMC86tM082/ZJ+0aNyLot0gA7uYjY5u5pMnyasiiQq+f9xvI0mfyM6bRd0y5N7bL7oo8+bStwukqc4sdieOO19ZxY2e1zibcQvugw4AcoBsEnPfqWA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956680; bh=b1eGRnX91MNiXzR4Birec9dBdUmhp+1YaLukTViqSzb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bC2K7KsWUDQacYCTQqPGY5Db2TgzLidhTmH205cqqyM66VUq+DkJ5XegZZPophmRHzeNpS2BvUH8ARv0Er00jBWHcWi+ZXlyz6GzHDLyGjTb/Af1q98uVxq7n/2l5EflZUUWyt86xCOalI5IfM6vB5W54JvwdOJ/svafHt0nayrv5BEh4k4ab68Lt3qStZSs0RIO4PdBHLlfjcXPdwx5DWP5Jia4VWkJvJoM5s38YSi5hL2ALpHXEf0ZvZL/9IHliJaJYjwh/476FqBusnbxcEH6TWw3g27TGM+gz5L4TH+2xWHDtGqb+EdeMI9rKlkHZHAUS2OLbgHtXAscsrrD/w==
X-YMail-OSG: 2TECTt4VM1kxK.jYRCSkwN1m51bw9jx3sG5E7_2bSnyHGysdclGYyLI3U8ZHq0R
 M1kUYotMDa_dP65mJ9YZVNxK8NSHH7vbOU_dqbenKFeMTHtUxe8ow0grGZuM8IDviPfpLN4Vj5ox
 3RIoFyEb90qxxnButcmd98fjAAwTnwKokb_FCgLTn7DOWZIiQsiomp_UT.C6DfvmtAlPX0RKPlZA
 amrgBhPl4H4xge026pUZs5jeJTTs.U80jDMGGtCZYCsQXCYVnT64uDyIgKXi9HSt7ZkXgjmfYQ7f
 QPZ9qDC78kgkbVHLYVAbzy4cr3mxkMmYj4C1UNFeED_Z5Toacyzqe9z1biIWUw6a08kIF30_7LqP
 UNZ2u_pYY6FedHx9L.vh.oSOM4zKd8E_uwr3_GJrVJvKWDbgpblh92JAM3mfsizrFj6mAqQlkpRo
 HIitzlguonJvWlAidfEPv8TL8Gca2mQSua6myhxc2rQVGQpVy_uqmwZ3c362g6IN3i_HdXOYZoFL
 0eHtyRPqQXZqVKOktXUlkfpLiZIA6ZJOyUPn9MxWeB6gTBmF.cvQZX6De.Tp7bFUOrZOS_xTTri0
 HjFq7HRsayTcnw6MpycejH5sEUvJBXpFuGwAFuHw.7AuE_889I_bOhYp.z8oozhY9sh.DJgxmRpi
 6EfYTYApWzikQkgKbERVCh471_Ruduw2V.WgV84KJrix408nBfvERLhZWL.fUBRvaWp0d6iubnKr
 7oX_72kMWEpeh_YPOqSaNFps4HyDN7QhEPnCCOASLJcJmlSLj_UX_z7WMA6CEvqdqmtVZu4YnTp3
 _fI1pqbJ7vs.E32ljcKr4_kPAlRmI_PVw8quqnIoOT0kNo8mcGyJhmdGIWc.hWb6xNaXG0lH3nBQ
 6F9jOCzC0XQCb.bKnCPrROdp_7XwwQ7g.fFtmbYlGSMKqp9empldFHOeAatgDpU_MA4liU64FJj6
 8pPGk6kv93lWSbHKq9z4PluaUDmRkyv873LXcvfqb8or0_JeDnfJeHLQ3ARZvkkO2dWhDeqV8SRK
 wxgmFGRBYsq3liX8lPT.krnx71suBhJsFmXajSs6.dAA.J0GoCGR873BfcgklnfMoXL5lItrUPbh
 1U6.N5MqSIvEFlMPS7JXun.8lHS3zmsZRjh6oXb.5pfGxbhx6gz1f8wWMpyIxxeM9B.JWqEXs6Z9
 8rGikEEH4AHVX7pr49CGOlvob5O0Onzs42A58kzW_aiIsHaJGDM477iqv3hFm7UtY_6zJhCalFbx
 NRVV.lAO5hMmXeoSxHT7dU.2R_HAHhr.Inmz5aqpYKTdPKb0_EtKk2Od8lrZGPZMTruQYtEUZ5z7
 3RxSf35fv__u8TTRm6Y6s4ro80.nPXT.b27rbgJ0UJDXI_EsXFFZ881r0GS8DqfX8JTb4adJ5o3b
 vzACO9KHesrwG4L4my.c3aC90MEOnLhu.a1dGUwNu6AXU.apfwWxlM651Ni0794DiZOQWp7oGjsJ
 pjanz8L5N3pEbxymnf8S.Rs8DCQURYsY_3OYIh0hdMlkCPov1kQdlP.mtlIeJckIIyRtJa5ibKGY
 iL2E5JLO9rUbH7H_0rDCGMn9C52N5xGGL8Bc0LCJOzFlWEgwBQRMmnH39cQSkLcROzURchAgiydI
 SsCu6lIgwXON7sgf5HEF6XPWnPH4c4b2irM.IKdRmODJymk.n4TlH9qTCCiF7oE0tCItOjZ32D4X
 yXxnTrqbQMpMhEI2eVVTlZc3bGO2TpF35PmViIMQtm7HJU5GEGA7Oe4DneyHI1XjMBTpx8L8a4Fr
 V..Lgt_REZb0_IrpN92dMQbVZLeSQr5pdMgsSirwDEoCSzuECimDre2oQKiuT__n4To.qP4kPngP
 Voo5Y_y4wuRA97jVDkDj5GtMdN7Y.B3AENC3_qIAoDOcosAgR.v6JX6Cd0RuEcJjdtZoUEbOitXV
 c5uNRLQCv8477ABHH7fF5I3GA7NcQODL24hZJBefxkJ8qXO6MzXRiu5HXCp65BNM.w0Lyo8_bXK9
 TMkODMRl3xLQvoyjE8.jRsK3nLjhEhib5yDROnk5ejbTlXiiolLuEW33p6inf_N3Lc1onYs.bqAx
 jN.JHoQkNH4dxMh4hDcaBfeaAxuWTX9bGionPf_ytSrtWgQAi6Hq.iGyllkwKPZ2Mol.nSz.eQ29
 vC40OLzd8eoK7fInxLqJE.jsP3.NehitqLFfILKcaTyt3RWO028YAc_07zpYvOfS_2QWjQbPT0aQ
 x8MABeuKiErx5LxqyJ9u46.JdqQQB0EhDiuJ3l7t.0GItBrRStCo-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:58:00 +0000
Received: by kubenode526.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 075078af6eda9fc0a8c4174c138d83b1;
          Thu, 10 Mar 2022 23:57:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v33 21/29] LSM: Extend security_secid_to_secctx to include module selection
Date:   Thu, 10 Mar 2022 15:46:24 -0800
Message-Id: <20220310234632.16194-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
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
index 65db769a8584..6dbdfd12fd79 100644
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
@@ -597,7 +599,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
-int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp);
+int security_secid_to_secctx(struct lsmblob *blob, struct lsmcontext *cp,
+			     int ilsm);
 int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob);
 void security_release_secctx(struct lsmcontext *cp);
@@ -1451,7 +1454,7 @@ static inline int security_ismaclabel(const char *name)
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

