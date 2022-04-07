Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900C44F899C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiDGV37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiDGV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:29:45 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7119F449
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366863; bh=BtHo1QSoNl0+JSUijRm0h7RCZJK8XQ8GDtQ9CbzS1Bo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=L5/tabTZHLYxoHwIhJH3sxIC6GxQ6/JovdjnGvJeJbu92BX2QCdtKAkCETyopZGF0VkOHd/pyBTi8TN32b9L1GRMsfbEOwJwYZYpRuT3IkqaXcwD74DE4wmfwvePnjkn8naimo2Ad5CdTECTfXIHkBYTRQniBea/GoIIZmzSE4v2DSupRMq2nWTSJzAt9Fg0vqwoTTF5mFs2hsgJakzKkrB9T3c++6zyL4m9PXt0YTuRgwYAUd3CSNnlp2kTUv+jCD5sWT4HKs7v7H95vUh896hfcLElojWNB2grl5YjAVgovjiS7rcNAvsKc8wHntdC+bODvJOM78+ciTNkXA6Wpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649366863; bh=MaplFYysY+Ah6wLWvXWiiUfk1v+Yzl4T7nKlrOMurRT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bES03OG9ytk0efQ4V5+3XpFZ+hCirgTiWrn88Eo7iE8YMYMyQTVYULZzN0jPmgUaVKwrzB1tsB9KxqB9Dlt0JUOWNEB3KCSD2glkgJGgH0GrSzvM7M4/Y3B9iP9B0oOm1QXfemxtHx1U4ZSCtQNJpeJkf6HQwlDuFEWa1JawH5D1URyviN0VX8Dnd5Geeh3hQy79E9XT4Hno5HxgILo4WBJ2Lmo0mEWFkcoallNX635esXzQGiTlx2GWJOeBfhfjr1HMLAOO+vBMFDpYuBL1jAjmNCePcFPjCSn5k7GnQpFT0dCFY727Mzu2wgS7leGLE5Bce8NrqAM9HidIb286kQ==
X-YMail-OSG: 2hMF8DYVM1mCaZQV1y9TAXEVk6dJyqLgDs9y3Dmr1tSazuXE0KASsVhn1SoefQp
 rXWJfotiMlwA_cC..L2Dxgp8QoLRWI.xRAFNVXC4pHjPtbk4vgOClNJ1JB3s6d1Kpe0nTZWnAxMp
 eh3TukB4bC3cbNLcRO1RLX4nFMvwQbTXsMbe43c3g5JXQQQ34EFYaVXNylIZ2Qafeg3EglBOYiUc
 SbqpduiPKPHJUCFOikPVWTgVIQDN3O1lP7QRqetCGsbcluNMmqIa29WHgKSIiq6Z75yfQkpNhDzU
 kkADCLxjIdBhXZZSegQbS1VHgB8giOlu5RGFwWIJQ94iH.Uwp4i3MHiGkqY179wXQsQ4WIq5sDZj
 7r.gTRvN_dZlzJv_T2V10OWNkXwgdozjEfBn3mS2y_y1ebavV5QUv.0.GRYIjcL3EB8YT6E0yb2v
 6V8feBGDM2onak1Yic.lxEs5cVAA6zFczlcABfeeXwBCoZHhLjfzKFcdUusbBm27.WED9.4hldfq
 jGsFoj7bk5Tzf8yhXIwKW4UB2vk7JMTF.CAuVyPU9fI4DbMQZIqHH9Af5ax.d78pNBmeP94bkf82
 hOJwVh_WDmmUAfVyR1Bb8kCcfkummDSQn8Yn7grjIejM.H8r.yhzEXWNHIRClpN7XTC6WpjRRTtK
 k7KS7et7V1bmTZZGvBuoDd1OqC6KQXwzPuwbtPT_tDW1AvvqgQ947FfgeXnyMQ4aODUcrtz3I5V4
 jQEweR3vw8Pf385ocuXKzGJJ46.A.DOI0EnT4cv7Oamo2LSJ3pT2ELU3W.wpLHnAWK8pCS0avFIE
 z1OWJHQJNxk0iAcFf9OTKUvOW_nnzFy2eqtLXf1IH0mr8k1DHx0g3Rqr615wDvnq5VDy9ZsXtAg5
 3TCyTX397fvmljuweuFOuRo0UiymXL9iYq33W_53p5SWlGyrSwuM8cB7PXzrjW9Fr5t.de9uG1aT
 rg0esyW2pxmCL8ch.0g6KzTLVETJF2cZculAl9VFGMpVuyqmlzcfg7eTC4QN8SpXyseSTsLONXL0
 EvzqKLQXMffYy_7.YRH0vlaiv_JjjGtzyX1gEeBQja_jQ_lxyICxJK2GE2qIqbncnfOrYLojed7J
 RHEL5C9z.s1__4fzWAR1RlJVBiVjyQYhHRppZbEteP9B6WvxgKfp0f05mvuglUY.vPd9qMySf3cW
 zRDTp8vzf2b_OQjfJkQqymGeg4dkF9cE9B_YuTM8NNSz_VEXjMVNnxoB0Ge5XxDSfQdL7PMufwT4
 H2mDKcQAP3R2BNHpdvXub9M6bg4kNiBWg2qMnOUscH7QUZsvIR.jtW0zqzX_xquTe1H7ES6TbN2P
 o1ncI79ywkGobt.Nu4lVlsGpyMhDgfySNi.embE3kVjPuu2VktDaFQUlFKUJ_XR_w.k20YqqfJdf
 2CfHfJc_wB7vAV0DtDdkB9BRNKx5XvjhaG8febaw7NpkgJTWK6savUJJA9y3EZAhPV_z2W4n6kfd
 Oo7uEASo5m2sBC05wwqzsSXNJV8hR10760cQcetDaOey_wPX8FpJAs1uuNQOy4qwkqPgkoOncsW0
 OPBrCwImCL6RvN63BScuQqXWitl7Ndx2nkd5.GnOpyCOJ4PaEzTvPQDjsHIgP6IKP.Fsh_XbLpbx
 H.jv.gNzEHb1ZDnlsJiVTcb58k1UzYjkl_0sR.R7ZI0_rbrg6ZTBVvLExjGccOkjz4QfBHqGRqyk
 tyGeILjs.1Z3EwIh7a1QSi1wXAgw_0kIZAAAYFdo1GBHgB3Wx.qjevKOfsDYb25sOKewqErYXCKl
 XcoUzKQw0y4D3aW6IhnMjzj4TI1bJr1Vpkx8I4yw1Io9tK44xTW6HU8Etr5LCCaEwuG0scD.9eSY
 znRA339w0fS9e_xcIV1MTOWonQlEPDgYXrS3z4bPwm27LgWqTi.eZpswVcYcjOk1bk3fcqYPBnqr
 kBihAvqasBGmVrea9eLyORJPIogkizEuznBslNzCFVP_MreJX3ul0fFqe5aGU4E4YKIq5Z9gBJZy
 fKHTn1L_GkYfRbWRTlqScLUSse3ZUssjzkX8gVSu5JSZlXgmfPSnoikVllnikD8xvE0y7.2Veil2
 Tajo6Z7KSyA5SsGaX9QemwH9g2M0jXrIYI.9yXhUveYdxMZ3RhxbWVnkkDOOzEaOWCVTvu5t85p9
 Q2gp26tikvJhBswa5hxIs7lhzgyeMdX2iMLef1tIZ_kkXXwMqEle7fYvXl5wkWhbdr.N_TnIcvSd
 9bIzhSDlVwlLoGOlwSLVOL8nYFOl1AaFqyC1ioFyzdavd9CqH7H5PnseiDtvdO.I55zKCUnS1BAV
 pgasvDai6F1_E8H1.RrwesjvsZo.dEIA-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 7 Apr 2022 21:27:43 +0000
Received: by kubenode522.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID cdeff4c1363a36af98b9100857bab95c;
          Thu, 07 Apr 2022 21:27:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v34 10/29] LSM: Use lsmblob in security_ipc_getsecid
Date:   Thu,  7 Apr 2022 14:22:11 -0700
Message-Id: <20220407212230.12893-11-casey@schaufler-ca.com>
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

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 4f940ef06e51..4646ca90f457 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -520,7 +520,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1277,9 +1277,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 10b9dc253555..d125dba69a76 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2662,12 +2662,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 6e6e44213d80..131c851dd681 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2012,10 +2012,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.35.1

