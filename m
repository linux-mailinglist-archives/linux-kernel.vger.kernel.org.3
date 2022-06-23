Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5BE55726D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiFWFBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFWFBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:01:06 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1816B49B75
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:45:39 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-101ec2d6087so14713065fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1eJjql1DS+4tUOmOmPQ3Sdf7SzV4qJ6k25MmxMxIlo=;
        b=A9PtieinnX1oh4Vt1n8jWdSiJuHpdYC04CNgpVBHL0s4sf9I2w6qbUGmITInydmuw7
         zhHDVED7Eq+9AkR1C6UZBa0laJGpqE2krzx8aBUbxPRNrke9UFIHWvbi01pdHWT6jnwJ
         Upq87K+McYK8bxHrwmN5cX30wB4wYen5DRLXJs6o/qnFG8QHyKWuQW/fjVh1xtk9TX6x
         KkUB0Jqw6lsdLwoNt9nNP+WHV+Px5jNQl6VAvgyAy3OAfCIdg6xS1B/ctLaw5WjBQrf0
         0JEXBvyWNMq4lzvB37kBbFheMRlNHtd+hiqpawJsFPOrEmcdMw7FeXxUEXVX7/KtC1PM
         M9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1eJjql1DS+4tUOmOmPQ3Sdf7SzV4qJ6k25MmxMxIlo=;
        b=mYqdSTjVV5NJVGtoN1Z8CojQfIFIqcr9Cn7AccVjvvG+vkGFB9Q5hzzdpezEM0igQ6
         LZRbj4KoSvKAUIA6uHbJWMY113a1hQOkWglzHEkXZWhF8Dvvbe8V5dgnRU7jbEBNr2iJ
         BdMxFDvwkGs14ABP8tSFx5Dp2VrhM0/aDOlcxkQE6gWnwQirrdBxzHSGV1ycBXsod5Mk
         y6hoPpbOT+61ccTSK5KJ2aI2fmj4/CfqmJ2AXUJ0z2z6E5icVvnWThJyCKLMM/hcPTy+
         WI2V1JorAopyJMZqgar+l5zYCCKRuE1LWREfdIyl46tixBehCKt0qF6hi/ZVbdBcWeR2
         k9lQ==
X-Gm-Message-State: AJIora9brwGSWPYnBxp+w970PjQ5y1FD8z1pYslIXBCB0DW4M4Wyb4di
        X2g6N0GgbXym077YXJBvvuVp86rmr6s=
X-Google-Smtp-Source: AGRyM1txdBUeGkwFzvXCQfQ6+abOTYupkMvGUjrSYlrhD2Bjp+E/d6mJjfbvXMq9dWx7EBW2cz9M+w==
X-Received: by 2002:a05:6870:6c15:b0:106:919c:80df with SMTP id na21-20020a0568706c1500b00106919c80dfmr1274546oab.111.1655959537968;
        Wed, 22 Jun 2022 21:45:37 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id 79-20020a9d0bd5000000b0060afaae0e34sm12243064oth.0.2022.06.22.21.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:45:37 -0700 (PDT)
Date:   Wed, 22 Jun 2022 23:45:36 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 1/4] memblock tests: add user-provided arguments to
 Makefile
Message-ID: <YrPv8BnNWyqgwOMo@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <b7e8e89dbbd7acdf41d62f1528f02d1dc2283e4b.1655889641.git.remckee0@gmail.com>
 <YrPia6frNDEyN41S@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPia6frNDEyN41S@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Jun 22, 2022 at 10:47:55PM -0500, Mike Rapoport wrote:
> Hi Rebecca,
> 
> On Wed, Jun 22, 2022 at 04:29:06AM -0500, Rebecca Mckeever wrote:
> >
> > Subject: memblock tests: add user-provided arguments to Makefile
> 
> Please be more specific here, e.g. 
> 
> memblock tests: Makefile: add arguments to control verbosity
>
Should I also mention debug messages, or does verbosity refer to both
arguments?

> > Add VERBOSE and MEMBLOCK_DEBUG user-provided arguments. VERBOSE will
> > enable verbose output from Memblock simulator. MEMBLOCK_DEBUG will enable
> > memblock_dbg() messages.
> > 
> > Update the help message to include VERBOSE and MEMBLOCK_DEBUG. Update
> > the README to include VERBOSE. The README does not include all available
> > options and refers to the help message for the remaining options.
> > Therefore, omit MEMBLOCK_DEBUG from README.
> > 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  tools/testing/memblock/Makefile                 |  4 ++++
> >  tools/testing/memblock/README                   | 10 +++++++++-
> >  tools/testing/memblock/scripts/Makefile.include | 10 ++++++++++
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
> > index a698e24b35e7..9fde49ad73bd 100644
> > --- a/tools/testing/memblock/Makefile
> > +++ b/tools/testing/memblock/Makefile
> > @@ -45,6 +45,10 @@ help:
> >  	@echo  '  clean		  - Remove generated files and symlinks in the directory'
> >  	@echo  ''
> >  	@echo  'Configuration:'
> > +	@echo  '  make VERBOSE=1            - enable verbose output, which includes the'
> > +	@echo  '                              names of functions being tested and the'
> > +	@echo  '                              number of test cases passing'
> > +	@echo  '  make MEMBLOCK_DEBUG=1     - enable memblock_dbg() messages'
> >  	@echo  '  make NUMA=1               - simulate enabled NUMA'
> >  	@echo  '  make MOVABLE_NODE=1       - override `movable_node_is_enabled`'
> >  	@echo  '                              definition to simulate movable NUMA nodes'
> > diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
> > index ca6afcff013a..058146b528a5 100644
> > --- a/tools/testing/memblock/README
> > +++ b/tools/testing/memblock/README
> > @@ -34,7 +34,15 @@ To run the tests, build the main target and run it:
> >  $ make && ./main
> >  
> >  A successful run produces no output. It is also possible to override different
> > -configuration parameters. For example, to simulate enabled NUMA, use:
> > +configuration parameters. For example, to include verbose output, specify the
> > +VERBOSE flag when building the main target:
> > +
> > +$ make VERBOSE=1
> > +
> > +This will print information about which functions are being tested and the
> > +number of test cases that passed.
> > +
> > +To simulate enabled NUMA, use:
> >  
> >  $ make NUMA=1
> >  
> > diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
> > index 641569ccb7b0..4401f79bed4c 100644
> > --- a/tools/testing/memblock/scripts/Makefile.include
> > +++ b/tools/testing/memblock/scripts/Makefile.include
> > @@ -17,3 +17,13 @@ ifeq ($(32BIT_PHYS_ADDR_T), 1)
> >  	CFLAGS += -m32 -U CONFIG_PHYS_ADDR_T_64BIT
> >  	LDFLAGS += -m32
> >  endif
> > +
> > +# Enable verbose testing output
> > +ifeq ($(VERBOSE), 1)
> > +	CFLAGS += -D VERBOSE
> > +endif
> > +
> > +# Enable memblock_dbg() messages
> > +ifeq ($(MEMBLOCK_DEBUG), 1)
> > +	CFLAGS += -D MEMBLOCK_DEBUG
> > +endif
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
