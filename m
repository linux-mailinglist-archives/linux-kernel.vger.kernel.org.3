Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A24F8987
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiDGVgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiDGVgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:36:12 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608FA1667E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367249; bh=EkL8jDEVD6UvH2vqKmpdMElmONU7ovIZNNe/SkBqwn8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=dYrIEV8BXLA0RC+NNKHAg4A6il6pH5WrN6eH/9EsHrtyaBQeVnY0sUSaR/W7gPxkamR4mbfYsB7pNz8Sp5HxLZWFSsL1bRLso6kRYyasgZ2FwJYE4f8nuogF8YO6/1U5+1inHVG3aRsRvfoXXrpa2pTjAUzvnnhAtaXO8dG2uaT1u39YYPsOXzCg+szEMP/83IukS6l/qz4MCaXvP4tUSF/wuTlbxz5c/Z9zjOgE3lS2TUb2mTPYbhRfqsulB+48YBdh5RCm61vFFC9YBqD5oj/AMLeDcLIhQDOfBdDkW2FORpa3teowKZY1EXOvDoL31oJ8WAGn/AUqKuo75LTXGQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367249; bh=QeE7eHd0h92NRluxaFtImjhbXiQAIyC5p9uDfZlvg3m=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ApXPVnZ0YQN/jG4INlps0z/HAsxa+ZAsdGXkDrSjU+fH7utbx77QEgCmsdJnhnUT3lreG6UZr0Yle2Y5BHTXa+Ro6/6TWBMrqcirR1dsB2AHtpYC2Qata1n06gPQL4cAixdC2TkYKd7J9BU22bglrL9oXGRZE59LhDBNuO8/wfodGTf9kzkATwfHqcIKZgWrRX3JERQi7dfTPWoGNrMGemJukT1PPFIYEuv8BNMHq64E9lo/qY93MGboU3/MsLt88CIJSXpoJDQeXfxQ972Oxxbp16N2kicx/I/AXGswLsmF5I1YrajVlVLP/Cy8Bxo2/0K24gHkpD0Ckd2mGQjCjA==
X-YMail-OSG: hUKXObYVM1kCe2053eqqToSegaSUFjfE4uk_ujqOdOmY9ST3J3.Vah69hqklMzm
 9Bjay3ENga.NvBOEBw1VsjmarnzgxtQs9tXfDBHuc88XWp3mHS.XnuuKCv6C.L.3BcymY3sC2PA6
 dbSGUeFZiiBYUXC_2OjU0Y9v3k3Kr0NE3BmMCwktSZwqX1lK_lQIEbnrpJNCF9k4PfqUoGRVBfK7
 qPKtciKeXAdpDv5q9CTljhClDuQ53Jin3GQrpJD8MjzO0Iy_tniLWLAQY.PqF2lgvE01tXxhWnLV
 L.z1sBRJonxaXcR7XT1_YQUTjun9GXfxemmknxYKNPkX.kGDmrsjmCf6XLWneKANFHGHvR5.sp1j
 Dsdz0UZfz3Mbtyfq6YxPgU617Il0L34RmC_ZAzAMX_6y.WFEg3YZgANqytDNOiWBI3uoaiqzRY7X
 1XOgNuipiKR_GD73WBnm6umz.yd1cpzcrtPbKaEKH.Ey56yD7L01VYs2Xm6bEftpJGW7zdSo6BOc
 bamPoFZjVdnzlx.SZEv20adeKf4AG7m9X38D5U_k.j7lXHXGXhS6wy1DLo3axMASyi8dq.4Pbnx2
 axRfqGOhORgw3g38I.3Tve1yPFlOgYN_FQz0ibx4IUphTv6aMIIgQGlirjWZiUJZVt.WqIR.tI9e
 fXfWRFOHdjq98Y546OI4OBf2XYrR.kFHX0D.Ym.CIyOMLx8ckJBFXpehUu0v0jFGVKwrF1iwRiff
 9SQrm7LlkW8peBPZic62HSMUukM2JN.2Ysg.VydoVnbKKHt0QpXChexL5N32Swka5FzyIW97hNnv
 lHK0U4A4sl2ltpMKgRzGN29_C59ahFDExWUGIk22eOd4exH_Cv1L2NWHSos3TiY0CRSTqxMOQgm7
 GfQ5ZTPCcL_iK0voKIVJc7vAlL0KEZzbKjWMOUaIqeOynxAYFCcktrG5CdDCPe01rlX_Ku2S41xx
 MLJFGPAfo8iURO4CZJXW_r48xOpniJBgwT9Z6.kZOlVS49OFHOZyJkLupkeUT7uFTQ1V86qxi6e2
 E93RQvzkmxXzDS6..IDHZQVCp67MGW7XW5wWJ87MC_HNIpA_JtDf8dXZUQMw6hpH4g3SAGEXOTMI
 TOORzKTK2IR41ZieEPFwphhGqhXiU2yF9FVcvTEmgumwM6AlZJxBjJVjCxmCp0O.NzmkJXw1i1TM
 HyVnH_nVwr33hNksjgz9_xdhkZW1rvIrZRQ2F.i_mfbqPigygRXI.VtNBFIMSCkFp4hySRk3ikGE
 zaqXzbagP1qGAAoY3rnAmXF6J1wkqOviwmS2jB39pv0mFX2j0ggfhCA_UhCDyldXZNwFYb.RKteE
 4GoVnfYcwn2Dh7xdOUKEOrXjU0.8VqSTfY92DQpEZzQ2uG71lraYr1Mnt5Kq4zqwTkXSIJYClsXe
 jK98dlI9WzpN1lf2KMoytX3_8ez9tdb5RLodJInXgP3G73fsxoOJjEx.ZJObSRztAn9PnJIIFW_G
 LOBBeeXlaY22RuhvlQgRIasf1QXm0wLW2zO6gahGlR3I_gdrtH90r9.uURwhBRxXVM.wh6Qrq3nq
 Iy0.c_tkC5d0ER1h_LfnjVt5W.LvN.WaIUKxbI1jtBam6K2CVXbVYHAAW7oab9lsBHmRtEbJXcN_
 .izwTEjqnTt4hgori_M7DhsIRXqmohJZnsfBBOerdYas8.yezJPOtxfo6hNxH.oM_F_2DmaEcmw8
 bCzCLjLl4YhBYjz_NcrHniLQK.EPjGTsagOrr4A9E8IR0gAnkQDvTldnRdqYplNtS9.pkJSrplWn
 FJ2UCaWmE3.1VsJjqaVqVy6uXxo16D2JpeS8Q5wN8nAVfygxyXbcM_j786zyXMz89kHO4oTogDPm
 ZjuLiGjcz43RHPA0sQri3k.wWqwiWtWIP4nJ2DugBQXyw4GmBeeWzK11i8u5XKxRfeV43O2cNZOH
 ZVbJSwRjEeO0qBD4BB4bvYy4YvGZb1e8Nu8TPmle4jJZ_8KaGiV3a6BHISPRid.IzG_shUMvwj4B
 SHzKPRUvdRdPRkey74zBGszsskpT8VfuHUKUbKBBQu69UKV1a0pbpH9FUtLMBPhqIDpzvPyzemqh
 NH6OiRxu3ieAAjm9X72UUdcxMpHILsge31fSrMSMnTxSa49gbLGRxlzu9tKDiy8aJry_tMdGd5oV
 ewPkeA5OFFAvU0u3qhtxgcthI6aqx3ydtvINN6_7awHbsrAR2urYxhzi1IMQaDN9tiCOKlpfgL2O
 PwY0s34nvdiyHZi3v2LlOeL.k_2ImKZ94NWA3LiUV6u12MqKHCCBh7YM0CEKj6gz3BfBBUGg7JK5
 7NuVm8ez6dcmMad8eDNDOhzfaB4nQwg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:34:09 +0000
Received: by kubenode510.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6ea890d0479c56b8723f536561e1f9ea;
          Thu, 07 Apr 2022 21:34:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 21/29] LSM: Extend security_secid_to_secctx to include module selection
Date:   Thu,  7 Apr 2022 14:22:22 -0700
Message-Id: <20220407212230.12893-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
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
index 9933a6e28ad2..0d3931723361 100644
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
index a5d01fcdff3a..82aa6049a858 100644
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
index 02b931df277a..01e14ed6aa32 100644
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

