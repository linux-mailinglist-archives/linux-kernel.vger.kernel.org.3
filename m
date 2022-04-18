Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCFD505B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345424AbiDRPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbiDRPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:38:59 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5482C7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294089; bh=Mc99k5LJl1NLZ3vwr3RCF20H2bsg0Mu/p0/f5FknUa0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=D8lrLN6oStFphaA+ugoHbcXUIfNi92K0b+P8UXdBt+BmGPFjFx4peRBpDVXhZIm7dp+ZOhLshPXsEtv3UjklEx0tEkvZBPZ/wGKnEfXIRWklrTLHBXMDZzNGdU0ousJO+2BiKbPHipygo+fkhEDEp77PA3WnRzqyGG9LoFfJwVFopJMEjsM+7Es+I4RTZxl61O+yLJ8B4z6ymDrV4Mv9e10cZTn17zLJRUGA+N0rWL4QI1/OcJl+ZFGb+jy43nWqqTw/SGaw3RrAhMX0tAQpyKNVjefZuYL98Cb1I+bIzaH3nODQwXDC8ZQTM6loA3O1+UljOlzj+4P+Rpzt2fIGiw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650294089; bh=LNSOwznnzLPNrJQyNnDMP3+r0kgPoszHtGeuRo10+L1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OFLgGGJx2zxNra9EL8hBaiDvfYYArWjChnDbmKd/YJwPlhiKIO1yO3YCHZjGslB8OIo9NP3lblzPBWpole4M8Bl1AILHgd4djQjVu45vbMbih3GHiFk3Ff4Dv2YBWu813HGmILEsABCDXgGTkv2e4RndeYwmJJ+esC3FCelKs9xXErlvwEAAu9EXLEHWz7D9vjzPcjCKJSmVpCwwkI/ery2ILkh9Bl/Feehi4en9sqRz+5GtZgCVW33fTNrSNNtzAVX0xmiH4/tKoKvUkEg0svn8cl41zAREschvtTS29gvJEfOz4gNCSQBx4pcZyOb0WMEkRBm6IIM3RZAze4grlg==
X-YMail-OSG: xHKeIuQVM1lQKYFJWtO_xtbx2IeizCeMk.2M0J8ahA0_Cmo0eqa9K4ylssacqcG
 uHtbplq8dadI7BBCIFLoqMtmBrUVFs.7CDiSS5o5E91HLpdQg8X0jaM14Hi..1pmBbhPNYlZ65ag
 2R7hTOEMwqLueekTmXfQITjo9JTccRZwRPR6UBayZRiA44YEJgy.U7GWjMikUcwKmX5Leo7CGuEc
 GebKhPkJBDRyHQgfsedBqUaG5lQrWQgaNpSd.NUP13DmWpOnShaJ27sFcWvWyrRgzMIxDiPjcXER
 5deMz.UKiURmHA.Ah1Uktf4FCC3xtxW7yQMQWTviorlE7aU7nrWIsJvciwpO5r76FLKNKQ3lZr7Y
 p4SmToCB5mmHeUh999MQr2RFOInnmgXiP8WIev.eMP6H2A6bryBLDS2x5V4goJb4czev4Eh3gWT7
 pAXkr4JOiAHZs.fHvjDxkUI.A_qnyq6syJyjiATPHFLVUoODUacf2moSWvFx6ifTShyQgyaUKdwe
 NnTlpJAH1_SPNSJZAsQNpqX4pYIWds4cGILAQdc0Axjo_KcpVDks4YHjk4VZYcP34vVpizjdaKBQ
 IFd86j3kYpSy156xqZOIZWxWyH_r0AfPn7EByVyFcVIffW5bs2ELlAwnHQMU58IrkyE39ZgMw.Jc
 veQXgkD6KRGY3FaJCKOIjfRz5hgoKoZkUnmLyhGjyu4IwtESYjVpeR0hO6jzDJn5UJ2Qm..0w_g9
 BVDbcl6eQ.dsyF1qxmHi8fdVMa.eORgkke2ZZqYIDd.rSLxkhBLOrbhShP5zYv8j2KtVzr.SNM2g
 yr07hrxULe6U3T8OA9Qd_XyrWqo.uPRzKL.Bn8T0ES.wvSX8d90Plz2_daHh6.ius3rOXrpKJdz2
 ngOppaVH02AEMwRaBIECxav9GXmP4FPVwRfbSOYP0DzfJXNXZ4Pjh4mDgkX1QWZ6Uc.49pR3mitg
 IfZnkD37lYwsspzH.N5CHkOcu1GDTbsIRnOhbA_yICJntfpL6sw7rpGXpSPCWmfxA552AWfSn6Ut
 cSIAJRcj28EzH_85XOSYl_KGRPi6fmYh7VjYB0BUNtQrtdaz5nzpZDsdF0NsH0pazBZrYY9wNIx2
 nXZoZiEygss5NWN6CLIaRdXQ8TnJ17CHDd2y1vIdJF13Ioftw7P1QJ5co7aVqDuAip09UPtBc9dB
 tymT2wbXO2GzVfJjpAKEMyrlg1f3eqiJyVmIRYQ0jB7c4C0clwD23mknRgL5qAtZonw6ToDlXDR9
 2O4yF_pAJvVNOuk.1GMztMlDGlgxTCy_dBtydKyAK6mesgGpsOp4lpwjzDE1XH.jTUQVzwmfLVNX
 mMS.5UTSIjGjkIH7nnU79LZFlev9UzZuM2SBQjbLIer489bAnE2Gsf4icWsI3j0RrHE1KstkvcXo
 F7fuZsa_bUdl4LjLH3HaR3hvURDehCrTb9FWkXDRS2q8SXv9dgolgiy95Bm6QFBbL6A9MkH2P9F.
 5HgKtDgHuc3loTuHW8Tih.gXG.iA5VH0grjouHJnbD1F6qtcghohwF2Ny1BbsdKF6EeYR7hNBlnR
 4Svqxb0Lzx7MeNFPh5lQnmw0PncO.8tRSrmhUgkG6sM4IS.tKLO7de5xviuR6enuYwDyyDMKY26Y
 86mqYx9NGNnWXJilfD6ECyBoShFrggReVnR2uMlbSGoufqZXnYOFnXG6XUaP6xS2fb7KccFSLKwm
 ZxRmv32b.ILaDalk24flUQY8Geys8FgwlsB__Z8FA3cabUM_J5T8qq9WSYrUFJSsDnoHFRA8WBrH
 .1NxI4l6xT7Bo.5XPgHDdGW.mBFxlDQP9qXhslYkPmu7rzA8M_NSDgtaOwSo6MoiX02yIfp91og1
 P4L_f.lgz2JDRasvJPznepowALjtS.DFGxVMii9VvPqbJOiJoymGopFx6ngx9XsMjTglsQROIbaC
 avZCKTSa2MoJVx7LFNGQsjUOTdu9k1uHLM4Q4XdGFnyWTgm61788weWwcr1C81p5wgTgDgFE2QAi
 6iVh_zkSdk8eHH7vJWo05YW3Ur0zlh_sTnFqWa_ZarfEfE8SqXD3mrK6I5K34XUoYqqhT8yze_zN
 LnViPUwDAVrcGb1mXIzB_6Qu.5U7oNwreWnsPWZ2xDqwXsw7umnisOdagDhqPSlGszqy9dnMMFhP
 IQnvvU0m0x.TttGnCeY_LvQSG7QNT3qNNYs73bulasVA.vfHiLDa3K9F38kSXT2x_1I0nD1lslQr
 CeaHUo__bFRGZXV.EhApqD26SEHW2lFSmRWqTIlqmSEljcpzOQcuX98e.Mn_Pwctz96sKmuSlmUa
 GAfanOE.sYdElg6DDwOE5uz6H5g6tYamz1Zd3Sd3mmW46L3k3Dw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Apr 2022 15:01:29 +0000
Received: by hermes--canary-production-ne1-c7c4f6977-qcc8c (VZM Hermes SMTP Server) with ESMTPA ID becb8feefeabb669980d2a553c076f56;
          Mon, 18 Apr 2022 15:01:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v35 03/29] LSM: Add the lsmblob data structure.
Date:   Mon, 18 Apr 2022 07:59:19 -0700
Message-Id: <20220418145945.38797-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418145945.38797-1-casey@schaufler-ca.com>
References: <20220418145945.38797-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

The lsmblob structure is currently an array of
u32 "secids". There is an entry for each of the
security modules built into the system that would
use secids if active. The system assigns the module
a "slot" when it registers hooks. If modules are
compiled in but not registered there will be unused
slots.

A new lsm_id structure, which contains the name
of the LSM and its slot number, is created. There
is an instance for each LSM, which assigns the name
and passes it to the infrastructure to set the slot.

The audit rules data is expanded to use an array of
security module data rather than a single instance.
A new structure audit_lsm_rules is defined to avoid the
confusion which commonly accompanies the use of
void ** parameters.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mickaël Salaün <mic@linux.microsoft.com>
---
 include/linux/audit.h        | 10 ++++-
 include/linux/lsm_hooks.h    | 12 +++++-
 include/linux/security.h     | 75 ++++++++++++++++++++++++++++++---
 kernel/auditfilter.c         | 23 +++++-----
 kernel/auditsc.c             | 17 +++-----
 security/apparmor/lsm.c      |  7 ++-
 security/bpf/hooks.c         | 12 +++++-
 security/commoncap.c         |  7 ++-
 security/landlock/cred.c     |  2 +-
 security/landlock/fs.c       |  2 +-
 security/landlock/ptrace.c   |  2 +-
 security/landlock/setup.c    |  5 +++
 security/landlock/setup.h    |  1 +
 security/loadpin/loadpin.c   |  8 +++-
 security/lockdown/lockdown.c |  7 ++-
 security/safesetid/lsm.c     |  8 +++-
 security/security.c          | 82 ++++++++++++++++++++++++++++++------
 security/selinux/hooks.c     |  8 +++-
 security/smack/smack_lsm.c   |  7 ++-
 security/tomoyo/tomoyo.c     |  8 +++-
 security/yama/yama_lsm.c     |  7 ++-
 21 files changed, 254 insertions(+), 56 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index d06134ac6245..14849d5f84b4 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/sched.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 #include <linux/audit_arch.h>
 #include <uapi/linux/audit.h>
 #include <uapi/linux/netfilter/nf_tables.h>
@@ -59,6 +60,10 @@ struct audit_krule {
 /* Flag to indicate legacy AUDIT_LOGINUID unset usage */
 #define AUDIT_LOGINUID_LEGACY		0x1
 
+struct audit_lsm_rules {
+	void	*rule[LSMBLOB_ENTRIES];
+};
+
 struct audit_field {
 	u32				type;
 	union {
@@ -66,8 +71,9 @@ struct audit_field {
 		kuid_t			uid;
 		kgid_t			gid;
 		struct {
-			char		*lsm_str;
-			void		*lsm_rule;
+			bool			lsm_isset;
+			char			*lsm_str;
+			struct audit_lsm_rules	lsm_rules;
 		};
 	};
 	u32				op;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 14d88e1312eb..fd63ae215104 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1587,6 +1587,14 @@ struct security_hook_heads {
 	#undef LSM_HOOK
 } __randomize_layout;
 
+/*
+ * Information that identifies a security module.
+ */
+struct lsm_id {
+	const char	*lsm;	/* Name of the LSM */
+	int		slot;	/* Slot in lsmblob if one is allocated */
+};
+
 /*
  * Security module hook list structure.
  * For use with generic list macros for common operations.
@@ -1595,7 +1603,7 @@ struct security_hook_list {
 	struct hlist_node		list;
 	struct hlist_head		*head;
 	union security_list_options	hook;
-	char				*lsm;
+	struct lsm_id			*lsmid;
 } __randomize_layout;
 
 /*
@@ -1631,7 +1639,7 @@ extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+			       struct lsm_id *lsmid);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/include/linux/security.h b/include/linux/security.h
index 2986342dad41..ed51baa94a30 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -39,6 +39,7 @@ struct kernel_siginfo;
 struct sembuf;
 struct kern_ipc_perm;
 struct audit_context;
+struct audit_lsm_rules;
 struct super_block;
 struct inode;
 struct dentry;
@@ -134,6 +135,66 @@ enum lockdown_reason {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 
+/*
+ * Data exported by the security modules
+ *
+ * Any LSM that provides secid or secctx based hooks must be included.
+ */
+#define LSMBLOB_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
+
+struct lsmblob {
+	u32     secid[LSMBLOB_ENTRIES];
+};
+
+#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
+#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
+#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
+
+/**
+ * lsmblob_init - initialize a lsmblob structure
+ * @blob: Pointer to the data to initialize
+ * @secid: The initial secid value
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		blob->secid[i] = secid;
+}
+
+/**
+ * lsmblob_is_set - report if there is a value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a secid set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	const struct lsmblob empty = {};
+
+	return !!memcmp(blob, &empty, sizeof(*blob));
+}
+
+/**
+ * lsmblob_equal - report if the two lsmblob's are equal
+ * @bloba: Pointer to one LSM data
+ * @blobb: Pointer to the other LSM data
+ *
+ * Returns true if all entries in the two are equal, false otherwise
+ */
+static inline bool lsmblob_equal(const struct lsmblob *bloba,
+				 const struct lsmblob *blobb)
+{
+	return !memcmp(bloba, blobb, sizeof(*bloba));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -1887,15 +1948,17 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 #ifdef CONFIG_SECURITY
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+			     struct audit_lsm_rules *lsmrules);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
-void security_audit_rule_free(void *lsmrule);
+int security_audit_rule_match(u32 secid, u32 field, u32 op,
+			      struct audit_lsm_rules *lsmrules);
+void security_audit_rule_free(struct audit_lsm_rules *lsmrules);
 
 #else
 
 static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+					   struct audit_lsm_rules *lsmrules)
 {
 	return 0;
 }
@@ -1906,12 +1969,12 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 }
 
 static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+					    struct audit_lsm_rules *lsmrules)
 {
 	return 0;
 }
 
-static inline void security_audit_rule_free(void *lsmrule)
+static inline void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 { }
 
 #endif /* CONFIG_SECURITY */
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 42d99896e7a6..de75bd6ad866 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -76,7 +76,7 @@ static void audit_free_lsm_field(struct audit_field *f)
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		kfree(f->lsm_str);
-		security_audit_rule_free(f->lsm_rule);
+		security_audit_rule_free(&f->lsm_rules);
 	}
 }
 
@@ -529,7 +529,7 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			entry->rule.buflen += f_val;
 			f->lsm_str = str;
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       &f->lsm_rules);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -782,7 +782,7 @@ static int audit_compare_rule(struct audit_krule *a, struct audit_krule *b)
 	return 0;
 }
 
-/* Duplicate LSM field information.  The lsm_rule is opaque, so must be
+/* Duplicate LSM field information.  The lsm_rules is opaque, so must be
  * re-initialized. */
 static inline int audit_dupe_lsm_field(struct audit_field *df,
 					   struct audit_field *sf)
@@ -796,9 +796,9 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 		return -ENOMEM;
 	df->lsm_str = lsm_str;
 
-	/* our own (refreshed) copy of lsm_rule */
+	/* our own (refreshed) copy of lsm_rules */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       &df->lsm_rules);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
@@ -850,7 +850,7 @@ struct audit_entry *audit_dupe_rule(struct audit_krule *old)
 	new->tree = old->tree;
 	memcpy(new->fields, old->fields, sizeof(struct audit_field) * fcount);
 
-	/* deep copy this information, updating the lsm_rule fields, because
+	/* deep copy this information, updating the lsm_rules fields, because
 	 * the originals will all be freed when the old rule is freed. */
 	for (i = 0; i < fcount; i++) {
 		switch (new->fields[i].type) {
@@ -1367,10 +1367,11 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_TYPE:
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
-				if (f->lsm_rule) {
+				if (f->lsm_str) {
 					security_current_getsecid_subj(&sid);
 					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+						   f->type, f->op,
+						   &f->lsm_rules);
 				}
 				break;
 			case AUDIT_EXE:
@@ -1397,7 +1398,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 	return ret;
 }
 
-static int update_lsm_rule(struct audit_krule *r)
+static int update_lsm_rules(struct audit_krule *r)
 {
 	struct audit_entry *entry = container_of(r, struct audit_entry, rule);
 	struct audit_entry *nentry;
@@ -1429,7 +1430,7 @@ static int update_lsm_rule(struct audit_krule *r)
 	return err;
 }
 
-/* This function will re-initialize the lsm_rule field of all applicable rules.
+/* This function will re-initialize the lsm_rules field of all applicable rules.
  * It will traverse the filter lists serarching for rules that contain LSM
  * specific filter fields.  When such a rule is found, it is copied, the
  * LSM field is re-initialized, and the old rule is replaced with the
@@ -1444,7 +1445,7 @@ int audit_update_lsm_rules(void)
 
 	for (i = 0; i < AUDIT_NR_FILTERS; i++) {
 		list_for_each_entry_safe(r, n, &audit_rules_list[i], list) {
-			int res = update_lsm_rule(r);
+			int res = update_lsm_rules(r);
 			if (!err)
 				err = res;
 		}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ea2ee1181921..d272b5cf18a8 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -664,7 +664,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->lsm_rule) {
+			if (f->lsm_str) {
 				if (need_sid) {
 					/* @tsk should always be equal to
 					 * @current with the exception of
@@ -679,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
-								   f->op,
-								   f->lsm_rule);
+							f->op, &f->lsm_rules);
 			}
 			break;
 		case AUDIT_OBJ_USER:
@@ -690,21 +689,19 @@ static int audit_filter_rules(struct task_struct *tsk,
 		case AUDIT_OBJ_LEV_HIGH:
 			/* The above note for AUDIT_SUBJ_USER...AUDIT_SUBJ_CLR
 			   also applies here */
-			if (f->lsm_rule) {
+			if (f->lsm_str) {
 				/* Find files that match */
 				if (name) {
 					result = security_audit_rule_match(
 								name->osid,
 								f->type,
 								f->op,
-								f->lsm_rule);
+								&f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
 						if (security_audit_rule_match(
-								n->osid,
-								f->type,
-								f->op,
-								f->lsm_rule)) {
+							n->osid, f->type, f->op,
+							&f->lsm_rules)) {
 							++result;
 							break;
 						}
@@ -715,7 +712,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 					break;
 				if (security_audit_rule_match(ctx->ipc.osid,
 							      f->type, f->op,
-							      f->lsm_rule))
+							      &f->lsm_rules))
 					++result;
 			}
 			break;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index be8976c407f4..1e53fea61335 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1168,6 +1168,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_sock = sizeof(struct aa_sk_ctx),
 };
 
+static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
+	.lsm  = "apparmor",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1853,7 +1858,7 @@ static int __init apparmor_init(void)
 		goto buffers_out;
 	}
 	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+				&apparmor_lsmid);
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index e5971fa74fd7..7a58fe9ab8c4 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -15,9 +15,19 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
+/*
+ * slot has to be LSMBLOB_NEEDED because some of the hooks
+ * supplied by this module require a slot.
+ */
+struct lsm_id bpf_lsmid __lsm_ro_after_init = {
+	.lsm = "bpf",
+	.slot = LSMBLOB_NEEDED
+};
+
 static int __init bpf_lsm_init(void)
 {
-	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
+	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
+			   &bpf_lsmid);
 	pr_info("LSM support for eBPF active\n");
 	return 0;
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 5fc8986c3c77..c94ec46e07ac 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1446,6 +1446,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
 
 #ifdef CONFIG_SECURITY
 
+static struct lsm_id capability_lsmid __lsm_ro_after_init = {
+	.lsm  = "capability",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capable, cap_capable),
 	LSM_HOOK_INIT(settime, cap_settime),
@@ -1470,7 +1475,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
-				"capability");
+			   &capability_lsmid);
 	return 0;
 }
 
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index 6725af24c684..56b121d65436 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -42,5 +42,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_cred_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			LANDLOCK_NAME);
+			&landlock_lsmid);
 }
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 97b8e421f617..319e90e9290c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -688,5 +688,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_fs_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			LANDLOCK_NAME);
+			&landlock_lsmid);
 }
diff --git a/security/landlock/ptrace.c b/security/landlock/ptrace.c
index f55b82446de2..54ccf55a077a 100644
--- a/security/landlock/ptrace.c
+++ b/security/landlock/ptrace.c
@@ -116,5 +116,5 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 __init void landlock_add_ptrace_hooks(void)
 {
 	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
-			LANDLOCK_NAME);
+			&landlock_lsmid);
 }
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index f8e8e980454c..759e00b9436c 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -23,6 +23,11 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
+struct lsm_id landlock_lsmid __lsm_ro_after_init = {
+	.lsm = LANDLOCK_NAME,
+	.slot = LSMBLOB_NOT_NEEDED,
+};
+
 static int __init landlock_init(void)
 {
 	landlock_add_cred_hooks();
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 1daffab1ab4b..38bce5b172dc 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -14,5 +14,6 @@
 extern bool landlock_initialized;
 
 extern struct lsm_blob_sizes landlock_blob_sizes;
+extern struct lsm_id landlock_lsmid;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b12f7d986b1e..b569f3bc170b 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -192,6 +192,11 @@ static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
+static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
+	.lsm  = "loadpin",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
 	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
@@ -239,7 +244,8 @@ static int __init loadpin_init(void)
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	parse_exclude();
-	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
+			   &loadpin_lsmid);
 	return 0;
 }
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 87cbdc64d272..4e24ea3f7b7e 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -75,6 +75,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
 };
 
+static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
+	.lsm = "lockdown",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static int __init lockdown_lsm_init(void)
 {
 #if defined(CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY)
@@ -83,7 +88,7 @@ static int __init lockdown_lsm_init(void)
 	lock_kernel_down("Kernel configuration", LOCKDOWN_CONFIDENTIALITY_MAX);
 #endif
 	security_add_hooks(lockdown_hooks, ARRAY_SIZE(lockdown_hooks),
-			   "lockdown");
+			   &lockdown_lsmid);
 	return 0;
 }
 
diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 963f4ad9cb66..0c368950dc14 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -241,6 +241,11 @@ static int safesetid_task_fix_setgid(struct cred *new,
 	return -EACCES;
 }
 
+static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
+	.lsm  = "safesetid",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list safesetid_security_hooks[] = {
 	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
 	LSM_HOOK_INIT(task_fix_setgid, safesetid_task_fix_setgid),
@@ -250,7 +255,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
 static int __init safesetid_security_init(void)
 {
 	security_add_hooks(safesetid_security_hooks,
-			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
+			   ARRAY_SIZE(safesetid_security_hooks),
+			   &safesetid_lsmid);
 
 	/* Report that SafeSetID successfully initialized */
 	safesetid_initialized = 1;
diff --git a/security/security.c b/security/security.c
index d956912741d5..49fa61028da2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -345,6 +345,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size         = %zu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -472,21 +473,38 @@ static int lsm_append(const char *new, char **result)
 	return 0;
 }
 
+/*
+ * Current index to use while initializing the lsmblob secid list.
+ */
+static int lsm_slot __lsm_ro_after_init;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
  * @count: the number of hooks to add
- * @lsm: the name of the security module
+ * @lsmid: the identification information for the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * If the LSM is using hooks that export secids allocate a slot
+ * for it in the lsmblob.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+			       struct lsm_id *lsmid)
 {
 	int i;
 
+	WARN_ON(!lsmid->slot || !lsmid->lsm);
+
+	if (lsmid->slot == LSMBLOB_NEEDED) {
+		if (lsm_slot >= LSMBLOB_ENTRIES)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsmid->slot = lsm_slot++;
+		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
+			   lsmid->slot);
+	}
+
 	for (i = 0; i < count; i++) {
-		hooks[i].lsm = lsm;
+		hooks[i].lsmid = lsmid;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
 	}
 
@@ -495,7 +513,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	 * and fix this up afterwards.
 	 */
 	if (slab_is_available()) {
-		if (lsm_append(lsm, &lsm_names) < 0)
+		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
 			panic("%s - Cannot get early memory.\n", __func__);
 	}
 }
@@ -2088,7 +2106,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
@@ -2101,7 +2119,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 	struct security_hook_list *hp;
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
-		if (lsm != NULL && strcmp(lsm, hp->lsm))
+		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
@@ -2599,9 +2617,27 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int security_audit_rule_init(u32 field, u32 op, char *rulestr,
+			     struct audit_lsm_rules *lsmrules)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	struct security_hook_list *hp;
+	bool one_is_good = false;
+	int rc = 0;
+	int trc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_init, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		trc = hp->hook.audit_rule_init(field, op, rulestr,
+					&lsmrules->rule[hp->lsmid->slot]);
+		if (trc == 0)
+			one_is_good = true;
+		else
+			rc = trc;
+	}
+	if (one_is_good)
+		return 0;
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
@@ -2609,14 +2645,36 @@ int security_audit_rule_known(struct audit_krule *krule)
 	return call_int_hook(audit_rule_known, 0, krule);
 }
 
-void security_audit_rule_free(void *lsmrule)
+void security_audit_rule_free(struct audit_lsm_rules *lsmrules)
 {
-	call_void_hook(audit_rule_free, lsmrule);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		if (lsmrules->rule[hp->lsmid->slot] == NULL)
+			continue;
+		hp->hook.audit_rule_free(lsmrules->rule[hp->lsmid->slot]);
+	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(u32 secid, u32 field, u32 op,
+			      struct audit_lsm_rules *lsmrules)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		if (lsmrules->rule[hp->lsmid->slot] == NULL)
+			continue;
+		rc = hp->hook.audit_rule_match(secid, field, op,
+					&lsmrules->rule[hp->lsmid->slot]);
+		if (rc)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7aca813b5826..429309d8a910 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6992,6 +6992,11 @@ static int selinux_uring_sqpoll(void)
 }
 #endif /* CONFIG_IO_URING */
 
+static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
+	.lsm  = "selinux",
+	.slot = LSMBLOB_NEEDED
+};
+
 /*
  * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
  * 1. any hooks that don't belong to (2.) or (3.) below,
@@ -7308,7 +7313,8 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
+			   &selinux_lsmid);
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2689486160a2..6e0eaecd8256 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4744,6 +4744,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
+static struct lsm_id smack_lsmid __lsm_ro_after_init = {
+	.lsm  = "smack",
+	.slot = LSMBLOB_NEEDED
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4947,7 +4952,7 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index b6a31901f289..e8f6bb9782c1 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -521,6 +521,11 @@ static void tomoyo_task_free(struct task_struct *task)
 	}
 }
 
+static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
+	.lsm  = "tomoyo",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -573,7 +578,8 @@ static int __init tomoyo_init(void)
 	struct tomoyo_task *s = tomoyo_task(current);
 
 	/* register ourselves with the security framework */
-	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
+	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
+			   &tomoyo_lsmid);
 	pr_info("TOMOYO Linux initialized\n");
 	s->domain_info = &tomoyo_kernel_domain;
 	atomic_inc(&tomoyo_kernel_domain.users);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 06e226166aab..a9639ea541f7 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -421,6 +421,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
 	return rc;
 }
 
+static struct lsm_id yama_lsmid __lsm_ro_after_init = {
+	.lsm  = "yama",
+	.slot = LSMBLOB_NOT_NEEDED
+};
+
 static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
@@ -477,7 +482,7 @@ static inline void yama_init_sysctl(void) { }
 static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
-	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
+	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
 	yama_init_sysctl();
 	return 0;
 }
-- 
2.35.1

