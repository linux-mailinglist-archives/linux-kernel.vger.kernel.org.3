Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAC655ABB4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiFYRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiFYRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 13:07:19 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668515A1C;
        Sat, 25 Jun 2022 10:07:17 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id k24so7548010oij.2;
        Sat, 25 Jun 2022 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8n9hH/ythAzKKBKCcBBuLLTJGb02YFxnmek8KzP48ZY=;
        b=Xj14f2kF5uDcTrOhgRk/1voVwpMJzJpmVCSNNBF3kWL5gJ3nQmljbmB0vJGWVDMKXT
         aUVQUS5qnNtX0wOeSuVtvrADrVzSWzIhs54A/kk0RRaUJMlpDCjjyaBXLjcg6V1Vkc33
         dFYi5yD6jRCpFgsfVWc/ECuRgWbln3L61Wb0AhSkhclG+wmHtrnPMPsnCRV3ebGOT3Ro
         A1+ov/HeaN+UYmjbUGhxtx7WR5gZCHHdUk+3ZeaxZD1Q4p3fqFQeP/9lELspW1uU9AX0
         LEv5kZ3VVcmL2yl36+VtPkDvIozmMSIFmZsCXrxq6MUdDGlWLS9kQk+DgoF7E1nKQauR
         ASJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8n9hH/ythAzKKBKCcBBuLLTJGb02YFxnmek8KzP48ZY=;
        b=7fTFgvKp9dZjK4+ywVMS6mvkjQGtnAWEHWfRJ9of9RuyK4jnGqqIZS+P8Y40Do9kUT
         f7plz1o8SjpMXQyCg9cOkQLaIrE0u3sPbcbQ4CE3MtZaSNc9iLB/RhPFdSFHl2VgyEc3
         EbubsS3704gS0gC+T0uwb0cqrqwpxlKNvC7xsmkDhdoxVKG/KTgj9BSYa4p7g+usyKej
         F5g6+zE0ZYFAegTDUmeGQoR8QwDmUS3Pm2oja3wy9E6H0XRSAplRcew3jqgtwi9Qg/ln
         wQOkvnxyNwYXQWkM7hM+ihrNFqShA69Cc7T+ZjFZCOov0CAak3tk7HpHwpzid5R9qoYB
         sKIA==
X-Gm-Message-State: AJIora9r4jKvGDWqdMWXBY/P5oHsZvHutTkM6nCABJjClDiBrJAE2k7D
        eG6GwgoLZIGCV1/uNQhz17RpotcbMC0NNkbVGHE=
X-Google-Smtp-Source: AGRyM1tky3qHCX8JXqM0saeXGeVNItq3JpdgE7sqUGOAM3SJJZHjLdqcxT0uTLhjPLworwQNvE+o2Rlv80GA4Jm4CM4=
X-Received: by 2002:a05:6808:e8c:b0:335:2835:79c3 with SMTP id
 k12-20020a0568080e8c00b00335283579c3mr5493503oil.217.1656176836854; Sat, 25
 Jun 2022 10:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220606160943.663180-1-xiehuan09@gmail.com> <20220606160943.663180-5-xiehuan09@gmail.com>
 <20220626011006.22572fbabcac5c8494e09f13@kernel.org>
In-Reply-To: <20220626011006.22572fbabcac5c8494e09f13@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 26 Jun 2022 01:07:04 +0800
Message-ID: <CAEr6+EBCPoZ_KkdOkFQgqgc9rrsOUVbkthJN6t-OLvL2gBwmDQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] trace/objtrace: Add documentation for objtrace
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sun, Jun 26, 2022 at 12:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> OK, this looks good to me.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> And just a note that please add 'Documentation:' tag to the title
> and Cc to linux-doc@vger.kernel.org and Jonathan Corbet too since
> this is a patch for the Documentation/*.

Thanks for the reminder, I will do it like this in my next version.

> Thank you,
>
> On Tue,  7 Jun 2022 00:09:43 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Added documentation explaining how to use objtrace trigger to get the value
> > of the object.
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  Documentation/trace/events.rst | 83 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> > index c47f381d0c00..0dc475160133 100644
> > --- a/Documentation/trace/events.rst
> > +++ b/Documentation/trace/events.rst
> > @@ -546,6 +546,89 @@ The following commands are supported:
> >
> >    See Documentation/trace/histogram.rst for details and examples.
> >
> > +- objtrace
> > +
> > +  This command provides a way to get the value of any object, The object
> > +  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
> > +  static event(tracepoint).
> > +
> > +  Usage:
> > +  When using the kprobe event, only need to set the objtrace(a new trigger),
> > +  we can get the value of the object. The object is from the setting of the
> > +  kprobe event.
> > +
> > +  For example:
> > +  For the function bio_add_page():
> > +
> > +  int bio_add_page(struct bio *bio, struct page *page,
> > +     unsigned int len, unsigned int offset)
> > +
> > +  Firstly, we can set the base of the object, thus the first string "arg1"
> > +  stands for the value of the first parameter of this function bio_add_gage(),
> > +
> > +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > +
> > +  Secondly, we can get the value dynamically based on above object.
> > +
> > +  find the offset of the bi_size in struct bio:
> > +  $ gdb vmlinux
> > +  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > +  $1 = (unsigned int *) 0x28
> > +
> > +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > +     p_bio_add_page_0/trigger
> > +
> > +  # cd /sys/kernel/debug/tracing/
> > +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > +
> > +  # du -sh /test.txt
> > +  12.0K   /test.txt
> > +
> > +  # cat  /test.txt > /dev/null
> > +  # cat ./trace
> > +  # tracer: nop
> > +  #
> > +  # entries-in-buffer/entries-written: 128/128   #P:4
> > +  #
> > +  #                                _-----=> irqs-off/BH-disabled
> > +  #                               / _----=> need-resched
> > +  #                              | / _---=> hardirq/softirq
> > +  #                              || / _--=> preempt-depth
> > +  #                              ||| / _-=> migrate-disable
> > +  #                              |||| /     delay
> > +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > +  #              | |         |   |||||     |         |
> > +               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > +               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > +               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> > +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > +               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> > +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > +               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +             ...
> > +
> >  7. In-kernel trace event API
> >  ============================
> >
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie
