Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E8598C26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244648AbiHRS4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbiHRS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 14:56:00 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E19DBBA7E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:55:59 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o3so1266167ilf.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o9IqWqTExqfvAFZ3y/aPtmNVxALGEdclMGoLQukyCMs=;
        b=UpgEzYK8fvk/arvCh/WKzNm+H/ueOgS7/lFGRNPT7ffAwaZk7iLif5Ej4qyizteQM/
         jGOyzZ/shwlzi+uBcSvJjlcO6hxfCTDOZwa7TGYutJ3eXUqzHkzBUQbVEwynj1fnXhmQ
         v9haHLPPuushmrmvU2QJ2eIFgPDdb6R30w4K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o9IqWqTExqfvAFZ3y/aPtmNVxALGEdclMGoLQukyCMs=;
        b=joUHkBa5wiTdyOb77WIh0jN+WNE6OFhUHyA2x5P7g/UDmAPli2SIE5K5K+OhtaHc6v
         /we3dP7QtFJgH9mIFG4+a7/EZuHpXWayH/fsHDLat4vfyDffNljFMpOdNCMXG5sCQ2vb
         9CWa8YNtBsqwLrS+HwzRVOSCA8+wumlz9aVw9YR2uoOTCBrcVCjijPjWyy7by112uFw+
         DQ7nLkla7Zbh5yrx0e6GKZ1NUeypfwCw4ikYitMUJw2tHul7zLIvv4yYcFUoe3vFVvnn
         sdAlo8GB+V4/IJR9VKO22vlovUGJHd6uLKBeWikHEYVD/RLUxIAdMLaNNfdv9iTro07f
         AAfw==
X-Gm-Message-State: ACgBeo0HYPujEIeT6GjLwZyAA1GsqHWnikJjAmwUlBzs1hMAzQxDDSF+
        FJIP2C91rpm2dhtncSDjk8q2i0MGkPQIfGLQtrZQ0CZZEno=
X-Google-Smtp-Source: AA6agR4DrI/Jhj5BsFj/OILFnVRNJfDhmvWXyKUgfnFsK76LWPDPerPHF3jneiEap7xzxQhz/8yowLU6hRy0PRVt8Ks=
X-Received: by 2002:a05:6e02:1c84:b0:2e5:b635:c6bd with SMTP id
 w4-20020a056e021c8400b002e5b635c6bdmr2088909ill.190.1660848958971; Thu, 18
 Aug 2022 11:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220628145552.349839-1-xiehuan09@gmail.com> <20220628145552.349839-5-xiehuan09@gmail.com>
 <Yv5gkKnufS7CUq9A@google.com> <CAEr6+ED7UovW1BbrK4s5tCRrTrfkESpa4m3VO4a4PBAY9nK_JA@mail.gmail.com>
 <CAEXW_YQAFVJRe9mUnR1HAXvYDiQ3jCwrKhO52t8O=bxb_qSCzQ@mail.gmail.com> <CAEr6+EBC3MfqGZQ8zqLhr6P1VFkU2Hs9JsM-mqGBXWKLcAXkAA@mail.gmail.com>
In-Reply-To: <CAEr6+EBC3MfqGZQ8zqLhr6P1VFkU2Hs9JsM-mqGBXWKLcAXkAA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 14:55:47 -0400
Message-ID: <CAEXW_YTJGbGWZkmCndVqXaM=N_6ZuvmcxDrcgTaHjCEMyvXeuQ@mail.gmail.com>
Subject: Re: [PATCH v14 4/4] Documentation: trace/objtrace: Add documentation
 for objtrace
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, chensong_2000@189.cn,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 1:34 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi Joel,
>
> On Fri, Aug 19, 2022 at 1:05 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Thu, Aug 18, 2022 at 12:38 PM Jeff Xie <xiehuan09@gmail.com> wrote:
> > >
> > > Hi Joel,
> > >
> > > Thank you for your review.
> > >
> > > On Thu, Aug 18, 2022 at 11:53 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 10:55:52PM +0800, Jeff Xie wrote:
> > > > > Add documentation explaining how to use objtrace trigger to get the value
> > > > > of the object.
> > > > >
> > > > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > > > Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> > > > > Cc: linux-doc@vger.kernel.org
> > > > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > > ---
> > > > > Changelog:
> > > > > v14:
> > > > > - make documentation more readable and fix literal code block by Bagas Sanjaya
> > > > >
> > > > >  Documentation/trace/events.rst | 87 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 87 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> > > > > index c47f381d0c00..c15f1d25d4a0 100644
> > > > > --- a/Documentation/trace/events.rst
> > > > > +++ b/Documentation/trace/events.rst
> > > > > @@ -546,6 +546,93 @@ The following commands are supported:
> > > > >
> > > > >    See Documentation/trace/histogram.rst for details and examples.
> > > > >
> > > > > +- objtrace
> > > > > +
> > > > > +  This command provides a way to get the value of any object, The object
> > > > > +  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
> > > > > +  static event (tracepoint).
> > > > > +
> > > > > +  Usage:
> > > > > +  When using the kprobe event, by only need to set the objtrace (a new
> > > > > +  trigger), we can get the value of object that is set by kprobe event.
> > > > > +
> > > > > +  For example, for the function bio_add_page():
> > > > > +
> > > > > +  .. code-block:: c
> > > > > +
> > > > > +     int bio_add_page(struct bio *bio, struct page *page,
> > > > > +                   unsigned int len, unsigned int offset)
> > > > > +
> > > > > +  Firstly, we can set the base of the object as first parameter (arg1) to
> > > > > +  to the function:
> > > > > +
> > > > > +  .. code-block::
> > > > > +
> > > > > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > > > +
> > > > > +  Secondly, we can get the value dynamically based on the object:
> > > > > +
> > > > > +  .. code-block::
> > > > > +
> > > > > +     find the offset of the bi_size in struct bio:
> > > > > +     $ gdb vmlinux
> > > > > +     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > > > > +     $1 = (unsigned int *) 0x28
> > > > > +
> > > > > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > > > > +       p_bio_add_page_0/trigger
> > > > > +
> > > > > +     # cd /sys/kernel/debug/tracing/
> > > > > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > > > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> > > >
> > > > No offense but this documentation is not well written and hard to read.
> > > >
> > > > Admittedly though I am just casually browsing through, so apologies.
> > > >
> > > > So basically, 0x28 is the offset of the u32 within the bio, that you want to
> > > > track down, as it passes through functions?
> > >
> > > Yes, Not only track the bio, but also get a value with an offset of
> > > 0x28 relative to the bio.
> >
> > Right.
> >
> > > >
> > > > The example is good, but I suggest breakdown each of the commands separated
> > > > by ':' and document those as well.
> > >
> > > I don't know how to explain it in more detail, maybe need to be
> > > familiar with kprobe event and trigger in advance ;-)
> >
> > That's not a strong argument IMO.
> >
> > Shouldn't it be super easy to add the following to the documentation
> > since you already mentioned it in the commit log? Or am I missing
> > something?
> >
> > Syntax:
> >         objtrace:add:obj[,offset][:type][:count][if <filter>]
>
> I'am so sorry, I misunderstood you, I thought it needed to be
> explained every word like this, e.g.
> objtrace:
>     ...
> add:
>     ...
> ...
>
> Thanks,  I will add the above syntax in the next version.
>

Yeah no problem, I am also OK with that being a follow-up patch
instead of the series if it matches with Steven's review timing
better.

Thanks,

 - Joel
