Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84849BD88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiAYU51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiAYU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:57:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC6DC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:57:25 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a8so15531849pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zNnJZ8cULoAFIJoo6anuEJ9z/gTYkfvN9kje7W7RV4o=;
        b=nz81gq6QaZlSyl/2nVpfQTbtLIFlSJX0bcTS30c3i7dQ9JkjfUYWX+EyAC2dppdYLj
         jYubDxKLkO/SvkRwVlxV4OwhWKn38NPbrcu9pedSYv0zJEg3D/sI2C5YEbaQ88a8HWDf
         4IB96WsmKBm7jpWHs3pqpa+A/3bFXOAELKf0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zNnJZ8cULoAFIJoo6anuEJ9z/gTYkfvN9kje7W7RV4o=;
        b=AXvdvO7XJUoQ1Uy5JUoQyeUz9vJamYiZtpShvPW26XSHWGOxV4tlk5O8EGjzWkM2lE
         Qr9sXEBn/iU4/9afFQ8GCGJD2j2nflYzlIf9+yOztP7+Gl4blU0Vpoz8iq1ohd1frLa4
         KktSMvR9iOONxAVQLE7k1YS+0YGCeuT3uGKhCLHbz1KZe/nPC9QR4CHWQz0H4uVYNjZx
         an9CXoot48sdJ/W8aERF6/nPVbQSFtnb9rhkWLrcJW8Di1zYsz/eWDqhd5/O7zwj5608
         CAB2pJaHW3nw4rzrs8+h/REIzaqT5xCzrlc0AJFSsrGK2QxsM2epvQymgB14ujuHrU+u
         HqTw==
X-Gm-Message-State: AOAM531B281DS5nafisWJ1z4nYmmsEQmu8455yv/5aUrAmXMkDrsShJh
        Z23NMH+kTmolsbrt3nFu8b0HIw==
X-Google-Smtp-Source: ABdhPJzgvACB2egAfulYVCRGcnQXy//k48Ir8AaaGOefnXMaodm6XT6dVXWkZ6OQVqUnDywk2vV0Ig==
X-Received: by 2002:a05:6a00:1589:b0:4c3:cc45:58e2 with SMTP id u9-20020a056a00158900b004c3cc4558e2mr20129245pfk.86.1643144245304;
        Tue, 25 Jan 2022 12:57:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 198sm11472118pgg.4.2022.01.25.12.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:57:25 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:57:24 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201251256.CCCBE9851E@keescook>
References: <20220125145006.677e3709@canb.auug.org.au>
 <202201242230.C54A6BCDFE@keescook>
 <20220125222732.98ce2e445726e773f40e122e@kernel.org>
 <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 11:31:54PM +0900, Masami Hiramatsu wrote:
> On Tue, 25 Jan 2022 22:27:32 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > /*
> > >  * struct trace_event_data_offsets_<call> {
> > >  *      u32                             <item1>;
> > >  *      u32                             <item2>;
> > >  *      [...]
> > >  * };
> > >  *
> > >  * The __dynamic_array() macro will create each u32 <item>, this is
> > >  * to keep the offset of each array from the beginning of the event.
> > >  * The size of an array is also encoded, in the higher 16 bits of
> > >  * <item>.
> > >  */
> > > 
> > > So, I think -Warray-bounds is refusing to see the destination as
> > > anything except a u32, but being accessed at 4 (sizeof(u32)) + 8
> > > (address && 0xffff) (?)
> > 
> > Ah, I got it. Yes, that's right. __data_loc() will access the data
> > from the __entry, but the __rel_loc() points the same address from
> > the encoded field ("__rel_loc_foo" in this case) itself.
> > This is introduced for the user application event, which doesn't
> > know the actual __entry size because the __entry includes some
> > kernel internal defined fields.
> > 
> > > But if this is true, I would imagine there would be plenty of other
> > > warnings? I'm currently stumped.
> > 
> > That is because __rel_loc is used only in the sample code in the kernel
> > for testing. Other use-cases comes from user-space.
> > Hmm, can we skip this boundary check for this example?
> 
> If the -Warray-bounds determines the destination array size from
> the type of given pointer, we can just change the macro as below;
> 
> #define __get_rel_dynamic_array(field) 
> 			((void *)__entry +                                 \
> 			 offsetof(typeof(*__entry), __rel_loc_##field) +   \
> 			 sizeof(__entry->__rel_loc_##field) +              \
> 			 (__entry->__rel_loc_##field & 0xffff))
> 
> This must works same as __get_dynamic_array() macro.
> 
> Could you try this patch?
> 
> From 2982ba01367ec1f746a4f128512436e5325a7f9d Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Tue, 25 Jan 2022 23:19:30 +0900
> Subject: [PATCH] tracing: Avoid -Warray-bounds warning for __rel_loc macro
> 
> Since -Warray-bounds checks the destination size from the
> type of given pointer, __assign_rel_str() macro gets warned
> because it passes the pointer to the 'u32' field instead of
> 'trace_event_raw_*' data structure.
> Pass the data address calculated from the 'trace_event_raw_*'
> instead of 'u32' __rel_loc field.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  include/trace/trace_events.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 8c6f7c433518..65d927e059d3 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -318,9 +318,10 @@ TRACE_MAKE_SYSTEM_STR();
>  #define __get_str(field) ((char *)__get_dynamic_array(field))
>  
>  #undef __get_rel_dynamic_array
> -#define __get_rel_dynamic_array(field)	\
> -		((void *)(&__entry->__rel_loc_##field) +	\
> -		 sizeof(__entry->__rel_loc_##field) +		\
> +#define __get_rel_dynamic_array(field)					\
> +		((void *)__entry + 					\
> +		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> +		 sizeof(__entry->__rel_loc_##field) +			\
>  		 (__entry->__rel_loc_##field & 0xffff))
>  
>  #undef __get_rel_dynamic_array_len

This patch doesn't silence the warning, but now that I see the shape of
things more clearly, let me see if I can find the right combo.

Thanks!

-Kees

-- 
Kees Cook
