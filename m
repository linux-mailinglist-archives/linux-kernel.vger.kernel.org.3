Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5055C392
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbiF1BPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243022AbiF1BPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:15:32 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B4C22BDC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378930; bh=DTAI/9xviH+bkMNtXgDq3LVf2k6deU8gUjXsDZleOHg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GogV1PhIpFQ5noZ9NvlEr5i1i7CQZLEOMIhVmpxchWt/e9LKMaacbQ2ob6g/SIvwhyE4eLZ6yKhq+T5nKfRCRhOlDG4nM91wYi9D6peT+yAHEOH/QEWQJUaFtXcp2nI/QpIrddMvaDv1I+IYI7SfUS+5ch38/E5X64IWauve/fWN13otX2TTLMi8XateJz9IAnH1p62BshH4hSRklURavYbNy/gP/jTa75OU+d8JMl23GaZKTpDBkLfS27TCIKIeqp5JeYj5mXaRvvlaEwWIVldCNmyoNPoabX6J2Ahe1J0f6ocWAwQVuPlTA6AIEP/j/0Q4s9L4bYzDLgXgwxVOjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1656378930; bh=3Iw43IJpRr+QAVpYo1fukPLwO9UouEPl9SsAweeI52r=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=V01wPgPEidZ9gAE4AAhE/bC86P2uBIA6AdWtM3NVQd9I8+7DtfWrFvvm84mLP6L1stAhZjUjsT9HrnuWa9wzCS/ezszmf8quO5X2mcEirn/+a5GqAA22lJmhkOXU8RLE2QpgKruQc2t13/1aOHfxB4KdixAM4hH2a7Tgy1VINSj0QeNlVMY10WQawdj6xUrHEq4P0JYxTqd8uRyhMDk0xq6BadKnUiMq+EXCoHjaMfiRml7gF4E4IjgZOFNBIfZea/Y8V8GIPj1dHooZ9x//XVeEK0EXhPb7Bkhj04dAfrJOkQZ/uYmRBnMouIPPyU5hrjHkBW65aSOku+t+gzSjYg==
X-YMail-OSG: ebgZvQsVM1nlQoXj1J09M6YT2RWLcEVyGTfVdxIhouVZBTSPt0Ds8wdMQ96_maz
 MOzuI8tmHcoioMQ8rD7erKLkXh66dqa39xwxqiuxDCfMkZ5kSzogWrSb818alklnaPJ4Xl0n42xA
 x1Rd5Kk2CwLWtKkYgrNJA89hkYZGjXjYMXd0.hS1pKSu8sl9dn97XF84Tzai0dIDKN_CCwrH6yhJ
 Ai4jyoR.dJnIng6lVe00SRhqZKeBcARdcFjcdMHBXVm9ZdrSISqJL_Tl5nKOq25bJT.GjOS7ll_b
 VPMWP9cHVhoUjgNeJ361ntTBnJxdiIE5Q_7jVxTIQ2hCmjzLdsNwM8PxXr1avUIh6A1lHoTTxVwB
 6h6IFHEa3W0vqHiXP_Q_YXhYR0wxppOSiuninSaTJp_0N1QccqkBK5Le3pof2tj4keoy7oL6Y8eF
 8pnh4gpLzstvkfleqxO2IXSwnZR.2FmWBHy5tkmCFejqNAPmFgOToS8_6JiVbcS7XjEHiUs9vrm4
 FSNfiB0aNIp5LCXh7zB4k8hZN9R6x2RQV8RHhVFgB9BjwU_wmdHYM3WW8Hh9rETPz0UaFTfBpIC5
 7b7PFbgdvcVVZ4_HsdFQ4fBeyl8ZclEo2Qmd5TRAdP3vC7_.yo8wjc9rs4DqFWi6fXVyvDuEwu7Q
 Dq9RMWrSoeVuELgQ31zfpY7y2ZhxQKD.7JpDRA0DmVRjOU_IHt3jmdb.JaoGZF4B2o0RInM7eMXv
 PnUk0kSFlANzfiD1eIBpA4UYTPD_Q8tb9TDELi1Sd._oSR0RYnBBnNqLCU6_7lHDULScW9j68vnp
 YbaPDJ7DsxWMznXxx6hMp99u5PkeEUoK.18uw5NYtcXBZ2u3mWTOwUW4Zy_.nEKtCLw0_wRhBaoI
 PC0RCzRyhmoR5wMUR13YyqZxw74GlnlAKWfe6w7qFvbFnauUzXVBed8rvs3GjL_ATKfE.hcifcCP
 4.qsquDOkVu6dh6dL5VEKQj74fRIVUIFxFB5X.EHMPPZUi5ziO.wH0qvnmHSMwZBtBES5D_cml94
 phZLeEHvvYixicDTQKuQes5.XwnchcCrFEZPpTCJnnyEyEAfBIDWmEykmR6ZF40YBV7zzgzkHhl0
 67_frmTn8j5SsedHSpi_ETdzkBt_JZ8d4S35J6cNsMsAaI1evxLsg.lSIysGJdpV4Kr90sCmA0kj
 dzb29DIvt22xfrNGs4OjaovH4W1cTqyNR9NdJAdd3LpcqqgD.deku6v_FVbGMW0ebfFLgOIsUrRx
 5OK6flmd0gaI0jZPOaoW4Cm8WCQL_CEmi_CLHh2nmZMaLS9aBmkPuvDxfl7lqsbqv1dnOdjScvyO
 zV4ZVVUQEYZcnR461dyb.s8iZdR4X.WAVhTxHzRZQgjYIyLzto0c7Q4vgsh.vMcL0B9RamxGYnL9
 .itvdHaVccGHFiusYld9WLlpt.gIE7NdvA0oKxKdzTfYg2XKx.M3HIGBqTcyc.5wdPYSroR4zIpG
 l2nPkIhw8Tt7.qZPuwzbfpALjGvjjtS7w3QNySOnfT9fV.YS.2RC8KLsCPpwTw..FVNfn1r6ZtVE
 3s2ZP_EFb21rVh1C4xgGviVLc1TrdZ_TDHKlIz22pgTzlJVi0WOWU2Rxj6tFu.84O3cDH1.wnqPi
 QosPXaqrvMZpWoMcGotQnAPHmNxb6ZzyDyi.lI1qTvLvttwQgCxu3vzjiloF2uFmdL5__X0Bj.sz
 nVNvLODqQplG87JG2Z7C1OBSGLhjoMf3HnZZwI3ShrrN1QM4093ZJvv28a8mQy84E_W1S6ucsD6i
 FTtlP64Cd4RyCMPrfMVC72j64F0iMIF1shiYb60rRm.G1y0CMzFqnbiJNCDhm3OR2BijskUf_lZg
 1MNyGTT3VwvGkco179CmCKsXYGZSRfsY5g1JUyaH_Tz5qW983FIA5of_hl2vxVYOVw7J9YLUBU6w
 zaHL3JHIsI63Dnb837Qac4OAxNJ1IeTC790HG467rhwhdxbpggQEYNVAoPklmhVQEqADjAjE09z9
 yu7tqUpoviingaO3P9ZX9w2pJAXXvlAX90MWJbDXpAugOtHd9srU2tL13AXjWhFffN5eJNH7tdKc
 anm0l4uvJPjjB1.L_i6zw_QO4G6XlKrsqKn4WUDg4SUho9p96oVLInGm8GSjHCUu4AuQwIiVJPNh
 vIguVNdyrY_CKGkZjZIpGzenUudDvLRkzqeCHjUsTr.DC6zea3nzBf5FTZK_ykMS.ytX0KdX6Go2
 SlUedWTfZ9UAeppfbfegvoG58LnoNPYGrneGA_0SVj4fi8PX21knXNXDvrhN3gc0XDtG4K17_wGX
 KhhrSLvyvvrECZ7dNlSwGF74Wsm838NL9WqUo12GsJiqmaa0-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jun 2022 01:15:30 +0000
Received: by hermes--canary-production-gq1-677bd878b7-wc7mq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ec536e7148195aee3798b7fdeda5831;
          Tue, 28 Jun 2022 01:15:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v37 32/33] LSM: Add /proc attr entry for full LSM context
Date:   Mon, 27 Jun 2022 17:56:10 -0700
Message-Id: <20220628005611.13106-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628005611.13106-1-casey@schaufler-ca.com>
References: <20220628005611.13106-1-casey@schaufler-ca.com>
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
Acked-by: John Johansen <john.johansen@canonical.com>
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
index 085ef5f4109f..d7f98395fe05 100644
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
index 0496a8d77ca5..dffb3e7dce7c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1402,6 +1402,12 @@
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
index 7f06f43d3bb0..1fdb885facbb 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -622,6 +622,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	const struct cred *cred = get_task_cred(task);
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
+	bool newline = true;
 
 	if (strcmp(name, "current") == 0)
 		label = aa_get_newest_label(cred_label(cred));
@@ -629,11 +630,14 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
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
index a9a56be58e73..b6b83a07405f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -808,6 +808,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
@@ -2226,6 +2277,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2253,6 +2308,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index aaf602d7daaf..12b33d324cb3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6343,7 +6343,7 @@ static int selinux_getprocattr(struct task_struct *p,
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
2.36.1

