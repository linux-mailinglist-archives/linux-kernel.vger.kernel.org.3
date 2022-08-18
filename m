Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E8D598908
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbiHRQiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343766AbiHRQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:38:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C322C2667;
        Thu, 18 Aug 2022 09:38:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 73so1687285pgb.9;
        Thu, 18 Aug 2022 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mGi68k3/ZOueNJIfhs8LYeTo62YasiY5TTeVFTAH3Ho=;
        b=mCc4T86k8linRDzEa+vA98jNwF59uiu36VyZqefG36cp4xpU/A5ez8D74FQoLaRyjC
         wh1WNASqhPQkUUiSkAQ0VP8wpsjZDihbAzx8ZWNi00fZ2SYOMA4FhaPVX3A/rarBv84m
         76R0i7PB2q/RJafeE1EDDpFkVDWAI1Seb+Vr26eP4sXDD5LCMCWBHuexY7rBMc+uvudg
         6dosbMzbR9qsFI9Zp1oPXyQKcNk2GLf6s2Ubsi1UdZS8odKNsyOIwTMg5M+5LzNy87JY
         MHIvirnUrNzKhBnoPlW7p2l0nGpMX5IDoYzXnbVJfhEAPMTHZitulBIrcFQXF8vtHCgk
         BfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mGi68k3/ZOueNJIfhs8LYeTo62YasiY5TTeVFTAH3Ho=;
        b=mDDEU3/flmdIoaoLwAzxWXGmq9hxvRc4YSPzyzvE9xEAyw0l2YnIl7RGgkheHsEx0C
         NtRYnkPgktFxjBVWUYTqFyitfedNFtutjM6XfyhRNCxNzDF5uuBIxYBsN57K3jREsZQG
         XxpeXcmFFCBToG7Imt9JqL5KhZnvmGumDcJ4PS77Jf0kiNQsFnzlAdtJGN23izjw3W+3
         7ida2esDmP5rVlREvVRs45rypnAiz2wjAszZL1BrYrcZ2L5RS9NkFufYR8CbaVkD4Rcu
         45SqVBouXU50J1iHs0ExpQpWcGSLZejOXGMe7hGwJmr0aCcnJgCd8qF/njnnBtcTSGw9
         DT8Q==
X-Gm-Message-State: ACgBeo0RHyTn6Ue9GIS96aXgFbV7cx5+hAAXgjI1Bxpx7suLHwa3gJoE
        mSFTgjGVd8nN5L0PGXCeExZhl6zV8EduYUX2RBQ=
X-Google-Smtp-Source: AA6agR5xt5D7tCcbDxlnYYQRWeTaY/NKbs35GKoLcvnlyO0FMvsAd08M5tEPXwnKDfL1TkpQMZ8Iwfk6elr6lUquICg=
X-Received: by 2002:a63:87c3:0:b0:429:fa0d:c954 with SMTP id
 i186-20020a6387c3000000b00429fa0dc954mr3136756pge.96.1660840692293; Thu, 18
 Aug 2022 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220628145552.349839-1-xiehuan09@gmail.com> <20220628145552.349839-5-xiehuan09@gmail.com>
 <Yv5gkKnufS7CUq9A@google.com>
In-Reply-To: <Yv5gkKnufS7CUq9A@google.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 19 Aug 2022 00:37:59 +0800
Message-ID: <CAEr6+ED7UovW1BbrK4s5tCRrTrfkESpa4m3VO4a4PBAY9nK_JA@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn, Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
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

Hi Joel,

Thank you for your review.

On Thu, Aug 18, 2022 at 11:53 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Tue, Jun 28, 2022 at 10:55:52PM +0800, Jeff Xie wrote:
> > Add documentation explaining how to use objtrace trigger to get the value
> > of the object.
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changelog:
> > v14:
> > - make documentation more readable and fix literal code block by Bagas Sanjaya
> >
> >  Documentation/trace/events.rst | 87 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> > index c47f381d0c00..c15f1d25d4a0 100644
> > --- a/Documentation/trace/events.rst
> > +++ b/Documentation/trace/events.rst
> > @@ -546,6 +546,93 @@ The following commands are supported:
> >
> >    See Documentation/trace/histogram.rst for details and examples.
> >
> > +- objtrace
> > +
> > +  This command provides a way to get the value of any object, The object
> > +  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
> > +  static event (tracepoint).
> > +
> > +  Usage:
> > +  When using the kprobe event, by only need to set the objtrace (a new
> > +  trigger), we can get the value of object that is set by kprobe event.
> > +
> > +  For example, for the function bio_add_page():
> > +
> > +  .. code-block:: c
> > +
> > +     int bio_add_page(struct bio *bio, struct page *page,
> > +                   unsigned int len, unsigned int offset)
> > +
> > +  Firstly, we can set the base of the object as first parameter (arg1) to
> > +  to the function:
> > +
> > +  .. code-block::
> > +
> > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > +
> > +  Secondly, we can get the value dynamically based on the object:
> > +
> > +  .. code-block::
> > +
> > +     find the offset of the bi_size in struct bio:
> > +     $ gdb vmlinux
> > +     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > +     $1 = (unsigned int *) 0x28
> > +
> > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > +       p_bio_add_page_0/trigger
> > +
> > +     # cd /sys/kernel/debug/tracing/
> > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
>
> No offense but this documentation is not well written and hard to read.
>
> Admittedly though I am just casually browsing through, so apologies.
>
> So basically, 0x28 is the offset of the u32 within the bio, that you want to
> track down, as it passes through functions?

Yes, Not only track the bio, but also get a value with an offset of
0x28 relative to the bio.

>
> The example is good, but I suggest breakdown each of the commands separated
> by ':' and document those as well.

I don't know how to explain it in more detail, maybe need to be
familiar with kprobe event and trigger in advance ;-)

> Cool feature though, I can see myself using it for something (dunno what yet) :)

Thank you, hope you have a good experience ;-)

>
> thanks,
>
>  - Joel
>
>
>
> > +
> > +     # du -sh /test.txt
> > +     12.0K   /test.txt
> > +
> > +     # cat  /test.txt > /dev/null
> > +     # cat ./trace
> > +     # tracer: nop
> > +     #
> > +     # entries-in-buffer/entries-written: 128/128   #P:4
> > +     #
> > +     #                                _-----=> irqs-off/BH-disabled
> > +     #                               / _----=> need-resched
> > +     #                              | / _---=> hardirq/softirq
> > +     #                              || / _--=> preempt-depth
> > +     #                              ||| / _-=> migrate-disable
> > +     #                              |||| /     delay
> > +     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > +     #              | |         |   |||||     |         |
> > +                  cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > +                  cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> > +                  cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> > +                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > +                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> > +                  cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> > +                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > +                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> > +                  cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +                  cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> > +               <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +               <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> > +                ...
> > +
> >  7. In-kernel trace event API
> >  ============================
> >
> > --
> > 2.25.1
> >

-- 
Thanks,
JeffXie
