Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72834F894F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiDGVkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiDGVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:39:47 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F741CAF19
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367454; bh=9VuYQwBW39Ekt7RPYK9z2xCBm7gX5c3J21ZsAJyisLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MvODoSKht6tzcZqkfBQdKEUOrSgqpJ3GCvhbNcBiFS5nGmER37f+d4hL912b4CaKE5spbMYPnnPiI+TDOUMEPY66apoacgVXnWp6xEJPWaZH8RHd12+b5a4uTp1gD/DXMc89rWA6nQY10TgVPGfnvhIf14RiKJFFpeF0FEvLKyfe+EXdkpJuSTvWTOnttUoZJiLvFEgNn8ABNA9670LfzLr/srzaTI911K1ipCujIJuwCvZe64pZCwD1K0rKN8AVSsfN5tyAqFCAk3ejJ8JpxsNu8onqEknnm74ZgK3U3/3MzOy6rLW/vbtxjHWQKb+aOYUcxMWZeNTfOIkX1Fjxsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649367454; bh=n82J4LcOlP2c5GHlEx444sfcHBKQReR/ZCEOsxoPSha=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=befwzS2OvVyiPKZgd8lT2YvGLjXwtL4OSXFVRbn6AxPQVGM4O61Yavmqdpi5//ahKY31K81uvrO53P15YgWyh7IXWpMfPD2ClkG/yw0dRfv/HK23YyGTwNxU/Y225i/uG4VrUwZdfT1xLyzUdepL5q9k1zcdg0EKtB6PrwbGqbvHs45+YdOs5Ausq5qBVkODsWc3eZ/60kMbyXiFocevfOyNqSJsTjHsoRFmSBNWe/5EYf119fEhTEIFUy1kCy/MWhUfKMJ/OhNNWLpiOCzVqcTfO/eIYU2/SH13LwxV/i6q/wwkGXCvlDrPT3VvirTECTqteQ+U/jTL32uYqHBW6Q==
X-YMail-OSG: pwGcZr4VM1mgIjvqVU4IutnAjBNIXGjOAqvXNVtAP4gTuoOPmcHbO__TCEAAOL2
 fnar.42aiiQ0lsfCrKGA7HGAIxUWEoq0KNo9RBwPGSK2W85miF29Vycad4rUQmffDGFoSnY_HZcs
 7jlsnZ0JqR6TfMN_.dwHOMmKX37B5dV7KzZCMsDYVkWTWcPtqLDWQgzOT3YwLhakOH9Ka3mMnCKb
 75y8ikMRI8K_25m77Y3nQfuF5EDxypk0R8S3EpSjtPa_DSxVWHM7qJaZqRjtbmDQvwfExtCapdND
 QW9WU.MWl5K1Zp797LwiU5UBJKG8lUY7jdW4hGVXJEGeYKnWElU1Yj7BPhEEOFdmcupOjGpUmoeG
 1ZkuV7fqNmzXiMl9oXAONd.vBBG380eQKmJmto0pM4KXfPRRNi1w6IDd17.ccFTkeoxSUK2gVUBE
 yhG5cNkB2Ke_SEi6FGcZCPkU86esYGAIzHii9MROrMZZgAkY2Z7kmswkCDDNh25mDHVAsxERaD9w
 mDlljvHPFPKUNf0LelmLaYGCVWghxugnEk0dDmGpXqd6PlZxFQrdzkzcCvD6pgCPX7OnN37VOe8M
 jrecaAydgFKx1KjwZHEjY2bowTs10FexyR._r0sJgqi8Iks9mXYglei6Ci5sSWWSboHxIYmKEHeV
 43ZBdZn4HSHdoFts8VlpobnfJRglSOUtidTliuKYI8jBvdg7X1KnUX4kkIO11Fehj.D4ezBHW3ke
 9MpWfAR6i7.eo1HC62yYFLrGB9XW7enzy9BvzD6xi.5HacOefs2_bq63qN61RDR97Y4jThLXpH8p
 atIYNUojgISQDt4NEOjBXnzgQbEbUsngbhziOeu0qU6koUoKA2Zy8yuTti_qtRDBVwIrTPzemkPh
 v.6YIQaXHgBK1aYOwyEHR.ojcViLTgA_S6Y_5wzDx0mZ334rEBd89aDucigAG4yU0u1MPTM4dZax
 LImZ1fWFNOzc96FrFKkmIq_T9ShYeDo0bdriesXUEftZXsaBLgO.MqtjXW8g2stiCnl1.ktjYVkZ
 1fG9CeqKrjcncu5RZ14BaGOqOsBxIWsdD3U745eawUi0OEWsrXuWoLPX1tSGuu3og.f1Xy4spLAw
 kMnuvoK40of1.R3LEhaQ6xOPIvZMCa5sRjiZx.LcZ8NaW4gHEJVo8WdsadljufnDooAwqW.JWWge
 QuhTU1R7ng8RwY9DpWKnGv7drS6vhKn57ZuxM.csV2sVqXJo2jc5Q1v.wH16NDta.f9RZZqcu0Yf
 A3cbGf4HhvCwW2LDkUzKFHcsp_f4q5VBa.2DM.5LhRiFOqd2JclMVDX_1TE.JEPbmS4giFhUGjI8
 3.HtbL7gMOjqEl_XmURJfuiw8HftEIHsWfZfi4Kl2p3Hp4QWH_hwA_YEsfC44aEB8JpPtUx8QkG7
 p8eDjBie0m69oEgnIXRoGUtKuVV79eBsGdEJLMAM2Br_q8w5vLCvqX_FYrzJEbVz7cmaRm4BLxrf
 PynHv71Io8S0pgz0gT137Ea2HU0JbRkl6CYLCWknzMHYTyC1UuJHakh4QR63CfZXgibiNUmmWlKU
 uqFNN7nVweAtuZu_aRlQ3PCAvUYAfC7oYjkB5HAwr_arCjJe.4ZmDxemZlhm53r3SQzt0A_pz3Lo
 _aY4q9w.77WJpoxNLIILdmInDOokstzYWdcaasLNNotSDP3nJ9rwgP..VdXcxl3jPz3w4AvnwBy0
 MdfRn7p9AHPOkr2If4M7cNtCuYtYuCBXlUQG72984lLBJROOdQAwYqFhpWnV8dHCJ7oBbcRiOmfp
 qiERBkVxy2KyusZu0rRuxiCzVcMuXEW2q6.THD4wJ6E_7s_N6lzQkYcv.7VFV3wDhB0rh2yWseTU
 ZteVTqt9r0HJ1OwvV80Ux_08n.PdJEZqYgEJsYDo5sxG_NsDrXqp7FInO4yWo_qoz8QJ7.gbgSTi
 bE5U5DYCBnHaGqmDarMcGKf8UHrT7BAX7DQz9sn1qYRlwURTdtEvXIPOzkBDQTex1t35b0bjdZtX
 H9twPDCJLlf5Zb_k8olHFGdcdr90HXp5GAyM.Kp7tBv4SyS8z_kRLadwNhaRocIwoZJPsGCGHKCJ
 BlP4L.Lh8fhKAJGji.WzCLT9p6UvkRIk0zcMrGAnNMTtpvclqdz8YwGlLf0BkT30pzst7DlaN3Lu
 gFZDn2Itk4Nv9Mx6KPBP6SPOM4Tm5CnMMxRVbFmmYKf4fvHosEPQjg573bdBWlqQMecMIWK729ND
 ye.rMB9FejEu.oK01Zg2_TGZUqeFJgFEs6lVIWNFiOzR.6ww4cOoKxDeYJjs-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:37:34 +0000
Received: by hermes--canary-production-bf1-665cdb9985-tmblj (VZM Hermes SMTP Server) with ESMTPA ID a865fb4ad0018b13f62bbe44bfe50d3b;
          Thu, 07 Apr 2022 21:37:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v34 28/29] LSM: Add /proc attr entry for full LSM context
Date:   Thu,  7 Apr 2022 14:22:29 -0700
Message-Id: <20220407212230.12893-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407212230.12893-1-casey@schaufler-ca.com>
References: <20220407212230.12893-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 01e14ed6aa32..916b977c9ffd 100644
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
index 81d71d664600..e74654ec592c 100644
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

