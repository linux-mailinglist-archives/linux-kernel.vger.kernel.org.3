Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553DE4CCB9C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbiCDCOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiCDCOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:14:37 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F7965815
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646360029; bh=P7XN6GDqkiD99TeeHb0dTFy/6zGwu8WGWw0aiwiteak=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WFgho6WeJJZF+CaVPYUTDLfC9bUJisiXDa737q5dChuNgK7ZA4fJC5OfIut3D4V1iM16zrIAbaAz0Y3/akAHzGwp4zb6RdoWs/Ef4HjWhR+ZUlBEbky7bMW3V+ZrgW42zyxgGTMsc9NwBsOtUDX5y9rfdeSjomCeepIxessUyepjC+jjlpp7XI99TJiPL57G0hjAH5Hvp1r2dAUUwSil3ynBWX0ZCjKf5gJ5MEqg10x7XbnLHlvZfzRbbtmwtTH4np1K/i2gQ+RDVSJR+Yzab9o97PAGCFGOIQG05HGq3vGKa23okDucK1DuiQu0moMQEVD4EC3fxSR9PoXrX0nN/Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1646360029; bh=FG9wnl+b/RW1G5IRiLsYXp30wSLSduCVW7lN0QegVYg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ERmOezgyCykAIfstDc+rDpOm4PZG/O5MGCmvrFaUnu+Y9hbZtnVYfVspaFBY+/RXQJEY1e7LLFxjHIeZZ1AFs4laLW4KFdgfvGlnSVr+f2hxkrmKHCgQzTFyD0XgzJtqckCrL/zVflp+YTc3anZLRJFrdAS9KGdQzciQw7FllW/hNAiXIZzuihLrlRwAuhMKzVB3gzmRpxe/hDjqxErTheDh6uR/Z6VutuZg4QWoHP0wAqL34NYQIOiQtBEG9diYGUwEBpMgAOZkOcnhx3S7oCvQ9lC7OQe4M0BEocuDFkgtiW2iY9ZdYpNKZ0EY9L0G1lhkvbmrw/uvNA3Bl92TzA==
X-YMail-OSG: jTfT5m8VM1nHHHpg0G_QiMTYI41gJAwr_gzib_mGTIbS9GJPsm0wCTZ5W6usp1k
 T7CO5Dt5xerOzF9HLdpJLQ1hqWI2z093M5WUimpsMIquSBm6IlXfYoFkFiogGxd7J5gQcj2TSq9I
 77WLBmz6P1Goyv_TWCvdbrl6yJsk.wJRuOsqvasilMEJ3A78Nz0Q7HbqU27EGW3KFgwCZYwup7Vt
 s_jSyYnCsJYh2v0rjMf_rLFW8KmLqBmLBFgc4hE6jX8ltIohyND3eu2MuU6ZxLnjvWfhC_T_PwhB
 wGQizc6hsZrKxG7O.0uHYndUmuDl4bx0umpaGMmvYnMwtfpXVhyw._eBGzUHKy7s_57tNIpkxN3G
 utnUR_5siifdzKweJX346cxnr1X.JwjAn4fNJcTNmSVvV_ggenuT96xkjqyTw7GUV7DG7tNy5RWT
 lZ3G3ZoMhp.HOa8Ql6uUiHwgVo9rIiu53gJY9eMACvH0lhA78nsemQSobWreZb2jxfSMqvx13GDd
 TXMYljOIeCMqgMUFGsshHOdQ21XWr6soDNpxIr6ZLBrKjPj_0sYqZrhVyx0had4APO.P82YeHaNa
 Fk7tZqyK.XhXqWRj3F3CbXaXF_GybbAamCR.4MeuYp04N28PDnOsclu4ivzyV7aky88Drq3iSkGG
 UndfzVH0boy2IuTEkaK5xljkJHeaseqUR8o42sK9dvUan4XX.cMR7.QdqwDWgElS3DcSOE6rF7yj
 x6Uo_JNCqCyrXhu8PGdlPCTElhnpRpBOyPsvPBiElT5ihuDmJUHSRROrsSBvwDQNz5Lya9bofwIZ
 w8ER_aQhksWlSA60FAKvSlnS79DvbtY4TaGeN__WUkc72RrgYT.2.eQ_xjVSiwVaqFc.IOwxG1lj
 xjX4idQmuDyxRrsMrq2dZZhDETqUlBv2GyRg4gj5cljZPi9THvfeMY6sBUUvSQJD9qRaZyXozdJi
 1y1IVdW9gJFHF9uNHlNegtnGT3KPIkJ8w9Cbri_8JAznmwmUrbAGw4vCP1I2OrC7N75OQKCHe.gh
 jQ7e4oafWLAHCSyL0QQ9zIEK.T2NDJ0n8lO.5_ZMecqvu_CGtv.MbBFV07fqtdklzemm.WhkhK1n
 3WIX9HPwZNQv_jnupZMU96EK9KQG0u7iEIAo2hJVZsb71aHwJOSrIZ83pLpRiL4kF2fBEb1.xfhJ
 fHy3EdH7_R82eNn4Fsf_3u_kxwWbzON6pZgbbexLsPwi60A8_8CZQkS7YCslAXuwDkhTutihn.YX
 p0RYoHRn0..08m1YDabtFSG4lqPoRHATh_aTVhTIKiegp5F9qYXcpa2CzRsLLjiBIg48UDMgTlzC
 gby4RdokKZOORII4BiIr5.gHPyFlKJFboOlZOwmbqik35.ckbE3cfSh3FzdYAt6hOfeVDo1zJf7L
 mDMEB2EIkMDDFO_g4EDO.5R_47Qy3kwrX2AiTN6r7NT_O88VLf6QoDeIFRu3KoFmhr6TARRW8G5R
 D3.3S0cbsliXn2CxM8tbnE1KY58.RxwrnLWkW_6AddK6vNjLN2qZ4vp__wWbpLG4twr2Q3nyqgrJ
 gtBbbZntuUgGhaCNjo.QHrPbwxQ7tmuBY.Z_ENtOdO1TrL2ehY7UZHuMWWbuYBe3aflWI_VRy8Pq
 44.VLfb5n0UxB8wJMyU3mSwIPGs9Ecjbp3s71v8N237oW4jXpRDhIsfygLSWxYbrFG6KCcNlV7vV
 DnUvG75UmomV78RrObdIwBWzwDvF8Alxs3.m3PSf9ZIM0r7Ya9Ef_YOcQH96F5.yeDfWptGnSKPx
 AVPpnbBj9qNhgZcFU62L.vdxHh6FaOvBnTvONh.00B6zzlRz4BqRVLv3hSKGiYK2JcW0jms9c.Kk
 z7ijsguvEBFABY2E4kQQ70Z0Piams66UrbXOYXuHBjDQPh0ui6C6ya7w7tkleGphIINew4D3rezb
 ABUDTwBWldwZ9L2tCbxp5aw.2wh23DFKJMIYWwB3rK9_p2M4.JS95NsMsrl52Lpwi1RTgl0VO5vH
 U1mqoLi4mZ.PdXhj_Kw_M5WVTyjq8I0tfa4DoXcs1K6rlWIqzH2RSgpbih8UnWwPCrqq8LIHe.a1
 kj8Y7uB68ktTikTMw3BibVgELUOwsdTAy.f3HFB4HwrJCnRJPZ_bRWrOpsrT.usoG94V7OfBCS1E
 sWJRrkhk7oJF2xdfBGnYIiITxYJCztzQSpWoycl83ej04.n9qw.C5_tUUoopr.6ogYNYDiGrTzG7
 a4pnbo7JgCpvISRDP0T4Evz0UjuvEruSAUio.1V92pjpwchxJfqgyVIjc3f61B0YwXa4SYxLBgTk
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 4 Mar 2022 02:13:49 +0000
Received: by kubenode548.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4db6f65d6c0f135cd9c3d7ccb463ee64;
          Fri, 04 Mar 2022 02:13:47 +0000 (UTC)
Message-ID: <0bbd2d61-415f-08f2-251e-2dd6b8991d6a@schaufler-ca.com>
Date:   Thu, 3 Mar 2022 18:13:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com>
 <CAHC9VhS6An9L7LavYTP57QXdOugQf62NCjDmS4kQq3wk+yemcg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhS6An9L7LavYTP57QXdOugQf62NCjDmS4kQq3wk+yemcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/2022 3:36 PM, Paul Moore wrote:
> On Wed, Feb 2, 2022 at 7:20 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Add a list for auxiliary record data to the audit_buffer structure.
>> Add the audit_stamp information to the audit_buffer as there's no
>> guarantee that there will be an audit_context containing the stamp
>> associated with the event. At audit_log_end() time create auxiliary
>> records (none are currently defined) as have been added to the list.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>   kernel/audit.c | 84 ++++++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 74 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index f012c3786264..559fb14e0380 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -191,15 +191,25 @@ static struct audit_ctl_mutex {
>>    * should be at least that large. */
>>   #define AUDIT_BUFSIZ 1024
>>
>> +/* The audit_context_entry contains data required to create an
>> + * auxiliary record.
>> + */
>> +struct audit_context_entry {
>> +       struct list_head        list;
>> +       int                     type;   /* Audit record type */
>> +};
> Looking at how this ends up being used later in the patchset I think
> we would be better off if we stored a fully formed audit_buffer in the
> struct above instead of data fields which we would use to generate an
> audit_buffer in audit_log_end().  This helps tie the buffer generation
> logic in with the existing code with which it is most closely related,
> it allows us to report errors back to the caller as audit_log_end()
> doesn't historically return an error code, and it helps us get ahead
> of any future data lifetime issues we might run into by storing the
> data in this audit struct.

OK, I'll buy that.

> This would also simplify things with respect to the audit_buffer
> struct.  Instead of having a dedicated struct for the aux data, you
> could simply leverage the existing sk_buff list mechanisms:

I can't say that "simply" is the adverb I'd choose, but sure,
I can do this.

>    struct audit_buffer {
>      struct sk_buff *skb;  /* part of @skb_list, kept for audit_log funcs */
>      struct sk_buff_head skb_list;
>      struct audit_context *ctx;
>      struct audit_stamp stamp;
>      gfp_t gfp_mask;
>    }
>
> The only sneaky bit in the struct above is that we likely want to
> preserve audit_buffer::skb as a dedicated skb pointer so we don't have
> to modify all of the audit_log_*() functions; you could of course, but
> I'm guessing there is little appetite for that in the context of this
> patchset.

I will give it a go without making the massive interface change.

> Adding a new aux record would involve calling some private audit
> function (no one outside of the audit subsystem should need access)
> that would allocate a new skb similar to what we do in
> audit_buffer_alloc() and add it to the end of the sk_buff_head list
> via skb_queue_tail() and resetting audit_buffer::skb to point to the
> newly allocated skb.

Good naming may be tricky as we need to indicate that a new buffer is
being allocated for an attached aux record and that the buffer to which
it's being attached is going to temporarily be in a curious state.
audit_buffer_add_aux() seems wordy, but it's what I'll start with lacking
a better suggestion.

>    This would allow all of the existing
> audit_log*() functions to work correctly, and when you are done you
> can restore the "main" skb with skb_peek().

audit_buffer_close_aux()

>    If for some reason you
> need to fail the new aux record mid-creation you just dequeue the list
> tail, free the skb, and skb_peek() the "main" skb back into place.

Why do I always get nervous when I hear "just" and "skb" in the
same sentence?

>>   /* The audit_buffer is used when formatting an audit record.  The caller
>>    * locks briefly to get the record off the freelist or to allocate the
>>    * buffer, and locks briefly to send the buffer to the netlink layer or
>>    * to place it on a transmit queue.  Multiple audit_buffers can be in
>>    * use simultaneously. */
>>   struct audit_buffer {
>> -       struct sk_buff       *skb;      /* formatted skb ready to send */
>> -       struct audit_context *ctx;      /* NULL or associated context */
>> -       gfp_t                gfp_mask;
>> +       struct sk_buff          *skb;   /* formatted skb ready to send */
>> +       struct audit_context    *ctx;   /* NULL or associated context */
>> +       struct list_head        aux_records;    /* aux record data */
>> +       struct audit_stamp      stamp;  /* event stamp */
>> +       gfp_t                   gfp_mask;
>>   };
> ...
>
>> @@ -2408,6 +2418,60 @@ void audit_log_end(struct audit_buffer *ab)
>>                  wake_up_interruptible(&kauditd_wait);
>>          } else
>>                  audit_log_lost("rate limit exceeded");
>> +}
>> +
>> +/**
>> + * audit_log_end - end one audit record
>> + * @ab: the audit_buffer
>> + *
>> + * Let __audit_log_end() handle the message while the buffer housekeeping
>> + * is done here.
>> + * If there are other records that have been deferred for the event
>> + * create them here.
>> + */
>> +void audit_log_end(struct audit_buffer *ab)
>> +{
>> +       struct audit_context_entry *entry;
>> +       struct audit_context mcontext;
>> +       struct audit_context *mctx;
>> +       struct audit_buffer *mab;
>> +       struct list_head *l;
>> +       struct list_head *n;
>> +
>> +       if (!ab)
>> +               return;
>> +
>> +       __audit_log_end(ab);
>> +
>> +       if (list_empty(&ab->aux_records)) {
>> +               audit_buffer_free(ab);
>> +               return;
>> +       }
>> +
>> +       if (ab->ctx == NULL) {
>> +               mcontext.stamp = ab->stamp;
>> +               mctx = &mcontext;
>> +       } else
>> +               mctx = ab->ctx;
>> +
>> +       list_for_each_safe(l, n, &ab->aux_records) {
>> +               entry = list_entry(l, struct audit_context_entry, list);
>> +               mab = audit_log_start(mctx, ab->gfp_mask, entry->type);
>> +               if (!mab) {
>> +                       audit_panic("alloc error in audit_log_end");
>> +                       continue;
>> +               }
>> +               switch (entry->type) {
>> +               /* Don't know of any quite yet. */
>> +               default:
>> +                       audit_panic("Unknown type in audit_log_end");
>> +                       break;
>> +               }
>> +               __audit_log_end(mab);
>> +               audit_buffer_free(mab);
>> +               list_del(&entry->list);
>> +               kfree(entry);
>> +       }
>>
>>          audit_buffer_free(ab);
>>   }
> This would also allow you to simplify audit_log_end() greatly, I'm
> sure I'm missing a detail or two, but I suspect it would end up
> looking something like this:

Agreed. That is a much better fit for the existing code flow.

>
>    void __audit_log_end(skb)
>    {
>      /* ... current audit_log_end() but with only the sk_buff ... */
>    }
>
>    void audit_log_end(ab)
>    {
>      if (!ab)
>        return;
>      while ((skb = skb_dequeue(ab->skb_list)))
>        __audit_log_end(skb);
>      audit_buffer_free(ab);
>    }
>
>
> --
> paul-moore.com
