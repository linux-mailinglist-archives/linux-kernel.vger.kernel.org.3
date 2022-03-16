Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2A4DA6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352768AbiCPAS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352762AbiCPAS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:18:26 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2EA4DF6A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647389832; bh=pKH+3mIFp+umBQDsSMTqPOceUhO1uzZlZ864UKbjcnE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gAbPkWH4JeZRi+ZaLSRDbF6UoAKUkySKoDtmjUz1wetWqcGGQ3wBSiAdb2uXFhrJQVVru/2cmw2BZrsTrw6AupZ5ieZOeOhpzo/FUJc7T5BBk5IUYebKzFli7cWcgJTZ/ExwgYdBLpXfEFmdsryJmxtJU7Ne6nTcaOuQyscKptWuekZpRaQX0BmNmCDy3wYDSht/lMNNKfBz1dRLYzHC6SwGI9m9HVHq8K2XkrdDskzsBj8aAaxg/Y1y2HxTf8MLtM05Yzj2B8UbGBcj6fGglXX3omYMOvK3cNvWxo+itjwfydY9WR4CNOlSHq4y/rF6K25wcMPWdq1GkJwlmgW0dw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647389832; bh=zpLnl9ycIt2/i1RvAe0diDhXGKeFZz299sE4EMVtMtG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sekgNdroAlcCXKYp5lakkTK8hijD6SrV9XbtV2wMemPb7WYXb9fn8iLRnV9aF3OcjH8eVbMivKoXvJSQn1LIjLbr6XG8S3s0PPMb0f0lcdhmawhDJGN/yIMAfVdJw47Gki0Em4Uw63GPVy6GJSaRM5Oqhyy5s/Is1TNBG0Cx4UzAhszm4wnFGm6p2HdeQ5Em9vLGZf20DMxWPiqr2gMLULE0AQaIbHxhLJe7nnCoVXbvWVC+yFnVIof6jPvU4VbIoQ7ahW430SvImFvd6m5dAOvkFxT2U/uFf16Z/mRb4oe346FMckCT3cLwPaz9MXcGCamaRu36G7Z+11limHiepw==
X-YMail-OSG: VOCQbaQVM1mfpvP80ZeI5KR55KD0.DmRMmS7EdhItBioP19G9Zol9eLDkLj5s67
 p3O2RZJKHufOg44C8RVZ5Nr8ryh8MpP_ZoLkTCZNHSZwfGOriD7HOd_88gmyMKgZnQAkmiB_POER
 Tkm_18wAuj9upewQ7OOPaaMsVHnixTl.7PqvxRfYzXQuc9wkkUEgkCupcq43CcTEfCGV9oAqKSTZ
 eH69M2WIR1VPdPustxrPf4AqJSCsoV4kJGDHUHwEG6ugvMQKZdaCVrKglXydJXxQMjPwWZhTBxB.
 Lvtx0TvSYXYj4Z9meuzJ2aHqotFLxWtLcc_AW.dfRdhr2UmRJwiT_Vr8.HsRo46KilS4AdvTwVg5
 fCDOn69fl9_KndSP_iV8yVg3QSR0jwwzYD8GBSg1XahuAr4ku20hRRX0pDiFwExHydkhQc3Aj9FX
 l4JrcqQHMZsy_c7FxP6oKMEVn3G.QQlrmDgoX1sEwbJT5vOyE.wallIEMQarmSvsMrYMfB7gL7gK
 9mnQc6pwTkDGVLakMVaroIkCKqha6hwtfJoXD_oE2Xbjq_2vTOxSDV0ofhnkJ7YKyE0CgJBEMDj0
 dfoETrE4iAS56vSyYOwZdP6BnQLuns1hffZ5zUhoiS96kIRguz4oy4yWYsAq3iHE6bak5WV8HxJ8
 2bwEZOCmmM6XystOj4mFpARY3Trl73IgAfKCb48YK.TBQaN4CPV.OdJhY0Ww2y_eQS2zsE9kLw76
 CJZuX68Two3X9VG8ZSsC8Aq5kvxhPaCabPqhXMe0.DhajXQv7CSX0e5hH.qlUWN3qijC0GRQD19g
 nJ2ZziA0GrljwC8tOjjaXeMV9SJRGvNxlNyBsAZ1floyB5FdI3IeQUkp0dRUj4ge0yFnOKZ4eTIm
 i1IPRMm.J5BaqgzI9BRwu8U7J.ZB4bwv0tHLUG9W7GQuzTan8SA1EiZXEBX.iBeai3yJJeWTPS0a
 _HpvXKIsqaskngwa.QdEUslYHcC71J0UekChxNA_oOeNYGFW.64x1VGGwq1vjvGlGiqokVO3QaRZ
 2_jyqVeBIl8lv8kVUn4fktp9DCgbsFhkHAeMi4q2XtOMUM1N_Lo57BHqDC1i580Z3FUZk6WxM7GT
 QngW0nATYeOtWYTV2VLJsLSsNebruW5xJwHrjlP2JYfw6xVd6SMs17z7YTD3zvW0I69hlKVdkmK1
 OTtRWNVbiUjl5j0xX7eGJuFaWoYPvgSoPC2BmXHGUW_WdoahgwvUgAwNh4.Wb4Rf4wjCd1t7LoOj
 iBEGsnjdoc3TYjf2.IdaAMIc4tjVv1AMpa4YJ9eCXNjpTUqHLjmSXteobFCJURP7X.SMI5_.TkmU
 M04GFnUAIvPzB2tvB6mUq7zh5CxGy9cEHCgcAXB0rSikBuxivdnnATDZyE.kWclw2rV78Zytgj3K
 ErFx85y38TWfPLbqCcY6IvCW9g61Vj16bCQ.csLmIQ7JZnqzI7_pUwdejO0q_SB9fo2Gke2XN8nC
 4RVNRinaMqpE3HsP1nQa6Z9uP2PtZI3RuWeZ585rIJbkg.tdND87uXkUYu76XtTcxCoMCHoXe8hX
 CRnR3ClZWSfG0wW4g_AQJzfjQ9z.9p81ShkEDG9hYVI9a6i8n.s7y1x_mMcrPQsBN9TFRno69i.c
 EBQs1W4hA6zXbHI4qDm4SPwNfDizyJskLNk5JmRNq4QI0tEp8pIx.6ZqQrVTAYP7NA07aJG9yLQb
 WKpRZ7b3GKb6ksN5FAHQcoA91d3qQA2J58kNLJ4Gn93eH7528gIVJcueNSPmRdoR1GvUnhh40WPz
 uTR9bY0n5Eorv7q4..l7ocssjEjNc8t3RzxSyc_a007CUT27DS.Ky3rQdIoC4izD7WNhB_lvPhPp
 J9pksnaQp.GiJ4vynxcTFM7Y5Y8D64mgsvnXXPyZ54BsGKZ0FTyySyiMBq7C47uaniyajT_SoOBD
 l.dsS8Bit3L.cQp_uz9M8sUsENmECGngeikQH6Wx4bJ2b6RjEn4raVYT0G3YKsjHCWmpiMKyCL_T
 jTisFivX3V6u8XDt_zoRh5QhS4XRK5KTodyF8jKUyvx5nyqzKj6CjDBcAJM88aS6M9kWdWztxqZj
 DqP5ZW95myMZ7Vk8xM9jAygNwYyLVGOuuitBFr4JgStMImbSDVVJGPOgOVX8nxjWWvj0hRTtJeTL
 c4QJCX5jTLGY51suWkp1KLI7aR.P8_YT82Jqu1usiS.QRBclws_D8iMz.YzwsE89YojKzoI0iPFh
 2aK0wOnI8sXafwnYOEge15umesWVgVHh5jhlDglkd7r5amgysdfzM7wEi2y4wmbCuTiTGHeNXw.R
 WI5pEDw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Mar 2022 00:17:12 +0000
Received: by hermes--canary-production-bf1-766d6d57f5-z4vf2 (VZM Hermes SMTP Server) with ESMTPA ID 05dfc940f855908b22d83beeb4c6787f;
          Wed, 16 Mar 2022 00:17:08 +0000 (UTC)
Message-ID: <8be54cd7-61e1-5534-5f27-e3c24c6ad8fa@schaufler-ca.com>
Date:   Tue, 15 Mar 2022 17:17:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v33 26/29] Audit: Add record for multiple task security
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
 <20220310234632.16194-27-casey@schaufler-ca.com>
 <CAHC9VhSYr3nC87jk+cPzvVLgYZO9p9vaM7n+jvGEF60RaNJw7A@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSYr3nC87jk+cPzvVLgYZO9p9vaM7n+jvGEF60RaNJw7A@mail.gmail.com>
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
> On Thu, Mar 10, 2022 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
>> An example of the MAC_TASK_CONTEXTS (1420) record is:
>>
>>      type=MAC_TASK_CONTEXTS[1420]
>>      msg=audit(1600880931.832:113)
>>      subj_apparmor=unconfined
>>      subj_smack=_
>>
>> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
>> the "subj=" field in other records in the event will be "subj=?".
>> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
>> multiple security modules that may make access decisions based
>> on a subject security context.
>>
>> Functions are created to manage the skb list in the audit_buffer.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   include/uapi/linux/audit.h |   1 +
>>   kernel/audit.c             | 104 ++++++++++++++++++++++++++++++++-----
>>   2 files changed, 93 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 8eda133ca4c1..af0aaccfaf57 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -143,6 +143,7 @@
>>   #define AUDIT_MAC_UNLBL_STCDEL 1417    /* NetLabel: del a static label */
>>   #define AUDIT_MAC_CALIPSO_ADD  1418    /* NetLabel: add CALIPSO DOI entry */
>>   #define AUDIT_MAC_CALIPSO_DEL  1419    /* NetLabel: del CALIPSO DOI entry */
>> +#define AUDIT_MAC_TASK_CONTEXTS        1420    /* Multiple LSM task contexts */
>>
>>   #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>>   #define AUDIT_LAST_KERN_ANOM_MSG    1799
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index 4713e66a12af..ad825af203cf 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -2147,8 +2147,65 @@ void audit_log_key(struct audit_buffer *ab, char *key)
>>                  audit_log_format(ab, "(null)");
>>   }
>>
>> +/*
>> + * A brief note on aux record management.
>> + *
>> + * Aux records are allocated and added to the skb list of
>> + * the "main" record. The ab->skb is reset to point to the
>> + * aux record on its creation. When the aux record in complete
>                                                        ^^
>                                                       "is"
>> + * ab->skb has to be reset to point to the "main" record.
>> + * This allows the audit_log_ functions to be ignorant of
>> + * which kind of record it is logging to. It also avoids adding
>> + * special data for aux records.
>> + */
> It might be good to move the above comment into the
> audit_buffer_aux_new() comment header (below) so it does not get
> misplaced.
>
>> +/**
>> + * audit_buffer_aux_new - Add an aux record buffer to the skb list
>> + * @ab: audit_buffer
>> + * @type: message type
>> + *
>> + * On success ab->skb will point to the new aux record.
>> + * Returns 0 on success, -ENOMEM should allocation fail.
>> + */
>> +static int audit_buffer_aux_new(struct audit_buffer *ab, int type)
> ...
>
>> @@ -2157,16 +2214,44 @@ int audit_log_task_context(struct audit_buffer *ab)
>>          if (!lsmblob_is_set(&blob))
>>                  return 0;
>>
>> -       error = security_secid_to_secctx(&blob, &context, LSMBLOB_FIRST);
>> +       if (!lsm_multiple_contexts()) {
>> +               error = security_secid_to_secctx(&blob, &context,
>> +                                                LSMBLOB_FIRST);
>> +               if (error) {
>> +                       if (error != -EINVAL)
>> +                               goto error_path;
>> +                       return 0;
>> +               }
>>
>> -       if (error) {
>> -               if (error != -EINVAL)
>> +               audit_log_format(ab, " subj=%s", context.context);
>> +               security_release_secctx(&context);
>> +       } else {
>> +               /* Multiple LSMs provide contexts. Include an aux record. */
>> +               audit_log_format(ab, " subj=?");
>> +               error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
>> +               if (error)
>>                          goto error_path;
>> -               return 0;
>> +               for (i = 0; i < LSMBLOB_ENTRIES; i++) {
>> +                       if (blob.secid[i] == 0)
>> +                               continue;
>> +                       error = security_secid_to_secctx(&blob, &context, i);
>> +                       if (error) {
>> +                               if (error != -EINVAL)
>> +                                       audit_panic("error in audit_log_task_context");
>> +                               audit_log_format(ab, "%ssubj_%s=?",
>> +                                                i ? " " : "",
>> +                                                lsm_slot_to_name(i));
> I wonder if it might be better to record the "subj_smack=?" field
> before checking @error and potentially calling audit_panic().  In
> practice it likely shouldn't matter, I feel better if we at least
> record the subject information before we call the wildcard that is
> audit_panic().

Not a problem. Easy enough to fix.

>
>> +                       } else {
>> +                               audit_log_format(ab, "%ssubj_%s=%s",
>> +                                                i ? " " : "",
>> +                                                lsm_slot_to_name(i),
>> +                                                context.context);
>> +                               security_release_secctx(&context);
>> +                       }
>> +               }
>> +               audit_buffer_aux_end(ab);
>>          }
>>
>> -       audit_log_format(ab, " subj=%s", context.context);
>> -       security_release_secctx(&context);
>>          return 0;
>>
>>   error_path:
>> @@ -2382,13 +2467,8 @@ int audit_signal_info(int sig, struct task_struct *t)
>>   }
>>
>>   /**
>> - * __audit_log_end - end one audit record
>> + * __audit_log_end - send one audit record
> If we want to be very nit-picky here, "end" is more correct than
> "send".  First, audit_log_end() doesn't actually send the record, it
> just queues the record for the kauditd_thread which then attempts to
> send it.  Second, there is no guarantee that the record will actually
> be sent at this point, although it would be nice if that were true :)

My bad. I thought I had deleted the 's', so I fixed it.


>>    * @skb: the buffer to send
>> - *
>> - * We can not do a netlink send inside an irq context because it blocks (last
>> - * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
>> - * queue and a kthread is scheduled to remove them from the queue outside the
>> - * irq context.  May be called in any context.
>>    */
> This should probably be moved to patch 25/29 as it has more to do with
> the __audit_log_end() introduction than this patch.
>
>
> --
> paul-moore.com
