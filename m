Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137CC473960
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244425AbhLNAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:10:32 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:36098
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244415AbhLNAKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440631; bh=rWTuUIAY8sGCwcNu7t1nRlYDj4aZvxMbuFNjr+lx5KE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fj1CwNhC6RmtH1X902Vq0lXB/kKEbd1zC+cxT5Z0d2D8o3qZ21PJNT0bfAswP6q3JhqNqwwS1x2DfwgezDFDiXQiu7RFSXePY8ifyEedily//6Jsg31BKlNEJahz4D7jTtCMJVBIh5l3hRwUak1FkJO9ZgVC0IyerIbbkyhJFXU0M9Bcz6rH580vr4mZT+d1+febuwWNciS5AOt1kz62Iu1eekpGCAVeF51UoAjvXA6lcSA9nyba/KemqnqPGjjN6XHgPpUtEudvoLfca2BuGODb4OCK+iYIi92/MdygqVxFO8JW1lJICarxYoUo3BwtGkOM7zHls1BRqgSAGme1Rw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639440631; bh=u2zsBOHNwkVkez89hI/X2NLCTM1MksSWFWckZbcynAR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YFn3l6WWi+SBW5cWb0e0vxCOSBDa6xaStucWFHp5MtBFeK/Hv99nqSeix9AZgaPRG6rrUMWPInH6GJd8DUXjTCRc7oEoFMyT5tv+eA1Uli426RuZHtMue3pCIaP1LGv5MfPRtCvvwzzynROAs1hWsh8nQxPMuV6xprbzUrHBvDdGiCCSzB+sjIlWN9HkGxL1KVGBpHLfFp5rfz4q8VoVseneQfHN9pnwIH1lNIoaKszV+DMcPhy3bdBAdk8bgSaxmY9ZEq+lMHRc/0aszaa5FgKdYbwNG4S2B5qtGS6/tym0LYkVhI/8T/92O8mQMiMgOVt8JTRRg/Aroi3lhiZFRw==
X-YMail-OSG: cLvgcScVM1mmG6tTKxNSk5zh4PgU8vtFAJzp2smHiyLebVIhsfTMb8aRoBa3ERM
 m31bNBTMMieooHa2DjsbeaOSCfol_puflqsNfEzua_IJ4dfWq1LZkMWrUz72DFDWelnFYQybOe47
 EQBA_nAA_GlJMZTNrnAqBQqzuKuW2no804kAsdP_B8.aS1.mLFF5irKn4JDHmyGj_b3oFy2SfArf
 9FhbubbbRA0Db3okW0bpDz7w3S2wPOLwSbTeS5mjSrGGOAAo8ekHeo14Ld19J5AyYNlRwaHioLEz
 zdR_E2ZTWDIF4cFL_0.1iXwCOHlDVzQ6xSaN.oc0R1E6pE63ZUiWAHChyDtqLJZq.2JD_yRF44Ar
 3.oCslMNUacHpvVfdc7qF6r7V6YUt1Snms8u2pFfG.U4G9AAe6kBIALCzKujCtywpkS9.pz.rf03
 klFe3sCRfzCjz4MGWyXG0heIV6Z5.kTPwjl0NHnvEy3vDKvGF._gtpjC5TJFF03jwSs3wF9FKQH9
 yMQvFsn5S.wT6N0.RzBH.XZm4IxxejIc_jYamYlU3LYVsJ8OBKXk7BUeoVWbTj_AN7vLEo5HmLbt
 sGTDlo.Tx7dQWzQJHpmO0.dxGJ9MrAiJPbrPHVedExN5ATJMbDSDCYvuC7.LlydxWrf_yXSsVkwD
 qNE9pIpNpoVIaDFljzQ6Q9218O9O.t_B7c.fGKRHC6oJKQ0KrYagrJb0egINzKnuE4Xx52iA_s2_
 X55c3fow1lztb8jRP.AyTOTqSOrLSpn3JEYfSE3ZsBiuKDII5Kl17IX1CzWJDCNuQEHvbuiVsXo5
 HA..dOf2sPfTTW_imZ0Ayn_PsVYVEkxIQkLrkJUui6_nruSO_QMaGl119JU7R7zClsejlwIJkZXL
 XYDsS.xd1O.IJ3O0q7BH76kRpYImVNNEJiliy9bEEkCETGc8ImSJk3.t6Bt1WOc4xWeMvDp5LglK
 BVs22Mw6yq2DqGgU1Fo8iavMuQUzDJTaeEWJ38qqqrvJ0BMPNpP8Wy007maxtC_gUhmnlFhL5ZJJ
 t9CYmpyjB16M_pYNersNsBelB7vqzJl52jPYY.jCbGhtfFnmJzSbU9ikpFm53zGN_YgmLFyXKgwa
 cMO2RWpsRi2SBjUCm3JC78ZitytMFcfLND_8HqMG6kZJLQGICHAl09yKBD.v6rVH_.diDiYDG7Pg
 LltxQp2RmqDyPWYDjWChJOtFHVulTS6vzRlw3ksA8.rjFWJ4lKt4EZN1tmUT9f13dRRQ.D_k6VhA
 eSgDHEFBslegukabt.f9Xzh.riXNqKQ8HqC7hdUbK3c0.GF4nmtCAUdAfMStX4orSMwZmHrrKq7E
 6bnq7f_y3ITTXm5qke8_k62ZkLyPaXsll3QIvVS935vI8_ChU_tB0V4BG2TPi4o1W28tL0eJMIhP
 .6Uo0RVHTkHccWh7v.3ykuk_s9leFrUsGpwfdetQTPw90oa6JbLP24PQbAzb2aQbgMUH_K0xDS1k
 FcODM2SvlkddbE33MVYVRcOSNFlxBYiiT_VR8MLmeqk207golXRW4kpVV0H0vbivjyAQRB7Kah4a
 K4MljuJNGCEFUHaeLqvpOH9wDzMP0HKQRRFoRaDBkpzZYwkeQFAw00t9EvjBjjITwXFsQN0XL7bB
 lzY8sN0WPMsmwfo19nt2n_DTeGVY1czOtMINXPKHjszbAtC7RTJBFw2dLgSXNsLC9Pz8sTD_u3Z2
 Bs8uL65u7fQzwbv6a4wDtTo0MfJiPusleusLsri0Z7qo28knX0YkaAMUjAmmNLpyyQ1gWPYIduij
 vpbWtQywRl5VRbOREAcQYfPel1hNROoWR4_7Ko1M.IXzoPX1pyuRQuLiIH55RsoygBLnIzYikt5H
 y6aE1Z.L59FuHClytPmc16Z9dkvZof8ZBk4XhGCsj5zPVdPxGL4xG13iphvxke7qPKLU2FfHVrPQ
 dBUd8yZZxoVLKl4E6.ZFEWwMGzkKKgFetfPXWidV_l.TUzl9Mxr7NEIKS6hamHm0TnUY0M6Wn_xB
 jzM_bEUQtVkHk8JbGUTq45aSIi9JvA8OC3EfxS7nGiY6AMu5AXUAm8o1I4ZfCo5PByykyeIqXXL1
 IE6EPLT2xil6Tg4hIfqZA0YuSJ7_HiBTdtUq8eDCAH_hjVQXgihv_acvlKj6m5XZ4gUjUjokMUay
 qdahzRukhDF4SRnqksx0x8yz9e1EYsTaBTZOiebXyUBYM526mt.f58uMivel_mO6oPcSPzCZ0dG9
 s8LN52LUh1.DoLzdcRRk_bFiQu1XQrTcN8CWpJIbf2zIqnMAit6agilOr6XgZ9LPkEabGcnUkUfa
 sW4wFMWJ4ZtW_vd5wEiA_
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Dec 2021 00:10:31 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5808045f7f7a4ebb3074d4165fc760fa;
          Tue, 14 Dec 2021 00:10:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v31 27/28] LSM: Add /proc attr entry for full LSM context
Date:   Mon, 13 Dec 2021 15:40:33 -0800
Message-Id: <20211213234034.111891-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

A security module may decide that its policy does not allow
this information to be displayed. In this case none of the
information will be displayed.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/security/lsm.rst       | 14 +++++
 fs/proc/base.c                       |  1 +
 include/linux/lsm_hooks.h            |  6 +++
 security/apparmor/include/procattr.h |  2 +-
 security/apparmor/lsm.c              |  8 ++-
 security/apparmor/procattr.c         | 22 ++++----
 security/security.c                  | 79 ++++++++++++++++++++++++++++
 security/selinux/hooks.c             |  2 +-
 security/smack/smack_lsm.c           |  2 +-
 9 files changed, 121 insertions(+), 15 deletions(-)

diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index b77b4a540391..070225ae6ceb 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -143,3 +143,17 @@ separated list of the active security modules.
 The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
 module for which the ``/proc/pid/attr/current`` interface will
 apply. This interface can be written to.
+
+The infrastructure does provide an interface for the special
+case where multiple security modules provide a process context.
+This is provided in compound context format.
+
+-  `lsm\0value\0lsm\0value\0`
+
+The `lsm` and `value` fields are NUL-terminated bytestrings.
+Each field may contain whitespace or non-printable characters.
+The NUL bytes are included in the size of a compound context.
+The context ``Bell\0Secret\0Biba\0Loose\0`` has a size of 23.
+
+The file ``/proc/pid/attr/context`` provides the security
+context of the identified process.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 50dbe5612a26..c90022027357 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2829,6 +2829,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 490545f0db6d..b919d5ab9120 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1400,6 +1400,12 @@
  *	@pages contains the number of pages.
  *	Return 0 if permission is granted.
  *
+ * @getprocattr:
+ *	Provide the named process attribute for display in special files in
+ *	the /proc/.../attr directory.  Attribute naming and the data displayed
+ *	is at the discretion of the security modules.  The exception is the
+ *	"context" attribute, which will contain the security context of the
+ *	task as a nul terminated text string without trailing whitespace.
  * @ismaclabel:
  *	Check if the extended attribute specified by @name
  *	represents a MAC label. Returns 1 if name is a MAC
diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
index 31689437e0e1..03dbfdb2f2c0 100644
--- a/security/apparmor/include/procattr.h
+++ b/security/apparmor/include/procattr.h
@@ -11,7 +11,7 @@
 #ifndef __AA_PROCATTR_H
 #define __AA_PROCATTR_H
 
-int aa_getprocattr(struct aa_label *label, char **string);
+int aa_getprocattr(struct aa_label *label, char **string, bool newline);
 int aa_setprocattr_changehat(char *args, size_t size, int flags);
 
 #endif /* __AA_PROCATTR_H */
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5ed40fd93ce9..28ed41a3ffcf 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -602,6 +602,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -609,11 +610,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 		label = aa_get_newest_label(ctx->previous);
 	else if (strcmp(name, "exec") == 0 && ctx->onexec)
 		label = aa_get_newest_label(ctx->onexec);
-	else
+	else if (strcmp(name, "context") == 0) {
+		label = aa_get_newest_label(cred_label(cred));
+		newline = false;
+	} else
 		error = -EINVAL;
 
 	if (label)
-		error = aa_getprocattr(label, value);
+		error = aa_getprocattr(label, value, newline);
 
 	aa_put_label(label);
 	put_cred(cred);
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index fde332e0ea7d..172550f67fc0 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -20,6 +20,7 @@
  * aa_getprocattr - Return the profile information for @profile
  * @profile: the profile to print profile info about  (NOT NULL)
  * @string: Returns - string containing the profile info (NOT NULL)
+ * @newline: Should a newline be added to @string.
  *
  * Requires: profile != NULL
  *
@@ -28,20 +29,21 @@
  *
  * Returns: size of string placed in @string else error code on failure
  */
-int aa_getprocattr(struct aa_label *label, char **string)
+int aa_getprocattr(struct aa_label *label, char **string, bool newline)
 {
 	struct aa_ns *ns = labels_ns(label);
 	struct aa_ns *current_ns = aa_get_current_ns();
+	int flags = FLAG_VIEW_SUBNS | FLAG_HIDDEN_UNCONFINED;
 	int len;
 
 	if (!aa_ns_visible(current_ns, ns, true)) {
 		aa_put_ns(current_ns);
 		return -EACCES;
 	}
+	if (newline)
+		flags |= FLAG_SHOW_MODE;
 
-	len = aa_label_snxprint(NULL, 0, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(NULL, 0, current_ns, label, flags);
 	AA_BUG(len < 0);
 
 	*string = kmalloc(len + 2, GFP_KERNEL);
@@ -50,19 +52,19 @@ int aa_getprocattr(struct aa_label *label, char **string)
 		return -ENOMEM;
 	}
 
-	len = aa_label_snxprint(*string, len + 2, current_ns, label,
-				FLAG_SHOW_MODE | FLAG_VIEW_SUBNS |
-				FLAG_HIDDEN_UNCONFINED);
+	len = aa_label_snxprint(*string, len + 2, current_ns, label, flags);
 	if (len < 0) {
 		aa_put_ns(current_ns);
 		return len;
 	}
 
-	(*string)[len] = '\n';
-	(*string)[len + 1] = 0;
+	if (newline) {
+		(*string)[len] = '\n';
+		(*string)[++len] = 0;
+	}
 
 	aa_put_ns(current_ns);
-	return len + 1;
+	return len;
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index a1dec90d7757..26b6cc0ee64b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -802,6 +802,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
 	return 0;
 }
 
+/**
+ * append_ctx - append a lsm/context pair to a compound context
+ * @ctx: the existing compound context
+ * @ctxlen: size of the old context, including terminating nul byte
+ * @lsm: new lsm name, nul terminated
+ * @new: new context, possibly nul terminated
+ * @newlen: maximum size of @new
+ *
+ * replace @ctx with a new compound context, appending @newlsm and @new
+ * to @ctx. On exit the new data replaces the old, which is freed.
+ * @ctxlen is set to the new size, which includes a trailing nul byte.
+ *
+ * Returns 0 on success, -ENOMEM if no memory is available.
+ */
+static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
+		      int newlen)
+{
+	char *final;
+	size_t llen;
+	size_t nlen;
+	size_t flen;
+
+	llen = strlen(lsm) + 1;
+	/*
+	 * A security module may or may not provide a trailing nul on
+	 * when returning a security context. There is no definition
+	 * of which it should be, and there are modules that do it
+	 * each way.
+	 */
+	nlen = strnlen(new, newlen);
+
+	flen = *ctxlen + llen + nlen + 1;
+	final = kzalloc(flen, GFP_KERNEL);
+
+	if (final == NULL)
+		return -ENOMEM;
+
+	if (*ctxlen)
+		memcpy(final, *ctx, *ctxlen);
+
+	memcpy(final + *ctxlen, lsm, llen);
+	memcpy(final + *ctxlen + llen, new, nlen);
+
+	kfree(*ctx);
+
+	*ctx = final;
+	*ctxlen = flen;
+
+	return 0;
+}
+
 /*
  * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
  * can be accessed with:
@@ -2207,6 +2258,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2234,6 +2289,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "context", &cp);
+			if (rc == -EINVAL)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			kfree(cp);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6f790d96594d..cbacfdabbc30 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6399,7 +6399,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9832b5e5c9fd..e5437d72699b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3486,7 +3486,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.31.1

