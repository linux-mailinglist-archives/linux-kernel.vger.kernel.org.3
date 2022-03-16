Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161EA4DA6A9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345045AbiCPAIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiCPAIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:08:17 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2E4A3F7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647389222; bh=17CqI6wDcACcmVyzDX7yK4XDzhZKA2hzZCXhuIJmRf8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IKvLd1YCb4cXQDthkJ5W8YbZr9yCoYaJzfY5F4PF8kTHG8tDu7/ldASrBXzi2h4yzFcuyFX+uH4ipee6Ayw/VXNYEER6+glOttuoEtfoOGKMb78QB5az/6r46+ucQ+QDgyd4JJSFTVbMI8/wYZjtXSi/aqA97H//XwnA0NUVi3iVsw9UscQ3p7yPa1Pee6XXzuKAa/t6t3qwc9+iGCq/Df6EhvrvFWXg3nVIXIqzQnf+lyl7W6Q6oyHpGc3zlRwaeslEOgpOXqpAjEY++6Ddzp/9N0sMNIG8A2fGx7I/OBGXx7IABRWdAuqHPYXQfoj4UiDqTgvWiN9XeJh+tl892A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1647389222; bh=ne7SrGYZz+JEa2VhbSJV/mo5kMmpeLs22krYla3fGSV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lxqYmzOl/aUeUpgop1n/WRP7gw+IFEcS5xViwGTbQmFcsGmDIa9yStkoFCqqybdPHQUWO7yX1IZNPuH22pDFlCHJu6ZXbBm3FQWOCLOzK+qkDXrJ86InH4BdWjxAOol1M2sNluqi/HzLIX1RI+LSUBQbK/ILZtq6wkVRbYNY+PYHanORiwov99EDxmjzXYGNS90Mov22tGyHxuW//r6WbUX0hjzyFUpXE34Bxldk6fqpUPqnt73Ka0PPR65PC49GeaLCwt8p3KDTXIwqn0cIjP6CCXRe1bfqFn9ITjSDAocg0vWroqMoKUk3/IuhVpNS5uwcM7atYrFA/VA/8ij/1g==
X-YMail-OSG: eJoJ0PwVM1kRcmAqTu1m6BitgnI6ePZhg2SqYYxsa0Y14D6bxGgy8eb06wCXGiH
 iD7VSTyXOCmzY.xtT1UX_LzCusTE88Y_WOYqCm.oiqZ1CSmTRf0NE9WbGRUQ9AtmrOKDjc4UCaVT
 FRqRV4u_vuniJUnMzQZ58Y7iV3JHMa3ku9qrqjMSPZW0LZwZirGRYkgxgfJDjb0z0VvvwKtz0_Sw
 Nszkk6VA1Ibf9MeWT8FFjq.bi6OGl_LpGHaItaH1FxzXCT9KX4OicA78LGcfmC4bfKNnX7UqfInE
 sV4G4BJ3gyDI3AanVx6N80QExxnPGItnDTTEn_R8gK94xW9YsD0hGb8A18aTbDkQoGRaaB_YeHWm
 UILeg.sNy0Iq56QkH1ooKJGV7_NZrDVHjbw6whv2SIxPpZ1RKR42KBY6TNEsbi6B0CgC_qiLcm2Y
 yJCKgzO12vGsa6mztsyDP0eJ0ycW.8JOaD3Ohsc_7010g_eU9iiRD5sFkhTfFKlXmgQzKJiYBUhQ
 OT8He9bOJzvxel3ZUMj0z2cROoy0qhysrPGTxjYBVawoQcExZ.A7w0afVjuRREeKvDDJr08HXJBm
 5E7MQumRlowcR5eBYPxiW3IU_FcXpFTQH1cXR.Rx_apgzXw7jDIE0tg35mdLih.chXJ16Z2VhHok
 BdgMhojIDjHOCPgfsBQRVCUCyiRSBHQc2K8Pizhin.ITH6jSMUsG6hatojFYT0ujTM3ZhNLkDovJ
 X0LmxrpchiNNdwfPsvWEQK_rcbQBb9hSOsvxCvSzt_AXRUAOhH9cSpKm7a.RJZAX8O3sHlkJzxme
 LU316L0ylOGKEUAuyd1K5DKr0DO7A3kYolRHzqMBJnYBflCXciuZPsnbKjqgr6f_.0rjGTQeG0fs
 19aAPgbomgbmT6G7jUewe7X0Lpwj3wsrDig2C_zJtrv_DDmHOpqVUaQjmqKuCupegR1xq.YGPxBI
 lJhkREMZxjt72XTcw3AIAQePp1gf65bbD4g1A3GZnMbzMF.7bkqU1CQWnaZNydY9iN3noq_2iJF7
 t3.c_VoYfJBMQAiF5qg9uvXQgWC3.Wcb85_5OXo1E9rRA0pZGSbRWHrEOT6D5BYbvtcl8hStwFbd
 xIJKUZKb2YwRPYjWgwW_liRslqR74nU3pwDaSdPXIyj8cZ9LALAJgrOYakyO2KXOyEn_lzeRlt0V
 MCwklIf5eiy9v2aJVhXHEkR19t6urDQnsu6qf.KmmI3GYR3IGLoiRluWpVl5CCJZlg.cFxNec4pe
 VBbA4x9cRq.kC._ddTkfJRXzDZltzkm981_PkjvfDkbBF5hKVCAfg7ipkQEMMBmOuMVpji.p3Ogo
 QfBI5YBZtNAV_CE2HSlgfkhsIRzwCzj.QtZfVsWecbMJOp9L_tnU2EE_4gedz51qwdxmoAcCBpVw
 3i8nkbvp9.qDCq45EHoSB9CGNxUbBH6kaBxTU.Juu4M8WweqOMGFulkPx6ZbFj9YfQhkB.KTCTnn
 jQewrZVxScEwrheA8eIVPdVvrXkRhM67Rt.FBho_XOhHOa1qLA08Q1aLx2rMlD2L1_H4yweXJdAP
 wxOQYdrLTz_A9RcdFWFovj3etIYOiIFqdJJpfuwOSaeh2nglDqXAv7y30GzEDLnJzCMea.ijIKLS
 lQNRjLZ.sWyF20eA.1IG_ksqQw2P7dPSzw5ZgHV5VvJmfltujvIDP1DsF4gQlXX4w38yp1vuy7_R
 3vqih.cH71AsYP2ml.H0BpX7RLl7s6Z.aZo6fBq8SJaD.3TOQTMMORqv3CdZ86d6329OnK.Inmgx
 mI.gPpWzS9bKe6j2.dpuMistCwDFHVf33wZdAwRBlShMRBdB7ookvjL0rlFCugFx7tFAiIOdrlGA
 KUuL5T7oFiVJuv2UIFBCHCq7ezGiHaq_n36hv2bKJr70XmRMEPTraelNgJiRdWMNMs0UgRxcuSdw
 MU7cxmbBYQfHGZ_8LhTgXGdro6O8n.RbJDDty8UhW01cCE3WOzAk_.9ToxkU_eiTVEZIXA.7y2Z1
 l_rrN.DFgW3PDi3f4dhwAo3CusXjX5FLb25Lq0nGLucQhUHTsdCzLf5nQODXGVGS0EDb3A6Tzca_
 SwizrOrZ.q.wOr54pgtzzxnFWe5JUFfUAPEwIoZEl4y7wR0POWkY3K1wqjWGvhn.fjBAnIB9FLOZ
 B3MZXs3KycbqFsa_po29RijbVy2nd644NzitgKqxVzoaGNyGHqxuvC1iS.e1ChOX_aptdl.dbCxR
 L_.e03Mq7KuI0_MWE.98cpGb.cHjd.1RDZ326Pqp3.yfGadG3MZLuwCvJsRnmOLJ2cWk2a5qgAjc
 M
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Mar 2022 00:07:02 +0000
Received: by hermes--canary-production-bf1-766d6d57f5-vvkg6 (VZM Hermes SMTP Server) with ESMTPA ID 888b8df0963ca36e60da537306eef9a0;
          Wed, 16 Mar 2022 00:06:57 +0000 (UTC)
Message-ID: <86e7613c-6878-21e5-82af-2aa726e230f2@schaufler-ca.com>
Date:   Tue, 15 Mar 2022 17:06:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v33 25/29] Audit: Allow multiple records in an
 audit_buffer
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220310234632.16194-1-casey@schaufler-ca.com>
 <20220310234632.16194-26-casey@schaufler-ca.com>
 <CAHC9VhTkXaJ6nsJU9hf9KO22bGSpyr8EeBQKef-f6jhy_6OEkA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTkXaJ6nsJU9hf9KO22bGSpyr8EeBQKef-f6jhy_6OEkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19878 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/2022 4:47 PM, Paul Moore wrote:
> On Thu, Mar 10, 2022 at 6:59 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Replace the single skb pointer in an audit_buffer with
>> a list of skb pointers. Add the audit_stamp information
>> to the audit_buffer as there's no guarantee that there
>> will be an audit_context containing the stamp associated
>> with the event. At audit_log_end() time create auxiliary
>> records (none are currently defined) as have been added
>> to the list.
>>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   kernel/audit.c | 53 +++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 35 insertions(+), 18 deletions(-)
>>
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index f012c3786264..4713e66a12af 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -197,8 +197,10 @@ static struct audit_ctl_mutex {
>>    * to place it on a transmit queue.  Multiple audit_buffers can be in
>>    * use simultaneously. */
>>   struct audit_buffer {
>> -       struct sk_buff       *skb;      /* formatted skb ready to send */
>> +       struct sk_buff       *skb;      /* the skb for audit_log functions */
>> +       struct sk_buff_head  skb_list;  /* formatted skbs, ready to send */
>>          struct audit_context *ctx;      /* NULL or associated context */
>> +       struct audit_stamp   stamp;     /* audit stamp for these records */
>>          gfp_t                gfp_mask;
>>   };
>>
>> @@ -1744,7 +1746,6 @@ static void audit_buffer_free(struct audit_buffer *ab)
>>          if (!ab)
>>                  return;
>>
>> -       kfree_skb(ab->skb);
> I like the safety in knowing that audit_buffer_free() would free the
> ab->skb memory, I'm not sure I want to get rid of that.  With the
> understanding that ab->skb is always going to be present somewhere in
> ab->skb_list, any reason not to do something like this?
>
>    while ((skb = skb_dequeue(&ab->skb_list)))
>      kfree_skb(skb);

Sure, I'll give this a try. Thanks for the review and suggestions.

>
>>          kmem_cache_free(audit_buffer_cache, ab);
>>   }
>>
>> @@ -1760,11 +1761,15 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
>>          ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
>>          if (!ab->skb)
>>                  goto err;
>> -       if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
>> +       if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0)) {
>> +               kfree_skb(ab->skb);
>>                  goto err;
>> +       }
> Assuming we restore the audit_buffer_free() functionality as mentioned
> above, if we move the ab->skb_list init and enqueue calls before we
> attempt the nlmsg_put() we can drop the kfree_skb() call and just use
> the existing audit_buffer_free() call at the err target.
>
>
>>          ab->ctx = ctx;
>>          ab->gfp_mask = gfp_mask;
>> +       skb_queue_head_init(&ab->skb_list);
>> +       skb_queue_tail(&ab->skb_list, ab->skb);
>>
>>          return ab;
>>
> --
> paul-moore.com
