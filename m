Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C4B47A7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 11:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhLTKpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 05:45:42 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:14097 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhLTKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 05:45:41 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211220104538epoutp0492419f6417decc5a38298fd5ee586a7d~CcLVonWv30883408834epoutp04P
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 10:45:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211220104538epoutp0492419f6417decc5a38298fd5ee586a7d~CcLVonWv30883408834epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1639997138;
        bh=GHjPuRlN7lgYIOLxcLZS27/0oT5FoCuTmReZeO3YNto=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pjYwEE/Ms/ut89btY3eziHWdaP59reSXZABm9Y5/3NAEIKS3BiseSuZjWtWo/Atnb
         0g2sxfjXjonbnvHqQNRzFtrxP0z1f+ZTLVVCtU/iU8O74X/FraQbjLoBk5ZOZPrwij
         qIt3cP001ICDibTolk7sRRiOTxU9QP8x2ChblFV4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20211220104538epcas5p4cc756255b82de510b3d22f6933bad442~CcLVOtvfX1980019800epcas5p4K;
        Mon, 20 Dec 2021 10:45:38 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.9C.06423.2DE50C16; Mon, 20 Dec 2021 19:45:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7~CbvmNJSEp2921429214epcas5p3W;
        Mon, 20 Dec 2021 10:13:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211220101352epsmtrp26844d4a4b0b24f752bf589f58a696ba0~CbvmM31mq2927729277epsmtrp2i;
        Mon, 20 Dec 2021 10:13:52 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-eb-61c05ed2b5d1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.07.08738.06750C16; Mon, 20 Dec 2021 19:13:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211220101351epsmtip10b77e35d320f460d0aee0cdca7202ccd~Cbvk52S5U2180221802epsmtip18;
        Mon, 20 Dec 2021 10:13:50 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        Vishal Goel <vishal.goel@samsung.com>
Subject: [PATCH 1/1] Smack:- Fix the issue of wrong info printed in ptrace
 error logs
Date:   Mon, 20 Dec 2021 15:43:18 +0530
Message-Id: <20211220101318.3538824-1-vishal.goel@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCmuu6luAOJBjcfsFtc3J1qcW/bLzaL
        y7vmsFl86HnEZnHo5FxGi3W3TzM6sHn0bVnF6HF0/yI2j8+b5AKYo7hsUlJzMstSi/TtErgy
        7q38x1hwxqHi+YaJLA2Me427GDk5JARMJNbe38jaxcjFISSwm1Hi07HFjBDOJ0aJj1MbmCGc
        z4wSs+ZNZIVp+fh0NlTLLkaJLX3vmSCcL4wSZ3/+YwSpYhPQluidd5cJxBYRSJT48GQHO4jN
        LBAp8eTgOaA4B4ewQLjE5ouWIGEWAVWJKf0X2UBsXgE7ib/tq9ghlslLzLz0nR0iLihxcuYT
        Fogx8hLNW2eDXSchsI1dYsW074wQDS4Sz74fhGoWlnh1fAuULSXx+d1eNoiGdkaJCbN+M0Mk
        JgBd/VYSwraXeHJxISvIccwCmhLrd+lDhGUlpp5axwSxmE+i9/cTJog4r8SOeTC2qsTUSd1Q
        u6QlDt84wwJhe0i8X9YDDjkhgViJza0dTBMY5Wch+WcWkn9mIWxewMi8ilEytaA4Nz212LTA
        MC+1XK84Mbe4NC9dLzk/dxMjOHVoee5gvPvgg94hRiYOxkOMEhzMSiK8W2bvTxTiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOezp9Q6KQQHpiSWp2ampBahFMlomDU6qBidOnJDNGV+JhwM4lz9Y6
        u5/qPnsmyfT0o9ZHevwW18W6/f28lRevX63Dt5vfOH4V23TVBXbMK1fn7BW9HbFk/sbCecwc
        Qvv1lpyftk5JpV1t1X3xkJcuqc2Xbu28ueg9Q/nT6q4NDdW7Ndtb++S8zv5iSnbJT3e/e+1j
        zZxDquavVBOMV1aZ/5mhGf9B+7pt5uYOPhGNyR1BF56ZfXE+PU/Sz8bIbsnl/MVa0TO0PfS4
        dq/e/5gl4PrexdyzVLvi/628ru96OsSGKTo5wd5oTUxumyVHxaEl0k/uvyo4fedy/s0Aux0L
        nttK3zrt6nghtuTMaquLtVGvLMLNOW0/el37tepwR7i3w4332zzSlFiKMxINtZiLihMBua4J
        IowDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHLMWRmVeSWpSXmKPExsWy7bCSnG5C+IFEg1VfhSwu7k61uLftF5vF
        5V1z2Cw+9Dxiszh0ci6jxbrbpxkd2Dz6tqxi9Di6fxGbx+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        91b+Yyw441DxfMNElgbGvcZdjJwcEgImEh+fzmbtYuTiEBLYwShxYv0bFoiEtMSSzjfsELaw
        xMp/z8FsIYFPjBKLrnOC2GwC2hK98+4ygdgiAskSu5unM4LYzALREj3PV4HFhQVCJS5u3gXW
        yyKgKjGl/yIbiM0rYCfxt30V1Hx5iZmXvrNDxAUlTs58wgIxR16ieets5gmMfLOQpGYhSS1g
        ZFrFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREchFpaOxj3rPqgd4iRiYPxEKMEB7OS
        CO+W2fsThXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCS
        Obho3pMQr8JeaYYGZc/iGm4dxZj+TLaNzMcWakXOclE0tp6RfyGtvyD/ldzUI4w7qgUXPLG6
        cjsureR2SdLB0Ktf/G+ILNJZzdy7/czThi7ZR4E3X3tM69s4KfhD08M9ffptfd/F1GZ/17g4
        cZPIhh2rPxdNkmy+5dHx3e3y0tnbXxXVmnKsPx3eenROLJvRgeQZAidWVsyY46SQ7MjZf3Pl
        04qao8ezNPt2Wmk895feekd9C2vQ/SMdZ3kkDreuXzo5dn3H3H1t8xskU4xUTQ+Uegdtcf+S
        xhHWpFeX9JUlZkKV/OHYiTMXTPVWmcUSeMcvNlHfzi9TYrXd4oXcG3X+9l9xWuBX3dOY8l2J
        pTgj0VCLuag4EQCx6dMYsQIAAA==
X-CMS-MailID: 20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7
References: <CGME20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tracer process info is printed in object field in
smack error log for ptrace check which is wrong.
Object process should print the tracee process info.
Tracee info is not printed in the smack error logs.
So it is not possible to debug the ptrace smack issues.

Now changes has been done to print both tracer and tracee
process info in smack error logs for ptrace scenarios

Old logs:-
[  378.098330] audit: type=1400 audit(1637212273.300:2): lsm=SMACK fn=smack_ptrace_access_check action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=9397 comm="tst_pt" opid=9397 ocomm="tst_pt"
[  520.261605] audit: type=1400 audit(1637212415.464:3): lsm=SMACK fn=smack_ptrace_traceme action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=12685 comm="tst_pt_me" opid=12563 ocomm="bash"
[ 1445.259319] audit: type=1400 audit(1637213340.460:5): lsm=SMACK fn=smack_bprm_set_creds action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=1778 comm="tst_bprm" opid=1776 ocomm="tst_bprm"

New logs:-
[  378.098330] audit: type=1400 audit(1637212273.300:2): lsm=SMACK fn=smack_ptrace_access_check action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=5189 tracer-comm="tst_pt" pid=5189 comm="tst_pt" tracee-pid=962 tracee-comm="test_tracee"
[  520.261605] audit: type=1400 audit(1637212415.464:3): lsm=SMACK fn=smack_ptrace_traceme action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=6161 tracer-comm="bash" pid=6310 comm="tst_pt_me" tracee-pid=6310 tracee-comm="tst_pt_me"
[ 1445.259319] audit: type=1400 audit(1637213340.460:5): lsm=SMACK fn=smack_bprm_set_creds action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=6435 tracer-comm="tst_bprm" pid=6436 comm="tst_bprm" tracee-pid=6436 tracee-comm="tst_bprm"

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
---
 include/linux/lsm_audit.h     |  1 +
 security/lsm_audit.c          | 15 +++++++++++++++
 security/smack/smack.h        | 19 +++++++++++++++++++
 security/smack/smack_access.c | 16 ++++++++++++++++
 security/smack/smack_lsm.c    | 33 ++++++++++++++++++++++-----------
 5 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 17d02eda9..6d752ea16 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -76,6 +76,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_IBENDPORT 14
 #define LSM_AUDIT_DATA_LOCKDOWN 15
 #define LSM_AUDIT_DATA_NOTIFICATION 16
+#define LSM_AUDIT_DATA_PTRACE   17
 	union 	{
 		struct path path;
 		struct dentry *dentry;
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 1897cbf6f..069e0282c 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -318,6 +318,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 		break;
 	}
+	case LSM_AUDIT_DATA_PTRACE: {
+		struct task_struct *tsk = a->u.tsk;
+		if (tsk) {
+			pid_t pid = task_tgid_nr(tsk);
+
+			if (pid) {
+				char comm[sizeof(tsk->comm)];
+
+				audit_log_format(ab, " tracee-pid=%d tracee-comm=", pid);
+				audit_log_untrustedstring(ab,
+					memcpy(comm, tsk->comm, sizeof(comm)));
+			}
+		}
+		break;
+	}
 	case LSM_AUDIT_DATA_NET:
 		if (a->u.net->sk) {
 			const struct sock *sk = a->u.net->sk;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99c342259..901228205 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -266,6 +266,7 @@ struct smack_audit_data {
 	char *object;
 	char *request;
 	int result;
+	struct task_struct *tracer_tsk;
 };
 
 /*
@@ -497,6 +498,16 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
 {
 	a->a.u.net->sk = sk;
 }
+static inline void smk_ad_setfield_u_tracer(struct smk_audit_info *a,
+                                        struct task_struct *t)
+{
+       a->a.smack_audit_data->tracer_tsk = t;
+}
+static inline void smk_ad_setfield_u_tracee(struct smk_audit_info *a,
+                                        struct task_struct *t)
+{
+       a->a.u.tsk = t;
+}
 
 #else /* no AUDIT */
 
@@ -524,6 +535,14 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
 					    struct sock *sk)
 {
 }
+static inline void smk_ad_setfield_u_tracer(struct smk_audit_info *a,
+						struct task_struct *t)
+{
+}
+static inline void smk_ad_setfield_u_tracee(struct smk_audit_info *a,
+						struct task_struct *t)
+{
+}
 #endif
 
 #endif  /* _SECURITY_SMACK_H */
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index d2186e275..f39e3ac92 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -323,6 +323,22 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
 		audit_log_format(ab, " labels_differ");
 	else
 		audit_log_format(ab, " requested=%s", sad->request);
+
+        if (ad->type == LSM_AUDIT_DATA_PTRACE) {
+                struct task_struct *tsk = sad->tracer_tsk;
+
+                if (tsk) {
+                        pid_t pid = task_tgid_nr(tsk);
+
+                        if (pid) {
+                                char comm[sizeof(tsk->comm)];
+
+                                audit_log_format(ab, " tracer-pid=%d tracer-comm=", pid);
+                                audit_log_untrustedstring(ab,
+                                        memcpy(comm, tsk->comm, sizeof(comm)));
+                        }
+                }
+	}
 }
 
 /**
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index efd35b07c..47e8a9461 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -416,20 +416,13 @@ static inline unsigned int smk_ptrace_mode(unsigned int mode)
  */
 static int smk_ptrace_rule_check(struct task_struct *tracer,
 				 struct smack_known *tracee_known,
-				 unsigned int mode, const char *func)
+				 unsigned int mode, struct smk_audit_info *saip)
 {
 	int rc;
-	struct smk_audit_info ad, *saip = NULL;
 	struct task_smack *tsp;
 	struct smack_known *tracer_known;
 	const struct cred *tracercred;
 
-	if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
-		smk_ad_init(&ad, func, LSM_AUDIT_DATA_TASK);
-		smk_ad_setfield_u_tsk(&ad, tracer);
-		saip = &ad;
-	}
-
 	rcu_read_lock();
 	tracercred = __task_cred(tracer);
 	tsp = smack_cred(tracercred);
@@ -480,10 +473,17 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
 {
 	struct smack_known *skp;
+	struct smk_audit_info ad, *saip = NULL;
 
 	skp = smk_of_task_struct_obj(ctp);
+	if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
+		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
+		smk_ad_setfield_u_tracer(&ad, current);
+		smk_ad_setfield_u_tracee(&ad, ctp);
+		saip = &ad;
+	}
 
-	return smk_ptrace_rule_check(current, skp, mode, __func__);
+	return smk_ptrace_rule_check(current, skp, mode, saip);
 }
 
 /**
@@ -498,10 +498,15 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
 {
 	int rc;
 	struct smack_known *skp;
+	struct smk_audit_info ad, *saip = NULL;
 
 	skp = smk_of_task(smack_cred(current_cred()));
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
+	smk_ad_setfield_u_tracer(&ad, ptp);
+	smk_ad_setfield_u_tracee(&ad, current);
+	saip = &ad;
 
-	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
+	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, saip);
 	return rc;
 }
 
@@ -897,15 +902,21 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
 
 	if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
 		struct task_struct *tracer;
+		struct smk_audit_info ad, *saip = NULL;
 		rc = 0;
 
+		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
+		smk_ad_setfield_u_tracee(&ad, current);
+		saip = &ad;
+
 		rcu_read_lock();
 		tracer = ptrace_parent(current);
+		smk_ad_setfield_u_tracer(&ad, tracer);
 		if (likely(tracer != NULL))
 			rc = smk_ptrace_rule_check(tracer,
 						   isp->smk_task,
 						   PTRACE_MODE_ATTACH,
-						   __func__);
+						   saip);
 		rcu_read_unlock();
 
 		if (rc != 0)
-- 
2.17.1

