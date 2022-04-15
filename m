Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE10503130
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356074AbiDOVfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355946AbiDOVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:35:29 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FBD9E90
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058377; bh=9VuYQwBW39Ekt7RPYK9z2xCBm7gX5c3J21ZsAJyisLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=o+wVyisKIaMMLHDnF3CkNh6LkJhoM+YP0xF9i3/8ewddG/PJd9agZYXUbb5NSxjq+cJMKGSn2lD7FNJpVLBxoCSMzmXmuPm2NZmazDWyQb31EChLrGivoiIm5HcYDTIxq2U8/1sLCA1vUOfrGR0gy2u5GhdrnIt6ySqS1RYVOfqzqNRjpr2hzf3MvsPBCprbA7DI1eLPUEK0M/cI09w+Ex03OpZ11q7it5Iq4jS/wqVmQYbdohsyCCdjCxHt/1Zm+eS9ktR776+3YkzuheH41pmZN84Da5aNSv9eEFzd3clHqzDJtbIiQmHi2TQoSoSiQcUcx4xp7Uxj2PuHUcioGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650058377; bh=f41ZfX3bWZrPMb8oy8k6OM967ZuMwrpcUV998s+lg2U=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tHMynzYkORea/FU2t9a7zSX8Za2sEbFd07FO6b87xFS689JT+PXi24Fsh7vNnQllsoMz1A9lMBfSkDu7jWHIrqOsfNm9u3dPIhGzTz7lADmLh9A0drEi/57JJgN+LXpHjkM/h4A9Pc8XcSv9CDRpI56nCUn/Hvb+BKZ4whwwzX0UfHt1kaDuQmr7ppW1TKBnUrV24kKyDTfzDzoZd7aMFVj6ohWNCfKjLh6rtC8DqPN+jELSzxw1Ze6Lw3cKmDetMO24Vm6Bownz1mFlAJVti1ZUsAPU++PB7j+YGPuslDmxudXE0mJEhCp7j5DVKOEtJfa8meZwtsZipjSSOqYfSQ==
X-YMail-OSG: dsZRX54VM1kM2WBxu.OI.CRhuue_2oFRUrhqMgCFAlD9AGcqqiQH3wts6cd2dze
 FNiQhcCu.Y3sr.7d_cHfh68vt29ymlZ.trjamS3B46r1iIu_ry6LKC6Mha9gkfwu4zs.juUINq3K
 PfgG8WBSxqkZY3q9lq7Gr4F4dey7SHS2Y9J_FJLbaBd0PqtY7oe1ZMnBs8IWb6MPk8QWvntvH1bh
 Li52U2StwPPnhQi9J91G6qYlBQkg_s9FDSeMWRR6QTXZLh4cTHfgClWIPOQRhw3FLrZjZbIM3ZDB
 xjteGZ0jbY0CIupWXMeKVe9DkyaQ2WX4t4gdkFT5gudOf36bmgMR4WbpPWu87xVzdhuVIVHjl9sP
 1RpKGVAEKuEGVIXQ1V3ppsNw1y3QzMjg4dW8bNbUdOHG4tROmwfBRDYZ4sxIu4GWPKhf75Lt3Vw1
 y_.3N2D5XwJ.6Wylti5GoDWzVH4XKr3i5eGF153pdLanSNT8Ef64WZaGSqiF.BxWOqEXLpTIyVK5
 TGT4d6LIL555o0rEfLNKeVaAUL696h_kMc3ucGveuCYYnALOk5pVYtWuO9zIbOLGoEdKfIeHegWG
 a17ux3Q5xhEMuv9cgZXhmu7kkEr9Xft2LVtJOuZShrYd7FAhMJ50NMwYlhIRO7xzZtOdG7y4W6DL
 v3U0KxgP2Mlr5yo3XyksIUtVg6iMOIGu2iyfCYIo5Wd1ThU0m1ImQJQcPMoKaH1Wisi4cUNC0ue4
 Vg3YEoWgbjUKecQdQukUANrptaqI2CXYgD215w6alhEu18ppSXNOVLJTJJUaCrWTNvUgnjAh4J9H
 UcS3RKM3T70Qyw5J8u.cDb0VlotvECVX7pWSAWmcAHVCB8QdX8RUjsi9WZGhnMaJGF7MtGTaqtnq
 3jGSP7Fy7oHx_Cdqtzmlpc2rX44bsTGher2mTduTPwdoiFYwlW9_WXxBZRA6cG2YQ3MLEyoTRsVz
 L1mQbnnZpa0GAOVXLGv2zQfnsDZ2k1U58kFRY5crYVF05nORc_LgMirJ6mwaQ9AdEIJ.RoG9q6Py
 FfpcNgeDOpas89oMie2VilshcjDNauBuOTGPtYKUzybnefP46NTlsOTQJ3A_WjImcbRHTN.8cBmM
 5X3NUjeKIKA5uI5L89CNAJaAE3gbAx81cU2swP9XlfMSjr0FaQyKHVRaBAUFWm8Da2lnkuQ40tJc
 cTBo5UntyizCPR64RjREGs9eCvXB3jhtsR5_IpB3he5OjZGPbaC.TnlnB1n6FOGFR2GneR1twkE6
 eSlngiy2vBkrzhU8rGsvqcyOmAHvcEhzpnGINFNtAZHAMf.bl9oZUsSntbTSoIymohsPzeZ1FgGK
 eeDqtUNHpV4RSDaWkz2Iujx9ZGMu08ikglP4wA0msuk1iPCrH7UJPdI7dU1B2wrA_8_4s_9W1xsU
 RWHG7BTyqXFNen0iMkAY1C36NtdF_Wr2ehbcl.0LrYR4gNTGh6B_lABYbUak9JAYUslhl981eS7F
 pjlf_77SCkbvU_6qTpbXxStQi9UzABH2f78YVqg4ZQeQP3KGyCinRCL2r5P6hUxD3vQoShMO..OM
 pmFFf091Izx8bXYBB4CaOYu44.JsJ2Wg_WEZA.Qf1Po5gAQpkkrVzbZLAEjnXnHCIGRiQunzQU.H
 THma9SXUsP03M.640F_BEZ5vdwgiT0Mt.Izcv.C30SDOdAAToiYI1OKsLXxHJ4Gwuzu..p40KlyX
 yweGNFe.AH2TOrlKhIequR56_WtOFlyB1dfva4w714kzFxjioUqMHeryHtJB31esWn_i2ubxW_8j
 Vy1C_KTpFh9LfobIBaxVBvakWUOjXO3QHHCSwEjXKCPro6xKB_Ja98BjxAA1oI_DJZIlnJOwvS50
 P9Zbz3_xICjLnZI9F.JjOqlH1JYXl6gTbf4loBltNcGZK9dLCN26FFxKhWQfaGrS8pR8li4uws6L
 X7.lulce6n8ghEShRPOx6I_OjQWaZFKLuISrEiyAqmmDok4nZlRlskp2wc5iGzRedbUH8IFunr_D
 kwgd4UYI6qJvO4KLt8oMaKpAMPFCfw75anGOGBNFQf4jUpsuVa5n8DoaF9XasAkBeWS0j7QEBFq6
 BJWXL2FWB.henWOZSFBkincPH8ozGNkLKkqHAanyuNFq4sUKSZRkqnz4UpTyB64qSk6Pp37sl.pX
 nS_HDO4TLOko_cDFoXTw.v3C6fnnM1kC5fQ6VT80QYWAciZxDpAgqF4yoIhKGSScGDlv.V.kzYYg
 FVlFvsI9cMSNT4YC03y4akuKUqS.gFNyEUWhkdNyIKuC43G4HynlEFmlJJKnNGyN6n4YPxoEgndd
 JhU0p7Jwr1rPqkM6KWtJeJ0mf1.IMSEeEoz5xUUqNPkUDVZY7keHTmA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:32:57 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-hpxwv (VZM Hermes SMTP Server) with ESMTPA ID b492b8f8d9f0e2ffe991666b37d07d11;
          Fri, 15 Apr 2022 21:32:56 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v34 28/29] LSM: Add /proc attr entry for full LSM context
Date:   Fri, 15 Apr 2022 14:18:00 -0700
Message-Id: <20220415211801.12667-29-casey@schaufler-ca.com>
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

