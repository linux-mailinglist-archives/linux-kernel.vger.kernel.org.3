Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0769B47823F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhLQBqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhLQBqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:46:05 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:46:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so666916wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 17:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7D5/6hum6wbfHPPlj6QmqZYuj6zMxUPWrnG1cT+8qQ=;
        b=KJXiqvDCjeNfJSlyK1D0hYlhANaw5fxTgptxBfLj3/9EH0Z8CNBu8EMqUUXl8ShjGx
         X6pDrDyFAIwdWy9RbfYLFV4xzEvrna2uN24nFkbUtU1w3avpRw9QUphbTliq/AXuMZAV
         tPvcRxyPi0gDRXWSeojhkyj0daeZeT8X0Pbnp4fRu40gwkuLisjfhDJZ/3Zw/ijSLrKS
         MQSeqzZOSOQFRzDUGAm7bL6kRhFDFcBfYO4mA95bOevffTRokK+PkEHJpsud2rOB/P/S
         BdzVfsSbogF2pNkL2IVi3K9C7WLVWJ4CxeddjBQvXXfvo/l3jjpZ6RkwoDc9zrXPy17I
         C2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7D5/6hum6wbfHPPlj6QmqZYuj6zMxUPWrnG1cT+8qQ=;
        b=sG1PVoeNK9223Cxqp7xMBV/NuqXlZHjoqjwo/nEaW1k5u2djPOTMNpRistKQRAl5bq
         uC1OEa37tLWs4UnplR58C+5Nin0qNPsCxu0GVbojkcZZDrzyADkcySBjsxKLcqrauQhg
         O+I9Su+RUqEjIwKmgegy7OwPAKpcKdSECf4gB+36KfPcS5rj4Cwc5Pt+uu7hSSbT0mUc
         UqtrUP2M3KV/ZEkU2dEABePxtXWbLV9FKQ3EEq4hzMbE0Oz9wFXatpMZnuQcmFRNdwC9
         Uz8oJtwDjoZMHzRQGgwI0WzJbcTDlvhywxv8Ox0msE4ZsYY2AskZiaWt/oXFqVhuuEwh
         er0w==
X-Gm-Message-State: AOAM530SdInh55CK6DpwgXFHwRqCFFiaWjoV/QHY4Wxiknm7mnupaCrt
        j+LW9Fg3ttykCaETkSOhcwOCfIdoZ9CJ3kJZx2Y=
X-Google-Smtp-Source: ABdhPJxzFyRwzWfhEwaU/oQ5y3t5QIEaNBHQrT0naiCgET7EPlOC1oLOewX3Kt6IcFBQtrKGPqz2S9i2B2NvbNJpQhg=
X-Received: by 2002:a1c:f602:: with SMTP id w2mr7701825wmc.54.1639705563484;
 Thu, 16 Dec 2021 17:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20211129164951.220511-1-xiehuan09@gmail.com> <20211129164951.220511-4-xiehuan09@gmail.com>
 <20211217000234.46a613cf12d8402176c49322@kernel.org>
In-Reply-To: <20211217000234.46a613cf12d8402176c49322@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 17 Dec 2021 09:45:51 +0800
Message-ID: <CAEr6+EBsTdWdmrWA-vpGA7qNtS2umdk2kt3MJfscxLGwNhE+uw@mail.gmail.com>
Subject: Re: [RFC][PATCH v6 3/5] trace/README: Document objtrace trigger syntax
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, Dec 16, 2021 at 11:02 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> On Tue, 30 Nov 2021 00:49:49 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Add a short description of the use of objtrace trigger.
>
> Please merge this into the [1/5] and [2/5], because the changes of
> "a new feature" and "the existance of the feature which
> kernel indicates" must be atomic.
>
> My recommendation is
>
> - add following line in the first patch
>
>         "\t            objtrace:add:obj[:count][if <filter>]\n"
>
> - and update it as following in the next patch according to the changes
>
>         "\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"

I will merge them, Thanks.

>
> Thank you!
>
>
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  kernel/trace/trace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 88de94da596b..a84b6813769e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5590,6 +5590,9 @@ static const char readme_msg[] =
> >       "\t            enable_hist:<system>:<event>\n"
> >       "\t            disable_hist:<system>:<event>\n"
> >  #endif
> > +#ifdef CONFIG_TRACE_OBJECT
> > +     "\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
> > +#endif
> >  #ifdef CONFIG_STACKTRACE
> >       "\t\t    stacktrace\n"
> >  #endif
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
---
JeffXie
