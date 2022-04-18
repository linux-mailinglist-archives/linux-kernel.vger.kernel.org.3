Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557D8505BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiDRPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345694AbiDRPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:47:08 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5095BD04
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294868; bh=zxytV29Ee/KqsOgddLCdzZjwv8OiqPiIqHzR85jUbE8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Yhp8ZF1K/LGkZGuNPs0gcQ7UiwsDVfgFy2oCOFIoSARJl3t19R6wPje8yKzjwiLTHHl6ULkwDKlCyopQnei4Bo6nxvESKTNaElh+CNz541fLn/TgKsb4cuShfY9003wztr5OV0ZEzpV0vGiD+Edy6nfLbXhLQOsdSHfMdaPqbH019+BqModozeu9DphDkfEgLQvSU5BPftDr4PHLdpAewBYiTYhQQfHHpRKd/XImuS3c8LjMI1EsNOiSATrsoeQIsDQxGCPtwmgXNVWWMPAH5I9Z/kE5ZodKJ7HVn6lZJKO5z2QaxT9vzUcqpZZnS7wvjDmAsbBWBO82/mIY3+Jx/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294868; bh=Vk4LPorpmdjOoNmR/xSMm9gdeauguAtz7W4fHMrO/vn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rbRlIFBGghlrJVs0TBJAGo19sYSAI5Mdh+Qz0Fm6UYwjzGvIWetO1X4P5J7W4dYy6Cq+GAJ+pXgb6mPwGUgKsGXLGIXeRoY5kmXd5+X55LGGNhScXlL4v2HwF39UOMQYmqcvJZMiHpbl0HVogIXZdA3qF3INzztw3gDnCsfxDJV81uIjgiR78DwTB6Nm2oyNGSGOETdQv6FqHWCWZt1VsZaCQ0mXryTgodELfurCsN8nRF6HIrRGUY8HB0NmRFaPq0mtqzVux+SQGGgD4+InuVvSY93bEqbVfdqZRYiKeZzWQEWjQBJPMKieDLjGSeOcNt7jme0Yi66GKJnqhOGgHg==
X-YMail-OSG: NnLFzUcVM1nlTnEdG0edl6v83mjHge.vM7UhJeY5ofhOGQuCWzVz0ltul8rM6xq
 gD1he0CIlJ9ay6oB8StL1oivSSyPfykTJgrgVgRbc6PEdz2zLYCMjAgHxbDanHEQtaCGJZt9Ador
 SojpwAoXVkY8gMjlC8o4Zg_Q_aQK.W8tvnSyT97iRjBG_XInQvzO5ppNNNVgayLvdWUZacXAQYlP
 KGQOrIGqB_Oc_hK5mluyy0egX0EmO7aDfyJ9YLfX3QX1ydnhaoQLSRooTg1VUSBW9AlfZSoVysF.
 9M3Hp4cAwBpU7_af9Kaui5fILTtmQA5yw2o_FezgTxEcKy4WAptXodgPZApdNqAYWmjy.x6Q9AaF
 4LGMAsWaMn9bjfDdKrbc4kUzvI7EN.4X9I9NSJr6fdMxYVTlaiDzkIUHMB0t_.4g1QRFJTMjrOEw
 El7162tiOVrbFnrxyJ3BjzkFASJSL5E1yxQ9Q_NUbMXv.5gz8BwO1UY1NNtQ95.qJPuMz6Mdcab9
 TW3N3UdbMKuVkfr8yhZjtNmgr1n09m4aNu2qbktCT9QltZo6_6XDJbIBYS73srn0GOJK3XdQlADy
 hsc23r0zj6DnSjAcoXqWlMtNJPuHmadNqWmaYcO9_D5gClsIAKC6tlGpP.Q8TG.6sTytapWIjyZ1
 G_QjlvwHl2Qesxf1733sKS2uM3dpwYLZYdBt91PBitw8J89AAew24VA_USVFXXFv90Yp7pQ.sUoV
 rpP6gupVjW8eOfyI6RJjLREzfWJthX7vxaQtntwZkNPU9h0CnwuJKNCCzfbm_qvwfhSjAdow9yos
 m.7lLPXIfkp6GXRU4NxADITemyEB3juGaRXiXrPkbY5RvQsyPgldiJo1.qdhASiRfHuGRnM5BlY.
 6Yw6LfbqKpC.DXMAuRDMn0Rr2ZF_swT8KQAcXtOV7Urc5mrWTKS42TaQCdFW8yYndzIxdfLHcPRg
 lk9uo6GIb9cvK4aGuwfywOSAR4AfzrJgBFMNJp06.Ef0zhSuXQOuwcWRv0gQQZ_19rbQBet5vKTz
 2hUb2ceFSOf6cSgucSlkXUY0djHh.THllL30gSz79VzTlsLotBlUEasQT3wcutMaN13Ml_7rrsDi
 nLLQJnbR2rRGWcBBh9HgAaJneLE8sc7bF_yxrB9KBecTOocmozrxTbTSX3nOWKQKJKvY_HsqfEFj
 EJjwiNyseaK_VjTvoGepnN_gLiN7Vm4V.O0azYI.Ql2w8hnE8sFj5ANrZDVbC4Ol8eyFkJ5Mvb9G
 3uyvZ9RdbLUQIqH4LUtxBPc29kQi5DpCvX1_eUB2uq0Ahm_ag994hSGY2yp1MmL.dVcpV_pYabYv
 ZKiQdE8qaErUyX7tORdk3iRa4bY2aAZPjB0nIeBZknFn4L2T_81s4uTgaLge.OvxEqkdimOfrpOJ
 UHUZY2N_Oj.gOhmHODrQn6jitkvu3MnvidDpe1a7vxFjEIIVo.m.VyDTIRjI5dLfPiEZgUqJeDVM
 VjyvkTtKK4s4UATfvDGa_iP67x3_EskWl5K1a95Q9G4QvWmu0sOs5pbO4h4bs2HVUQ4QbqzU48y7
 DTPw2p9XjsCIWu7vb5LpcVRqczF7KNKesg10S7REvlIrjqME7LszigYf42.Gk8v3tpx73J1KqLzS
 GiqvZB40RqP1VZnZllHV884xq4EMjtWAwX2WCUuupa.buVf4jiFOBFi7YEy1l29FM6Dr9N2ZNE3.
 Q9BOCxPfzrPzZHHac_wKvm2j_RNTpqzbDPHnUNvQ3CeJzAZMPI0lRz9o8Unt2QEKeCbH5qt2mkG8
 dLLgfnC9D87yQY7CwyEUswlbG1G9rvCUzN99T9Rm.7CZdIx.fwbyTku4KXwS_oE3RHn7L4vQhjV8
 ty8F8L5Ej.BKOTLXB48uYheS5w_d9vZhbngt1_fPHUV0GO6xz6_5T0vf8aZJqMSeEVEFnn8JwdUd
 .GcHLSexAOXxehFO8A8YnPMfvgPGxDjuPQehf2pBIq4FwavDHFZ1krruj92ITzs2ONs_4ibYxN70
 y37w74p35U0D93lxScwcvRJC6g2ICJZ.etycNav1sZkjUySs5BdNdgPbd9YI0L_pryOp9u0aA60t
 AcNZazdpBToMmwH83M4N.1Ahh9nyXF8Rne2TuHs75A8jKqZLZmVBo9uLDEVRaW76.gbvzsUSI.0t
 fj0peHfQjeppqgya2cWKHq7xg1RGv3rYWxOvl51nK3U3faZ9j4Mbqslj49BvK467S8NUaqWb1_Sg
 ZYJA04WfKE7qTxw0JqGQd8cKM8iblgFzCT675o5uMHhrj3nBTUDrr9Mwf2J1ILo5ZXaQCB_KvFY0
 YJ3hmAJZLjqySF3D9dLwP3sWk26ZdXBLTZHQvcjnfYQlSbX407ZqJEGJUnco-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:14:28 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-xjccz (VZM Hermes SMTP Server) with ESMTPA ID 311eab809775b4af02ae966c725fa26b;
          Mon, 18 Apr 2022 15:14:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v35 28/29] LSM: Add /proc attr entry for full LSM context
Date:   Mon, 18 Apr 2022 07:59:44 -0700
Message-Id: <20220418145945.38797-29-casey@schaufler-ca.com>
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
index f2d15348bdff..f8aed4404e7e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2828,6 +2828,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "interface_lsm",	0666),
+	ATTR(NULL, "context",		0444),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fd63ae215104..425538ebc606 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1401,6 +1401,12 @@
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
index be6682768760..4c6d4171ded6 100644
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
@@ -2223,6 +2274,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2250,6 +2305,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index 653dd2e236f1..cd977493f734 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6346,7 +6346,7 @@ static int selinux_getprocattr(struct task_struct *p,
 			goto bad;
 	}
 
-	if (!strcmp(name, "current"))
+	if (!strcmp(name, "current") || !strcmp(name, "context"))
 		sid = __tsec->sid;
 	else if (!strcmp(name, "prev"))
 		sid = __tsec->osid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2190c03ae3d0..9e442c4495bf 100644
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
2.35.1

