Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17D4A7CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348503AbiBCAYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:24:07 -0500
Received: from sonic312-31.consmr.mail.ne1.yahoo.com ([66.163.191.212]:44925
        "EHLO sonic312-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348504AbiBCAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847846; bh=MZ4vJagyUghLy0nswAC0kHp8cwcJQt/yZ0z4gmY7kX4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=p5QTvyuF/rVRZ8+Z13paP5MNFtsrjTEpKbYQfDKuR69vq++u+6XKMhgnWdOmO+6ZzB8Q5YNIIlXWMSmb2tmA1CHpXJ/FNRo/0rdh38tUGQ3M+ZjMDzvX6bONPXAv057csSU+tKDL/0LI1h+iB6ah6soi7q9A0R1LV7hbHK73O/UHAFuirEytYsgk/hPq3R6Wr55Mqe319roYn/9rQPfPNXY8Mw3s7yoXWRBfnhPzC2sgY2cZs9N02jF70qdIOzspaeXvWWDugIldIz3ellTEkKAYG8Ph8UWN+qm6mOubsr0tL/4PU2ZEs4guQM0TicyhqiVrGtztBQsLRwYVGqFNcA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643847846; bh=5OjqGiOXlf78fcMx34HFr0+szaN0zvGSAFDwRbcK1Rn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PiLMIkJmScSjk/OnEk0m3Yp/HOFjIH1EV4H6/71Zrlt/d8jRLfphatN4ptzORzWBJvIJZ5z+y+vRLvI3K2mY9cE5iBwDWfc7arTcC0YbG0e7h6+zArghIbytj2sIe29Eg/9Ijl9Y/fjzjLLtfl/4UTOjTOapqKLcfN7yast/dyz79S94ZLYWm7/vgxc2yhCQa05LACbFBTUqPCEZuVYlHBLeDqw4y251PTujgwxga9Gw/tIDJuh1j54Ixoz+bSgG0ZUldzsw6GjCwkdOrxwP0ZUsZpejlUeSbb/otV/AqUlHdkViyvjwuqq4BHL7ni9caDhhbkcSU+k8IRG6aQLoWg==
X-YMail-OSG: pZ.q6VMVM1lrqZ7XYBJrVdPhAVAdN.cbt98FeRxbjKd862DdUh1i573KU2N0gI3
 rDDm22a8.qjsGQK1jUJvml3N7lg7BBrUyl6IqkUGFgQimciSP3nQIM2iBLfTQN5f1w_cOpKpQMXG
 1yAdJW.1AXKw1JS6ws2GB28de5ac9gpISRPkhi9Ht684YPFLIlt2HdDzw70AiyHwqSbvXN2aGx5v
 xcmmmyxc.NVfQyN1j9aHiXS.VAgh6WckHN4KrSxSahC2GnECgQ2pdYLR0BovHD4x7T0vWkYvpnLY
 IgR6SNMI5hA6pmWXFKp9kTjjpdew2RGJbn2tXmm.BKBXKsKkXJmmkw5Z4SCKdj4PLK1vsXu8R8fZ
 43eMSQ1eUlHjJLqEIOiUo8LyuqLcWLeSzXUKC4OXJ8N0ZzZliXues51wpolYkPsjZ2Uj59gu5Pg7
 rUcXPlbf5eT1OsqxE8KGTp7eZOvC75_166LQJZd.bovXFbPSNFBaORxPiwx.sPhMg_TjLteTMBzL
 jGuApO1xcPC27LyV10B.t3LogUiB7Lk899HDWTG3uEbTqvAHL644VWE3baQTjiOXSQ28SDskwn4a
 I3bofkaIsKULrAPIylMWmKxgunHz_vMiaLaPZPs8.gSiR4kTT4.8KwZ9M4Q_u4HQHhIUma.DDE3V
 dZN1TtsmZFmaC.XUoAxEq.3V0tS5kHJfjZZww5wr8lBvT.QZzH.iHYRHUGI_0wQS6gzac.0mbyyF
 gVqNoyB035R_A4gYb03lDAs8gX3ytRuOaN2sE7bmyExv9joWx_TwUbYKRb8gqRLJcscyTaKOSDTp
 AEyhtPdvzSDg3mhOfvO1i.MX3zy..XSyZR2kAZdQvzOVKokVIRx4FIcNwc9ae..XWjEZfpeB6SnV
 d5QUk5_6MkqMd6X0Heal8RTBrOT.ZfuWIcIMXpFvVpG_G1dDqLrRH8NMXNPc.YwW6.0uEgHR_xsi
 PC66rRBHH5Gha4pAOguLxz.ujZsrSJznlZC0m_sCvGjghs1rJnOazZayqiOhwHx6K5NlQeImrpXw
 QiMRE31UnkK5C7C6Zz5mvycP5NR16VdduAX3YW7MpZAMpnBfuEfaRcgvnjHKXnReRBwrs6MfHkIo
 jTDDONJ4wW.Kj7YPzNc_8yN3GXSwQpSR6Ip.wOvL.6NfXwqJjuWR0BJPXRDaJBUcHjLE0osPeBcU
 chzkNDKJe_oS9ZJCA8xtN9nXfwg2v5Lo56TwDiWcJnW8sSWOXKBO19FJoX8oA98aWjZ1.hyj._kx
 m6tJnnSZJvaf5h1VSURfzY01Eh8iyJR0xb7zCZTlczq1z6MkZi8Zo2J6LB2zqq8A4g.wLs5NZElY
 _XvutlyxG1RLi53ToiEnD40rIAYK.aExuKN1W31fTAlNBddblBclWS4vuSrqeUW4ow_fa5ycONBG
 Nr.oKMh3KGLmU4I1mqWZfqMy04.DXkz0gaZ3Bvrw_PE2qTbAH4vd2jtydrbW0ev1xFPlMab9ibyt
 N03HHIcCaSyrmxWclFsBizYTuaWX3zuJ59V2x1bDQZusEyyHagfBbi2M1AYh.fvyYUSA8nk_jdeg
 Ow5hl3EXlvxhiFfvO3e7qcaOF3gGa_K4pXxKEvIIcJfb1kxOBwhUBr_BePw3hvmb0IXGt0NMaPFi
 tqPA0AqAvQVK1YoLjrU87bZBa3kcj.gaZJEJ2FDoTeOBScjLhpW8y6yx4dHbBWGBRFuGO32X4nkS
 0qk8qYoaDioeZRB847HFMrScDViIOiyOK.0a1EzjlRm12oO5eHslYXf0oIv3TZ9qsVZXMwzNlXl6
 QqXEXLHhCR8kuOi_dUxzkLhy5pQJe.HU7O.ts53vxT5xs0mSSTP_AkM7F2EbTJ4zhPHZZ.a5vsy.
 lzIlBaU1czF3yov65OsgnrKN8b3cfH4MJSvVmcsUDbYKcx4psfhE5qbMQ46CnmVkN2T.l9vBFz4o
 zKinrzSgXx0qtMd.NU2ZtPMec2VkrUxN7zpVGvECczrYBEW5bSfE7Ap_53i7KMLhh42F5D2AZiq9
 jFboOUwCwGrcWlkp_fCKLC2TneUKMxTVHLXbaHz3Hv_nB0GFPk6mX6dRLHTA4NqQKVvElPvIBMVH
 adplYPnQvuaXWd6R1jupsRJ7xwLq91uvSqriKSGibAyMNQFMCxJnBMGSAvDjh6fw3ggaVSrmmjlz
 3rsuIAOWzatGkpPckYcMIb3zkuz7TJbhDdgS47wV_bKAJNKHFjbZuP.SVQHKdLdtvY2Wjivc4_I8
 BcfIVgDAbaw6nNJgFYSxyCTmC4W2m_4XFeaQiaepZHe1lTJdi_I001g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Feb 2022 00:24:06 +0000
Received: by kubenode500.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7b7e5f79bfa77e30e83cb3d126de8e27;
          Thu, 03 Feb 2022 00:24:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v32 27/28] LSM: Add /proc attr entry for full LSM context
Date:   Wed,  2 Feb 2022 15:53:22 -0800
Message-Id: <20220202235323.23929-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220202235323.23929-1-casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
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

