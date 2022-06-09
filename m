Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6D545800
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiFIXIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiFIXIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:08:34 -0400
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5E72CE1A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816111; bh=Kt5aDujvPckVZ7qe2KuZUG0W9KiSq/tEqBYiSeBLUIY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FIObPFN/JN8njK/oCfcW7g2+Q5tuqRuvyY1u8rWgG8W+LvmpLMKif7eVMTkJuZiEw/yrLX+QK2e+F1jVIHgM/5jb86n7xaclMT1ZECsW/xwqPcopeg4xIBKuqjTbCA3i4Vjgq40rS1xA79ONBIwfdsieC6e8OwCfugk5A/TM6aulkp0apzRb6L/tFbXFIBcFV4H8+g5J5G9Us2YA9obJ53IDHwtY6gZZ0nQHvbEAm5RjRsL6GDHWONYpfuiZmPbS5ynAs/EEq3ViAj4HlzJYp2Z4h15hVdv6n3xbVNX+vWhfyjBjZFenTdBft2MGsx6wBIPwRiwC65Q4yIB5NiO5yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1654816111; bh=AP8CdR1egEnge8/Qxw2ybaZMbdI/P5jI230BYIpi7u/=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CytZ8/6w2BZ7ieb7ueUsabi6M9qZ0hksv9st/E0V4r7VTZHTvY7DeCj/8YtSIuuHgHDvmbeVQOd4+X2iDWNwMbhu4nc4qR2QsLnzrHSaMaFZ5/S2+EZTaRqIdrOk0BSeeYCOQzFc96NB//NOwyItg+QxGRRi5LRMVibqh8Uw8sQwWcPKPVuFZq7QrUbM7oaAqBg7EIpjqjKin5L9EnTNfxFsm80OEjMMe5ezkQjqxNrT9PoZR10qKHrULzta399x5iEiu4n21/W0U9FJtgJgv4hNCO7IHPD9H47A7HI9PszjoyxaepaJCneRFaLvp4VK83KTTE/zc4JnnL49ez8Oag==
X-YMail-OSG: 9YrTMjsVM1knHBiqc9LK_uzbhpbQuQleI7QWzVbPpVFpe_mMlloMT6z1q1SwXme
 VxBTIEMYfo8CR5ajUqWnQqdv5PdiMCrnxtodihwAgywUidIt0_o3mSONVJpa3fReUUVH8XKeYq8S
 623C09ZX4bKM8OUOT0XGi8Q04yoJXoGV9bJ3jf4zsIraqOivFZ4e59bvbA6QJbO8EahhRErIAdfk
 ihXGQaU.5hsMYh6FxsD6W3yYY84S3kaVpUMWZ12LPSF5yanxPNx1MTpJ5okPqR3L8sOl52XzlHg6
 _PW6vMWCmLT4mrVk9Dsf2pn2mFK09ijvsr929Yuz6jgqbkaw7MWhjeRcGQjs7kM7r0Sd3xcjuwPt
 7e1rbpgHTMneLbTEOrRB3.bwAH4eWTscJgwVSVeelJYRyDbo9y5f6fCiaTg3xBYKeh2QYOFutxWk
 HGO98SlqcbBW1rntCbv1WN8Q.AK4SL0M_rowVbaQdAkk_ZTWGmtRKHqTRjCpUTcbnksHkMELH8Kh
 Ov1Q_.XvISXV86JHx6eMPD.jz3zs9nYNrDusIJ2wQ17awQjg.ib8MjOX8YunE7wDHOOUN7kf_nNz
 YvURvzlO5e_HhU0ise9dkgZkW7JKjrx9bRys0jp1nKmRU519Kdet8Y.rXyKrLGcJWce74mlB7i08
 Gmbi9wpuTgblXNbpwikK.L.SzUNisWit2mZGZnSYOF6HVWduoZBsUpIb6aRPX1lnVl9oI_.ex8xj
 XcrfGnkJ4.DFnzaJNK28N9893mN.EVozFk9VD43elIxgcElIc9rwZF3SlgtmTQthoTNm2.L9pwqx
 Fjqrpt266gA43jXcqw3jkY9AOzspwWXPlBKKgfDhnsLbORguWqENTU7WDcRfKiQ118N1xry5jLdy
 tlvTUxJiReWaRNWqm2i0iVNcEIvHCJXTzGuJPvlKcwV6w3hrfhUfIONhkG7p83kYKHFbpVsrKkWt
 e4Ip2pldarAt1eX1ucobakllCPaMD_m3zRQadQbsQ.XU6ybQQEqv92KCXmH0s9j7vd.qcG9w762h
 VGPncY0UoFcJGw_CFgA8DWa56Gwi2v0JmiUq2FtIZrK4gii4We2eo3XIiLFif4iJHjGyrSZsuOqy
 .CQc8A3A1OBqvlgmlKgNpN1K7e8Qvuh8GgrRK.5XhVsb320em.u4GslR.xeb1ddUwXMU9bJ4nCVU
 9I3fj5jZ9jwNjIcrtTc2xNilRMNOm2Cqm8Ok3C47R6p7DEt8fVBSjRbcaZfpvsKNXcW07Jp0sn4y
 48Y6JApcRGdQCHJfp8uoag.bppZdl8maPG5L6s4fOeCrRLVw2gMeS7BtgwLzEMPnlwOfG3IPVWGi
 NegyMamFWXXAVZAryOByOweu09tc1XQWHwUmAnNmuLaX.3FeAV7frr.uKrXptWF3TEcbo8qLPPOs
 1FQdqt2xLC8af_zXL8c9gUBTY8XFwVjYWa0O67tA6Sn_ySUH5F5NmbEnRAOQ0fPE.b1JydDOkaKy
 TgYjfv6v1le6ejXpwbyuhNd4DJDkZKrwJy7.ssIvBeVuQOLE_d_MuzZy9bcr_KNvZZLuGr2n1bsk
 et8zOGtfR6jgRlEM7ELhJ5fwXxqshumvrkwM4g7YBuUSiS20r6GjLUZoQJEhXKWZ9VC1F2dwMRwl
 tQOzmFk3pbajtol6C3lxqJQ8KSR9Y.tAyuqFwI6tzi2YY4gR_Z.kFk8iSJ1RSQXYCkK_vRESGGGO
 vD28nwjLQMsOJrcPDCyYPwxOVG8MjZP3LzECZ1o8iDakjMZqv4WVyj_N5eSpU3D9I7AxYt4rUpvN
 M2_SrBWmUpxPGrRKthyST1i2RXkw5vH_rOQ5iEVzj5g24MiMXcVaAq.Oct.1BJlOtK0EiF9mJRww
 OzWUdRv.fti8v5ChWfM7gc.ePWQeaLP_F3Zoc6uM0z8ifkLVsfhcOqcFisa9cORpxOhiQ5ROsThV
 wuUMLdBr6B2Wb6vf3ZEW7_qfPymGWpThhYn_zT00E.Dp6oK.AKhB_H45rTqnCYsotGQ67tP99L9j
 LPraRgriYhrkONog32EDVu1c18f9pVzX8gNouqiYXJMlTBhFmTSNOFDbBEhk.dGKJ3P657pyXxpA
 VaTKplBwKfLcfHLTLfByNhzzQjdY6GhmRoQZcVieOGCuPuEjNitiWdHepq_mqOZLxIteCV1WSiyP
 nNVnECcNGOZcLCy3yIWh8eC0kIz3vvBvebcIYEerxGo2DfM73o__S4rJhShXUle_oPd.ZQzOq7nL
 U0IeJjsFMEEQtSKesG2OcvY_H1ZF4ePzKOEIhcm3ZielgtArZ8XFWMEDzgvopyQm7Q0F9oycsL13
 4GxXUDYx2h5sy9Wc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Thu, 9 Jun 2022 23:08:31 +0000
Received: by hermes--canary-production-gq1-54945cc758-dgl4g (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 81d1362bb2f9321f75335da17974ee85;
          Thu, 09 Jun 2022 23:08:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v36 14/33] LSM: Specify which LSM to display
Date:   Thu,  9 Jun 2022 16:01:27 -0700
Message-Id: <20220609230146.319210-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609230146.319210-1-casey@schaufler-ca.com>
References: <20220609230146.319210-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
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
index 8dfa36a99c74..085ef5f4109f 100644
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
index 61d5f23103b1..a7a445bac8ce 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -240,6 +240,23 @@ static inline u32 lsmblob_first(const struct lsmblob *blob)
 #endif
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
index 1aa6c56d79de..7f06f43d3bb0 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -641,6 +641,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
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
@@ -652,6 +671,19 @@ static int apparmor_setprocattr(const char *name, void *value,
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
index 6df37398cfd8..d60bc6abaa40 100644
--- a/security/security.c
+++ b/security/security.c
@@ -80,7 +80,16 @@ static struct kmem_cache *lsm_file_cache;
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
@@ -673,6 +682,8 @@ int lsm_inode_alloc(struct inode *inode)
  */
 static int lsm_task_alloc(struct task_struct *task)
 {
+	int *ilsm;
+
 	if (blob_sizes.lbs_task == 0) {
 		task->security = NULL;
 		return 0;
@@ -681,6 +692,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
 
@@ -1746,14 +1766,26 @@ int security_file_open(struct file *file)
 
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
@@ -2185,23 +2217,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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
+			if (rc < 0 && rc != LSM_RET_DEFAULT(setprocattr))
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
@@ -2221,15 +2340,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
@@ -2240,16 +2359,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
@@ -2257,7 +2375,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
 
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
 
@@ -2398,8 +2523,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
index d9709988bda1..36929614c09c 100644
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
index ff757ae5f253..e419a0665b11 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -53,7 +53,8 @@ const struct security_class_mapping secclass_map[] = {
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

