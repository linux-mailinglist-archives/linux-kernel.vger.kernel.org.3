Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6F503105
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbiDOVca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354757AbiDOVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:32:16 -0400
Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F0286DF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058180; bh=EkL8jDEVD6UvH2vqKmpdMElmONU7ovIZNNe/SkBqwn8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=cf8cvY3xKvhW5S2KM0wmrsDgtAC1pd2faARxLN/IrgZclxyuAXrX2U38KzAp5um4tmBzvoR4yxK85LTgbsWrchgF/5Sv6XRPD4bAtIvCQMpMNGOt2zvNpvlrOusrHE+HW2FI4JiRyIFAD1PYTzRRKJw9pivvbsAwFziIk91HSvzXkDdlPCbI8CE5w9gNHCg4dQCAenmsoh+mXG8JKkBpkF12FFH1elMn4dHCE0teBmhr3gbGbDg0BET2dBBmzxU6EWJDy7MBQ7AFWP8YP/7k1WKXA61XOmlDwpttaqYpH1EAt6RGn9+miPT8Nz/4qWPme6Q/lFwogNa5xy/LVGmrag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058180; bh=+jSpanIwDLTZJhC1r7pjnNsC/F61hqHh4wWWIcjBA0Z=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SRWxkQ6C8B8xmozGpnbloKBvK/HxF99brR/o4Jkyz/KMWsDgmxQT7yULtH1BsJ4FNVzE8kkeUpI9Tftmv62egEH7AO/grtb+kTRcOfHebi6Ut+gXX22Zdqv3SrVHMM6CwXJ4eSPNL6tyoX698IKmhgLYf8t++99WHMWtvyeatEBbs0hhvxMgZD7ArzYcz5Eu+g45Wh8H/XbZgxaz5VZJjPSfsYyVar2QRJFo6ack08TQZFFf8MexfZHStdQJzN1hW62u36U04/xcUJ8tm/22Htua3veJgw+3vJryQzd3VFfEVjBjgHaQyLABEtUoxKdEHjXpxYA76EU7GAKmGFC2Ww==
X-YMail-OSG: tmPV15oVM1kFmxMpQvJvU6eP5Q64ufOBcHF.sPy9YJOQcWF2dzqqFnXMs54jqiz
 YTJ1XfvGwjtJyls1lfwJho0nsLcUkTltiWzFX9hkTModszseiPGQzynQ7KddxRrCK5Mm3ARxg1T9
 9o1E64KerGbfhXiud9eBlGiE12twB09s5Ww9XhVJp2I8pdOfoccdG72nzpKkIJ9eotB90v0ovyNp
 XWxYnP8Nj7NYLR4q0xdPBZdLWHMsNo0hwnyhPSzlw3OwwczXaAO24euOmRnLbo3wYfjO.2kD0Z4I
 3BrEVVHVIv.89ArXye26vLuwbIgC.k61XXv65xW49fv2fetH6MG.U9JJQ.hgVFLU1JYVGSqsPWsu
 w0Ruqad8cO_K4nPcT.gP04oR8l9Z0wN1lcIpQExjCeh2kn1xC8qlG61zfRHcmuzT3vI79_.OsjAx
 sP1MNl2pdvUXPzelGcGlOcMgzDUkhlKzfwBwC9UWAeAPuNjoJebFUXJoOEYARm0taEjItuil8GcX
 XdtOMuk6DXVQ1.5NhXlxJAwGGbEEn2_mrUc62Wzo00iaExHwAwsZNhO6phavJX.kNLhRRLmsQqFl
 DUvr9zckuTDWn13GxWmyRpW0jGFQmEG3n6WRvwxbr.89AJgV_S9B5qYUCXh8LH2y.dsnAS3HhbWT
 ILLfjzrPEhPhYwGzNaz_0H_kfMchUBYGBCXHYbohnC3eDZ.BsjV2koB8jgm0QtKoW2ufyoeDCKqd
 2.ZyKrLxGL0IkYbyLQHW5uoEGvRkdwsviV8LwLoEFjkGxHuQzhUfZSYnAQ0ijxCcCscwyaeaY22z
 c7tBz13kXPBMK.U9zgBkup0VkUSHF2Xl7r4.uGmqu5UKD31jeBF9bD7.Ag.3kb5m3UjIqsw9Cmm9
 11m2R6xQZV6knQYF.zimpdGqTQC9G2cwDxwFxZYW8KsDVGKUSw.DpDFzbiCE6eIPCo9.w0N5Qy_1
 Bl0Qx_0DAzEg83Cbo7z5svF9HFI2uX7gogYqnBGZ8CXLo2NsaV_AS3313QXl5iIaz90LM2idgzBF
 U62ksWw.xSkpOozKYuQaRRuGSzmexoBZlKpeKkdqyDwV7HR_dkUuHeiPTKBxwAxXNhQkJHM0evS1
 lhDGV5Fgv1NxGW0Z9qTsEEpGURx21xW1oftcFe2CQoKF5UGqU26OozUckkdB4ktcXdvGMhM2Qx1V
 THxx2CXjNHlf4hdNRhBDsIDE4UqUwrIlZYL0I1IxxGKlOqL8trEm7GYniQT0u9.jgx9LFbKq5rWU
 sXzuLZFCGaQIeUajg.mXriOwS94VyzaQhavqOU1.7f9M0VjzNElVbxjC9IUnA10Fyrd.dEeZNZWp
 2OdvVj84U6QscT52_V84EsPHAjZ7FqQwTBw.G3D3F_EOx8oI.c0A7v4419R2dp7rqC694.w3EMJK
 ZIOD5ABEdfON1Jy_Q.3V1C4cduw.tiU7IbChbiMKRY3f_MJkgnfuAUrXWeC4Mk2JI3TEg0UPZ5Wa
 jg.9Y1MZM71mAMkZQsgDpOyY1thkey2F9NkOTjqPO9pHMb6ZyzjIo77fSqdizJ_.EgPb3p2MTPoK
 wi7opm.cod.2ZiYTSZabem6bPqgrL6aCqX5seh6pgxO0h1OiAAD8jDkwv.yZ1phdDJB.d9pbZIIY
 xkfRFesv.Zfn4RP4DgWOO1mTpEcSC6UrJ2LrRQkgbdnD0_QtNntD3gUmQHnOZ_ANkMeAnkQCs5Py
 KtWDl48PQoovk.A3rrgdveR98SfCiEOb8kBshU_r0d4O9I64TkNQAnxI07oTqg_SxBT2axXYQtPM
 EdEzfq0ejwEWpR27zTJDWnwQSmBH93IZcyiDl3ahCfW0t8t803ttn77lMeroLlq1YqiYGLF.AjBc
 atBXhmmIigDg62WUKypa6roQFbUErO5asE19w9KgcUFnXjxAhxr_H4aQfhqal_vePjAHSPEmYCcX
 023vABLX5I0mFNWaxTO1103wuGUr3goDXjuoSpqd5xgDGIV_Y21XJqM._3odH698T0sdCWUQ2bW_
 OA9bKxOkbn8oLFf5D.0WbYWiJYzHsR60qlPiZZnMWLK_lsx1l7r7NS69jW3v_XXrcDOIQPGvKR08
 KcY_JfZpzpy03VWSCIaQizzh9C_lFqgfUAxCwFUye4L3yVCWTaJ7_s_4mjUhDDfa98vzxSjOAMQV
 oKJa9UfyUOmIAKvcUJ0tkcvFP0z3Dc79InTGc56w19ILEid7MvICxWrsEs0kXnlAX9tYJySCWV75
 SMaI2B59uVmOP.qIdmnMVrzXBIJWIrjTIO.aEZbPDFTKxPX4k7Lv5Ubn48m_kzDJEVSobyGbjGJl
 X26W83RalLgwHyzvzqjniVqdTo5WDrOhyV9iAu10nQ3ERe332KVnOeHlSnzoe
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:29:40 +0000
Received: by hermes--canary-production-gq1-665697845d-l9qwj (VZM Hermes SMTP Server) with ESMTPA ID e13e266d8c7792b63d16d18d4175b5aa;
          Fri, 15 Apr 2022 21:29:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 21/29] LSM: Extend security_secid_to_secctx to include module selection
Date:   Fri, 15 Apr 2022 14:17:53 -0700
Message-Id: <20220415211801.12667-22-casey@schaufler-ca.com>
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

