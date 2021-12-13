Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4364738EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbhLMXvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:51:51 -0500
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:39241
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243969AbhLMXvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439505; bh=uLkiUf0AkXJu5UKLkfjJMYGyH/G9ehNWKG8YUmHWv1M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qfu0i4e6AhKu1FxDvHXhIFOUeHlZs/zYbk77pmmd7H7U+oswgChDVp7dlthf+RJLnGDtKHDGZERqebMXQzbvI4sdHX4V20Re8cbMojrw8LX19TWG8YAXX7WczyxM8BGgyqqD0yQRLngIBMokJuE+m7lJwE+hokxtxPtxB/Jsm1OtVGrFiS+TuPK00XO3BqpMHTcXjlbemshrvq62BaTHVQQ4at/UkahdFATGwt9sC5A7nmDJ3iM/Mpyb1K7Wqe98rvqSauPQDC4KJPRSjaWjaed1hl73EHg/7aFL5mx4Qs4IyoKW9LUd2mX6zyFGraSvck23qhQUy+hBeEGD2TIhiQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1639439505; bh=OXMgVYznAYfbR4Ka3VkZjn76srMeCj9P5Q+G3bzQPxk=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=O2/XJ8RUHWG5Gq6z3pHlbKHoyYXm0ljuKHAaFQImpTC8fEHBY/M7tHdIuZPxOnrLAaIBbZ3OCY0sh0M8wQnj+NUTiqxbkDvR+YAknIbaH3pbHX6Y8SdXX6PeMwUQ0f7+aYGpSYDMff4/4b8IwfCJSeD5uZCgya34SX7D6QcNxcTeTff3uSc9nTdSDqodjSLDmndvx6EW+SBoxOuo5mGRZBjngGewjm/CqIHcRIyXquandysuQUwAt6MpAEvO/VQLwRjzNS96k4kNyvI8TmMdFnYJ9du/LafPIj5jKmkLlEWHP1vBzsUDjOuSpCsINQT/SFG+R5bdkc0o0B9HE9cQxg==
X-YMail-OSG: 32FeDhYVM1nfOBmFHGsyzf4ltxK_u1Qkf0DO4FsDsCt50NGpOSHr9Mm7edRDW4C
 PjUMnr4Ong90ccTITuRvgncWGJ_Y2Cdadcf0MCAIEt33XJZkG6AwCi8JZ.mZkYf3zTjt6sf5YT5c
 RZcHx4tc4rujWsJcvDsJoURLEgaK5wRdLQVkYlCiVM_1U_lLAcU6MkVZqyviBcVtSyaxBEwr_XEL
 Nf64FgtUj7ot.Fe.XkX0xks2pfQ3qKuvdjLxrlYDJRwgBHOmh1tJQ8YeH1K_Eq4E5Hi8EESFEclK
 G3.jOB4PjF0KuzDRTMgG84h3N7fSz.FG_ntKJv8TFdeTCyYCnFhQ7lRIoU7VosI0XmlieUqWbG9v
 fQPAeIekwlwerHflaSVkOOuwhFt2W_UyVXVXfKlmZ0PGIYj0R0uc90pWql19XS3maWyAJ0DZljEK
 KiTsDJUUvWFZX5anp74tt4dYIu3q8dBOaWolaIvSAFG5HkiZVsa20MX9BuRDmXqGIL.6rCOC8jvF
 FLxRJEXL0xYXuyUe6apcrH4FphFOBULyiZbRhYER8oH02G5ibm.ryS1tP.sSMC0FTnUUq8uRiQF9
 lH2u8yDEmucBeRctzugFLA32W93KvvjphGU1j1UFY4AW0mv5hISdhPdqs7xVL5NDI6cETP6yhHV7
 dn6tcBboljcXb7u.mEWIuI0m6QYWSKAxMkluP.Km1YIc3iBC4F07rogT0QZK0pzqo60w0MVIt21b
 HArJ3u_Y0KHrbCegfF77M3J5jZpkL5LLchj4fN24HnjPH0OYGQvRKIz0CXk4QW7JytvLYYVA3SKq
 J1kAtkkYzZSC8Wjt138ZDAIpEeD.DfBlsEDYvdPL5O2Y0AJKseHiIKEQHonsT3zVQ8uDxf_1wURm
 N1omJAa72_IoMVsiteuNJ0j.RdYywB47G9Wdd76OsMiBLuBkJcfFDShRPUwsj2UU63yjRBn_s5RW
 OSLVqtBmGUL4Pf6w46rInfZpYrTtzfEP_wrVBNuJ2Qb0BYoEdhfgJ1hPXs51M_dIaeOSXYpImj_G
 XzZNgNBWORf15ySCGdi8KRT8t2Sk87xMgdF5YrQiCKw86iJNCcWSf3D4qGXwT4lTUZeP3ZwAjKEp
 qWFif6cJhTU3o5t5__l4ucXI0iF_MCevuEnYw8A7XKSJUON1AxyrtsmQHY5iJ_xOkdvSkEciK55d
 UVZyQhMVe2deMgfmiM7S9uROzadGbRY3VPa9pRd89..mlT8A11zGFsHHXKqO6tzUhpegSjHXoy2L
 tpWCblmURw5_BwYUV0bpslHq2_.6xn1E3ZH7WrH7a_rWOTP7MvZxHsHXjljdguHtGtSj56WcqPRI
 tQ9zMOGI_hO60I_1MSqYBIMfXnfD4RX_DUIWhPMDjaNoZ1BdVbuJHUKyDo9YjrtkLmwPr3ux7XLI
 NPqr9ANaP3QT.kVA38Id4CVS4Di0rg7IbYi.BzaDGOrch8HcWk0re.zSxEodznXquiOV1L2f3LxC
 LFUedLH3nySq.Hx_PcSt.5Pm9x.YoONwp5qyVkhnrO2laG6QWLRIVFR8xiHuWIuwPESmQCdQOxgx
 OMDIbGqSFAU8z5_FQWa2kFQgBgeFXdZ2328sSZcLXgeWOP.nIRSbm4.ztJzfPQLfUEnbg3AmuLR0
 P.Btjbimd3rkWtZIUXKeyoetnV2xplaVPRw4E4KbTWwnDg.uNzSO1T13p7WhRpiHqjUef6TbSGyM
 .1S6kXhKRLyqcqXxcjqViQID1D_zPhFhmgcISpch07NHEJO0eFVHAzk4tzR3tVRjv9h0ve7ZMrXU
 ibIvfr8UGnb_dKDMvgPUhnaNwpNbu4lyHVEb4wAe1q3modqDad_KqZsx.EEjGsaI.g_JWRC04nKG
 9d9A_uMhzdqjEvA2S9asZNFqE54FsPcRQs8FMu3aHZv17bSbt8ZAGtEoEEyKa3dt4D0n2Wv9UkRa
 aA5nhAuv492mlNyT3B6DZbshzDOVia0WjfWViSpUa3Bq51Zh1U4bQu.3HoYkv3MPAGaRizowVcOS
 lPBtUd1jcGj88zDmxYPa8GgZ9qRyqAaHZaTaaNW8Gwcp69Sij5SXa9b8HxkTxkZhJKl2jYb7GSOX
 lTPGmCrixQcYDEJMesArGY3kGEm_oIk.Md6yQCxLejBc2kaOaMfAJ9usnBwxnbZnVA22wAUZr7x9
 VRLqwKToeu0w7vbl4mnvbNvFKfIAAsZc2RLn7gIzRIlnS329UNQD6dXJelkXTtrSGKfNhpv7tteR
 REuFnyxxmnl_6kwxU35e0EZa90wzwmE7sx5nX.DEefjQ3_rybNuxaRkEHrFiCIFELef35c4NvI5h
 GhVz.XPcV9s1fHnp57GJw
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 13 Dec 2021 23:51:45 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d4d0e09ffbe12f593b23adee924909bd;
          Mon, 13 Dec 2021 23:51:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v31 10/28] LSM: Use lsmblob in security_ipc_getsecid
Date:   Mon, 13 Dec 2021 15:40:16 -0800
Message-Id: <20211213234034.111891-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213234034.111891-1-casey@schaufler-ca.com>
References: <20211213234034.111891-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 669eff47737a..a0b9bf48a60d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -521,7 +521,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1284,9 +1284,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index b28e2cbcc92c..c469368818fd 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2601,12 +2601,17 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
index a0612afefc24..f8b5e2fa37a0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1996,10 +1996,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
2.31.1

