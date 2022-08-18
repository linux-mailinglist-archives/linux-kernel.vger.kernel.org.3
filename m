Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A55598A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344783AbiHRReR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243946AbiHRReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:34:14 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011332EE6;
        Thu, 18 Aug 2022 10:34:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r22so1813605pgm.5;
        Thu, 18 Aug 2022 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EqZ6197pP8t7+d5LJrKRHbl6fiBqHsAYlVBVeIDO1T4=;
        b=R/VJtXMHVs/nPZ7S9/I14rGMoDZDXRRK7qWsNq+j8XFXPPl1qdlADlfZ7A4fbZ1e3P
         +FyG8JmKJW3wQrAPVx4TGFfz0A/KOdiXwVcmF7w4cnLXnNgiCx1OnpWab8cYKc8Gk2hE
         Xq+CY6zZ8mR7GFz0whJtw3UnLfpQF/7ZxdKf+PfUBBKryMZykrogr5GOedU0Ga5fmecr
         pGy2Gpf7Wt+CJSIhR4XSeQRKr+KRnxANdNF5VCILBO3JthSSGtuF7uHHpme7Zk0ZKX8l
         G/hYUwphUZawE8f60ZuW2O2Kg7SA8rXZXuHe+3p6fTkXapskXCjvKRqETj4k0XfFPRSi
         zY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EqZ6197pP8t7+d5LJrKRHbl6fiBqHsAYlVBVeIDO1T4=;
        b=MenmPlMOPrXMqGtw73pf/cFiR18KEbuAS+9p+naEtlp/fzBiAiPiKEQigOtI/oaoHR
         JDicKhjRlzC4oeHSN8sry4MdmxlolCpmhknMXZgwoCdAVvm8CskwE5W9+2PIK9sHkhcl
         puget6fhPtgVpVV+Q4CULURspE7SRWyqZlC5wbQ4CwsPKuDys639eYe084DSLyJOHvk9
         q0z0IWUAOb3FBGM8v1QL+4plN2a/TuS6C7o/FcvSt1eNcEDl9c5MJwlmUxcqOXgHtKEa
         Sw6NrkInguLnuSXrpt1Z1qDMbFjMllrnpVaL2F5lg/K7NjEeGZUOOYNslWm3K4HzlmRP
         OM3w==
X-Gm-Message-State: ACgBeo19kOLwEeZDtQQ8HtnPN2Dbkbbj2J/oV9Q5VHWi2+gpobjs8xeE
        Gn7lfY//F0g9ysW9eLdkQS8hLoWZ53YGjg7xuns=
X-Google-Smtp-Source: AA6agR4sfHGkNf4UvGajjR+GAmdoEDJ7CaNpiD5LP+fJ2n7229JDGe2UnIKBNlq5GdMGyRHlUvEIsGYUFzB05SOTd+A=
X-Received: by 2002:a63:87c3:0:b0:429:fa0d:c954 with SMTP id
 i186-20020a6387c3000000b00429fa0dc954mr3287390pge.96.1660844053530; Thu, 18
 Aug 2022 10:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220628145552.349839-1-xiehuan09@gmail.com> <20220628145552.349839-5-xiehuan09@gmail.com>
 <Yv5gkKnufS7CUq9A@google.com> <CAEr6+ED7UovW1BbrK4s5tCRrTrfkESpa4m3VO4a4PBAY9nK_JA@mail.gmail.com>
 <CAEXW_YQAFVJRe9mUnR1HAXvYDiQ3jCwrKhO52t8O=bxb_qSCzQ@mail.gmail.com>
In-Reply-To: <CAEXW_YQAFVJRe9mUnR1HAXvYDiQ3jCwrKhO52t8O=bxb_qSCzQ@mail.gmail.com>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 19 Aug 2022 01:34:01 +0800
Message-ID: <CAEr6+EBC3MfqGZQ8zqLhr6P1VFkU2Hs9JsM-mqGBXWKLcAXkAA@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, chensong_2000@189.cn,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 1:05 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Aug 18, 2022 at 12:38 PM Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > Hi Joel,
> >
> > Thank you for your review.
> >
> > On Thu, Aug 18, 2022 at 11:53 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > On Tue, Jun 28, 2022 at 10:55:52PM +0800, Jeff Xie wrote:
> > > > Add documentation explaining how to use objtrace trigger to get the value
> > > > of the object.
> > > >
> > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> > > > Cc: linux-doc@vger.kernel.org
> > > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > ---
> > > > Changelog:
> > > > v14:
> > > > - make documentation more readable and fix literal code block by Bagas Sanjaya
> > > >
> > > >  Documentation/trace/events.rst | 87 ++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 87 insertions(+)
> > > >
> > > > diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> > > > index c47f381d0c00..c15f1d25d4a0 100644
> > > > --- a/Documentation/trace/events.rst
> > > > +++ b/Documentation/trace/events.rst
> > > > @@ -546,6 +546,93 @@ The following commands are supported:
> > > >
> > > >    See Documentation/trace/histogram.rst for details and examples.
> > > >
> > > > +- objtrace
> > > > +
> > > > +  This command provides a way to get the value of any object, The object
> > > > +  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
> > > > +  static event (tracepoint).
> > > > +
> > > > +  Usage:
> > > > +  When using the kprobe event, by only need to set the objtrace (a new
> > > > +  trigger), we can get the value of object that is set by kprobe event.
> > > > +
> > > > +  For example, for the function bio_add_page():
> > > > +
> > > > +  .. code-block:: c
> > > > +
> > > > +     int bio_add_page(struct bio *bio, struct page *page,
> > > > +                   unsigned int len, unsigned int offset)
> > > > +
> > > > +  Firstly, we can set the base of the object as first parameter (arg1) to
> > > > +  to the function:
> > > > +
> > > > +  .. code-block::
> > > > +
> > > > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > > +
> > > > +  Secondly, we can get the value dynamically based on the object:
> > > > +
> > > > +  .. code-block::
> > > > +
> > > > +     find the offset of the bi_size in struct bio:
> > > > +     $ gdb vmlinux
> > > > +     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > > > +     $1 = (unsigned int *) 0x28
> > > > +
> > > > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > > > +       p_bio_add_page_0/trigger
> > > > +
> > > > +     # cd /sys/kernel/debug/tracing/
> > > > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > >
> > > No offense but this documentation is not well written and hard to read.
> > >
> > > Admittedly though I am just casually browsing through, so apologies.
> > >
> > > So basically, 0x28 is the offset of the u32 within the bio, that you want to
> > > track down, as it passes through functions?
> >
> > Yes, Not only track the bio, but also get a value with an offset of
> > 0x28 relative to the bio.
>
> Right.
>
> > >
> > > The example is good, but I suggest breakdown each of the commands separated
> > > by ':' and document those as well.
> >
> > I don't know how to explain it in more detail, maybe need to be
> > familiar with kprobe event and trigger in advance ;-)
>
> That's not a strong argument IMO.
>
> Shouldn't it be super easy to add the following to the documentation
> since you already mentioned it in the commit log? Or am I missing
> something?
>
> Syntax:
>         objtrace:add:obj[,offset][:type][:count][if <filter>]

I'am so sorry, I misunderstood you, I thought it needed to be
explained every word like this, e.g.
objtrace:
    ...
add:
    ...
...

Thanks,  I will add the above syntax in the next version.

> Thanks,
>
> - Joel

-- 
Thanks,
JeffXie
