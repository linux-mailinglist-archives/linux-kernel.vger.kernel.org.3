Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487084DA6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiCPAYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCPAYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:24:40 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D632065
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647390205; bh=LZaMOyrKxZFlpwY1d0cSSbKF3m8ogkrpb0P/8GLFFLU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fXSVTbrQqJhmDadCI3HRnR2w7nJuzOkhA/e8V+wVcKCftdOGToujA5JaxvcdzUHr+rL026oU13Q5BXo3KHllakOu+EitIT9yi6jxdSIna//V88MzNwV7xpXmjjKWW5WuUKoOJfkCvno7XsMuNO1hUmxtNooQXD0+AivD8gUEEjt+aSFAOdrGfihmERb99ymPyRA33HGKft3ZTdmTCzyZZ4LkcZ0MWQ2Yww79SWu3YPPCY2DW2+C0AQ7KzlfXPiUhqwjijLUByhn6D1NGLGmsTlg+i+4Ijo3seLy0qAp6C4z7JTI9/mq9/YVYdyyzrqt4RMnLP+AxjLEK4BWOLRDLOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647390205; bh=7g7nwb0s1pvxiyFbN++kXjMPLxAzcxEsq2fuv/fn/me=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=KIrAUcFr4JJfNAbsyl9AwNBW6M9dkrv/9LOjLROenXcjMaPBpouN83tHvxEWD2ZG9hCwhbOP+AmuCJlIntsZgCVWnJiNkrdkRERJeLajtwT0pAslsZE+/U/KcPVAVI7mKEOa1oMFGrUyN1aCRx0GT0WSoXaMSBwpfgu2cRNO/joGfCECY3Pu0giTDc25HwJJ7yeEfwU7N5TQmrubDlFsNzLjMoZHqFh4ACyiO7QiHs/JZsthFpy9OplE/37ondWemIM/vIo84Px4qj9U5SFpDH7ZO/O37EEhLKKRpG2y7sXrKYTEeklWDyuMMSSTEEnt9lb7pbNp22Kju9NT1Zryvg==
X-YMail-OSG: YZPgoIEVM1kzpagl60bEZ4O3XCJ_8tc5awCXjaK9IUmbPd8MxpPD0.N7e5QCJg8
 8rQwwYRYQiieAGQOouCb_pw16ms..FOHRH6mZX_91bdSb6kXACoDr0c2T3Db1VvasPu__AOX2Isj
 gg9Auw5PUvcpDZ5UEicEksss21L7DG8Jyr5hoDK5iJgU.HhANtn_Ubz3fvnUOziz7IFPQPFToYeu
 0hYKtEGgLWavyG9F4_Rxde1wcM0dBaBsui2IjHliDR3hIRp1earAys4j8LSjCtBGrVN7TzeESXc4
 JLWFu4BTTDIhI9eGONKx3trVzWPnHemL1rcggflpxXUZ9.rIM5qdXQpZMN3ADFX02Z.URF_rwE.V
 C.w.Rlciq7zd56CGa9nxcq0MlqnLhAHYNDcW6GCG5_PwVjEjCD4mLrn_x14VpIbefTy0lLi7p87q
 kZJ7Yr4A8fskDf7XFruaiwhwAJ6cJeG8xwtpzyOvgHp6nvla37M9U4hHW5IJIj7u1D8q0cuX7kS3
 24hddKk0zjPOSKoj9tfZ31BzxE0HA8fH31fn_3MW5W83oGlgZybt5lJDXzJ6RRjdyt1mcC2YrFJW
 pJARcxHeXn0cOA23z2bffCc8qij4t0kKBr.W3gr_QYpJeQJ4mGG.W6w6YpeaVaFYZ3dRSO2lkqMn
 vYZTGc.8Nl0OnKer.21I6NoOEi3uEVMCJrTbEz0yss26.iwZkeIVC2kAvENgzYLUJ24omPHUuu4L
 jfu4qFH560Gy7H2pqUg8FredEYeN7pxJYpOQOo_Wv3sVeyZXAhOe_UpKp1Um0m8vrNxzE1pJRQo5
 kZBj8B7OOhqQFl4eJjyXC25_e93sETo17GRz8ayN_Z590N.WW2wS9f6VCqUr4fC5Vp0r14GM6B_k
 7v6KthTtsS_9c62qylV3.gI.bgxvL_ZLGosup1Q_Wl4KcQPBKTrMgtU0AWLFwWj6t.4O3nbnDpOC
 aBPGV___hTU6WO34jw3BjZEuuMBBrGXQmtY7r7gAwNMeE3ED_XZ1pgJUoKqMsPF6_0swbAWCZeLJ
 76ZXrfnUde01B7o_QoXzPn3HTi0xOkzLAKQ04m.ZFZvyLbvxS2Ku.UMH4ouiB2Udml0pdNwnKwpU
 XFL7U7jtklqUd9i64AqfsBAdL3wF4b_wGS5egJrl52rD4j3v0eB4KUeC1pDrJ4MDromSs96n8Oxv
 o8J_kJzuBNeCgR8S6DCOGKF4Z3J7cIbBEpUnObaA31mUxOVRvxMiw7gAp9rs0Sa1cKnL7i3A5psk
 SdyKFI9rs8YIagreHj1jxqqjgSwhdvpz._9OycNk4zLw.cS9zuajqpPuS8gDTRf9CekzE_zQuWbP
 gd9TWxmxiqE4VMpo2eHDAfZv.mfrcJn6_eTShZ5Bx98QjYPCpgNgn3IIGrHPXM61SldpyYHGoVeI
 wQxU1_SNinASHnEbgOxjTU5kYIijduudVg5l4pGv6u8SOvyKbR21w8.sUEjoyM5n.hfE9JUHJP.v
 h8TnWSs9Tkvqimxn6rHG0GvJDS7dnqjErMGuzISKh9q8L1o.EboEFDZ0ZFbziDnQJ4Ay9JhkWv7w
 AMPRcdxRaslCcwBLoZO0SKXE6wGSfXuKFdXwsjSE_RZ6Z1wTJkXb2a8TvxEFXwI3727.pVY8jxw5
 zrQGMlWNc0Rw5bgQtC1EVhvfnDcE_eVGpEsLoyBuB0iLvgk2EZG4.9tFBfXEcEVLJ2mVbh.pZeAa
 cE_wmWvmdHfsI2r0Uu0SvaNRMsLLu1vyqawPxKlTTsOhoYvbvw8NzkFnuzyJesK9K43uWlKLcF6Q
 zFL9Q0LImVKDe.8zsMHm0nuWVU_Jud1a5a1g1CLyijZI3Ld4S8xm2DwZ03aATcAtquLDWORzINQE
 5gPc_wkeiFF7_YzOPmKuHcHWpq82rq7OeYlCzMPv29ZSGZFBgxKo3.ARpjRvON7xXeFxl5liOtzf
 _f79zUfnTY4muz2kF2KUqR.aMT4oTfLFL6_TOupwxYOGiIUBZofjQEy.LdOQgeYJxT3negqzn5TN
 rQACpYbi_hVAdsQgMqzR0r3Nf.d98BmBne6ugGOPbw8iwuS2N6GS73r.Xem44REVcpoy9_Sxfnsq
 lO7wJqACAe_oZSzHiCYvwMZ.3JSba7H4euHScTSVh_O8iXGcawk710eG2eksI185DDxJXx7gPtRG
 7tTL7Y3PMGowg4zpK4EQU2.iYNg6y3Zo5eiH1bqQKVEWvcztPLbtnRuvq3o.jEXaRXuGScg0R42i
 uQ5H58c2o3.yT2P_3iECNy1xtH.tvLPI6.9ulnW8B0ZDCfIyQK6GuNx87OX.XaC11xJDA6d3TUXG
 CrExG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Mar 2022 00:23:25 +0000
Received: by hermes--canary-production-bf1-766d6d57f5-2kfdd (VZM Hermes SMTP Server) with ESMTPA ID 191cf1563ef7b086fa9011d4ca343869;
          Wed, 16 Mar 2022 00:23:21 +0000 (UTC)
Message-ID: <987800d2-797c-e780-60f5-0e499081572f@schaufler-ca.com>
Date:   Tue, 15 Mar 2022 17:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v33 27/29] Audit: Add record for multiple object security
 contexts
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
 <20220310234632.16194-28-casey@schaufler-ca.com>
 <CAHC9VhQWv+04hETu3keU7Ev2nLn5MARW2R_p5hKVp3OfhD185A@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQWv+04hETu3keU7Ev2nLn5MARW2R_p5hKVp3OfhD185A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19878 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/15/2022 4:47 PM, Paul Moore wrote:
> On Thu, Mar 10, 2022 at 7:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
>> An example of the MAC_OBJ_CONTEXTS (1421) record is:
>>
>>      type=MAC_OBJ_CONTEXTS[1421]
>>      msg=audit(1601152467.009:1050):
>>      obj_selinux=unconfined_u:object_r:user_home_t:s0
>>
>> When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
>> the "obj=" field in other records in the event will be "obj=?".
>> An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
>> multiple security modules that may make access decisions based
>> on an object security context.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   include/linux/audit.h      |  5 +++
>>   include/uapi/linux/audit.h |  1 +
>>   kernel/audit.c             | 47 +++++++++++++++++++++++
>>   kernel/auditsc.c           | 79 ++++++++++++--------------------------
>>   4 files changed, 77 insertions(+), 55 deletions(-)
> ...
>
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index af0aaccfaf57..d25d76b29e3c 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -144,6 +144,7 @@
>>   #define AUDIT_MAC_CALIPSO_ADD  1418    /* NetLabel: add CALIPSO DOI entry */
>>   #define AUDIT_MAC_CALIPSO_DEL  1419    /* NetLabel: del CALIPSO DOI entry */
>>   #define AUDIT_MAC_TASK_CONTEXTS        1420    /* Multiple LSM task contexts */
>> +#define AUDIT_MAC_OBJ_CONTEXTS 1421    /* Multiple LSM objext contexts */
>>
>>   #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>>   #define AUDIT_LAST_KERN_ANOM_MSG    1799
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index ad825af203cf..ac92e7fc5aa6 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -2202,6 +2202,53 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
>>          ab->skb = skb_peek(&ab->skb_list);
>>   }
>>
>> +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
>> +{
>> +       int i;
>> +       int error;
>> +       struct lsmcontext context;
>> +
>> +       if (!lsm_multiple_contexts()) {
>> +               error = security_secid_to_secctx(blob, &context, LSMBLOB_FIRST);
>> +               if (error) {
>> +                       if (error != -EINVAL)
>> +                               goto error_path;
>> +                       return;
>> +               }
>> +               audit_log_format(ab, " obj=%s", context.context);
>> +               security_release_secctx(&context);
>> +       } else {
>> +               audit_log_format(ab, " obj=?");
>> +               error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
>> +               if (error)
>> +                       goto error_path;
>> +
>> +               for (i = 0; i < LSMBLOB_ENTRIES; i++) {
>> +                       if (blob->secid[i] == 0)
>> +                               continue;
>> +                       error = security_secid_to_secctx(blob, &context, i);
>> +                       if (error) {
>> +                               if (error != -EINVAL)
>> +                                       audit_panic("error in audit_log_object_context");
>> +                               audit_log_format(ab, "%sobj_%s=?",
>> +                                                i ? " " : "",
>> +                                                lsm_slot_to_name(i));
>> +                       } else {
>> +                               audit_log_format(ab, "%sobj_%s=%s",
>> +                                                i ? " " : "",
>> +                                                lsm_slot_to_name(i),
>> +                                                context.context);
>> +                               security_release_secctx(&context);
>> +                       }
>> +               }
>> +
>> +               audit_buffer_aux_end(ab);
>> +       }
>> +       return;
>> +
>> +error_path:
>> +       audit_panic("error in audit_log_object_context");
>> +}
> The comment from patch 26/29 regarding the audit_panic() placement
> also applies to audit_log_object_context().
>
>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> index 7848e7351cf9..923e4e3a5697 100644
>> --- a/kernel/auditsc.c
>> +++ b/kernel/auditsc.c
>> @@ -1114,36 +1114,25 @@ static inline void audit_free_context(struct audit_context *context)
>>          kfree(context);
>>   }
>>
>> -static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>> -                                kuid_t auid, kuid_t uid,
>> -                                unsigned int sessionid,
>> -                                struct lsmblob *blob, char *comm)
>> +static void audit_log_pid_context(struct audit_context *context, pid_t pid,
>> +                                 kuid_t auid, kuid_t uid,
>> +                                 unsigned int sessionid,
>> +                                 struct lsmblob *blob, char *comm)
>>   {
>>          struct audit_buffer *ab;
>> -       struct lsmcontext lsmctx;
>> -       int rc = 0;
>>
>>          ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>>          if (!ab)
>> -               return rc;
>> +               return;
>>
>>          audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>>                           from_kuid(&init_user_ns, auid),
>>                           from_kuid(&init_user_ns, uid), sessionid);
>> -       if (lsmblob_is_set(blob)) {
>> -               if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
>> -                       audit_log_format(ab, " obj=(none)");
>> -                       rc = 1;
>> -               } else {
>> -                       audit_log_format(ab, " obj=%s", lsmctx.context);
>> -                       security_release_secctx(&lsmctx);
>> -               }
>> -       }
>> +       if (lsmblob_is_set(blob))
>> +               audit_log_object_context(ab, blob);
>>          audit_log_format(ab, " ocomm=");
>>          audit_log_untrustedstring(ab, comm);
>>          audit_log_end(ab);
>> -
>> -       return rc;
>>   }
>>
>>   static void audit_log_execve_info(struct audit_context *context,
>> @@ -1373,18 +1362,10 @@ static void show_special(struct audit_context *context, int *call_panic)
>>                                   from_kgid(&init_user_ns, context->ipc.gid),
>>                                   context->ipc.mode);
>>                  if (osid) {
>> -                       struct lsmcontext lsmcxt;
>>                          struct lsmblob blob;
>>
>>                          lsmblob_init(&blob, osid);
>> -                       if (security_secid_to_secctx(&blob, &lsmcxt,
>> -                                                    LSMBLOB_FIRST)) {
>> -                               audit_log_format(ab, " osid=%u", osid);
>> -                               *call_panic = 1;
>> -                       } else {
>> -                               audit_log_format(ab, " obj=%s", lsmcxt.context);
>> -                               security_release_secctx(&lsmcxt);
>> -                       }
>> +                       audit_log_object_context(ab, &blob);
> While we lose the "osid=X" in case of failure, the secid/SID is a
> private kernel value meaning it was always of questionable value.

I could come up with a change to audit_log_object_context() that
would put out an osid= in the single security module case. I would
prefer not to if that would be acceptable.

>
>
> --
> paul-moore.com
