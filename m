Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2194D55FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbiCJXyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344973AbiCJXyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:54:10 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93F6D0070
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956387; bh=Cf7XpOaRoLb048SbSW7RBk/D7NmluyjJipC5MTUl6n8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hBJ6/nng+oKUdh8ODvyI7rY/vVI9GgfAXqgEKShXC9DQHJDiX1LOlIFH20u8sXfiTWvZR9ZSZRPtzG7OHQ+27/Ljdzfhd71hVZrtWelT7YD9nIht8n4cjFFwGPpiPDUkzSsX5jhYePHCpi6Q7wum8WrxuoY1bDLDl5MxLHALGo8kJh/H2VJhjZMJWZ8Jd4f77uR0hinRUqrKCYAANNi1vvSWjvApg2mdGGbLKFkkYw9C75023XUZFPXlNgJlsZARTjP+i9hDccubHXQSi+rZKx8sfgdvpYcL9OV/GjPGuoUf0jPjTmWJrERzMyEH06mY+tcbxSDoQtuEyGQ5n4g2og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646956387; bh=sVvzc2BHpfSD2QAQZcFxLWfl7+8op7mMDyj8RIWFaW7=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EuJA53hSzA/XyO862grM1sirx8p6cHJ6SDWdTT76/NFO0O7ZJKfTepkVM0kZ1IRuFVS31+cWw4bnuAy+TqkZzEM6y4Li3BFfumHAvMZMBTTON+76/o/97u+aLxiFMYKLGWk8FHgiQp365plFJm+uFM5KX+3z3BgAoWEJT6q5NsnndA7KJWc7EqONNcGygl2N7cTl3wLttJvyewl7y4N+qTvEKLckdgfCLHFTlpdwTH81zPSlIZjp6lCqUru65u3W+KrGrCVTggBzPGO2VFtxXYAJUEKARriyXn7SNCd7yotmhwkl+FU8CWweoEsvz4FpP6NIRkKLNyp9s3mTzarTAg==
X-YMail-OSG: cw92imwVM1mJjO39w8z85W3LmKlaM0Q8wJbztMIMG9kczvYzsSGVQfVLZZjmQLx
 lPGxCIN9wk217yv.WQr_jisBcuKuG2PfdZtUDpmZ24DoNS7yucBM7fvXZSgXeFoZmpmb8STt_3Cq
 UqEsvaZxMRCsgZSFRIWs1EOULFiuCjFPIvnnUg8bWBYYId0sOYMzYQe9oImV7EHR91R6OB5jJ4H7
 P0v8efilSq0fklgriUJi15XrEtmKIZc.FNbujIdPWpuvrLrJbeXc6o8GTKk1rtwxBoNw05kohxZZ
 ibv_lVqbN.MUgr6mBIm4Of9GE95opF99xNlcKguW_bugl5C_XoubvUCCa94qtCcVSM.OJTpbtmNh
 WryLMPFK45E7OAr2DUf4Iy3MfwyZuX4Epi0qugr6z8pcX712W_nS16JzMRAceQARJxNXJL_eOO2I
 kPGZn7frJlYmYQt05ww.KmwO4w6lpLEtBFGwvL32_S4OENkSZQWQFLvB6HxZf61CDf3D95wB94MC
 C0V8JkuNw55VTuZ48e5B5EsPUpOyruy26HzIR6nKKHrKO5aNCFfLo_qRWvglxn3N2dQ3GL4Oq9ul
 YAd7tSnVsnyPNtDog8n7o7yZmc4TKnV43i0BvsCcu84AVZBh5vhAZn9fTxSo8fWwGCjxqH7871je
 .i1sC4hhaIzbo5_JgeMbGsd587Vj_wnDGkU5T.zpxgfT9czSR68AneGm8eErY39JTN6VG1jXMWLx
 fBAvg01KqUVZKwzvJaYS6IfUVgkpjxGGdcmrAiODE8sWrXWzi14I42m0xtm.vlJHKq0e7fgylFa4
 hnlPVqKnmroNZDCmtgbcqod.a_.EruF51usTz0SrQR7W3g8WWCVGe.bmyf2ElGKDAMWyLsqPu2iW
 .yggY8cTXh9PsrK5y8ecnR0gjzDwfyqe7cQWfHNm1prIIE.S7.6nlYR5Kgc9GY_R9iIblX9cq1bl
 W1Ds7Wg6nAhHhr6lvdRCLEMlC3XfnTrTX11jBzZW21uFLoGaJlG5NUcMo1e5B_gMs2G6QzYjNban
 SMbz4HhWT4pJ6dHDGl1rbLtEXj6_lHnx.u3gfSs_fOmZGEbHokoerNrsT1ghCqmt0O425PdUGGB4
 LPEfPZSIyehq05hrfXnNLlJF35dtrAaIupe1ttnWgjZ7ruF8UOCSZDQzrApf8jxyRwstNECXYJ5E
 Co84cxIM.7CP.BXG2JYWkWRCv0I0MMK2qIigHXj1TyUu1rItoIFUH9uSJ0k4xU8VvfvqYyBSrpZ4
 p4VMAYdmq3nW1PhUdjtKTirNmm5iS2e5Mq3wqDQYl4dsSICojd.XLIu.ABG8HXYMpBhs7yedW9_1
 RltMbwSj_gQLjzGDpHTGz6086g0.ugeSbzm73Vi53pnXhdpBtSxrOzdKYo1Douu_UcibIO2J1olY
 c3uLEXrERPKEUb11d_a5tH3BOdD5nOMEWLqO7EqNHiWArm4AquhYyFw4hJjx0ddW7Sbh5DdgO0mf
 tbOXMUs5yVboooGYhXiM.HBq86Ot86mXKV0uESo4_aLVkcBmvejkv6PcDS4p3d50AlvVZkmNEaHk
 clMMvAu92hBinqq0SROzjZt_kyfnBsk2o1uXXO.6T.T1DADcP7xgENaHPaqgtivdvJTENKg0ZoRL
 iaOI7Yq._.RuVaE6GnNyrynNob1WNyTUXrE9CNnCKEWYE2Mc6J4nA.rXSzqC0e3lWqT3UJcJFqqs
 gG1fCPCaOv.Wwb4w884K5coVqnMhjR.vXlM2NBAj19mzZlkSl6qbbzcWxcsJ.BqboMXHqmtv_7Sk
 rNIktn4nPFB5.AsCC79nDmnZvHR0Qi7GmubEUtdvZDS0ljFCO8h8aLnuvVw_r44EAeSC4CvdHhT_
 uJ.dRmggEnvDdoNuzKNbRzinycpblLxUUIbKAFFgtMmu8VXXRVI_CBFMjjU.M9dAcmwjNAoork0q
 3MyV5.nQcStMDd1Pyhk6M2fRWioSvA6Z1HrZ0H3FJCXSyg4RcT0WBVmbXxRicIF8R1Gihy0E39Xu
 5Q2Zx5G8O79w9vfxDET8c7IPXbnuSt13tNAHyCNgkzTNrMU7owQbHZnQGILER1xQkNieieut99po
 6aelrAYx2V9cghWv_reAz_IOjimcVpMT8RVSZujtfqeB3xpsVXPbRg4YecJEneqb3_VZ8DZa18Ar
 scf54zWCWo_eDGxXLKTQ97YOZZvNDcvq5BUSA035Lm3X3q95ns3dsl0iy8Kf5MoCUQoc8SKQ._1X
 CShoKdQDqciJCPDTIv.tzAfTRAhX_K99oCSY0IT0_ssPra32p90tcFW6X1d3IkrLS3CJW.rgzLXt
 MlDdRVn9gkrFrT1nMjFuMbQrJeXQz0NltYZaMvQnk
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Mar 2022 23:53:07 +0000
Received: by kubenode525.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5fda70cf8d38a19ec9bc1b4fcf47812c;
          Thu, 10 Mar 2022 23:53:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v33 14/29] LSM: Specify which LSM to display
Date:   Thu, 10 Mar 2022 15:46:17 -0800
Message-Id: <20220310234632.16194-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220310234632.16194-1-casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
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

Create a new entry "interface_lsm" in the procfs attr directory for
controlling which LSM security information is displayed for a
process. A process can only read or write its own display value.

The name of an active LSM that supplies hooks for
human readable data may be written to "interface_lsm" to set the
value. The name of the LSM currently in use can be read from
"interface_lsm". At this point there can only be one LSM capable
of display active. A helper function lsm_task_ilsm() is
provided to get the interface lsm slot for a task_struct.

Setting the "interface_lsm" requires that all security modules using
setprocattr hooks allow the action. Each security module is
responsible for defining its policy.

AppArmor hook provided by John Johansen <john.johansen@canonical.com>
SELinux hook provided by Stephen Smalley <stephen.smalley.work@gmail.com>

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 .../ABI/testing/procfs-attr-lsm_display       |  22 +++
 Documentation/security/lsm.rst                |  14 ++
 fs/proc/base.c                                |   1 +
 include/linux/security.h                      |  17 ++
 security/apparmor/include/apparmor.h          |   3 +-
 security/apparmor/lsm.c                       |  32 ++++
 security/security.c                           | 166 ++++++++++++++++--
 security/selinux/hooks.c                      |  11 ++
 security/selinux/include/classmap.h           |   3 +-
 security/smack/smack_lsm.c                    |   7 +
 10 files changed, 257 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/procfs-attr-lsm_display

diff --git a/Documentation/ABI/testing/procfs-attr-lsm_display b/Documentation/ABI/testing/procfs-attr-lsm_display
new file mode 100644
index 000000000000..0f60005c235c
--- /dev/null
+++ b/Documentation/ABI/testing/procfs-attr-lsm_display
@@ -0,0 +1,22 @@
+What:		/proc/*/attr/lsm_display
+Contact:	linux-security-module@vger.kernel.org,
+Description:	The name of the Linux security module (LSM) that will
+		provide information in the /proc/*/attr/current,
+		/proc/*/attr/prev and /proc/*/attr/exec interfaces.
+		The details of permissions required to read from
+		this interface are dependent on the LSMs active on the
+		system.
+		A process cannot write to this interface unless it
+		refers to itself.
+		The other details of permissions required to write to
+		this interface are dependent on the LSMs active on the
+		system.
+		The format of the data used by this interface is a
+		text string identifying the name of an LSM. The values
+		accepted are:
+			selinux		- the SELinux LSM
+			smack		- the Smack LSM
+			apparmor	- The AppArmor LSM
+		By convention the LSM names are lower case and do not
+		contain special characters.
+Users:		LSM user-space
diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
index 6a2a2e973080..b77b4a540391 100644
--- a/Documentation/security/lsm.rst
+++ b/Documentation/security/lsm.rst
@@ -129,3 +129,17 @@ to identify it as the first security module to be registered.
 The capabilities security module does not use the general security
 blobs, unlike other modules. The reasons are historical and are
 based on overhead, complexity and performance concerns.
+
+LSM External Interfaces
+=======================
+
+The LSM infrastructure does not generally provide external interfaces.
+The individual security modules provide what external interfaces they
+require.
+
+The file ``/sys/kernel/security/lsm`` provides a comma
+separated list of the active security modules.
+
+The file ``/proc/pid/attr/interface_lsm`` contains the name of the security
+module for which the ``/proc/pid/attr/current`` interface will
+apply. This interface can be written to.
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d654ce7150fd..e0d41adb38ba 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2828,6 +2828,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "interface_lsm",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/security.h b/include/linux/security.h
index 955f75fc1007..9753bd9b4fdc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -220,6 +220,23 @@ static inline u32 lsmblob_value(const struct lsmblob *blob)
 	return 0;
 }
 
+/**
+ * lsm_task_ilsm - the "interface_lsm" for this task
+ * @task: The task to report on
+ *
+ * Returns the task's interface LSM slot.
+ */
+static inline int lsm_task_ilsm(struct task_struct *task)
+{
+#ifdef CONFIG_SECURITY
+	int *ilsm = task->security;
+
+	if (ilsm)
+		return *ilsm;
+#endif
+	return LSMBLOB_INVALID;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
index 1fbabdb565a8..b1622fcb4394 100644
--- a/security/apparmor/include/apparmor.h
+++ b/security/apparmor/include/apparmor.h
@@ -28,8 +28,9 @@
 #define AA_CLASS_SIGNAL		10
 #define AA_CLASS_NET		14
 #define AA_CLASS_LABEL		16
+#define AA_CLASS_DISPLAY_LSM	17
 
-#define AA_CLASS_LAST		AA_CLASS_LABEL
+#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
 
 /* Control parameters settable through module/boot flags */
 extern enum audit_mode aa_g_audit;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1e53fea61335..29181bc8c693 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -621,6 +621,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	return error;
 }
 
+
+static int profile_interface_lsm(struct aa_profile *profile,
+				 struct common_audit_data *sa)
+{
+	struct aa_perms perms = { };
+	unsigned int state;
+
+	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
+	if (state) {
+		aa_compute_perms(profile->policy.dfa, state, &perms);
+		aa_apply_modes_to_perms(profile, &perms);
+		aad(sa)->label = &profile->label;
+
+		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
+	}
+
+	return 0;
+}
+
 static int apparmor_setprocattr(const char *name, void *value,
 				size_t size)
 {
@@ -632,6 +651,19 @@ static int apparmor_setprocattr(const char *name, void *value,
 	if (size == 0)
 		return -EINVAL;
 
+	/* LSM infrastructure does actual setting of interface_lsm if allowed */
+	if (!strcmp(name, "interface_lsm")) {
+		struct aa_profile *profile;
+		struct aa_label *label;
+
+		aad(&sa)->info = "set interface lsm";
+		label = begin_current_label_crit_section();
+		error = fn_for_each_confined(label, profile,
+					profile_interface_lsm(profile, &sa));
+		end_current_label_crit_section(label);
+		return error;
+	}
+
 	/* AppArmor requires that the buffer must be null terminated atm */
 	if (args[size - 1] != '\0') {
 		/* null terminate */
diff --git a/security/security.c b/security/security.c
index 27154c39d109..0bca482166d8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -78,7 +78,16 @@ static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
 char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
+
+/*
+ * The task blob includes the "interface_lsm" slot used for
+ * chosing which module presents contexts.
+ * Using a long to avoid potential alignment issues with
+ * module assigned task blobs.
+ */
+static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
+	.lbs_task = sizeof(long),
+};
 
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_lsm_order;
@@ -672,6 +681,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -680,6 +691,15 @@ static int lsm_task_alloc(struct task_struct *task)
 	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
 	if (task->security == NULL)
 		return -ENOMEM;
+
+	/*
+	 * The start of the task blob contains the "interface" LSM slot number.
+	 * Start with it set to the invalid slot number, indicating that the
+	 * default first registered LSM be displayed.
+	 */
+	ilsm = task->security;
+	*ilsm = LSMBLOB_INVALID;
+
 	return 0;
 }
 
@@ -1739,14 +1759,26 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
+	int *oilsm = current->security;
+	int *nilsm;
 	int rc = lsm_task_alloc(task);
 
-	if (rc)
+	if (unlikely(rc))
 		return rc;
+
 	rc = call_int_hook(task_alloc, 0, task, clone_flags);
-	if (unlikely(rc))
+	if (unlikely(rc)) {
 		security_task_free(task);
-	return rc;
+		return rc;
+	}
+
+	if (oilsm) {
+		nilsm = task->security;
+		if (nilsm)
+			*nilsm = *oilsm;
+	}
+
+	return 0;
 }
 
 void security_task_free(struct task_struct *task)
@@ -2178,23 +2210,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
+	int slot = 0;
+
+	if (!strcmp(name, "interface_lsm")) {
+		/*
+		 * lsm_slot will be 0 if there are no displaying modules.
+		 */
+		if (lsm_slot == 0)
+			return -EINVAL;
+
+		/*
+		 * Only allow getting the current process' interface_lsm.
+		 * There are too few reasons to get another process'
+		 * interface_lsm and too many LSM policy issues.
+		 */
+		if (current != p)
+			return -EINVAL;
+
+		ilsm = lsm_task_ilsm(p);
+		if (ilsm != LSMBLOB_INVALID)
+			slot = ilsm;
+		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
+		if (*value)
+			return strlen(*value);
+		return -ENOMEM;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && ilsm != LSMBLOB_INVALID &&
+		    ilsm != hp->lsmid->slot)
+			continue;
 		return hp->hook.getprocattr(p, name, value);
 	}
 	return LSM_RET_DEFAULT(getprocattr);
 }
 
+/**
+ * security_setprocattr - Set process attributes via /proc
+ * @lsm: name of module involved, or NULL
+ * @name: name of the attribute
+ * @value: value to set the attribute to
+ * @size: size of the value
+ *
+ * Set the process attribute for the specified security module
+ * to the specified value. Note that this can only be used to set
+ * the process attributes for the current, or "self" process.
+ * The /proc code has already done this check.
+ *
+ * Returns 0 on success, an appropriate code otherwise.
+ */
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size)
 {
 	struct security_hook_list *hp;
+	char *termed;
+	char *copy;
+	int *ilsm = current->security;
+	int rc = -EINVAL;
+	int slot = 0;
+
+	if (!strcmp(name, "interface_lsm")) {
+		/*
+		 * Change the "interface_lsm" value only if all the security
+		 * modules that support setting a procattr allow it.
+		 * It is assumed that all such security modules will be
+		 * cooperative.
+		 */
+		if (size == 0)
+			return -EINVAL;
+
+		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
+				     list) {
+			rc = hp->hook.setprocattr(name, value, size);
+			if (rc < 0)
+				return rc;
+		}
+
+		rc = -EINVAL;
+
+		copy = kmemdup_nul(value, size, GFP_KERNEL);
+		if (copy == NULL)
+			return -ENOMEM;
+
+		termed = strsep(&copy, " \n");
+
+		for (slot = 0; slot < lsm_slot; slot++)
+			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
+				*ilsm = lsm_slotlist[slot]->slot;
+				rc = size;
+				break;
+			}
+
+		kfree(termed);
+		return rc;
+	}
 
 	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
+		if (lsm == NULL && *ilsm != LSMBLOB_INVALID &&
+		    *ilsm != hp->lsmid->slot)
+			continue;
 		return hp->hook.setprocattr(name, value, size);
 	}
 	return LSM_RET_DEFAULT(setprocattr);
@@ -2214,15 +2333,15 @@ EXPORT_SYMBOL(security_ismaclabel);
 int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
-					      secdata, seclen);
-		if (rc != LSM_RET_DEFAULT(secid_to_secctx))
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secid_to_secctx(
+					blob->secid[hp->lsmid->slot],
+					secdata, seclen);
 	}
 
 	return LSM_RET_DEFAULT(secid_to_secctx);
@@ -2233,16 +2352,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
 			     struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc;
+	int ilsm = lsm_task_ilsm(current);
 
 	lsmblob_init(blob, 0);
 	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.secctx_to_secid(secdata, seclen,
-					      &blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			return rc;
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.secctx_to_secid(secdata, seclen,
+						&blob->secid[hp->lsmid->slot]);
 	}
 	return 0;
 }
@@ -2250,7 +2368,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	call_void_hook(release_secctx, secdata, seclen);
+	struct security_hook_list *hp;
+	int ilsm = lsm_task_ilsm(current);
+
+	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot) {
+			hp->hook.release_secctx(secdata, seclen);
+			return;
+		}
 }
 EXPORT_SYMBOL(security_release_secctx);
 
@@ -2391,8 +2516,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
-				optval, optlen, len);
+	int ilsm = lsm_task_ilsm(current);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
+			     list)
+		if (ilsm == LSMBLOB_INVALID || ilsm == hp->lsmid->slot)
+			return hp->hook.socket_getpeersec_stream(sock, optval,
+								 optlen, len);
+	return -ENOPROTOOPT;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d67bcd1aeaf5..3469ffe195e6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6405,6 +6405,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	/*
 	 * Basic control over ability to set these attributes at all.
 	 */
+
+	/*
+	 * For setting interface_lsm, we only perform a permission check;
+	 * the actual update to the interface_lsm value is handled by the
+	 * LSM framework.
+	 */
+	if (!strcmp(name, "interface_lsm"))
+		return avc_has_perm(&selinux_state,
+				    mysid, mysid, SECCLASS_PROCESS2,
+				    PROCESS2__SETINTERFACE_LSM, NULL);
+
 	if (!strcmp(name, "exec"))
 		error = avc_has_perm(&selinux_state,
 				     mysid, mysid, SECCLASS_PROCESS,
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 35aac62a662e..79b480983bdc 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -53,7 +53,8 @@ struct security_class_mapping secclass_map[] = {
 	    "execmem", "execstack", "execheap", "setkeycreate",
 	    "setsockcreate", "getrlimit", NULL } },
 	{ "process2",
-	  { "nnp_transition", "nosuid_transition", NULL } },
+	  { "nnp_transition", "nosuid_transition", "setinterface_lsm",
+	    NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff832d47479f..3c1cf65cac87 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3516,6 +3516,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	struct smack_known_list_elem *sklep;
 	int rc;
 
+	/*
+	 * Allow the /proc/.../attr/current and SO_PEERSEC "interface_lsm"
+	 * to be reset at will.
+	 */
+	if (strcmp(name, "interface_lsm") == 0)
+		return 0;
+
 	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
 		return -EPERM;
 
-- 
2.31.1

