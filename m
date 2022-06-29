Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD985606FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiF2RHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2RHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:07:38 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181F3B3DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:07:37 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id q18-20020a9d7c92000000b00616b27cda7cso11027743otn.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ani27qvWfhhMe/zeIF8mB9KZc5Lqz8+v8+hLYRP+d+I=;
        b=e4ElhJBCu4PRKQoutwrAAa3FolaIqIVKuJw+WU1xcRNo2oraMivRVMNZdkP5Ow7f95
         B2vCDV+N+2td5HvyB8r9ZvbLZUwWmWtle7tih8Vh/gdqWxYf8gBXYnQ+62/LzfO8yYtP
         kdHBnNrYcilWzDnM7JB9YOfKnwcEYKrxNyLNVr26DcpeRpdcdetd+I2VumF7EZYrgO8b
         CAwuomluaGxYXE0f9z9alRjY9dC0/Wz96At8MK1t/mpZbZjdKBdQMx62/UKDLQwRWfCw
         /mx2Bbs7yA5xVbt778wyynKubAtUMHhuu1xk4xcowzHkMit5vjR+Z3Ej+H9wwqUEmmak
         c2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ani27qvWfhhMe/zeIF8mB9KZc5Lqz8+v8+hLYRP+d+I=;
        b=XZgM1H0+bHbJQvkAzIfgvZwYra43BZ6Wr0VNDvFFKzORLpDoyVwGsFpHFB+/VKYtUC
         qdVxFXF8gcANNHmBuq3ED3RQ0qRyI2fboulnImimibS4xUT2vpp9MeGFkufDPocBMDDT
         yTqeyL3fRkQqGxvCaHzL2hfyEKrgHnXrC6q89DJZbDtYnjv4UYcVb4BOF/F57aqj15f9
         GXsMnzPC98+IkHTdZwtv+NjAGqgRb5k+VKQ9NN7NI4cXjwQypGw7vfnKBE2fkBQ0WkEQ
         cYfGd+P0q/IPVgTyOrsTDKAXaaXY3NTwoJBuILRL6hW5ofZw7gLEo3Fo4pJ3k0KgHEs3
         HAsw==
X-Gm-Message-State: AJIora+uyzPl586bU87s/EXRZoz9MslCJE87JapRh0GQVjSI1y4hOPR2
        EWleU9DlctVkV5d5qWtnwAd7DqCmiN0=
X-Google-Smtp-Source: AGRyM1vQV5rs/uR2BoHI5x/1SCooR6Go9/KbU+5an7lTaqfEfh/z/cRVEsAnIwDji6f/fNSyJQLzOg==
X-Received: by 2002:a9d:6291:0:b0:616:d7b2:5832 with SMTP id x17-20020a9d6291000000b00616d7b25832mr1801653otk.103.1656522456268;
        Wed, 29 Jun 2022 10:07:36 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id u13-20020a056870f28d00b001048b819e13sm11289036oap.8.2022.06.29.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:07:35 -0700 (PDT)
Date:   Wed, 29 Jun 2022 12:07:34 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YryG1nuJ+nL9maeS@bertie>
References: <cover.1656368930.git.remckee0@gmail.com>
 <883c28e34527fd4cdc55df97c791ed8b2e79538d.1656368930.git.remckee0@gmail.com>
 <5db2944e-9d64-8faa-83d3-fd02fce583bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db2944e-9d64-8faa-83d3-fd02fce583bd@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 01:34:54PM +0200, David Hildenbrand wrote:
> On 28.06.22 00:34, Rebecca Mckeever wrote:
> > Add and use functions and macros for printing verbose testing output.
> > 
> > If the Memblock simulator was compiled with VERBOSE=1:
> > - prefix_push(): appends the given string to a prefix string that will be
> >   printed in test_fail() and test_pass*().
> > 
> > - prefix_pop(): removes the last prefix from the prefix string.
> > 
> > - prefix_reset(): clears the prefix string.
> > 
> > - test_fail(): prints a message after a test fails containing the test
> >   number of the failing test and the prefix.
> > 
> > - test_pass(): prints a message after a test passes containing its test
> >   number and the prefix.
> > 
> > - test_print(): prints the given formatted output string.
> > 
> > - test_pass_pop(): runs test_pass() followed by prefix_pop().
> > 
> > - PREFIX_PUSH(): runs prefix_push(__func__).
> > 
> > If the Memblock simulator was not compiled with VERBOSE=1, these
> > functions/macros do nothing.
> > 
> > Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> > If the assert condition fails, these macros call test_fail() before
> > executing assert().
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> 
> 
> [...]
> 
> >  
> > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > index 62d3191f7c9a..e55b2a8bf0ff 100644
> > --- a/tools/testing/memblock/tests/common.c
> > +++ b/tools/testing/memblock/tests/common.c
> > @@ -4,8 +4,12 @@
> >  
> >  #define INIT_MEMBLOCK_REGIONS			128
> >  #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> > +#define PREFIXES_LEN_MAX			256
> > +#define DELIM					": "
> > +#define DELIM_LEN				strlen(DELIM)
> 
> Why not simply
> 
> #define PREFIXES_MAX	15
> static const char * __maybe_unused prefixes[PREFIXES_MAX];
> static int nr_prefixes;
> 
> And then simply insert/clear the corresponding prefixes[] pointer and
> update nr_prefixes?
> 
> When printing, you only have to walk prefixes from 0 ... nr_prefixes - 1
> and print the values.
> 
> Avoids any string modifications.
> 
What is nr_prefixes? Number of prefixes? Currently, the longest prefix is
49 characters (alloc_try_nid_bottom_up_reserved_with_space_check), so I
think PREFIXES_MAX would need to be at least 52 (including the delimiter),
but let me know if I'm misunderstanding.
> 
> Anyhow, this LGTM
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
