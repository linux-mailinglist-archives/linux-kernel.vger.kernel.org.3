Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F56598A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbiHRROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbiHRROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:14:25 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D231D4749
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:07:08 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r141so1555325iod.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i2O12e3ukuPPlXBoE2i6x5fq7Ep5bqezMI8f2hjJfTc=;
        b=uXj9CMHeDj0QQgzDApRFDggcYWjs4EE5n80ii5zq3RlyXDhOcOvIYmu3zBOAI3PI+S
         mkDKct/g8rBaQhLJhUmznPamP/ONt+uGPeGt9JsaUicm3UhsNWx7MPlI8NEPnY+Kd2Rn
         5EBdEAISDH9SwlKiR0GFxMa+yi4OKZTJwuH10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i2O12e3ukuPPlXBoE2i6x5fq7Ep5bqezMI8f2hjJfTc=;
        b=sURfoQxK9nzh7KpJUU7KETXP0IsG5FfwOIMDk5GfdGCa7t8DsOKIXon9xSM1TbU6+X
         y3534vAcFD3hRxp9iSRjA8rhXpPvR2bvXWzTHIu+R5bUJd5PEgAkYq3VgPDtljRTW3j+
         5bbxkOuGq+Xe1jPo57hKp4A5LQ1MuPM3zmVTGNEe1pIgkG5JwGjlzWKrXjJH0jIQmDET
         RxdSJBUG9zfyplzE8HfLBImfr+NmK2Nmh4mPbuvT5AJrQ5tsG6alQ9W+uuJ/ePCoPfMj
         TwhY9056H3r7Jcwt5c5OHGKagg1kM77fqpqpl+1zJuK88hA2xRGGX9HzFR+scb1D93D0
         XMxQ==
X-Gm-Message-State: ACgBeo17Lv1ty8OH9uGCI5P/Ig+unqT/GsGOhlwQphQcLJMOzC7GHoyS
        O+jXSrY/EzJb8DMBzDPTZ7VfXRUPj/ULuIGIFnWiqQ==
X-Google-Smtp-Source: AA6agR5cYUVejIUFxvGmZbZsJy8h1HMfvH/hHbxB5c3MdOFzIJ+WrWUgQ0/7LkwWtFV+90NZ7dIegoQVb5eAfhCatto=
X-Received: by 2002:a05:6638:40a8:b0:346:8e3c:8141 with SMTP id
 m40-20020a05663840a800b003468e3c8141mr1776957jam.107.1660842355639; Thu, 18
 Aug 2022 10:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220628145552.349839-1-xiehuan09@gmail.com> <20220628145552.349839-5-xiehuan09@gmail.com>
 <Yv5gkKnufS7CUq9A@google.com> <CAEr6+ED7UovW1BbrK4s5tCRrTrfkESpa4m3VO4a4PBAY9nK_JA@mail.gmail.com>
In-Reply-To: <CAEr6+ED7UovW1BbrK4s5tCRrTrfkESpa4m3VO4a4PBAY9nK_JA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Aug 2022 13:05:44 -0400
Message-ID: <CAEXW_YQAFVJRe9mUnR1HAXvYDiQ3jCwrKhO52t8O=bxb_qSCzQ@mail.gmail.com>
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

On Thu, Aug 18, 2022 at 12:38 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>
> Hi Joel,
>
> Thank you for your review.
>
> On Thu, Aug 18, 2022 at 11:53 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Jun 28, 2022 at 10:55:52PM +0800, Jeff Xie wrote:
> > > Add documentation explaining how to use objtrace trigger to get the value
> > > of the object.
> > >
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> > > Cc: linux-doc@vger.kernel.org
> > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > > Changelog:
> > > v14:
> > > - make documentation more readable and fix literal code block by Bagas Sanjaya
> > >
> > >  Documentation/trace/events.rst | 87 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 87 insertions(+)
> > >
> > > diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> > > index c47f381d0c00..c15f1d25d4a0 100644
> > > --- a/Documentation/trace/events.rst
> > > +++ b/Documentation/trace/events.rst
> > > @@ -546,6 +546,93 @@ The following commands are supported:
> > >
> > >    See Documentation/trace/histogram.rst for details and examples.
> > >
> > > +- objtrace
> > > +
> > > +  This command provides a way to get the value of any object, The object
> > > +  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
> > > +  static event (tracepoint).
> > > +
> > > +  Usage:
> > > +  When using the kprobe event, by only need to set the objtrace (a new
> > > +  trigger), we can get the value of object that is set by kprobe event.
> > > +
> > > +  For example, for the function bio_add_page():
> > > +
> > > +  .. code-block:: c
> > > +
> > > +     int bio_add_page(struct bio *bio, struct page *page,
> > > +                   unsigned int len, unsigned int offset)
> > > +
> > > +  Firstly, we can set the base of the object as first parameter (arg1) to
> > > +  to the function:
> > > +
> > > +  .. code-block::
> > > +
> > > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > +
> > > +  Secondly, we can get the value dynamically based on the object:
> > > +
> > > +  .. code-block::
> > > +
> > > +     find the offset of the bi_size in struct bio:
> > > +     $ gdb vmlinux
> > > +     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> > > +     $1 = (unsigned int *) 0x28
> > > +
> > > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> > > +       p_bio_add_page_0/trigger
> > > +
> > > +     # cd /sys/kernel/debug/tracing/
> > > +     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> > > +     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> >
> > No offense but this documentation is not well written and hard to read.
> >
> > Admittedly though I am just casually browsing through, so apologies.
> >
> > So basically, 0x28 is the offset of the u32 within the bio, that you want to
> > track down, as it passes through functions?
>
> Yes, Not only track the bio, but also get a value with an offset of
> 0x28 relative to the bio.

Right.

> >
> > The example is good, but I suggest breakdown each of the commands separated
> > by ':' and document those as well.
>
> I don't know how to explain it in more detail, maybe need to be
> familiar with kprobe event and trigger in advance ;-)

That's not a strong argument IMO.

Shouldn't it be super easy to add the following to the documentation
since you already mentioned it in the commit log? Or am I missing
something?

Syntax:
        objtrace:add:obj[,offset][:type][:count][if <filter>]

Thanks,

- Joel
