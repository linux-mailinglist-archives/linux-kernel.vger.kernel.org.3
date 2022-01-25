Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F6749BE34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiAYWHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiAYWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:07:16 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D8C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:07:16 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e16so10122311pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JEF4zKgPP5NwFQij2garUdemoLu5qnPKXjSaY5UzW1E=;
        b=GRiOUztm2xR9USR3s3T4JI1JgtmWtSNFAhEtMxDQ56W7VQWjzI9HEc05Xsc4cHXq53
         P1i6H90+j3r4fr1Ao3/l19B1U0wV9gfryrYKB6cKipw7uQxUpbdtRGSbolcpbgz3zBAJ
         03AVGzxDBI97/FBXWaQpBVBanBmRaWmuQ+Hlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JEF4zKgPP5NwFQij2garUdemoLu5qnPKXjSaY5UzW1E=;
        b=fILEeIb7zHvdmOfUr8M7N14Qv+r5pMlLHIf0LqbtFBFj3IzKUFqZOJ4qMnEv+oQ9MV
         9r3Nj0+S4eisWfv2t2OR9vaPwLf3wodTjDxevZ0GfGrg1MZTGAsrl4wxR228z6SvuXWk
         HttrMBQtDi/lKOByCt04y+P4tg7vicR6D/6AAe5etsa73knL2o25jh8XpKdTVoyQ0a+w
         q1gjIC96fVEHGdQBjp7XoCG1k6wt8e541bTdr7VNuBD5bQZ+T4jz5alAKIbLBQyetZqp
         VjxpoR/USdaEd3aa8ZBEKNOsqgnCSsDo3e3nMhAUL9uyE3RGwdtYBxo7hFJcJFL5r6bi
         C8Wg==
X-Gm-Message-State: AOAM531Wguw/K86173bKa/GAao4uObEQ70sKizzqRNVyXz28vaRGb5kT
        gRh7BQm2ETn3w9bleH8IN9XmRD8VEiAOyg==
X-Google-Smtp-Source: ABdhPJwAMaF19PxTaafBwuZzPWOXEe7mBo2vCPx6Is1UC15RdVgBDIqqr9w510IcG2VTUP9szTXgFg==
X-Received: by 2002:a63:8048:: with SMTP id j69mr13923611pgd.485.1643148435658;
        Tue, 25 Jan 2022 14:07:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a4sm1263614pjs.24.2022.01.25.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 14:07:15 -0800 (PST)
Date:   Tue, 25 Jan 2022 14:07:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201251402.0FB08DB@keescook>
References: <20220125145006.677e3709@canb.auug.org.au>
 <202201242230.C54A6BCDFE@keescook>
 <20220125222732.98ce2e445726e773f40e122e@kernel.org>
 <20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org>
 <202201251256.CCCBE9851E@keescook>
 <20220125162326.3d1ca960@gandalf.local.home>
 <20220125162859.2b3cc8a0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125162859.2b3cc8a0@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 04:28:59PM -0500, Steven Rostedt wrote:
> On Tue, 25 Jan 2022 16:23:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > >  #undef __get_rel_dynamic_array
> > > > -#define __get_rel_dynamic_array(field)	\
> > > > -		((void *)(&__entry->__rel_loc_##field) +	\
> > > > -		 sizeof(__entry->__rel_loc_##field) +		\
> > > > +#define __get_rel_dynamic_array(field)					\
> > > > +		((void *)__entry + 					\
> > > > +		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
> > > > +		 sizeof(__entry->__rel_loc_##field) +			\
> > > >  		 (__entry->__rel_loc_##field & 0xffff))
> > > >  
> > > >  #undef __get_rel_dynamic_array_len    
> > > 
> 
> I also do not like the the inconsistency between
> sizeof(__entry->__rel_loc_##field) and sizeof(u32) that is used in the
> calculation part:
> 
> 
> #define __rel_dynamic_array(type, item, len)				\
> 	__item_length = (len) * sizeof(type);				\
> 	__data_offsets->item = __data_size +				\
> 			       offsetof(typeof(*entry), __data) -	\
> 			       offsetof(typeof(*entry), __rel_loc_##item) -	\
> 			       sizeof(u32);				\
> 	__data_offsets->item |= __item_length << 16;			\
> 	__data_size += __item_length;
> 
> Why is one using sizeof(u32) and the other using the size of the field?

It might make more sense to calculate everything as an offset within
__data[] instead of from the start of __entry. The patch I sent just did
in perf.h exactly what Masami did in trace_event.h. That worked. I had
an earlier version that did this horrible thing which could probably be
significantly improved, since I just subtract the offset of __data:

 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field) \
-		((void *)(&__entry->__rel_loc_##field) +        \
-		 sizeof(__entry->__rel_loc_##field) +           \
-		 (__entry->__rel_loc_##field & 0xffff))
+		((void *)&__entry->__data[			\
+		 offsetof(typeof(*__entry), __rel_loc_##field)	\
+		 + sizeof(__entry->__rel_loc_##field)		\
+		 + (__entry->__rel_loc_##field & 0xffff)	\
+		 - offsetof(typeof(*__entry), __data)		\
+		])

> Just to let you know what is happening. As dynamic elements of the trace
> event needs to be appended at the end of the event, the above macros are
> defined and then run through the TRACE_EVENT() macro, where the
> TP_STRUCT__entry() is parsed to calculate where each item will be for that
> event.
> 
> static inline notrace int trace_event_get_offsets_##call(		\
> 	struct trace_event_data_offsets_##call *__data_offsets, proto)	\
> {									\
> 	int __data_size = 0;						\
> 	int __maybe_unused __item_length;				\
> 	struct trace_event_raw_##call __maybe_unused *entry;		\
> 									\
> 	tstruct;							\
> 									\
> 	return __data_size;						\
> }
> 
> 
> The tstruct is the TP_STRUCT__entry() and for each __rel_dynamic_array() or
> __dynamic_array(), the __data_size gets updated and saved into the
> __data_offsets that holds where each item is.
> 
> The rel versions sets the offset from its location to the data, where as
> the non rel versions sets the offset from the beginning of the event to the
> data.

Could this just be

#define __get_rel_dynamic_array(field) \
	((void *)(&__entry->data[__entry->__rel_loc_##field & 0xffff])

?

-- 
Kees Cook
