Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B7D53BC66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbiFBQXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiFBQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:23:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473EF186E9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:23:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e29so1359068wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eSiFQMELLSa5Z07ibxKS6Uu+L0qY0UU5WkKVpdJwBc=;
        b=axZZklCFshHH21Hz7kBAhD3S7f3uQKv52XBA5zgPzeffQgMZes9XwMCn+rvTnKTXho
         9/cQqhX9B0gDwKk9mC/Mz02eiYxe0UW5zP2L71zSGX7wTu2iEM1n2mNH/2HfuRDrAWIA
         A2xjkSNHDeLtb0uUrBO5uxFTP7SdbS7sIQAfkGVj+92rNXgw1UCkKynadXFVvtcuRVRn
         V5uvNV/u+Xi/JWFG81DewXO2pFCNeAbRf18DY3A530j8rTKhhKwpWomUwR/4vzILyU7R
         R9mGAKFMo2WA5ZKXLXCDhDwJLth00JhPI4k/lyxLITQfe6hAR+OUHdxwjECnRKDVVenE
         v3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eSiFQMELLSa5Z07ibxKS6Uu+L0qY0UU5WkKVpdJwBc=;
        b=EJZ43E4CLGy9gboqWGR77FldoyAWB/1n2yn3dzff22UNJdjFbILunk+NCjr06xFog5
         Qp3sNq2V7EqMVOun2p0cQubfz8c938RS7ZX5PyUVkg98PfQxF6eQUoriOQuYwXEUSlqx
         1XDuBo4WTtNUxpcZLemqoVQBAz5vT9/IxUkdyI6U4CBbQz+B33MCLF5qK6Ezcj3WdPl4
         mew5oQz+Dx7vPHh2VQtcr2ITL5MRuCxMaSs70r3I0yt1G0BCZyhuYn97IkJFeYTB9FG8
         JnAR+PXEJbpi5RyjWF+igiX9CGMC90XqLflRiB8ZGoxaZ3QYKN/7i8zWPSvyGZaevDcV
         6HOA==
X-Gm-Message-State: AOAM5310y8QweKUnu9Lwg9BqfRJ926Wp0JKHdFJbF47iFw6kUnsRWvoH
        I5a9CyWqn7E21ezz2erfa6TT9TEFbg+ZlNgcL1WAW4KnKjWzwQ==
X-Google-Smtp-Source: ABdhPJx7w0ofG0uYpNp5prqJ7kxI/eW6Ek99DP4FCc7qo+h0d0d2do8KQh3Ydsml0uzTfER8iXx2h4pqtIyfa14z+K8=
X-Received: by 2002:a5d:5343:0:b0:210:2f76:649f with SMTP id
 t3-20020a5d5343000000b002102f76649fmr4361260wrv.554.1654187006673; Thu, 02
 Jun 2022 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220512170008.1301613-1-xiehuan09@gmail.com> <20220512170008.1301613-3-xiehuan09@gmail.com>
 <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org> <CAEr6+EAU_FUvCqZqqpp_hC5ichV9WJ+Up+N6ya5KW_CbqbRGFA@mail.gmail.com>
 <20220602001331.fab92b2dcd2c9aaad800ddae@kernel.org>
In-Reply-To: <20220602001331.fab92b2dcd2c9aaad800ddae@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 3 Jun 2022 00:23:14 +0800
Message-ID: <CAEr6+EDGrBzuTMGnDp=AB6tiZLUn7s=nCNE2XZi6vhXynTgZ6w@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] trace/objtrace: Get the value of the object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
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

On Wed, Jun 1, 2022 at 11:13 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Tue, 31 May 2022 15:13:24 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Hi Masami and steve,
> >
> > On Sun, May 22, 2022 at 10:22 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Hi Jeff,
> > >
> > > On Fri, 13 May 2022 01:00:06 +0800
> > > Jeff Xie <xiehuan09@gmail.com> wrote:
> > >
> > > [...]
> > > > @@ -175,9 +271,27 @@ trace_object_trigger(struct event_trigger_data *data,
> > > >
> > > >       field = obj_data->field;
> > > >       memcpy(&obj, rec + field->offset, sizeof(obj));
> > > > -     set_trace_object(obj, tr);
> > > > +     /* set the offset from the special object and the type size of the value*/
> > > > +     set_trace_object(obj, obj_data->obj_offset,
> > > > +                     obj_data->obj_value_type_size, tr);
> > > >  }
> > > >
> > > > +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> > > > +     {"u8", 1},
> > > > +     {"s8", 1},
> > > > +     {"x8", 1},
> > > > +     {"u16", 2},
> > > > +     {"s16", 2},
> > > > +     {"x16", 2},
> > > > +     {"u32", 4},
> > > > +     {"s32", 4},
> > > > +     {"x32", 4},
> > > > +     {"u64", 8},
> > > > +     {"s64", 8},
> > > > +     {"x64", 8},
> > >
> > > Hmm, as far as I can see, you don't distinguish the prefix 'u','s','x'.
> > > If so, please support only 'x' at this moment. kprobe events supports
> > > those types, and it distinguishes the types when printing the logged
> > > data. E.g. 's16' shows '-1' for 0xffff, but 'x16' shows '0xffff'.
> > > You can add another patch to support such different types afterwards.
> >
> > I feel to let the objtrace trigger to distinguish the prefix 'u', 's',
> > 'x', It seems a very challenging work ;-)
> > I spent a lot of time thinking, I would like to add a callback
> > function(print function) in the struct trace_object_entry  for each
> > data type.
> > Not sure if this is possible or allowed, as I haven't seen any example
> > like this to add function in the  struct *_entry  ;-)
>
> Hmm, I don't recommend this, becuase this event record can be exposed
> to user space as binary data. So please do not put such a function
> pointer which will be used in the ftrace directly.
> Instead, add a new event type of the object-trace for each type-prefix,
> since each of them has different print-fmt.

This place is still a difficult point for me ;-)

> Anyway I would like to ask you is to share the next version of the
> series without that improvement. You can improve it after merging the
> basic feature. No need to stop the series until all possible feature
> set are implemented (unless it will change the user-exposed interface
> much.)

Thanks for your suggestion, I will submit the next version.

>
> >
> > The following is part of the code I have prepared. I don't know if you
> > can give any suggestions or wait until I submit the next version to
> > discuss.
>
> But thanks for sharing the code. This helps me to understand what you
> are trying :)
>
> Thank you,
>
>
>
> >
> > <snip>
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > index 2407c45a568c..5f8289e26f91 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -414,6 +414,7 @@ FTRACE_ENTRY(object, trace_object_entry,
> >                 __field(        unsigned long,          parent_ip       )
> >                 __field(        unsigned long,          object          )
> >                 __field(        unsigned long,          value           )
> > +               __field(        unsigned long,          print           )
> >         ),
> >
> > +/* get the type size for the special object */
> > +struct objtrace_fetch_type {
> > +       char *name;
> > +       int type_size;
> > +       int is_signed;
> > +       print_type_func_t       print;
> > +};
> > +
> >
> >  static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> > -       {"x8", 1},
> > -       {"x16", 2},
> > -       {"x32", 4},
> > -       {"x64", 8},
> > -       {NULL, 0}
> > +       {"u8", 1, 0, PRINT_TYPE_FUNC_NAME(u8)},
> > +       {"s8", 1, 1, PRINT_TYPE_FUNC_NAME(s8)},
> > +       {"x8", 1, 0, PRINT_TYPE_FUNC_NAME(x8)},
> > +       {"u16", 2, 0, PRINT_TYPE_FUNC_NAME(u16)},
> > +       {"s16", 2, 1, PRINT_TYPE_FUNC_NAME(s16)},
> > +       {"x16", 2, 0, PRINT_TYPE_FUNC_NAME(x16)},
> > +       {"u32", 4, 0, PRINT_TYPE_FUNC_NAME(u32)},
> > +       {"s32", 4, 1, PRINT_TYPE_FUNC_NAME(s32)},
> > +       {"x32", 4, 0, PRINT_TYPE_FUNC_NAME(x32)},
> > +       {"u64", 8, 0, PRINT_TYPE_FUNC_NAME(u64)},
> > +       {"s64", 8, 1, PRINT_TYPE_FUNC_NAME(s64)},
> > +       {"x64", 8, 1, PRINT_TYPE_FUNC_NAME(x64)},
> > +       {NULL, 0, 0, NULL}
> >  };
> > </snip>
> >
> > > > +     {}
> > >
> > > If this array is null terminated, please explictly do that, like
> > >
> > >         {NULL, 0},
> > >
> > > for readability.
> > >
> > > Thank you,
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Thanks,
> > JeffXie
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,
JeffXie
