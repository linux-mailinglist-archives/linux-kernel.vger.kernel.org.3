Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECAF47B6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhLUBTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:19:18 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:35756
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229787AbhLUBTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640049556; bh=1dxMRgvKumV3QzZ6w2VMpx7EPQSo3ny4lCc5YCrP+Ac=; h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To; b=XMuT34442w5h5olPVvIB1yL6/ORL0+Y0XynMBPZf0I2aqC+C5jECzcPX5xdm/Aq1JKloVwE4IhEOTCoSNmVgwfU99wg//IBLR9S6HGcP+kR6dcqXviKaaBbwoqGWGcbPS0gaogWtdmeOnyqrgjw73U6NH1qv4s504d8oVQ+YXQr/Lx7hPVSMOwnplP4uI/Goa/lHqZYsTpKPpN42T0ZHZsE/b4HASLjbnIq3NO8AIUWYtWcqPszwaZ2WCrkrl47OUN30GzSoR7EHyFoVIo6BP8I154lGnArJ7hfMJNqZhuj+ymOdIUdwT9M/IMCThLiq81txfJ0HmgTKX6e/on0s3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1640049556; bh=090SaLLer0HF+BYW8WAxZZcjidVHn1kWqDJImjgHnXO=; h=X-Sonic-MF:Date:Subject:From:To:From:Subject; b=RaraK6FwK5d0/wAC2WLrIvV01j6u9qcb3DJxvy8+IVbX7v4qad8QqHDg+qlhMGBTQkEKs3JYtaidnVce2Md9MTYkYBKRDmutQwO7nsC61K5v2hKcru6fqvm16JqFFkOziWiGudawp/9QBOUUkaomOFOXjquXRf12cG1PdcJfrHy5/p8sD/DSHEjPUmxrzfdLNl1avCEckk4dXp5J+ZSW/Ef6/QtLTPIX4eK2nGHSkQMghBYQi1jzqNzcz9cr4g0W+wAHTsEZ3C19RRsivQAseVvOvnAv9Ciu6OKQ2v4tM9t6BHL5UCuHPy3AFUYEMAxTv/EsDmF4wNcqMGTPAPGp3Q==
X-YMail-OSG: 0Dr20a8VM1keQrfHUmIrDqj77xWTU7jC1XYpT7LpbQWiyHic8Fugz_9BBvD7NBr
 rC8RK4iA07z9DQHyqAAr4GxTe3q5G5WriHewW5gINuv3KUNIX9IXLIq9hiOiRxdAHS8zdQDUyeKE
 NVNxwXdaf3QpGyv8goNxh0bhjmWsc_.d7GUUsdCo_BQxbbCp2MDjqKW.paTnP__gFwxsVH2Liil1
 gcwaIaXxaLDsaooZeolIgCKQfKK__u9kSJpeFS.f2qMR5b6DXLdbfnlh.EXPCMcT73Up8TpGYwQ_
 8V9yqP3qxJx3E.FgLFDqdSnz.Dphndx6bAH_hVmiEc9dOLTU3FW1Nterjyn.I.UL_m1ZoS4ATHi1
 YzoiZ2BPDIevRug_ykpn8FtEuq4JO.SC0ZaRzjhjjiv5yLyVEPbl3tfAm6BRzxbXqUXO2ys9iuld
 WHst3N5K7WLU2MsPGd6nQKrIpbDPq0F0xmN1fd6IfkSIjeGzPI21eOMJmHUG0__0gifjl6hMGV2d
 dYUPNSO28ZiuxQJdJ1GIa0QA62yo8lcq6EKPDXbjM8nDCNTH4.cBTZRzoOfz5h0yLZw4V95_bqPD
 Z6RrfqRlWPIpseUappJatKL1dQP3uZ.5TS1dKZRk1OHmuxRLVmTs_u8o5YbLuqN5ng1lUmKM5s8R
 rqRXwB4ccBakvm72i0wa3AIHdKpIN4U3t0.cF7NjSiVTxRGud7rINM7NivXEyGd6MALbnrh0fTxh
 ZVo3bq0pdxG4tDJlsJtdOy.xveyn2tFtT8GuT2wceHKk0fNP__zIGxsUs60d.m.RO1m.6fCpoj4v
 47u0ZEqPWAWir84YetG9LGhdBYjCrY2lD8XruPyuHs3ufN6CYrrpucAEyI4yjkAVLSIg9pB29EMd
 qLvfXlHDbM8jknXKEp1icbwl5wd2JW4zGIiVNQkOa.95GOE824vHrXUnNPiGXy28YFwWhTrr8OS5
 FgzOgHjQ9rra6FvCybDzZEnkwZLhu2oNzsuqpafpQ6UnjxK4xptjSFL3z2qGG3hf48wyJBRy9R5Z
 EBZOcor789ZAOS0L47A.Mz8y10Kf7iayV7ED6HI_ZgN0RmU99jed3Q6mB6..g3bqyX7dI0IRdPSo
 1UUUpIFTugpxkhqXYCnpAB0XDywA8KhF3RiggMULST97UqjS6kVITmL9REArusPaZDVS6tP1ym6U
 hbFLPoJ_KzSD8pGMotn61qkDZnezt3ckCrwEsGJNyxx4zOTy1ZIKynrBLNDssIN3kKNzX5r6MqSt
 JOm7DX77tTjmnDym35gmgV7m3ke_9GJz7nq6e1O3mKuaWeHlrymnKWiGcemvmYdUbOeSB2AwTN7B
 pm2nZnL2.Mzt6S4vytuW5I_4VwXaCJAuV4daZdbGLFBj9uSrXNxUTPNieP6b8eMoChrQ5ggusbQ7
 uzvB61pq83X8OaLYVbGVRgSpI7clMCxKJI4jejswiPNCznBeQ8uWLrCnoly37iCx_zjUpN7arRcJ
 7D9yb1Exsnkop_dEpcXsQIqJFHXXfhCzM4GKNz.hV7wVe4j9APONYWNtqs6sqD3hAb8XPchVSjmX
 coapTXhmBm6F9p1JX1AnTThLYhkafL7V59MSsfzSDDYjKRJ1A3k1SpL4X8seZbJw.xNDp09LqbAS
 rLLNaf6jJh8CTxzyU8VwoaiRCK.4Xws4kG8Ue5g1YnmMdcsZU6rX9MSwuS6_NTKSldeJY5CUO7fK
 28.kZ2E0uAtzNjqjOibfX2krXdvJXEJydIESupJQ1ZD25heI6rivntF38vrWpZEJuurHgtaJcfjx
 eX02HVbRm9amH8jv3L9DI_lp3YffcU.fzAMGup1LNoTN2XzJ2wStZmVo43x.oS6xsUlOMpT7tWrt
 ec1iaYPKYe7R4N3s_Q_r.OnI4gGAZUB6JcHddOMQMyZnUs_ExtM0VCxfwxMzg0YJEQSeKImiLesA
 yd88QL0nxtIB_yO0.cMwaKgeRFbdORaU7E7pYD_MPHRQy5yH20fEJPVaaEhTkwr8NgSCe50rE1nX
 1gGxCAS7WCzj1NkdL3sT_dPfmVtpIGJrjwM7w__bSqAjBUwtiAldr666NpgMUbVGmdbhbzvWlfSA
 HCFSftJi2hKpFmhcAK10rooWAuZpwRbtWiJcBv1BG30e2OWqaUjh.LOaJAGjg7jFDCvPquVjQN71
 Tvach42ocp1z_UIl4kL5x45rxS.ljhkE5bQlgVEFJeZ3ehnuNAFE3.SjCzoQ2ozplEIwSRu.mgTE
 l0iRrRQRY8qwh_czqgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Dec 2021 01:19:16 +0000
Received: by kubenode531.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ba7cd69bee2e437f0ef8669a04210f25;
          Tue, 21 Dec 2021 01:19:14 +0000 (UTC)
Message-ID: <a648c816-3093-8023-d96c-b1b8d459430f@schaufler-ca.com>
Date:   Mon, 20 Dec 2021 17:19:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] Smack:- Fix the issue of wrong info printed in ptrace
 error logs
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CGME20211220101352epcas5p3aec72d06d04f71a7c387570957a0f6c7@epcas5p3.samsung.com>
 <20211220101318.3538824-1-vishal.goel@samsung.com>
 <3ccb78ef-905c-4914-c77a-24765c0e6675@schaufler-ca.com>
In-Reply-To: <3ccb78ef-905c-4914-c77a-24765c0e6675@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19498 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/2021 8:41 AM, Casey Schaufler wrote:
> On 12/20/2021 2:13 AM, Vishal Goel wrote:
>> Currently tracer process info is printed in object field in
>> smack error log for ptrace check which is wrong.
>> Object process should print the tracee process info.
>> Tracee info is not printed in the smack error logs.
>> So it is not possible to debug the ptrace smack issues.
>>
>> Now changes has been done to print both tracer and tracee
>> process info in smack error logs for ptrace scenarios
>>
>> Old logs:-
>> [  378.098330] audit: type=1400 audit(1637212273.300:2): lsm=SMACK fn=smack_ptrace_access_check action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=9397 comm="tst_pt" opid=9397 ocomm="tst_pt"
>> [  520.261605] audit: type=1400 audit(1637212415.464:3): lsm=SMACK fn=smack_ptrace_traceme action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=12685 comm="tst_pt_me" opid=12563 ocomm="bash"
>> [ 1445.259319] audit: type=1400 audit(1637213340.460:5): lsm=SMACK fn=smack_bprm_set_creds action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= pid=1778 comm="tst_bprm" opid=1776 ocomm="tst_bprm"
>>
>> New logs:-
>> [  378.098330] audit: type=1400 audit(1637212273.300:2): lsm=SMACK fn=smack_ptrace_access_check action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=5189 tracer-comm="tst_pt" pid=5189 comm="tst_pt" tracee-pid=962 tracee-comm="test_tracee"
>> [  520.261605] audit: type=1400 audit(1637212415.464:3): lsm=SMACK fn=smack_ptrace_traceme action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=6161 tracer-comm="bash" pid=6310 comm="tst_pt_me" tracee-pid=6310 tracee-comm="tst_pt_me"
>> [ 1445.259319] audit: type=1400 audit(1637213340.460:5): lsm=SMACK fn=smack_bprm_set_creds action=denied subject="Tracer_lbl" object="Tracee_lbl" requested= tracer-pid=6435 tracer-comm="tst_bprm" pid=6436 comm="tst_bprm" tracee-pid=6436 tracee-comm="tst_bprm"
>>
>> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>

What test case do you have that generates these records?

>
> Added linux-audit to the CC list.
>
>> ---
>>   include/linux/lsm_audit.h     |  1 +
>>   security/lsm_audit.c          | 15 +++++++++++++++
>>   security/smack/smack.h        | 19 +++++++++++++++++++
>>   security/smack/smack_access.c | 16 ++++++++++++++++
>>   security/smack/smack_lsm.c    | 33 ++++++++++++++++++++++-----------
>>   5 files changed, 73 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
>> index 17d02eda9..6d752ea16 100644
>> --- a/include/linux/lsm_audit.h
>> +++ b/include/linux/lsm_audit.h
>> @@ -76,6 +76,7 @@ struct common_audit_data {
>>   #define LSM_AUDIT_DATA_IBENDPORT 14
>>   #define LSM_AUDIT_DATA_LOCKDOWN 15
>>   #define LSM_AUDIT_DATA_NOTIFICATION 16
>> +#define LSM_AUDIT_DATA_PTRACE   17
>>       union     {
>>           struct path path;
>>           struct dentry *dentry;
>> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
>> index 1897cbf6f..069e0282c 100644
>> --- a/security/lsm_audit.c
>> +++ b/security/lsm_audit.c
>> @@ -318,6 +318,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>>           }
>>           break;
>>       }
>> +    case LSM_AUDIT_DATA_PTRACE: {
>> +        struct task_struct *tsk = a->u.tsk;
>> +        if (tsk) {
>> +            pid_t pid = task_tgid_nr(tsk);
>> +
>> +            if (pid) {
>> +                char comm[sizeof(tsk->comm)];
>> +
>> +                audit_log_format(ab, " tracee-pid=%d tracee-comm=", pid);
>> +                audit_log_untrustedstring(ab,
>> +                    memcpy(comm, tsk->comm, sizeof(comm)));
>> +            }
>> +        }
>> +        break;
>> +    }
>>       case LSM_AUDIT_DATA_NET:
>>           if (a->u.net->sk) {
>>               const struct sock *sk = a->u.net->sk;
>> diff --git a/security/smack/smack.h b/security/smack/smack.h
>> index 99c342259..901228205 100644
>> --- a/security/smack/smack.h
>> +++ b/security/smack/smack.h
>> @@ -266,6 +266,7 @@ struct smack_audit_data {
>>       char *object;
>>       char *request;
>>       int result;
>> +    struct task_struct *tracer_tsk;
>>   };
>>     /*
>> @@ -497,6 +498,16 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
>>   {
>>       a->a.u.net->sk = sk;
>>   }
>> +static inline void smk_ad_setfield_u_tracer(struct smk_audit_info *a,
>> +                                        struct task_struct *t)
>> +{
>> +       a->a.smack_audit_data->tracer_tsk = t;
>> +}
>> +static inline void smk_ad_setfield_u_tracee(struct smk_audit_info *a,
>> +                                        struct task_struct *t)
>> +{
>> +       a->a.u.tsk = t;
>> +}
>>     #else /* no AUDIT */
>>   @@ -524,6 +535,14 @@ static inline void smk_ad_setfield_u_net_sk(struct smk_audit_info *a,
>>                           struct sock *sk)
>>   {
>>   }
>> +static inline void smk_ad_setfield_u_tracer(struct smk_audit_info *a,
>> +                        struct task_struct *t)
>> +{
>> +}
>> +static inline void smk_ad_setfield_u_tracee(struct smk_audit_info *a,
>> +                        struct task_struct *t)
>> +{
>> +}
>>   #endif
>>     #endif  /* _SECURITY_SMACK_H */
>> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
>> index d2186e275..f39e3ac92 100644
>> --- a/security/smack/smack_access.c
>> +++ b/security/smack/smack_access.c
>> @@ -323,6 +323,22 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
>>           audit_log_format(ab, " labels_differ");
>>       else
>>           audit_log_format(ab, " requested=%s", sad->request);
>> +
>> +        if (ad->type == LSM_AUDIT_DATA_PTRACE) {
>> +                struct task_struct *tsk = sad->tracer_tsk;
>> +
>> +                if (tsk) {
>> +                        pid_t pid = task_tgid_nr(tsk);
>> +
>> +                        if (pid) {
>> +                                char comm[sizeof(tsk->comm)];
>> +
>> +                                audit_log_format(ab, " tracer-pid=%d tracer-comm=", pid);
>> +                                audit_log_untrustedstring(ab,
>> +                                        memcpy(comm, tsk->comm, sizeof(comm)));
>> +                        }
>> +                }
>> +    }
>>   }
>>     /**
>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>> index efd35b07c..47e8a9461 100644
>> --- a/security/smack/smack_lsm.c
>> +++ b/security/smack/smack_lsm.c
>> @@ -416,20 +416,13 @@ static inline unsigned int smk_ptrace_mode(unsigned int mode)
>>    */
>>   static int smk_ptrace_rule_check(struct task_struct *tracer,
>>                    struct smack_known *tracee_known,
>> -                 unsigned int mode, const char *func)
>> +                 unsigned int mode, struct smk_audit_info *saip)
>>   {
>>       int rc;
>> -    struct smk_audit_info ad, *saip = NULL;
>>       struct task_smack *tsp;
>>       struct smack_known *tracer_known;
>>       const struct cred *tracercred;
>>   -    if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
>> -        smk_ad_init(&ad, func, LSM_AUDIT_DATA_TASK);
>> -        smk_ad_setfield_u_tsk(&ad, tracer);
>> -        saip = &ad;
>> -    }
>> -
>>       rcu_read_lock();
>>       tracercred = __task_cred(tracer);
>>       tsp = smack_cred(tracercred);
>> @@ -480,10 +473,17 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
>>   static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
>>   {
>>       struct smack_known *skp;
>> +    struct smk_audit_info ad, *saip = NULL;
>>         skp = smk_of_task_struct_obj(ctp);
>> +    if ((mode & PTRACE_MODE_NOAUDIT) == 0) {
>> +        smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
>> +        smk_ad_setfield_u_tracer(&ad, current);
>> +        smk_ad_setfield_u_tracee(&ad, ctp);
>> +        saip = &ad;
>> +    }
>>   -    return smk_ptrace_rule_check(current, skp, mode, __func__);
>> +    return smk_ptrace_rule_check(current, skp, mode, saip);
>>   }
>>     /**
>> @@ -498,10 +498,15 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
>>   {
>>       int rc;
>>       struct smack_known *skp;
>> +    struct smk_audit_info ad, *saip = NULL;
>>         skp = smk_of_task(smack_cred(current_cred()));
>> +    smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
>> +    smk_ad_setfield_u_tracer(&ad, ptp);
>> +    smk_ad_setfield_u_tracee(&ad, current);
>> +    saip = &ad;
>>   -    rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
>> +    rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, saip);
>>       return rc;
>>   }
>>   @@ -897,15 +902,21 @@ static int smack_bprm_creds_for_exec(struct linux_binprm *bprm)
>>         if (bprm->unsafe & LSM_UNSAFE_PTRACE) {
>>           struct task_struct *tracer;
>> +        struct smk_audit_info ad, *saip = NULL;
>>           rc = 0;
>>   +        smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PTRACE);
>> +        smk_ad_setfield_u_tracee(&ad, current);
>> +        saip = &ad;
>> +
>>           rcu_read_lock();
>>           tracer = ptrace_parent(current);
>> +        smk_ad_setfield_u_tracer(&ad, tracer);
>>           if (likely(tracer != NULL))
>>               rc = smk_ptrace_rule_check(tracer,
>>                              isp->smk_task,
>>                              PTRACE_MODE_ATTACH,
>> -                           __func__);
>> +                           saip);
>>           rcu_read_unlock();
>>             if (rc != 0)
