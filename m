Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE41B503062
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355809AbiDOV3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355240AbiDOV2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:28:47 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2D3A5C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057894; bh=qWirYQox07XOTVDcUrrg8xs3C9TRpx0QbTKULbb9FEM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kGMaPHIhmoQMOhTrFs7avkBuiD9M2i77wVeRwvEqX840z7jfbZxyXm5/y2teFj57nSXyetgzJQmEA4aTnXgANTtV+wqfJ7NEsb8b3BOnDhlSj14HcCNs9yK8hVXvTGVhQbwqJtpxU5M7xFk7bBl6yK6NrRGNOwmgAUjQwCFxeAUfCnqb/RAUBRRGYEGoIcyW2t+J0cXwgDuoLuY4/Bu/ZOfOcjIArPMs0gO1M2PZGFsgTnCwlJKudp74Axx7PEa1NrZbmFMQWfjsGAoFgi1lriR2YtH9NwXXg4GUoygrvPAjQR3L2M0i3M2+PaIGWplqbqtCtIaOlOEGj6j3chlDtQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1650057894; bh=HQSgFO9FMFRd7UBjwb1ctsP/Y+D+4AAyUVRUyox6qsB=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=J3EWxO7Cs+ugnXrAKRDpTIL7RSb/i9j0SUFd1v/0azG3CpWPf6MaAm8FV4HOyM4vsaBxdDJV32eBngqyV0958Q4b9f0WsTVndLqUY1+BrrwvWPQ12yqTSGIg6R0t91Sn6wao1v6Nw0MV4foctnH6jb9m1sevlyUTPlj6eFyYNwQMTdB99a9VFFp0dTdHA5iBmBjsSkm6Qtu1HHOaN/GVYM50osnRiawJgVRFXBL0vK5BO67+KGpdu9BNy7cPDX3ApyI71p8SHFSmFxLx/5jYSpah0g4bNIMYSvzIhnpkFsAPJcBcpl0ir69OlXsg91nIPMiC7aZthMKMb1GkxTMayA==
X-YMail-OSG: qL6.tBAVM1nzQ_4frHdlTlCnaXvSKiyg9mxo_ZayF1.3FIN2lsSpU21NGSrlaSQ
 H_Puc2qhwC_bkImEmvbDs0hEu6tUJKVqfxKKjsT_LoGvYOFFWL7kIMmnoWdFzxLhYoX9I_HlF4aX
 xSdZ_3W3JJB6IDif.7w7AzqdXWpSdTD4xznzM38_yLF_hDw.ekQtt4Ma0fKR5CQlhtYJ5CrwtSxL
 uB_tSAjUtRjzFCRhgm01l2d5rv0fYaasNM2McyI8uThs2QS09uBiEl3kImaeulPV0oB6NhI_0OxF
 cqIk.GHsVTKWj8_V7_2a26NrcGVV7NedqltoM4q0pGI._uRxbwIBB29HnbWsDxRUvRwj5LcPKRF_
 xslSDkIUwwED7X5S6ay3wkXXGdNk31KOUcuWvgkElwM5wpquiTq0xCzRZlEvD0e9f3ecXTyn8t84
 k953Q55Wz5NZHhKZUcomgOtP8jYJ0LdEN67g8cw.godcUQPNAqf89ISWysXTFujCRWGesP0ZSHSj
 01OcjkSZM7ry7.zCozIaJ.lebM.WfrFQwE43GBUQpmyqeKiI4AIGguojtTYf1o85aOork2rSLmGO
 SpmgKMAmimGY.1CKS4_UfeREI1dAIlodRFqrk.ifLy4mLCTcT3ctpRu8Suehq4n8SJVyGDItnG79
 BvY8XV83_da.1JkAFUh2bVMHaZSTfAdlT0yjM0NtKAvP8gOe437H4DYRnLB0XxBbmnwcQ1xRSADo
 fQR9iedkqiykueVmPW51aOWqklgJbuJHLnV4bat8efyaHXXn1EjY.UkV8NfHwfq3Tm6e.X49sr2T
 dfl7dMt2xZuDxGeHYZhAkC1DWuCXnx5RCmOZ1WKf5ncx9Md5UjsG3Mv_23jqKE7o15eyYqzz.xzB
 qDPhOqBY460QXQI9_gkt2yo59R0r8QMpsDvXnlNq7gojfDwedH4ZdSKVMeNf6tiSsptRcFDgJXJ5
 iz0Fz2h03ZrFKHnbtGQnIitfDSZuZWaS.I4_wfKD4ToToNDcUUvofDESlqeT8qlbg2YEa.Rx8fyc
 T2QNSKmbA7NQLV1t6wFIyFfLVmodXdjpcvbwkN68eQjezx0mMRq_r7_hgvTK9iVg5kqHhN7kK1.Q
 .awSPyh3s1uiH4UaSJpef9cO4MvsxGArQCLgc5g_58IDWExRwX7JyH39RRm_VIozb1wadX_WRYUX
 o.lSkPtnlgPvNgKllLCklwPoaEEpBiemxJoqf9QACWzOnHa.YnJTw63LQnnTBtQou2bgP_HMzO0x
 ump6CpKvSJqIT4DOVjl0ILa4Qwa1F60jXDkc3PpkuX1fbsJ6hTUd2WvL9A0M1mEpb3bwvZEutkeI
 BVp3b6DUNuoDUNn20s5ADnyEF28rE9o4ZXiqNI66SaomuJ7rXVKSfSkkvgAms6WCBOt6ULeMwski
 zrfrq2TmZ5_CLyXhck79y8Wa619L5K9jOrTbn1EC2CmXYeRvx8LvfxUekYEW2GNlNZ54zR15LNij
 2qC4m19GISe65dQ5cIJu.GtpZ5cyzzIJKvHT6cWXP1sJroDfDg66yn29_HfOKdkQ.o8sYvqcXbSb
 72W6UiuktRGJMqObsTw.FGmt2UobRN3E1MUT6_XgrjFxqhXENFn3ZaJO7pqxxk99Fb951Ahj0Zdr
 doIOOsVVTOMAa1kKLmgLsJdRms40xs9W0hg2MJZrACSMRDVQxmokRWIuWgkcKh7zfRZhSTXmRVx_
 G1xGJYux7rbdb1ISINp4V7jibXtx4US4EOutoF8tQJURzrD_CAjOsJyIgSILTfYRrPdMjDsL2Bl8
 s2Iu9gBNiLcNqcAPPM1qvAJ7YknTO2RF0kKZQBV7vFYCGo4_mS9g2WGlkAV.8S0Ga1nPUfSFSt0T
 jkmryQEssXe3wLKVfPzP2Kt8SG63pO.1ivjjdaD8tkyxsiRle4MEbxDH4hoGW2bN2wYFicOCzQom
 usBUogM0ngJTzIPEqzvr86lgymXYkjKK7PI4OXqmdEw29biAYtJTuvpRyIItZ9.jWYqAkNmaZ3RH
 QtgN6BHUTSYVp_H8d_7DeFRcorts1sMvcRaphwdP9tvbGvA.hwcBjMvsG1sv4zkLeGzsnkZb.IiA
 3CMoD_NrAyQvypcAMddSGD3ZtzVedxartpzl90.h3rADzpTNwP7Joiw_sMrPA0SE2jYZfRnZE1cS
 nCFAmb6eBTxx1cr.OmXkmhhG0NgQ9yJ7ORNpVQHeQCJI7pCFIpEx6A74vQZRhSauOtUl0NiQoyua
 pKsmIcnf8vNqN936vqVYAT2tHAiSPuiQ74GIDSPR8nyTqvDWYNsbQqQ7bFjKg5lEHvpoyPhOD9G4
 JTgKuzs2AiW0fqM2gWLX_M7cSWO.yEnLSEUC.c9RJLWj_.g9zNKdww74GiwrLFEuk97Ww
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Apr 2022 21:24:54 +0000
Received: by hermes--canary-production-bf1-5f49dbcd6-vddpd (VZM Hermes SMTP Server) with ESMTPA ID 7e2b2946fba71fdc86673e46e490ef4f;
          Fri, 15 Apr 2022 21:24:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v34 14/29] LSM: Specify which LSM to display
Date:   Fri, 15 Apr 2022 14:17:46 -0700
Message-Id: <20220415211801.12667-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415211801.12667-1-casey@schaufler-ca.com>
References: <20220415211801.12667-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index c1031843cc6a..f2d15348bdff 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2827,6 +2827,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "fscreate",		0666),
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
+	ATTR(NULL, "interface_lsm",	0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/include/linux/security.h b/include/linux/security.h
index e36d7f35b228..4a4abda5d06d 100644
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
index 2ad0d4eb24b3..52d3d0601636 100644
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
 
@@ -1752,14 +1772,26 @@ int security_file_open(struct file *file)
 
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
@@ -2191,23 +2223,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
@@ -2227,15 +2346,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2246,16 +2365,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2263,7 +2381,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
 
@@ -2404,8 +2529,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
index 9f82920ca986..bf93dc6ad160 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6388,6 +6388,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
index 6e0eaecd8256..552c4d4d8fac 100644
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
2.35.1

