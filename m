Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B347B16A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhLTQly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:41:54 -0500
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:44780
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237951AbhLTQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640018511; bh=U1INV95iV39LSCIAVQMAUE6C5MMxLcUABNWpxW2R8sw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HJRphVhYzOpwGNAHrxR6KQzcK7slHf+b9OrNSrlN9IeaUpjP3jzyFJE8u+ckdZE23FvbPHfUxTcDcHFClMeK9J1oRnTJSYHfyl7HWCpf/c79KAh4uz09RV+LV4w8pnC4ahd+zw05zqgIgcEm/cHhatJ8QqJie72YfYSK9K7kghsmSgZhVV7la3Ql4nTjrkXGjUlLjfnch+Azyue9sDU4UOCfqhdWydMQid4h9rPc/l5DfpzTc0O4hBViY8GlFd4KADA4MIVAFBOI7UXKRVpU5TwvcdpEEa5BUkRhvnvb+ezXuUqak68Hs2iLPiP5rhiO+CzFWgoQ147cc+a9JMvHiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640018511; bh=I0XeNtQmT0Irx0Rftp1dXQq21EFx4cla3mwogsdSlHE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IkeoPOBrcgZk+5pZqMXGbWB2QcHWdr3q7/fFT8ErQ7Dej+Aw2WPHcO+2xnwmCxIQfrmaYAAqckhtkp+rK4se0XPGYL+aM+jw2JERRtvMBL8NoQOHrBm0E4UBTR+W8cJ1BVdM+8K0xLApygFG5GxaCC32hkeZMAHnzobVOU5XiRNdITj5GTYtZaIFdX+J+KzFbRQUC/WtCDZPN3u6FQQhVL+9VzsNXprN3aqaPypVf8KrWuhlLPhMw9zlOQm7H2Cqo32MLWpDyBT7ZmOE3ix+11x0rajajj7D6LKxQz96dGJq4ttfpuKvFkUNccwGliGqrRjH2ASF7VTeYEiChV448Q==
X-YMail-OSG: NVpTcKcVM1nuZ_hh9odpETKe8X89m8xhkEuVLn3AirFeDUQzSEZC7j9HXrxdt1K
 1fKAr64UuMYr.GjVCzoBmx.7XXk4mkDpL9VTg5ubJNHctbDzy3rvag0H7QipW.KiDHVhFWhpz_zz
 YebI7LoHlISN_HvEdX8ykmQYAwUVj4Ov3ih8Vy8mOxsYt9GWB.8IG3D6qcVowsZTzPPS9gU6pyeZ
 .w0_kBM1zra_hc8Y2zkO_zag5HIe1quqJdUzbOeQrTVY3VmzaJU0L4nVNW4Of4pFur_NfdUewi7k
 ebBgKU_lNyesZMgszO5x9fKm78hxrHHcynL2X0hZLFdZK0HvotFxS1VTbhIQu9MmUkWSTTafdnUz
 ZdJ892BK6ScKvNeSGb4YbrOyGO57NS3QTIjS8bZIcWpo8aEwsUXP4RGOyW3LUKqVMStn.EGKAswf
 oDazjYt3DGKRdV5ta9os4gfXZWkub5D.fUVKfEedb3PqFRNeYwGTvy7Kv7IL4bxu3SmRa1NdiEj9
 n0yeH04TOCTLOlMKgJ9UFT5M_H5B7lGadobbnzuUX9quYWhvJ9qMG_J0EBrx26W21N6UAvDnBsE_
 Sw3GT4mvjhsRNp8H5WAmcGz0LrJUHdM8Rqf7S6GF0fKhrv_qv1FcFo76ARJk1phX8fsx0wd6jjRi
 0aezHKN0x2wIAPvdoQ2x2MP6Pw73SJgnHYlJmCaoubzygwYKvoRjooAuc_6gKzMAOqrV.wzusd.G
 CtNGN4Hl727xebSeuZ1MBpI3UgULl788Unm5L90DQ9aUc4fYI30m9iT0UE8w8krMmrId26Exui4T
 SV3_fCS90QjAt2HPMgGHO09c3BGY.sHTqzIEQDwfUlYTRtdG04usfHPWFlulOzLHU.6twYoQcbRb
 69g9YKPI4dXQmVXpbQRgPp.YIZB7WckSWwINQGKc8VRbnl6vFtqU_7e5sE0BWeJgbCFonzbjpTHO
 EOGzndRfDteqhRTfv4QMZEwy2IB5VhrvLkaBqGIz.NKKQZuyXhosv.py6a7dtVRMZyc07wK2K6pA
 EvCnIwIGyLWMMq_O9C5Ocr4CP17UCTJ3pyfGX8ItGI.hNNIb_FCNQ1cRe0RoQb0sjua2wP8KURES
 Yw231Ugk.WexUtjnG4BEKazZzfutmDBADLdHoBGWBZIP9.x4_CrdKq7bvyKQOm5j5Td6H8lM.lbX
 j2MjNrlV3D56k2lVmjpVZLLRfRK4YnWGVxhAmcXJTDy20nkJDVvoEKHpPLmb2M8Je1CgP1UyQm7K
 .EkHbrfo.9cgpYjhmzz8QkAeeJMEBOSJMNAXjAu1eYhQwd2eNyRhChEtGhA1OpqCa_6Bg.EZ46vW
 EMwgpBCtN7Jc3wgOcwtYO6Cl8a3X61SuLQO9lXWo7cmIuTEWyynCLW4pwXiscoA_eYOMpmxjgVMp
 NWIUzeNPwlsIKLxvlRnwmR419dNerDTxoMXjOnO27OgFeJKnobsU1NuI8ZeWHdRhLp.p0Ju8A0wL
 tW.UFBcyly79Sna7eY7zqY9Eqc5OfjX5.3JZV6BgJMIankO8likQzGsVOkE4gNMpWiOyl_i9FT2v
 x.HUCiG5hAmf7bS899TGxMgDRBrr0zjkSWFAYRt71R9QWtcneUnDn7XdiDchm9eqEy6zGNTvWdhg
 KOU6De.z45AS1N_YiaN6s246gF9n6rdHbuzvB73KgShQ1SfMrxggAYcjqWVUcS1nux6lQ8CHkENL
 k_zP4zqpbVXoWbyEhok6GO0JVwHVeZ63AVvGuZDTUhZLK9MOuEKWTC7Vg6DTCrBtM7APvy4859go
 NUvICIoPx3fIB2FcT0y_HBP1aJiUBb9jQNnberKLc05e0Gc7GtiWQkvo1yHmntRXHMdd79JJ1DUk
 kR2T88qVzNhpjpIEy0mtlBCcayhOAb.7N6KLkuMoa5JbSA.itx_68nhKXlRftDRb4RkYDYk3XGNx
 poZuXXOAMYApFRvhFjGjV1U5b1TvGJ8IivLBOW5rOFLgN2jljD5SnMRUuiwTDxYxr3we4bm9QqiX
 dQxZuyWSwZ8m.uPnl6hnbrmyINSjVBzHc2FRMTJ7AJyDlf7FNPVOtQ8WKMIF3EAQRQkMmGAHGoh.
 fMPD_UY0MK8ZUy_31wOTgmyvPtZxefWXGrpwn_FB6HmMumv0zImbbk6clEQ8XLdAbaVYXo0Te7b8
 5cpWsRJ1y.gGI7qKp2jqt0r2xIrk2Y4HbZMnuRu6ye7.Tmft19bg9J1p0rgyMaaAwzRXo_BxC6T4
 K9KYkGlKLq1DMBDCP4UM7iuQwMrP7jE5datFT7fsfhi_.bHhXjauRqJ5Fm.TS5XI1tQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 20 Dec 2021 16:41:51 +0000
Received: by kubenode534.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID e8eb317fa886ab93cf30e22b9fb5ef37;
          Mon, 20 Dec 2021 16:41:50 +0000 (UTC)
Message-ID: <3ccb78ef-905c-4914-c77a-24765c0e6675@schaufler-ca.com>
Date:   Mon, 20 Dec 2021 08:41:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] Smack:- Fix the issue of wrong info printed in ptrace
 error logs
Content-Language: en-US
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
References: <CGME20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7@epcas5p3.samsung.com>
 <20211220101318.3538824-1-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211220101318.3538824-1-vishal.goel@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19498 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/2021 2:13 AM, Vishal Goel wrote:
> Currently tracer process info is printed in object field in
> smack error log for ptrace check which is wrong.
> Object process should print the tracee process info.
> Tracee info is not printed in the smack error logs.
> So it is not possible to debug the ptrace smack issues.
>
> Now changes has been done to print both tracer and tracee
> process info in smack error logs for ptrace scenarios
>
> Old logs:-
> [  378.098330] audit: type=1400 audit(1637212273.300:2): lsm=SMACK fn=smack_ptrace_access_check action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=9397 comm="tst_pt" opid=9397 ocomm="tst_pt"
> [  520.261605] audit: type=1400 audit(1637212415.464:3): lsm=SMACK fn=smack_ptrace_traceme action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=12685 comm="tst_pt_me" opid=12563 ocomm="bash"
> [ 1445.259319] audit: type=1400 audit(1637213340.460:5): lsm=SMACK fn=smack_bprm_set_creds action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=1778 comm="tst_bprm" opid=1776 ocomm="tst_bprm"
>
> New logs:-
> [  378.098330] audit: type=1400 audit(1637212273.300:2): lsm=SMACK fn=smack_ptrace_access_check action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=5189 tracer-comm="tst_pt" pid=5189 comm="tst_pt" tracee-pid=962 tracee-comm="test_tracee"
> [  520.261605] audit: type=1400 audit(1637212415.464:3): lsm=SMACK fn=smack_ptrace_traceme action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=6161 tracer-comm="bash" pid=6310 comm="tst_pt_me" tracee-pid=6310 tracee-comm="tst_pt_me"
> [ 1445.259319] audit: type=1400 audit(1637213340.460:5): lsm=SMACK fn=smack_bprm_set_creds action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=6435 tracer-comm="tst_bprm" pid=6436 comm="tst_bprm" tracee-pid=6436 tracee-comm="tst_bprm"
>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>

Added linux-audit to the CC list.

> ---
>   include/linux/lsm_audit.h     |  1 +
>   security/lsm_audit.c          | 15 +++++++++++++++
>   security/smack/smack.h        | 19 +++++++++++++++++++
>   security/smack/smack_access.c | 16 ++++++++++++++++
>   security/smack/smack_lsm.c    | 33 ++++++++++++++++++++++-----------
>   5 files changed, 73 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 17d02eda9..6d752ea16 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -76,6 +76,7 @@ struct common_audit_data {
>   #define LSM_AUDIT_DATA_IBENDPORT 14
>   #define LSM_AUDIT_DATA_LOCKDOWN 15
>   #define LSM_AUDIT_DATA_NOTIFICATION 16
> +#define LSM_AUDIT_DATA_PTRACE   17
>   	union 	{
>   		struct path path;
>   		struct dentry *dentry;
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 1897cbf6f..069e0282c 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -318,6 +318,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>   		}
>   		break;
>   	}
> +	case LSM_AUDIT_DATA_PTRACE: {
> +		struct task_struct *tsk = a->u.tsk;
> +		if (tsk) {
> +			pid_t pid = task_tgid_nr(tsk);
> +
> +			if (pid) {
> +				char comm[sizeof(tsk->comm)];
> +
> +				audit_log_format(ab, " tracee-pid=%d tracee-comm=", pid);
> +				audit_log_untrustedstring(ab,
> +					memcpy(comm, tsk->comm, sizeof(comm)));
> +			}
> +		}
> +		break;
> +	}
>   	case LSM_AUDIT_DATA_NET:
>   		if (a->u.net->sk) {
>   			const struct sock *sk = a->u.net->sk;
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index 99c342259..901228205 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -266,6 +266,7 @@ struct smack_audit_data {
>   	char *object;
>   	char *request;
>   	int result;
> +	struct task_struct *tracer_tsk;
>   };
>   
>   /*
> @@ -497,6 +498,16 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
>   {
>   	a->a.u.net->sk = sk;
>   }
> +static inline void smk_ad_setfield_u_tracer(struct smk_audit_info *a,
> +                                        struct task_struct *t)
> +{
> +       a->a.smack_audit_data->tracer_tsk = t;
> +}
> +static inline void smk_ad_setfield_u_tracee(struct smk_audit_info *a,
> +                                        struct task_struct *t)
> +{
> +       a->a.u.tsk = t;
> +}
>   
>   #else /* no AUDIT */
>   
> @@ -524,6 +535,14 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
>   					    struct sock *sk)
>   {
>   }
> +static inline void smk_ad_setfield_u_tracer(struct smk_audit_info *a,
> +						struct task_struct *t)
> +{
> +}
> +static inline void smk_ad_setfield_u_tracee(struct smk_audit_info *a,
> +						struct task_struct *t)
> +{
> +}
>   #endif
>   
>   #endif  /* _SECURITY_SMACK_H */
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index d2186e275..f39e3ac92 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -323,6 +323,22 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
>   		audit_log_format(ab, " labels_differ");
>   	else
>   		audit_log_format(ab, " requested=%s", sad->request);
> +
> +        if (ad->type == LSM_AUDIT_DATA_PTRACE) {
> +                struct task_struct *tsk = sad->tracer_tsk;
> +
> +                if (tsk) {
> +                        pid_t pid = task_tgid_nr(tsk);
> +
> +                        if (pid) {
> +                                char comm[sizeof(tsk->comm)];
> +
> +                                audit_log_format(ab, " tracer-pid=%d tracer-comm=", pid);
> +                                audit_log_untrustedstring(ab,
> +                                        memcpy(comm, tsk->comm, sizeof(comm)));
> +                        }
> +                }
> +	}
>   }
>   
>   /**
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index efd35b07c..47e8a9461 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -416,20 +416,13 @@ static inline unsigned int smk_ptrace_mode(unsigned int mode)
>    */
>   static int smk_ptrace_rule_check(struct task_struct *tracer,
>   				 struct smack_known *tracee_known,
> -				 unsigned int mode, const char *func)
> +				 unsigned int mode, struct smk_audit_info *saip)
>   {
>   	int rc;
> -	struct smk_audit_info ad, *saip = NULL;
>   	struct task_smack *tsp;
>   	struct smack_known *tracer_known;
>   	const struct cred *tracercred;
>   
> -	if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
> -		smk_ad_init(&ad, func, LSM_AUDIT_DATA_TASK);
> -		smk_ad_setfield_u_tsk(&ad, tracer);
> -		saip = &ad;
> -	}
> -
>   	rcu_read_lock();
>   	tracercred = __task_cred(tracer);
>   	tsp = smack_cred(tracercred);
> @@ -480,10 +473,17 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
>   static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
>   {
>   	struct smack_known *skp;
> +	struct smk_audit_info ad, *saip = NULL;
>   
>   	skp = smk_of_task_struct_obj(ctp);
> +	if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
> +		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
> +		smk_ad_setfield_u_tracer(&ad, current);
> +		smk_ad_setfield_u_tracee(&ad, ctp);
> +		saip = &ad;
> +	}
>   
> -	return smk_ptrace_rule_check(current, skp, mode, __func__);
> +	return smk_ptrace_rule_check(current, skp, mode, saip);
>   }
>   
>   /**
> @@ -498,10 +498,15 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
>   {
>   	int rc;
>   	struct smack_known *skp;
> +	struct smk_audit_info ad, *saip = NULL;
>   
>   	skp = smk_of_task(smack_cred(current_cred()));
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
> +	smk_ad_setfield_u_tracer(&ad, ptp);
> +	smk_ad_setfield_u_tracee(&ad, current);
> +	saip = &ad;
>   
> -	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
> +	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, saip);
>   	return rc;
>   }
>   
> @@ -897,15 +902,21 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
>   
>   	if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
>   		struct task_struct *tracer;
> +		struct smk_audit_info ad, *saip = NULL;
>   		rc = 0;
>   
> +		smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
> +		smk_ad_setfield_u_tracee(&ad, current);
> +		saip = &ad;
> +
>   		rcu_read_lock();
>   		tracer = ptrace_parent(current);
> +		smk_ad_setfield_u_tracer(&ad, tracer);
>   		if (likely(tracer != NULL))
>   			rc = smk_ptrace_rule_check(tracer,
>   						   isp->smk_task,
>   						   PTRACE_MODE_ATTACH,
> -						   __func__);
> +						   saip);
>   		rcu_read_unlock();
>   
>   		if (rc != 0)
