Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7AA545880
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbiFIXSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345664AbiFIXSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:18:21 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EEC224D0A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816697; bh=TJU6NJ2Pr7aqIBeIweyfK6XxH9KH5pnfvX2byNSBo8s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WE3h0bgGGCB0A1A77XI9zaS17uLK58In2dW2/zfg+5Eqlt3s6EbpCtjsluavxZSVtiVdEuMEubSDNDM4yzpu5/5kSwX5drKaXBjAoXwHGrjolaSuPan0rQ/ZsUlprPzvWMqycV1a/QI+gT6P75W9WqCguq/7FQbkzLPqG4r5Sq36xQICqjTximtslkgdyhatolvs37pl5Q4T9J8Y1sAsAOx919B3ADa0DeMw11c6uHbwBpMUS+KlpbpVs4tqgqPNHiOoMRkh7LOelxEMgkNqFjdTQAN7pQKVLVLajzQ1EzDr9Wg+WsGvCbwwjcu1Ulx4XeiQTfZUZKzXX/RmKxAVpw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816697; bh=eRuUC5qoZntdR6GCQypZkDvA+xK3SJMEH7EWQ1GW0dj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hhJB6WkncjeugFqu1DWL3hjF4bDt7U9PCZTOZQvk0/VR0FsXQIQyH7btIgvoe9fv/bjyXf9GPl1yy+QqrwAPlk/L4eQQ/eAg+vVuODJa3qXkREPi7xB7OekmrNMJa+puMZqP+vtDKjh23+J3tXRPB6FJrzHV65xUQvWkgOzpXXOBdMpd5yuCBTsAJyV23iYntp4aTnTXFVYB5rAKD9BKSw2WlMNEdeWi4i90f11pfRs1Hbikh3eUYb9aCdS/pB5g9YvBcIPaJ8XebwpzV3vMbglqXlp/QegQOBsVceT+Y7+NvMChaKP/RrTw8O8+QHJ73pOGbs8H4O62AVCid86TFw==
X-YMail-OSG: wuxqFfoVM1kiWK5HtHuF_l1Wo1RSiUDtYHGdvsQcFSm10bMOYFsMjBNyAbbFzAs
 48hV2L8StdkGmnRoKwvURmN2gx10dlj.br2yV1jBHl5NqCWAjHh0edLpbcoJZNrOfzY6AcgQrfGi
 8_pbbuBQQNt6QV1LGd43QB0u7qqtewGPcIDk2IWmhBw8XD1UPyoBlNxW0xhI1Z1vvjD1wzJnEl8S
 rRnWrkEXOHdbuwZRTPVa24IH_Tt5FH5MRGq87AuwdJmwjBL7YsdvW_JUSb3MgAlGEP68BEZaNrx0
 IqxsAec1LFCqiAeqFH.Z92O70oTgOih.UChb3jasvOM0lU21WQtqXoNPgF8QltCmzH1UHfPhrPQ0
 rWbT.qkKlZUr1fsw9ewDcZpzHTyR5Y75DvIbh9mF2x5vs_xT_wPMHY.WEVcUcAv6wJ65vUBFdKJd
 1Cs8_sR8z_NLoJrVgRKw3CK7OmZk3GwH75uW1meWaytw6gx9NJtdv5R4YJezjOUmxKCWmwvRUziU
 pqLjFClEFBgp66lrTgX8b3.sKISOPaGRaxLMWfn17rTfnAhQiegAO3Spl.5q1SVSRdtsp.tH_uiA
 TJ0eWXgio8v0p25nrWv2SUftI4MzExOZB2M.ovK2Fl5foDTMCN1A6D5xN9YOftnXyZBagiuI4hvC
 Cjzbri62D_8oBj8aOCVNOPaGZ6.KajLG0JEZi5SSdaAP8CmPbc1pWc7D2ZBiPmfqNpU2wprssxT9
 NneuG_OttkwHZgSKrk.FWGYNuVeYcH7dtALvr7n7AKsHoh_BbVvjFFkOt5sOl8nK0rF3mBd3br6e
 6_splw8uILTw7aqr6yPDlnRwFPoGST9Yl9vRxRvBlWM5bR7SQoi2oc9G0XhVA4jHKUnMGHK4oe7B
 B_Rilz0EqB6PCKRdymlllZ1VbfxjEvwB66qbAzEFWKxKSF8Dj_Bt6CAmtpms5P3F6_U8hWEovFWY
 QbNs_4EgArt12z4g1PMBC5Ssoece44kjcjf8QDPJ2KmPs5vsl4oIN8SWswFiq6Ax9OT4TCFd5zaV
 QcgEK_i9zJBy4mM5GsArwp07jKLIb_gsfVwkQCgJ8qERxBWcgnVHLt4a3VjQQN6ZwR6DhzpXpHsb
 tdPCegUFQLruNesgrBG_0ZwtfoHTGjtRogTb3t8aDeH2wxU1I2x908mJkhLh502tTA9iUdzn6y3s
 ur3l6udfzN.Nfng1J8e.6ah7xFbSixv..o76v3h.kcwc0ygnfgVLfBH1fwoxB649Qtpfm53CQ5bf
 d.T_fjo9.3xKhoW_SHxjD8X0C0zidYqj1XLAlWDu2qKru4oePY5y7UmcvxhEkL.auz609KY8CuBq
 uo7Rp9FYy8TTGdKlxY5nhNAs.r_6P0LjNMkeZ5PT0hk0ug5VIwNBHAuBuLHgx797ANfI5H38kfu8
 JU9U3fbkQI6_1NxgJAuuH7bUrPMalo93kyhhynioeQYMdP9ACoYO2k5B7PBlAu4wChS6eUvFP3AK
 q5B_E7hid2JzCC3U_AWaqlgJZJ7r7Cx_TySk1JvSkYMv626eE_d9zVCEojJtvn0N655j8sDPtHKi
 pckNu9Yv1uK7y6t0d45y4h42pECadPqKnzj5hD._v5GevwQNjhj.lAeSUt5z9cOEFk6oG4NGBZSB
 WCmmguyal3BdGnUSNEVJXxkL4YHqMBXkdtbcoAwjjBxE_EBd5TJnCdQ2mtvuwHG6.kqGWMDSztcr
 CJd0j2..Q7RS3JvZcWQIMmapjJUeWZWu7AsauP.Xj0ukfLa.xPKUaPfVFJIAkpVWFv2EVIsTwhB.
 3YNcXlTaZTSce6sum6hkm.HFS0.Ek2g6yZedqkEWM8i67KqI4Ht_0wd.Atr7b__tZLDDYlqgpA5Q
 Ixmp4CsNsCSXVdpy5m48YmDpiMDaPOCltR3FtMUsCnX98fIpx5niZBYcbdBgDpIOgq5FpBXtRPv3
 BZBY.GzSXMGd0RiwIEq2.SA7ny5Mrgn12_iqWYnkb8reS49Rea1KLuJyCInuuI7OnMHUjOkieO1C
 BQvyzYe1Ok722GTII1as7eti4sSjXvByZhhaZpcT0.4hqoWwiQHirWxdRVeVGGsK9GAVAV2TaIzv
 mtm6RQ_1Lb0LtuV38D5oRDOtnCJrNTozpQSB4J9faXIVK7.eQXz_eouo5EASS5y7MY4Ob.eVlUgk
 gIecsV0G_k6llEm7TzR43y97NxhZJkx6F2JlTRF1gFvGPBqAhi87VzCs6rFtEIe0v9VPZFR5BcHg
 v_RebYptqUbPAeGVkLTOjgvAYhhEcocj58oO2X8HaueWQ1MtsOe6IqcXW0vQmBNgAizhziOtDrmb
 5YSntsQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:18:17 +0000
Received: by hermes--canary-production-bf1-856dbf94db-ld7kl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8bd0cd8ed239bc60f51b90fd11ae18df;
          Thu, 09 Jun 2022 23:18:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v36 32/33] LSM: Add /proc attr entry for full LSM context
Date:   Thu,  9 Jun 2022 16:01:45 -0700
Message-Id: <20220609230146.319210-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
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
index 579feb93af49..a7b096f0383f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -803,6 +803,57 @@ static int lsm_superblock_alloc(struct super_block *sb)
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
@@ -2221,6 +2272,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int ilsm = lsm_task_ilsm(current);
 	int slot = 0;
 
@@ -2248,6 +2303,30 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
index d13024e30c49..072653808ce2 100644
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

