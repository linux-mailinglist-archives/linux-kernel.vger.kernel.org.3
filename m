Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CBE4738B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbhLMXmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:42:55 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:42018
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244245AbhLMXmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639438973; bh=mqrxP8YbMqpdwGpiKDP5pDA2udZP8b7nOi28pU94VwE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Lp6MPBRK09r/UyzC1eaotkHWeuR9T/ffRO5PlHxzKvbVsPsovBkrqOd40Pk8OqKpFORCGa58F3xxJAw2b3hGJ18EJfvME8njd4lc6ICYZoiBdDl8wKYFTUQ3d3w3yKRJLhHNNYNkIkZtH/iAPA6PtSKb+ziVOaHktnXzAoHnCmMP9GqDM7Gz24aHscDMda0JI8LPcbm/uZb3Dj3I0tUWaLGswv3RG4Rtu65ozGTimGTrtA18WCfjaOcyMUlaAQ1q1KC5m7g4myf1Fg1l04VLxt+SzjA+jI0Cp4aiSZnRjmfwLI1i+rU5GppbwZG0n3zY07zDC3evBtdDg1RAcVP+Og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639438973; bh=k98kOvNEk/eVdV4/w0cza7/aaRdFpn+41IFesbu52Nh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=TYXx3lAfpaD4BYPCLCF9Or7CJk2/2dBNuUcOD3caQ+k+0vlvblXQsLCmXVtw8qu/DZbRQ+rQIaMPIM00R5byYpEJbhcWuJMdIh1Eq4BF3eDcwROzsMBl3a9nscOxdBfe3s6mmSU92Suxec/cEt9ZOqoTeARrR61fqtKoXmNmNQ6VbwErqr2BDkEUOk/4ls989FbYxh0dCDWqnXurc+d3QPYa1ukKSr8I/lU/I77JSYHpOflAtZ50lyTZZfqdIvkGIEB+Mz92t7DD9O9CU32cOx50BM97Ec3LB1yv9FgENv4Qsm5fDYaGaTWrfwzt6Sm0fsYh3HkLP9S4PO0WQtQSCA==
X-YMail-OSG: 9ezkpLYVM1keYVEP4HGfbinZT1zilKc5zz0VMehl4tVEkq82O6inEfCTaGn9aaf
 OWN9hqMJqepdoEhP0zepAEwdpa7zbD3QWWHB7vbg2yBr9UDWdpjX9vJyNyHk7WZ1RQh_GT4RcIYY
 dGwUZ5_3_sjjEW0dB8teOqp8Lw6C22ErYDbhEONARGy28XahJSYlNtTNt250KR4wXvp2KnOcx1wo
 PEZQWB66JVAU9SGq3.6SIs87bjyhuyQopruKxZCGd7nFaP7U6ryygG7V5uWP_COyjODynMKXqL1J
 Tf_YABL.AIBapJMzq.I1J1.Sw3AINPPJd0THxalH1mw9vAlmwLKKeS2vTMwZYaWqd2_koaoP2Us7
 jgKtqFqVkBaAXY.n45T1k_EeOdCqxz43QbTMjizuJwKg_F4g6EMoLVQd2qW0uhcyznnJ_iU37zab
 Qdde9fdp8xUnmOQLhhHMAqVErBDhTxiUhvEBTxuAUWeocaA2ISHzgwiyCkFL43wZreLb2OJOk42V
 6xswHIQYQc1Bhks_rWF17Ux9P3jEMS8KnxXQ9l1cqAVsME1IrKWuGW64hHog9NWcXyDB_TIz9tCQ
 UNJZdI9zYWlA3dEpzVQKlkaOqv2EPowydO0syqD9yAu8MybUVcFLQ4G75EnSvk_jl.ZXcrJTT3Qb
 RxMTR1xECQj1JyZs6pYLJTRh4TKDbN4WR.wQiScntC04csx_BqiYTOPwssyloAaFUZ6tKIyHpdtu
 WUxZGXs4GCeeXgEoRWLT5p.PULkkxEUDJQsVI590IPBEt3eixl89HFrWH7.pwDE2KyWt1GkqNyzJ
 u62MosH64WCgJ0N7gSGwLhMrbOKWCBqWjb8.ddZFin9eF9lz2j6aK0NHqiDLm9NjGJfD2K5XeklT
 t7xMUuU9HqATBAroyPsxeer_8AUH5DshEagdDDpA44Dq4oB3F1rZeSjp1WA9QWw2Dyoiy6d5BGlE
 bfMGTtBLWepK8bGNbdJ2poyuHoF9SKZ6dVrnxC79kVZ7f9rpBpVSjvH2PFkOLyVBmLGxxNWeCXnb
 neQ8TO1TpzOFpyIWIM2yAUV1xRjV90OeW3ON.WdgICfwwWrgm1oGEWlIuWv6BmmMv7.VR44HnBol
 ngb8Lt5N5rYWSyLUIt8SLZyxtuVRMb83gbsEl8xPigpWr3OLNW7k8bb92IMVHNwy8x1ASF3oIKNp
 uC6W7wg17ps4kEW.7g8xIFrAYNe5idX54ShwwOpoqYf2lVGCjnnBSWuCF.2B4CQ35DJAinT.5kfE
 bLDh823cpPfdgn34_M2nuapO7nMD5eiyeGMd32p8hajbwct9QoJKLOQJ0SOoENn9jZMOxBPWXw5z
 c0NP0F60CKINpFnAuwURJfAtokuNBIqe_y6Y7ZAwQ.hj7kfoaATKZ8PdiEF2z3jbykkGguDI5Idy
 hGHHsrbHPskB8oy3xO5XEJlYKGuFm0FGEXgIjg6k_j8MqeDQ3mtvZoZQpToWJ1JtHkS5puFEbf0T
 IVdZUdhReVppjy1tGWkVMXQgi.GTdfTp725mu88ffivNftF5R66XwZbIi2RyIiegAKS0pHKzybRg
 t9hgGo4vVh60epQTHDLA8L7uWUW1p97PghdXcSV3CKh1vDGeuwzc7qvlWA2wPTPQNRq27teOGSh6
 C45kbyT1mxddumxM2P9p7uf8IKkTbEmuB9DMWKwKF76t1gkr8MhytRKCc5OjljcILHCUnyjrFsfv
 PhipaRDH9x.3oe8Fca6Smo7AwaSlbDqtOwK_9Ort.EdsvYvKb9z5UqT_mTlWmJjl2D7hVxRSxxdY
 vV.Kvun4.HwZD9S0NSqNdFGFsxYphHCtD8unxNXikUXphcFOBYR0sn4WHynk5ew7MCGLJ5U5.qDp
 .Klr0NQbiibHPwNC3l5DgEwz6VNPaOkOfxL7TsvGRQwaWHytubn6eQnSYsd4zAR7yQ0OC8IHRGcE
 6e4ryfk16H1VHl6U8Gv_IRba1_9fUpHZE20H8TgyEcblxTq5EaSix4nfsH4pTj7op58NKeXnz6k9
 ss1VBFulpcbafFhO_ahXKZx2K.MGFIkzpc.W1Y.xqwbLewf1eP4Qrp.5Oi.BLnxqtGoO.LcvmbHJ
 q8hcQ6ne57D479OpvZrKcNAtUCzdiEp.lzaxXk0.Qty6tS0FxbAy9EjHvJZ3L9mitkydUS3CzvlH
 047Am5vYgWWdlmNlBwXEA3qVOSjBRWcqLVVZv1BDkd0ZfUy26ZD3F4H8fpaAr5bF4tJdG_XYXYet
 BJ_IbZYi70f6N51IYqEIV0GI2WLc2jkqAUQ07h81vdN8MiUbXDG.5oub3GI11lDZztXVX9K_7UaW
 0imH9OeD6p5nQ
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:42:53 +0000
Received: by kubenode521.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 04ef0a30041a093d247185d7c5827f84;
          Mon, 13 Dec 2021 23:42:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v31 02/28] LSM: Infrastructure management of the sock security
Date:   Mon, 13 Dec 2021 15:40:08 -0800
Message-Id: <20211213234034.111891-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move management of the sock->sk_security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/apparmor/include/net.h   |  6 ++-
 security/apparmor/lsm.c           | 38 ++++-----------
 security/security.c               | 36 +++++++++++++-
 security/selinux/hooks.c          | 78 +++++++++++++++----------------
 security/selinux/include/objsec.h |  5 ++
 security/selinux/netlabel.c       | 23 ++++-----
 security/smack/smack.h            |  5 ++
 security/smack/smack_lsm.c        | 66 ++++++++++++--------------
 security/smack/smack_netfilter.c  |  4 +-
 10 files changed, 143 insertions(+), 119 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d45b6f6e27fd..89b8e40186f8 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1604,6 +1604,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
diff --git a/security/apparmor/include/net.h b/security/apparmor/include/net.h
index aadb4b29fb66..fac8999ba7a3 100644
--- a/security/apparmor/include/net.h
+++ b/security/apparmor/include/net.h
@@ -51,7 +51,11 @@ struct aa_sk_ctx {
 	struct aa_label *peer;
 };
 
-#define SK_CTX(X) ((X)->sk_security)
+static inline struct aa_sk_ctx *aa_sock(const struct sock *sk)
+{
+	return sk->sk_security + apparmor_blob_sizes.lbs_sock;
+}
+
 #define SOCK_ctx(X) SOCK_INODE(X)->i_security
 #define DEFINE_AUDIT_NET(NAME, OP, SK, F, T, P)				  \
 	struct lsm_network_audit NAME ## _net = { .sk = (SK),		  \
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 0d6585056f3d..343631e20c2b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -775,33 +775,15 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 	return error;
 }
 
-/**
- * apparmor_sk_alloc_security - allocate and attach the sk_security field
- */
-static int apparmor_sk_alloc_security(struct sock *sk, int family, gfp_t flags)
-{
-	struct aa_sk_ctx *ctx;
-
-	ctx = kzalloc(sizeof(*ctx), flags);
-	if (!ctx)
-		return -ENOMEM;
-
-	SK_CTX(sk) = ctx;
-
-	return 0;
-}
-
 /**
  * apparmor_sk_free_security - free the sk_security field
  */
 static void apparmor_sk_free_security(struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
-	SK_CTX(sk) = NULL;
 	aa_put_label(ctx->label);
 	aa_put_label(ctx->peer);
-	kfree(ctx);
 }
 
 /**
@@ -810,8 +792,8 @@ static void apparmor_sk_free_security(struct sock *sk)
 static void apparmor_sk_clone_security(const struct sock *sk,
 				       struct sock *newsk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
-	struct aa_sk_ctx *new = SK_CTX(newsk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
+	struct aa_sk_ctx *new = aa_sock(newsk);
 
 	if (new->label)
 		aa_put_label(new->label);
@@ -867,7 +849,7 @@ static int apparmor_socket_post_create(struct socket *sock, int family,
 		label = aa_get_current_label();
 
 	if (sock->sk) {
-		struct aa_sk_ctx *ctx = SK_CTX(sock->sk);
+		struct aa_sk_ctx *ctx = aa_sock(sock->sk);
 
 		aa_put_label(ctx->label);
 		ctx->label = aa_get_label(label);
@@ -1052,7 +1034,7 @@ static int apparmor_socket_shutdown(struct socket *sock, int how)
  */
 static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!skb->secmark)
 		return 0;
@@ -1065,7 +1047,7 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 static struct aa_label *sk_peer_label(struct sock *sk)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (ctx->peer)
 		return ctx->peer;
@@ -1149,7 +1131,7 @@ static int apparmor_socket_getpeersec_dgram(struct socket *sock,
  */
 static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!ctx->label)
 		ctx->label = aa_get_current_label();
@@ -1159,7 +1141,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				      struct request_sock *req)
 {
-	struct aa_sk_ctx *ctx = SK_CTX(sk);
+	struct aa_sk_ctx *ctx = aa_sock(sk);
 
 	if (!skb->secmark)
 		return 0;
@@ -1176,6 +1158,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
 	.lbs_file = sizeof(struct aa_file_ctx),
 	.lbs_task = sizeof(struct aa_task_ctx),
+	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1212,7 +1195,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(sk_alloc_security, apparmor_sk_alloc_security),
 	LSM_HOOK_INIT(sk_free_security, apparmor_sk_free_security),
 	LSM_HOOK_INIT(sk_clone_security, apparmor_sk_clone_security),
 
@@ -1764,7 +1746,7 @@ static unsigned int apparmor_ip_postroute(void *priv,
 	if (sk == NULL)
 		return NF_ACCEPT;
 
-	ctx = SK_CTX(sk);
+	ctx = aa_sock(sk);
 	if (!apparmor_secmark_check(ctx->label, OP_SENDMSG, AA_MAY_SEND,
 				    skb->secmark, sk))
 		return NF_ACCEPT;
diff --git a/security/security.c b/security/security.c
index 063c9cbbcea6..7f2bed1b2d6c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -29,6 +29,7 @@
 #include <linux/string.h>
 #include <linux/msg.h>
 #include <net/flow.h>
+#include <net/sock.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
@@ -204,6 +205,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
@@ -340,6 +342,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 
@@ -659,6 +662,28 @@ static int lsm_msg_msg_alloc(struct msg_msg *mp)
 	return 0;
 }
 
+/**
+ * lsm_sock_alloc - allocate a composite sock blob
+ * @sock: the sock that needs a blob
+ * @priority: allocation mode
+ *
+ * Allocate the sock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_sock_alloc(struct sock *sock, gfp_t priority)
+{
+	if (blob_sizes.lbs_sock == 0) {
+		sock->sk_security = NULL;
+		return 0;
+	}
+
+	sock->sk_security = kzalloc(blob_sizes.lbs_sock, priority);
+	if (sock->sk_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /**
  * lsm_early_task - during initialization allocate a composite task blob
  * @task: the task that needs a blob
@@ -2260,12 +2285,21 @@ EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	int rc = lsm_sock_alloc(sk, priority);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sk_alloc_security, 0, sk, family, priority);
+	if (unlikely(rc))
+		security_sk_free(sk);
+	return rc;
 }
 
 void security_sk_free(struct sock *sk)
 {
 	call_void_hook(sk_free_security, sk);
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62d30c0a30c2..90a140ea439d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4629,7 +4629,7 @@ static int socket_sockcreate_sid(const struct task_security_struct *tsec,
 
 static int sock_has_perm(struct sock *sk, u32 perms)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -4686,7 +4686,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
-		sksec = sock->sk->sk_security;
+		sksec = selinux_sock(sock->sk);
 		sksec->sclass = sclass;
 		sksec->sid = sid;
 		/* Allows detection of the first association on this socket */
@@ -4702,8 +4702,8 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 static int selinux_socket_socketpair(struct socket *socka,
 				     struct socket *sockb)
 {
-	struct sk_security_struct *sksec_a = socka->sk->sk_security;
-	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
+	struct sk_security_struct *sksec_a = selinux_sock(socka->sk);
+	struct sk_security_struct *sksec_b = selinux_sock(sockb->sk);
 
 	sksec_a->peer_sid = sksec_b->sid;
 	sksec_b->peer_sid = sksec_a->sid;
@@ -4718,7 +4718,7 @@ static int selinux_socket_socketpair(struct socket *socka,
 static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family;
 	int err;
 
@@ -4853,7 +4853,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 					 struct sockaddr *address, int addrlen)
 {
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 
 	err = sock_has_perm(sk, SOCKET__CONNECT);
@@ -5032,9 +5032,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 					      struct sock *other,
 					      struct sock *newsk)
 {
-	struct sk_security_struct *sksec_sock = sock->sk_security;
-	struct sk_security_struct *sksec_other = other->sk_security;
-	struct sk_security_struct *sksec_new = newsk->sk_security;
+	struct sk_security_struct *sksec_sock = selinux_sock(sock);
+	struct sk_security_struct *sksec_other = selinux_sock(other);
+	struct sk_security_struct *sksec_new = selinux_sock(newsk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	int err;
@@ -5066,8 +5066,8 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 static int selinux_socket_unix_may_send(struct socket *sock,
 					struct socket *other)
 {
-	struct sk_security_struct *ssec = sock->sk->sk_security;
-	struct sk_security_struct *osec = other->sk->sk_security;
+	struct sk_security_struct *ssec = selinux_sock(sock->sk);
+	struct sk_security_struct *osec = selinux_sock(other->sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 
@@ -5109,7 +5109,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 				       u16 family)
 {
 	int err = 0;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
@@ -5142,7 +5142,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
@@ -5210,13 +5210,15 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	return err;
 }
 
-static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-					    int __user *optlen, unsigned len)
+static int selinux_socket_getpeersec_stream(struct socket *sock,
+					    char __user *optval,
+					    int __user *optlen,
+					    unsigned int len)
 {
 	int err = 0;
 	char *scontext;
 	u32 scontext_len;
-	struct sk_security_struct *sksec = sock->sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sock->sk);
 	u32 peer_sid = SECSID_NULL;
 
 	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
@@ -5276,34 +5278,27 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
-	struct sk_security_struct *sksec;
-
-	sksec = kzalloc(sizeof(*sksec), priority);
-	if (!sksec)
-		return -ENOMEM;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
 	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
-	sk->sk_security = sksec;
 
 	return 0;
 }
 
 static void selinux_sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
-	sk->sk_security = NULL;
 	selinux_netlbl_sk_security_free(sksec);
-	kfree(sksec);
 }
 
 static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = sksec->sid;
 	newsksec->peer_sid = sksec->peer_sid;
@@ -5317,7 +5312,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 	if (!sk)
 		*secid = SECINITSID_ANY_SOCKET;
 	else {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		*secid = sksec->sid;
 	}
@@ -5327,7 +5322,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
 	struct inode_security_struct *isec =
 		inode_security_novalidate(SOCK_INODE(parent));
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
 	    sk->sk_family == PF_UNIX)
@@ -5342,7 +5337,7 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 static int selinux_sctp_assoc_request(struct sctp_association *asoc,
 				      struct sk_buff *skb)
 {
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	struct common_audit_data ad;
 	struct lsm_network_audit net = {0,};
 	u8 peerlbl_active;
@@ -5493,8 +5488,8 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk,
 				  struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	/* If policy does not support SECCLASS_SCTP_SOCKET then call
 	 * the non-sctp clone version.
@@ -5511,7 +5506,7 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 				     struct request_sock *req)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	int err;
 	u16 family = req->rsk_ops->family;
 	u32 connsid;
@@ -5532,7 +5527,7 @@ static int selinux_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void selinux_inet_csk_clone(struct sock *newsk,
 				   const struct request_sock *req)
 {
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->sid = req->secid;
 	newsksec->peer_sid = req->peer_secid;
@@ -5549,7 +5544,7 @@ static void selinux_inet_csk_clone(struct sock *newsk,
 static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
 {
 	u16 family = sk->sk_family;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* handle mapped IPv4 packets arriving via IPv6 sockets */
 	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
@@ -5633,7 +5628,7 @@ static int selinux_tun_dev_attach_queue(void *security)
 static int selinux_tun_dev_attach(struct sock *sk, void *security)
 {
 	struct tun_security_struct *tunsec = security;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	/* we don't currently perform any NetLabel based labeling here and it
 	 * isn't clear that we would want to do so anyway; while we could apply
@@ -5762,7 +5757,7 @@ static unsigned int selinux_ip_output(void *priv, struct sk_buff *skb,
 			return NF_ACCEPT;
 
 		/* standard practice, label using the parent socket */
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		sid = sksec->sid;
 	} else
 		sid = SECINITSID_KERNEL;
@@ -5785,7 +5780,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	sk = skb_to_full_sk(skb);
 	if (sk == NULL)
 		return NF_ACCEPT;
-	sksec = sk->sk_security;
+	sksec = selinux_sock(sk);
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -5878,7 +5873,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 		u32 skb_sid;
 		struct sk_security_struct *sksec;
 
-		sksec = sk->sk_security;
+		sksec = selinux_sock(sk);
 		if (selinux_skb_peerlbl_sid(skb, family, &skb_sid))
 			return NF_DROP;
 		/* At this point, if the returned skb peerlbl is SECSID_NULL
@@ -5907,7 +5902,7 @@ static unsigned int selinux_ip_postroute(void *priv,
 	} else {
 		/* Locally generated packet, fetch the security label from the
 		 * associated socket. */
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 		peer_sid = sksec->sid;
 		secmark_perm = PACKET__SEND;
 	}
@@ -5956,7 +5951,7 @@ static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
 	unsigned int data_len = skb->len;
 	unsigned char *data = skb->data;
 	struct nlmsghdr *nlh;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	u16 sclass = sksec->sclass;
 	u32 perm;
 
@@ -6956,6 +6951,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
 };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2953132408bf..007d1ae7ee27 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -194,4 +194,9 @@ static inline struct superblock_security_struct *selinux_superblock(
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
+{
+	return sock->sk_security + selinux_blob_sizes.lbs_sock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 1321f15799e2..800ab4b4239e 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -17,6 +17,7 @@
 #include <linux/gfp.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/netlabel.h>
 #include <net/ip.h>
@@ -68,7 +69,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (sksec->nlbl_secattr != NULL)
@@ -101,7 +102,7 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
 							const struct sock *sk,
 							u32 sid)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
 
 	if (secattr == NULL)
@@ -236,7 +237,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	 * being labeled by it's parent socket, if it is just exit */
 	sk = skb_to_full_sk(skb);
 	if (sk != NULL) {
-		struct sk_security_struct *sksec = sk->sk_security;
+		struct sk_security_struct *sksec = selinux_sock(sk);
 
 		if (sksec->nlbl_state != NLBL_REQSKB)
 			return 0;
@@ -274,7 +275,7 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
-	struct sk_security_struct *sksec = asoc->base.sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(asoc->base.sk);
 	struct sockaddr_in addr4;
 	struct sockaddr_in6 addr6;
 
@@ -355,7 +356,7 @@ int selinux_netlbl_inet_conn_request(struct request_sock *req, u16 family)
  */
 void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (family == PF_INET)
 		sksec->nlbl_state = NLBL_LABELED;
@@ -373,8 +374,8 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
  */
 void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
-	struct sk_security_struct *newsksec = newsk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
+	struct sk_security_struct *newsksec = selinux_sock(newsk);
 
 	newsksec->nlbl_state = sksec->nlbl_state;
 }
@@ -392,7 +393,7 @@ void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
 int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	if (family != PF_INET && family != PF_INET6)
@@ -507,7 +508,7 @@ int selinux_netlbl_socket_setsockopt(struct socket *sock,
 {
 	int rc = 0;
 	struct sock *sk = sock->sk;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr secattr;
 
 	if (selinux_netlbl_option(level, optname) &&
@@ -545,7 +546,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 						struct sockaddr *addr)
 {
 	int rc;
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 	struct netlbl_lsm_secattr *secattr;
 
 	/* connected sockets are allowed to disconnect when the address family
@@ -584,7 +585,7 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 int selinux_netlbl_socket_connect_locked(struct sock *sk,
 					 struct sockaddr *addr)
 {
-	struct sk_security_struct *sksec = sk->sk_security;
+	struct sk_security_struct *sksec = selinux_sock(sk);
 
 	if (sksec->nlbl_state != NLBL_REQSKB &&
 	    sksec->nlbl_state != NLBL_CONNLABELED)
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99c3422596ab..66b813e15196 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -363,6 +363,11 @@ static inline struct superblock_smack *smack_superblock(
 	return superblock->s_security + smack_blob_sizes.lbs_superblock;
 }
 
+static inline struct socket_smack *smack_sock(const struct sock *sock)
+{
+	return sock->sk_security + smack_blob_sizes.lbs_sock;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index efd35b07c7f8..db72debca070 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1434,7 +1434,7 @@ static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
 		if (sock == NULL || sock->sk == NULL)
 			return -EOPNOTSUPP;
 
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 
 		if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 			isp = ssp->smk_in;
@@ -1817,7 +1817,7 @@ static int smack_file_receive(struct file *file)
 
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
@@ -2238,11 +2238,7 @@ static void smack_task_to_inode(struct task_struct *p, struct inode *inode)
 static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 {
 	struct smack_known *skp = smk_of_current();
-	struct socket_smack *ssp;
-
-	ssp = kzalloc(sizeof(struct socket_smack), gfp_flags);
-	if (ssp == NULL)
-		return -ENOMEM;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Sockets created by kernel threads receive web label.
@@ -2256,11 +2252,10 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
 	}
 	ssp->smk_packet = NULL;
 
-	sk->sk_security = ssp;
-
 	return 0;
 }
 
+#ifdef SMACK_IPV6_PORT_LABELING
 /**
  * smack_sk_free_security - Free a socket blob
  * @sk: the socket
@@ -2269,7 +2264,6 @@ static int smack_sk_alloc_security(struct sock *sk, int family, gfp_t gfp_flags)
  */
 static void smack_sk_free_security(struct sock *sk)
 {
-#ifdef SMACK_IPV6_PORT_LABELING
 	struct smk_port_label *spp;
 
 	if (sk->sk_family == PF_INET6) {
@@ -2282,9 +2276,8 @@ static void smack_sk_free_security(struct sock *sk)
 		}
 		rcu_read_unlock();
 	}
-#endif
-	kfree(sk->sk_security);
 }
+#endif
 
 /**
 * smack_ipv4host_label - check host based restrictions
@@ -2397,7 +2390,7 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
  */
 static int smack_netlbl_add(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = ssp->smk_out;
 	int rc;
 
@@ -2429,7 +2422,7 @@ static int smack_netlbl_add(struct sock *sk)
  */
 static void smack_netlbl_delete(struct sock *sk)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 
 	/*
 	 * Take the label off the socket if one is set.
@@ -2461,7 +2454,7 @@ static int smk_ipv4_check(struct sock *sk, struct sockaddr_in *sap)
 	struct smack_known *skp;
 	int rc = 0;
 	struct smack_known *hkp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
 
 	rcu_read_lock();
@@ -2534,7 +2527,7 @@ static void smk_ipv6_port_label(struct socket *sock, struct sockaddr *address)
 {
 	struct sock *sk = sock->sk;
 	struct sockaddr_in6 *addr6;
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smk_port_label *spp;
 	unsigned short port = 0;
 
@@ -2622,7 +2615,7 @@ static int smk_ipv6_port_check(struct sock *sk, struct sockaddr_in6 *address,
 				int act)
 {
 	struct smk_port_label *spp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	unsigned short port;
 	struct smack_known *object;
@@ -2716,7 +2709,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	if (sock == NULL || sock->sk == NULL)
 		return -EOPNOTSUPP;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 
 	if (strcmp(name, XATTR_SMACK_IPIN) == 0)
 		ssp->smk_in = skp;
@@ -2764,7 +2757,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	 * Sockets created by kernel threads receive web label.
 	 */
 	if (unlikely(current->flags & PF_KTHREAD)) {
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		ssp->smk_in = &smack_known_web;
 		ssp->smk_out = &smack_known_web;
 	}
@@ -2789,8 +2782,8 @@ static int smack_socket_post_create(struct socket *sock, int family,
 static int smack_socket_socketpair(struct socket *socka,
 		                   struct socket *sockb)
 {
-	struct socket_smack *asp = socka->sk->sk_security;
-	struct socket_smack *bsp = sockb->sk->sk_security;
+	struct socket_smack *asp = smack_sock(socka->sk);
+	struct socket_smack *bsp = smack_sock(sockb->sk);
 
 	asp->smk_packet = bsp->smk_out;
 	bsp->smk_packet = asp->smk_out;
@@ -2853,7 +2846,7 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
 		if (__is_defined(SMACK_IPV6_SECMARK_LABELING))
 			rsp = smack_ipv6host_label(sip);
 		if (rsp != NULL) {
-			struct socket_smack *ssp = sock->sk->sk_security;
+			struct socket_smack *ssp = smack_sock(sock->sk);
 
 			rc = smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
@@ -3584,9 +3577,9 @@ static int smack_unix_stream_connect(struct sock *sock,
 {
 	struct smack_known *skp;
 	struct smack_known *okp;
-	struct socket_smack *ssp = sock->sk_security;
-	struct socket_smack *osp = other->sk_security;
-	struct socket_smack *nsp = newsk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock);
+	struct socket_smack *osp = smack_sock(other);
+	struct socket_smack *nsp = smack_sock(newsk);
 	struct smk_audit_info ad;
 	int rc = 0;
 #ifdef CONFIG_AUDIT
@@ -3632,8 +3625,8 @@ static int smack_unix_stream_connect(struct sock *sock,
  */
 static int smack_unix_may_send(struct socket *sock, struct socket *other)
 {
-	struct socket_smack *ssp = sock->sk->sk_security;
-	struct socket_smack *osp = other->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
+	struct socket_smack *osp = smack_sock(other->sk);
 	struct smk_audit_info ad;
 	int rc;
 
@@ -3670,7 +3663,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	struct sockaddr_in6 *sap = (struct sockaddr_in6 *) msg->msg_name;
 #endif
 #ifdef SMACK_IPV6_SECMARK_LABELING
-	struct socket_smack *ssp = sock->sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sock->sk);
 	struct smack_known *rsp;
 #endif
 	int rc = 0;
@@ -3882,7 +3875,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
 	netlbl_secattr_init(&secattr);
 
 	if (sk)
-		ssp = sk->sk_security;
+		ssp = smack_sock(sk);
 
 	if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 		skp = smack_from_secattr(&secattr, ssp);
@@ -3904,7 +3897,7 @@ static struct smack_known *smack_from_netlbl(const struct sock *sk, u16 family,
  */
 static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp = NULL;
 	int rc = 0;
 	struct smk_audit_info ad;
@@ -4008,7 +4001,7 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
 	int slen = 1;
 	int rc = 0;
 
-	ssp = sock->sk->sk_security;
+	ssp = smack_sock(sock->sk);
 	if (ssp->smk_packet != NULL) {
 		rcp = ssp->smk_packet->smk_known;
 		slen = strlen(rcp) + 1;
@@ -4057,7 +4050,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 
 	switch (family) {
 	case PF_UNIX:
-		ssp = sock->sk->sk_security;
+		ssp = smack_sock(sock->sk);
 		s = ssp->smk_out->smk_secid;
 		break;
 	case PF_INET:
@@ -4106,7 +4099,7 @@ static void smack_sock_graft(struct sock *sk, struct socket *parent)
 	    (sk->sk_family != PF_INET && sk->sk_family != PF_INET6))
 		return;
 
-	ssp = sk->sk_security;
+	ssp = smack_sock(sk);
 	ssp->smk_in = skp;
 	ssp->smk_out = skp;
 	/* cssp->smk_packet is already set in smack_inet_csk_clone() */
@@ -4126,7 +4119,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 {
 	u16 family = sk->sk_family;
 	struct smack_known *skp;
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct sockaddr_in addr;
 	struct iphdr *hdr;
 	struct smack_known *hskp;
@@ -4212,7 +4205,7 @@ static int smack_inet_conn_request(const struct sock *sk, struct sk_buff *skb,
 static void smack_inet_csk_clone(struct sock *sk,
 				 const struct request_sock *req)
 {
-	struct socket_smack *ssp = sk->sk_security;
+	struct socket_smack *ssp = smack_sock(sk);
 	struct smack_known *skp;
 
 	if (req->peer_secid != 0) {
@@ -4748,6 +4741,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
@@ -4858,7 +4852,9 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(socket_getpeersec_stream, smack_socket_getpeersec_stream),
 	LSM_HOOK_INIT(socket_getpeersec_dgram, smack_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sk_alloc_security, smack_sk_alloc_security),
+#ifdef SMACK_IPV6_PORT_LABELING
 	LSM_HOOK_INIT(sk_free_security, smack_sk_free_security),
+#endif
 	LSM_HOOK_INIT(sock_graft, smack_sock_graft),
 	LSM_HOOK_INIT(inet_conn_request, smack_inet_conn_request),
 	LSM_HOOK_INIT(inet_csk_clone, smack_inet_csk_clone),
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index b945c1d3a743..bad71b7e648d 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,8 +26,8 @@ static unsigned int smack_ip_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (sk && sk->sk_security) {
-		ssp = sk->sk_security;
+	if (sk) {
+		ssp = smack_sock(sk);
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
-- 
2.31.1

