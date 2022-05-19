Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2052DE63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiESU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244742AbiESU0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:26:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C359BB1;
        Thu, 19 May 2022 13:26:30 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id l1so5423832qvh.1;
        Thu, 19 May 2022 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=go2/YWXME4ez1o5zuNo4hO9s2i3InBGvMPu+M/NQw7Y=;
        b=GdnnUYzg0gZzyP8R/2GKPdRNtO4TGivLhRhb3/ka6IzuwlXDMyC7clL9y1u/8s8k3D
         39eHu5wO2KXS+h184uE3fjNwZg9YG3BWf4TdT3yuVPx7aXlCgpXSIeN887CxMjYluCgH
         r0EbEkg0yzkUYo3NlXU4cFeOGHCXkCMvgQvKgEgGmJNfcV+iz8T6J/mDdis5PITWWJjI
         nbSDr05uEdSlZQ/OrHb9rUGq5Xl15J+/btssanWetiYeEyGVFqyhf8COEJ/E0ohqSEA0
         nqw9IYQsC1fLiXUnyaU6Tlk2DiPpcOCcHCF1z+HiYimpH1MU88BLC/iGGSipCFZnOf4S
         9z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=go2/YWXME4ez1o5zuNo4hO9s2i3InBGvMPu+M/NQw7Y=;
        b=PkXnAc5/7ERY9YkgNVXstne3J6Dzo+56pJGgT2NyWGzvHKMmRqm6ESbXma1a4g+uhN
         elct9O31OhZddYDE/wkLUb6lBbMNIdC4/pTQ2pWjzcB7Fqp02LROQHJ+T8NibUHDBSW2
         V8mAAqFkcwNqokSASe/OHx/YKrFyMf6gb/IvmghY4SQRJVbjBL2h9V8uVBlqzMDE5X0n
         Bw2Q3RXhq+MRQa9HF2LtI7kLqpqoxHdP+FH1ZRzjjkdI3WXBUbkWM3m6KW62pn4Usp7g
         XRMqly1AprGTHJQwtZcRZ1PKmBnB9D+Ilosd9DGYhxVKo24hDYXc+NUH6DWF7VUJ2H4A
         v2/g==
X-Gm-Message-State: AOAM532ud5P2axT7R7j7TFL300WHHmE74W1LaeJMqA5dqrupHGEGm1SQ
        owlOSAKPsiILBIB7UoC9DQ==
X-Google-Smtp-Source: ABdhPJzPS6xHZHAUuDRBIazYR4mT9W6fh4etXbgmmbka+f/iPyO+nvjzUXeSKH42vj9TbMj0qn91xA==
X-Received: by 2002:a05:6214:c41:b0:45f:380d:2f6a with SMTP id r1-20020a0562140c4100b0045f380d2f6amr5498849qvj.54.1652991989654;
        Thu, 19 May 2022 13:26:29 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l184-20020a3789c1000000b0069ffe63228fsm1812412qkd.121.2022.05.19.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:26:28 -0700 (PDT)
Date:   Thu, 19 May 2022 16:26:26 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
 <Yoam1bW/vni3srLc@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoam1bW/vni3srLc@smile.fi.intel.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:21:41PM +0300, Andy Shevchenko wrote:
> On Thu, May 19, 2022 at 01:24:00PM -0400, Kent Overstreet wrote:
> > +void pr_human_readable_s64(struct printbuf *buf, s64 v)
> > +{
> > +	if (v < 0)
> > +		pr_char(buf, '-');
> > +	pr_human_readable_u64(buf, abs(v));
> 
> Wouldn't -v work?

This is a bit terser

> > + * pr_human_readable_u64 - Print out a u64 according to printbuf unit options
> 
> Have you ever compile this? We have kernel doc validator running when compiling
> the code...

Yes I have, but I've never seen the kernel doc validator - can you point me to
something so I can get that working?

> > +void pr_units_s64(struct printbuf *out, s64 v)
> > +{
> > +	if (v < 0)
> > +		pr_char(out, '-');
> > +	pr_units_u64(out, v);
> 
> Please, start with test cases.

I suppose now that we've got kunit I should learn how to use it :) And thanks,
good catch
