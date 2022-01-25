Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACC49BE25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiAYWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiAYWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:01:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9342C06173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:01:58 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 128so20997635pfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f+Aaba2ErpXUq7vBNLVHguof037975X+yPrv7J77Tcg=;
        b=cNdZeLox84me8aWclC47yRmEs5qsap7dCX3N0KCyd4z/FIo4JTaRHfDIrU0SByXMgN
         GiVU+Uc+d6ujjYCV2BAW3Rogu9HDub5t+pLGzWlh7fU/bfr1SpgK/bm7JpULBK5dkl43
         7ZrEc1fzjCZNfiVwvbBTCpct/QcNMnvefpb2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f+Aaba2ErpXUq7vBNLVHguof037975X+yPrv7J77Tcg=;
        b=TS16e+Ol0+EYjAOLuivrk1+96OXwq9hglLnnpHCnXCXYkzh3BSoLdcf9SyqvLzmJNu
         FaN6ljxR6NuhigeWZf8uCnzFL3i4APtFQfVwO1lyb9iXqgEXolVaSOzh6vDagOPXOvkt
         ev4qsZIcwLsLFc8b4K0kp6GylUVe692oECPd93FnSjw9DFL7Xt4zAusv+L7JxMcw9Vsh
         Rx7wqLAXOOQZ6ZLQ3C4lZm6LWsqHzJq614IAO4Cwhglb6RgOr6Xaw7WX6MbCh4WAaaz0
         oe4+/WCmpS1ZD/ICYm1BK3uYcHxdbAry3ZIb1rgyTFCO1mg4Y5RUV0ufL08tVCFZjbeQ
         ydIA==
X-Gm-Message-State: AOAM533pMweoIZ+t4sWdXaEoJE1rYw5Ud7hlIA5XuHzgkjZHErcHVWOt
        ZHJcqBHadxOs8Thc30vB6ApW1Q==
X-Google-Smtp-Source: ABdhPJzyQCqsG6NPvpV8s4zrvXKBmCTM4IytclQGXToHeWxUa2RmazvbA1BQ6fvga96SoUSlolRY2A==
X-Received: by 2002:a05:6a00:23c3:b0:4ca:f0d2:aad9 with SMTP id g3-20020a056a0023c300b004caf0d2aad9mr3384176pfc.51.1643148118205;
        Tue, 25 Jan 2022 14:01:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g20sm17818pfv.4.2022.01.25.14.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:01:57 -0800 (PST)
Date:   Tue, 25 Jan 2022 14:01:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201251400.9F091FC@keescook>
References: <20220125145006.677e3709@canb.auug.org.au>
 <202201242230.C54A6BCDFE@keescook>
 <20220125222732.98ce2e445726e773f40e122e@kernel.org>
 <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
 <202201251256.CCCBE9851E@keescook>
 <20220125162326.3d1ca960@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125162326.3d1ca960@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:23:26PM -0500, Steven Rostedt wrote:
> On Tue, 25 Jan 2022 12:57:24 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Tue, Jan 25, 2022 at 11:31:54PM +0900, Masami Hiramatsu wrote:
> > > On Tue, 25 Jan 2022 22:27:32 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > > /*
> > > > >  * struct trace_event_data_offsets_<call> {
> > > > >  *      u32                             <item1>;
> > > > >  *      u32                             <item2>;
> > > > >  *      [...]
> > > > >  * };
> > > > >  *
> > > > >  * The __dynamic_array() macro will create each u32 <item>, this is
> > > > >  * to keep the offset of each array from the beginning of the event.
> > > > >  * The size of an array is also encoded, in the higher 16 bits of
> > > > >  * <item>.
> > > > >  */
> > > > > 
> > > > > So, I think -Warray-bounds is refusing to see the destination as
> > > > > anything except a u32, but being accessed at 4 (sizeof(u32)) + 8
> > > > > (address && 0xffff) (?)  
> > > > 
> > > > Ah, I got it. Yes, that's right. __data_loc() will access the data
> > > > from the __entry, but the __rel_loc() points the same address from
> > > > the encoded field ("__rel_loc_foo" in this case) itself.
> > > > This is introduced for the user application event, which doesn't
> > > > know the actual __entry size because the __entry includes some
> > > > kernel internal defined fields.
> > > >   
> > > > > But if this is true, I would imagine there would be plenty of other
> > > > > warnings? I'm currently stumped.  
> > > > 
> > > > That is because __rel_loc is used only in the sample code in the kernel
> > > > for testing. Other use-cases comes from user-space.
> > > > Hmm, can we skip this boundary check for this example?  
> > > 
> > > If the -Warray-bounds determines the destination array size from
> > > the type of given pointer, we can just change the macro as below;
> > > 
> > > #define __get_rel_dynamic_array(field) 
> > > 			((void *)__entry +                                 \
> > > 			 offsetof(typeof(*__entry), __rel_loc_##field) +   \
> > > 			 sizeof(__entry->__rel_loc_##field) +              \
> > > 			 (__entry->__rel_loc_##field & 0xffff))
> > > 
> > > This must works same as __get_dynamic_array() macro.
> > > 
> > > Could you try this patch?
> > > 
> > > From 2982ba01367ec1f746a4f128512436e5325a7f9d Mon Sep 17 00:00:00 2001
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > Date: Tue, 25 Jan 2022 23:19:30 +0900
> > > Subject: [PATCH] tracing: Avoid -Warray-bounds warning for __rel_loc macro
> > > 
> > > Since -Warray-bounds checks the destination size from the
> > > type of given pointer, __assign_rel_str() macro gets warned
> > > because it passes the pointer to the 'u32' field instead of
> > > 'trace_event_raw_*' data structure.
> > > Pass the data address calculated from the 'trace_event_raw_*'
> > > instead of 'u32' __rel_loc field.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > ---
> > >  include/trace/trace_events.h | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > > index 8c6f7c433518..65d927e059d3 100644
> > > --- a/include/trace/trace_events.h
> > > +++ b/include/trace/trace_events.h
> > > @@ -318,9 +318,10 @@ TRACE_MAKE_SYSTEM_STR();
> > >  #define __get_str(field) ((char *)__get_dynamic_array(field))
> > >  
> > >  #undef __get_rel_dynamic_array
> > > -#define __get_rel_dynamic_array(field)	\
> > > -		((void *)(&__entry->__rel_loc_##field) +	\
> > > -		 sizeof(__entry->__rel_loc_##field) +		\
> > > +#define __get_rel_dynamic_array(field)					\
> > > +		((void *)__entry + 					\
> > > +		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> > > +		 sizeof(__entry->__rel_loc_##field) +			\
> > >  		 (__entry->__rel_loc_##field & 0xffff))
> > >  
> > >  #undef __get_rel_dynamic_array_len  
> > 
> > This patch doesn't silence the warning, but now that I see the shape of
> > things more clearly, let me see if I can find the right combo.
> 
> Hmm, could the zero size array cause an issues here. That is, does this
> help?
> 
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 65d927e059d3..3d29919045af 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -128,7 +128,7 @@ TRACE_MAKE_SYSTEM_STR();
>  	struct trace_event_raw_##name {					\
>  		struct trace_entry	ent;				\
>  		tstruct							\
> -		char			__data[0];			\
> +		char			__data[];			\
>  	};								\
>  									\
>  	static struct trace_event_class event_class_##name;

I changed this too, just to future-proof it, and in an attempt to base
the address off of __data[] (which turned out not to be needed).

It turns out that there was still a version of the __get_rel_dyanmic_array
in perf.h that was the actual culprit.

-- 
Kees Cook
