Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A555F4D5651
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 01:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345152AbiCKAC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbiCKACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:02:16 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901131A06D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956873; bh=MZ4vJagyUghLy0nswAC0kHp8cwcJQt/yZ0z4gmY7kX4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ig70eH/rEFJhyxDGoupbVviuyoFnOaJY9wFPJ7PuuuVGLfxrv8nk2ZjQjCTyrQDd8xAa4eBst7oC3/K3A5rtz3gVIEXPlXrlVH2U+RyP1HZdC2DGwPgsD6tHbg0JnRikLl74VuU9RfYD7vGLrpOWiMxtpyb/w+L0bbHx2hR63mIfuAyjVUPe+K3Htko3eL1Eh5d/l3zIc3I0KNSxqMnZZMGhmib0SSZcLT8PGTfQ2KslBw66RtOUETgmMaM8270ma+GIrBUIitOaT/JHMrm5EASCV45piTm72vZm6xiw3iq0mg+pGCtY2qhm/gyDateAm2z9Fnr/qWHOd4jfKCk9dQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956873; bh=vGRJHIJZSYEWXZlx5Fvz+ng1B2+1tOzbyPFQtvPAr/N=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=b342qMk8gwDDob3788lmsbuknJ0sYtEKRR6TiWTlWWRnYTiR3QIwPEMd68P0wNzvsoalYBZ5KGfU22jkqN8Q7BeHn1VWokeT3leegwf0FRtXAry0vls7Pjok06/DNXL/4VSsG+2LzgYAyKoF3BlUfUe2gwqNsa5sta8w+YoFe/jroxWafG2CZpC6QTqkEjoXb3td67M52nEzhykjCZpNXoIQqB0OimBHa3iKI1Q0b6I20CwQmFo274thPnIeT5RAyWkkKQnMDTibdpJOcxItBhDwvmXa5anRWbHkbPPr4pDHRXMV5dkB1HryWlBDuPYlBG380995ILtDbEpq7JWYew==
X-YMail-OSG: ntLwRWIVM1mIgPib9dDCnnNQqzt20f6uYeRl_KbRsrElABaFsreDF4THjv9TfF7
 8Y3E7ONDGOUWJUKEOfGkC6GHfMeoH_pV4eUC7YAnHyX1mCJbKkceCBv6ixLpfamg7t8YuIFWKcZr
 jC6k8_QXSJUqC0hUkjGftvxou.umkYEOcLxtPVMts3gDrajwBaNZC0ZaZmpTcJAY6jqnirLs7PKL
 13OA7qJjt8o1mabWj67nUwbKxReEEp0auVCU0hY6QWRr2SMH0PFv4Ton_DKTusjAyeYCh5fypMSD
 mI0ySeTZvpb852RaoXGwn.mnj99ZmEhMocJltdY06JUGv2v0xVFkRw8xaQy6iiVIH8QtqfZJ7Eup
 fh91AqOioMb_uhJN7P9OdjIDCVbB6C5O30X8kQgK2YLVWgKtSkW.UajRztcPZ76ToA5zzBZYegR7
 RxvO2vLCaZCVQxUM9f2mTWSDdMO9heD4sw0A1HjbVFMomQ9zVa4oLE2u_htoxPh5PkzvEEehIIYu
 2diwtIPjBNUqYrAKE4WSx.iv7lyrsVhMOGILyrUG7bQqnHC07tZ.PJD8fOmBpOt1_wyskzrZHnl6
 WnlZo3kPFYXbFUuUNxs1IP0Jv.bKHHzkEHGDKNbhK3nx_G74tcvW2nt993ATQGoCnFfd85EJcohR
 ADn9nR.4K4jgRorkRV5A9j0zSdaS9tiUUOJmCOP8xUWlVHaSF9TgXnSxf_Hu_2nUxsWVKrxL9XLK
 3KGSmWc4.aRK0WYQ5pX3opDUsQ0ZDvFsuqjS6.lBxqAHVpfCNjzCn5fc9X_avLuq3bb1QGSm9GDB
 Isjv3DGX1IQUGTuQRdnbIo_fWa76BXkeTIa9ZJROYjXRm3uCdDZ0ydhRaUAMkGMn.aIJI.J_XUKH
 pyl0IhczSeLWTyr_W5nlNtFZ_wEWs81P_q0Q9G75kSiEBZ5k.kAZYznFqiq.8FWIln8kjo5_F8Q.
 9uyf7TSccTMlgjA43IxfNyFOAM7rfdCzyw49Y.mtJcuECeTQSLa78.K2ftugK0uA9AitImPHQSmT
 VXVkzieeghLVHIUgahNRA4TGFbCYrqz2Wp0mUpgBKQow4KUapOZTn5OcKzp_t2OgnxX0x4HOg5zS
 GPSpi3k3vn7G1jQQOj8bCKuUMNJyDYwziNtgA4KombnhX4pcoXMpcQr3xMikpR.FlkX5itah0tK2
 si8wo69YhzeQqe_5Q8hG83IdO4UVUtUkqxmJhrzKNRLvHBez7vRHnoYBrrWWMZ6Oj4mnaYA.yEfg
 dQT171w43OhesGRhZClRCrkNXlrYID6wXdR7MFHvmEEQX4PyYT4ec0sEq4161srT5nUaTIUGisVj
 SwZAjTVMhsNL75pfkaCsMYCi87kKcNf1wPoJcOhAzIJt7tE5wKAk8ozCQbncTp_7Gn8ahZAYOFP8
 TV8cKOCETPmEC3niKS6URLUxL_fTBrJhIFe5Og596xPM_cznUxyGK13dMe6xNtjBSyUn8DRXjLmZ
 YulUsXmxGtVukXv9x.yu3e8PGuKiZTg3Oj_204BPYbpK0dB1Ngk.jCqc6t39H1R7DrbzZ1z9Bk8p
 EgFpsfmk6RA.v.x5oURHTjsuyEjCk1SclfGhFCLrU6Bx.y9u4.iDxlnwdSY_Xk15SXz61dNPVmBG
 qtgU6qkKqZHPWm969UDBSvySXp06KbCBtCZ5nnSCSaFedMA3YT3mJc1vkj4q.0nUyMk0ByNtJGWW
 EPvoc3y9gz7fOf6vU5IRrOhTMR4j3mJkLei1mrxzpyGT9KveJfBFjCLDkJObejUBmqklLoG8Xqw3
 qWyiFfAZHyHrVvTDCqtw8dCdXQE93vys3BOdM3BjmKuTccy3s1DgBq5xqSU11xuzIDmUJmYMytAj
 V7iw4guRu5fN8mkX_HeYmGEO174T.QyvM8ndKi.mL5X7.B_R70uHWvd8GsH0haWEeUGXqzrdJix7
 qQcr5vgX9XVxLe62T7J8FzlSJeIIQ1byXI7TiFsA_f8h_z.qLqCaU.5p5KEKkDkQMWwM_Td0vqV6
 5hMwXBgDOt6lpV76AQwn1fiz3wRaFIAMJ1I35aueGPsLuUKj1w1WHZAzO85e2vTfaPzr4HIdtbTX
 9_UC9fOBK9KPhMKhtc_9R4XDfrAFdFS_SYjpWgoHflh9ygnmeZsyuj8r9HB9kQmy9rud26JmqpUK
 v9D_8WH.aLxXp4SwnkFJt_DtBtJDdz3kdIGiwOTXiQP.nZKtRhmy.naNw3vjR0vjT2RPfZ6EUsyr
 DnnI0bi0IUODL7aBX2WPloqrXfxzb9JMhta7xQf7TjkPyLb9ET663tzmuc4BfaIDuOA5e14kQhIH
 3n9T2YDUTiJ7JLSKj3dxM7JUhmd29JU7X
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Mar 2022 00:01:13 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 14d447c144378bdd823ae563645b8a4f;
          Fri, 11 Mar 2022 00:01:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v33 28/29] LSM: Add /proc attr entry for full LSM context
Date:   Thu, 10 Mar 2022 15:46:31 -0800
Message-Id: <20220310234632.16194-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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
index e0d41adb38ba..324370d048b1 100644
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
index 2c2d0ef59a41..51b5acff7f0e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1396,6 +1396,12 @@
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
index 29181bc8c693..1ee58c1491ab 100644
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
index b694eca9d4f1..b1a95ede7fc2 100644
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
@@ -2210,6 +2261,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2237,6 +2292,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index 7b9cb4d263c0..beb0e1cf02b5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6363,7 +6363,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 46d81f638a2b..d1677339e677 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3485,7 +3485,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 	char *cp;
 	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") != 0 && strcmp(name, "context") != 0)
 		return -EINVAL;
 
 	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-- 
2.31.1

