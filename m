Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7AF4CCB47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiCDB1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiCDB1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:27:45 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com (sonic301-36.consmr.mail.ne1.yahoo.com [66.163.184.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1517B8AE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 17:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646357217; bh=6uWnuI7AdpEwS0XCUGVPovGTc/yyeEj7T7l1RyagDZE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nMWEZnWLBrWzJ7hAX7oO8fCCTG5uRX3ynDKZfHIwGYkwPdlwk556E2JLqBgPyK13yB12nOP5Jl2yfSFJB3/nxYCuZWnD2npNXY7bwxGrtb5TcFR245lGZFErXF+uine65z/qX3mGpyuNlewB79kLCIMwXztK7ag3/z1hSBVGXN+iwAJVgSbQaNRKZ9p5KRdc+1bBBLOx8AfKvEyBu4EJ8EYNIMGc/l6n+Vf43Cf5249jN4ezvHyOpFCVChi1Ia8PGkwdcRS1RNIDfO7kaCHV4D2/7pW+WR9T8DvrcKSUD+j37Bqdflv8ccqS+zKNXhq84Hn+5+sMMREj5YJMeF1niA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646357217; bh=3szUmKguUmL85OUn4VzosRmckMaoAngiMgsLlFp725g=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FPY9FPXHgTpC7227wNkyqByRuMlajNLLjjiQ3GuY/tkBpy5hLNXI3PNd04AvKvJjF2LmtoaUyQdeRx8pGNWLnn5M1eOQh2e5Tv8882SYsHo2bs2ACUBKjYHyIaAW+qJ7iTEwwPk7JhFg/vFOwDqJcf0+TJPNqpnw8ctNRW8sVXYwManszcdw8hsfrcOOOQeViGRmzZVvMQbH+SYkp+QqzkUhUD9/tgLwKtOKLjtzP8SeZssOjLYWNixSIyOuxEpD1ri0XdiLT/R+isqRI2RxFeXKeESsr0DRdkH3oe28a18z83EeId0j3a78WrOoIRns4VqfEeklq/7HE/memOo9iQ==
X-YMail-OSG: uAVAj6MVM1lAGPtJIYEsbxv5DqIna1GK_3Mx3klJ9vHZEibEhjgGJxt9jymqone
 dJr2R4kHOc7DADAR.lDSSkyAoOdG1_QJvhkAUP4ybpk8YFhAgmoeYRP0r9mq4EbP59ouKJiJ5wGv
 MmDTu_Mc3lOqJDOLUNCUdU7lUuf611QYUG_UKgP42L.sF5OWyCZJNL4t2YAJl3M0r0doVydTVUq3
 9mK5ZrS82YeE06sQB.3sWz2.6PUfrE_Q_WYwcDL9alxYmvZbVekXRVZHOW7mRvbj9aaV3x3TC9Yv
 f.gprv0jKL4hqbPK0CwvEtFeF_stZ681gGuUtUPmQJh6509IdU2n7Fj6hwUFYl_FN5qpvNSkY57h
 MlqahoqgEgq.KUNRj9j_veN9dlF8ZqPlwZjDvp7RpDq22.LfzJ7e0H3PnSyxWwPId_fQYLaq4Isi
 0trCOyn_IWeOI0Q3FqvenEBy6wu8oLChk.UZGMVv18erq_H3te4FaoCVyA1Vo1TxN1VcPC3vqRrQ
 2xCnnnR5s8npUl01YfjaIZNVIb64HcM_pmHTEGSC_OrFmQHRcugrKe.fHgRcV__dTLUfcw26ZnVQ
 sjXNxBJJhc48fw6WrrZQAnNyDZm2AhQgCh4_3t1wSkMzDfr8jP.mCnRTL3YvjSJgY3xZNuYfZvu0
 lwgmVjTu1KpffnuJ93MP22NDmWmK9wce2C4sYgBdDd9JumKK1LnevjRi1GlD2leeXSpNd4g7nKdO
 e4fS5vFMbP7mkarsFTFps40YeGbcCjVOFyAvSL.8GO6bbBnYd1U36pj0KSWNSliC2eIHjDceS4kV
 1pGl8MKStrCuSg8yeSpcNe3URwOH5NmLyNWN1ZafMWoVAviFHBWo9nza0ZSBVIeGKydX95NoyIPQ
 rEIdhKH4SNHBv8x26Rf9dAZZkjQ1Y8Y0tMZFxo9OSvaYKn9nOYjr6Pw1Is6eLLd_Cq4NK.5NYUia
 P_odNufY1oJVx967lriYgJ2jQrTdVDpUFBHSCOaURLMNRYc2tjnaW25.RSM3lAI12jpm0Q_q7oTz
 QBS_RR9oLgJdMWg9pBARfBMXMBIMYtpFg3CejMQZqLUptrcWr4lAws_driTGX1dBXL7VYqEl5dwr
 bufjI1WIxg9d25Ed2AWEFMpSUGxdJVZwPtCFJRIrx9pCAv.dOk0hwSlXz6T75.OPLIgGQuymhg11
 cbnGC2Rh5if4tGBUuK7SncVsQ6zrPXcPBAbgyHe5HpWP4mDuKw_20zjjahU2AT4aSf7Xi3l_u5Ns
 .huoWE4PtFiy2mi41mt8lJ.HcVD5vhQTH56FLgyW8eFHvzr8fCduZhGa.OywAPLud9XjBr2PuUb7
 lnRWiVYhMkrnTQ.Zgg9_wdi.K6oSQ5OOEJ_Mk7mL3OMy9aBjEiPBzjPTZtzUkvn6SpPXEPXGF.wf
 uVFZZBYwa_z6zPSCvWUQmG4xQT2sg0ilxFNDdq_fVrZjKmtGGlVA4xJwjHr7h7DASH9McXEbQ3nP
 QoIO3xoEVeGnPsu9ZGavTKjLJS1gAsc7Tj5tjMtbbT9_IHsa0iznUCoF7cH309ukH2Y50DHSY9x9
 pP8WJb2bF6fFFLMOnCYIvjxxLY11rpdwSVEBZpamloph6rLpuUYS7eksJxVgwYnh9D6ujHuIcjsJ
 qJAQct9q2uFu6DzxrQZzdu2i5uOGeeI.kYea_zoUdg1ScFblxQ3s3tT2T_eafe6foDm.F2Y0CNqj
 BXz47tXpkiCD0vRkfgGbnP7MLtEaUFY1oAUpF_EXR33hZgCAzJnNETfRwUrUgLwaqp04ePtQzMPB
 zPz5CAHAqFI1wjmzwK0qeceVmnTz.kxhzhFakgE94p9chklfur7Ni0ugH3uMuiePR2YeX0.2Z289
 9jR6y8TuHUm3oyniLfIb1ao02lZJm7eq4QDMmlXQQrM4dR.68eht0cwUstY_BDSFJOL2MqYVmkbE
 sZ53JpWg.r7zoRT0tMApe7apGwwY961Pan_3ZeHHU1yk7RjWGo.raeQ0_BR2LgBWo8ezrnDiKZ2M
 jibCb1R5Fw2q5XzQXmxfh03oqC2SjwKfwzufXpAt4OpW20EItI0KcCKG4UpQzts3hWTPIyRZMBAI
 qnhymgdIu1dVl4KR68n5wwfkkg0RApt2IQnhnAh3ATWboK3Au.PMNR555gq9xY46L.q74DYdhazl
 m_vPbRWmtjARmXfLryUgoqO12e9MGoNd70OMPF_dGwyDNuCAbKkAi8rzBi38wPLDagbV5ZGeG1bM
 KG1zzFEUjiBMBjCTcHZRpBnWJhAMJoyZ2K7D7TxSXFilPES26AzTk5qpiLxmqYGfLAND2iTOIeg-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 4 Mar 2022 01:26:57 +0000
Received: by kubenode536.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a537123eb6bfd1b2089ac85d04211ff7;
          Fri, 04 Mar 2022 01:26:55 +0000 (UTC)
Message-ID: <0dad94cc-2f4a-536a-94a9-c74e99c2f4ef@schaufler-ca.com>
Date:   Thu, 3 Mar 2022 17:26:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v32 26/28] Audit: Add record for multiple object security
 contexts
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-27-casey@schaufler-ca.com>
 <CAHC9VhR3d23Zd8=cP1=Sh5DjTEgEAyTc71M-zca4Beuiw7bywQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR3d23Zd8=cP1=Sh5DjTEgEAyTc71M-zca4Beuiw7bywQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/2022 3:36 PM, Paul Moore wrote:
> On Wed, Feb 2, 2022 at 7:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
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
>>   include/linux/audit.h      |  5 ++++
>>   include/uapi/linux/audit.h |  1 +
>>   kernel/audit.c             | 59 ++++++++++++++++++++++++++++++++++++++
>>   kernel/auditsc.c           | 37 ++++--------------------
>>   4 files changed, 70 insertions(+), 32 deletions(-)
> ...
>
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index e8744e80ef21..3b9ce617b150 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -2199,6 +2200,43 @@ int audit_log_task_context(struct audit_buffer *ab)
>>   }
>>   EXPORT_SYMBOL(audit_log_task_context);
>>
>> +void audit_log_object_context(struct audit_buffer *ab, struct lsmblob *blob)
>> +{
>> +       struct audit_context_entry *ace;
>> +       struct lsmcontext context;
>> +       int error;
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
>> +               /*
>> +                * If there is more than one security module that has a
>> +                * object "context" it's necessary to put the object data
>> +                * into a separate record to maintain compatibility.
>> +                */
> I know this is nitpicky, but I'm going to say it anyway ... the
> separate record isn't purely for compatibility reasons, it's for size
> reasons.  There is a fear that multiple LSM labels could blow past the
> record size limit when combined with other fields, so putting them in
> their own dedicated record gives us more room.  If that wasn't the
> case we could just tack them on the end of existing records.

Fair enough. I have no objection to adding commentary that will
help the next developer who comes into this code.

>
> However, converting the existing "obj=" field into "obj=?" when
> multiple LSM labels are present *is* a compatibility nod as it allows
> existing userspace tooling that expects a single "obj=" field to
> continue to work.

Likewise here.

>
>> +               audit_log_format(ab, " obj=?");
>> +               ace = kzalloc(sizeof(*ace), ab->gfp_mask);
>> +               if (!ace)
>> +                       goto error_path;
>> +               INIT_LIST_HEAD(&ace->list);
>> +               ace->type = AUDIT_MAC_OBJ_CONTEXTS;
>> +               ace->lsm_objs = *blob;
>> +               list_add(&ace->list, &ab->aux_records);
>> +       }
>> +       return;
>> +
>> +error_path:
>> +       audit_panic("error in audit_log_object_context");
>> +}
>> +EXPORT_SYMBOL(audit_log_object_context);
>> +
