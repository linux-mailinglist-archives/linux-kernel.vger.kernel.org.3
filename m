Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C0557222
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiFWEox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbiFWEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:20:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB4F2D1E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:20:14 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l81so23821532oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTdDyLbh8tP6o7Q+FLGKTGG6l09vUb5zEGBwzqDGc4Y=;
        b=URrd01aPjkPLzZ+FUPVluh3B9wHkVdfFgRToHXuZheiWFUv+m4z7a6jU9QbE7Y2NRw
         2n8OJuMkGQk+Uon/H5b1Yim7U8i1uipI8DhfJxx8bzavq7QLWgq1eI5UurJvDeCdDyBt
         znIxEWHZTND5vdiaoD9ufsJEFetTQU/AhdGX3Yu/qk3md8ByEPC/QYneIQXGi/B8vJ0F
         9arl/Cc76b+zJX10jnKh7ffHoUAzdeqySZ2Z5A5Hud1ZK8vxo9qiOIN59Y8rMqVQeIqB
         1oyXOl1u+DWre1Xg0egdCgLB1Kholq1edpbCV0EXeXN4aRIJ0hatik8+i53M2yRXRbrX
         WyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTdDyLbh8tP6o7Q+FLGKTGG6l09vUb5zEGBwzqDGc4Y=;
        b=kGDsra8QdeQB8l9Kkrdt/aTUWgz/NE9pNP2dDUVtcAFvTyTdqRRRqwAnsHNUGQetan
         EEf41ChM+QtRJPTbnSxfQZywAmrBmzyRlngzArvJJ9pMAhwLbM6AM+KY9N0tI5Izygt5
         ks5gQS9P9ABAEhf7/QAj77qhSD/Gk8ez+quTHYIfqouO1eyBhJEq5PmfE5dKEzfpHQab
         iHggQk/ZcFjM+qfI5k7Y4XoE2OOoHxM8sp7xDT826Q/EG4hizNBjV0P4lJeD8Y14ivQh
         i950hlKPOUkOr+GhpwbYbSQQ+JBlDlVJzK7gbjtgMgxxU+Leka6StxXU3Vo1QSIQhh53
         kW2Q==
X-Gm-Message-State: AJIora+iLIg2/ZD14Z5pxk9R7ERxiwOQutG9Fj+BMI7ByGrNQYA9UJdS
        cy679aLNeVlp8hMWH4pv6uM=
X-Google-Smtp-Source: AGRyM1s2b5Dok077072a1KKGCHrG/ui/nHrguWh4T9QOsw8X8BBakGLhoYiE0l1vUu+BDXSJ2bHlTQ==
X-Received: by 2002:aca:674b:0:b0:333:2014:9d6e with SMTP id b11-20020aca674b000000b0033320149d6emr1074143oiy.169.1655958014189;
        Wed, 22 Jun 2022 21:20:14 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id ep36-20020a056870a9a400b000f886139c51sm12482737oab.53.2022.06.22.21.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:20:13 -0700 (PDT)
Date:   Wed, 22 Jun 2022 23:20:11 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrPp+xMGZ/n1TpTk@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <YrPeXOgEQq7G4Ctq@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPeXOgEQq7G4Ctq@iweiny-desk3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 08:30:36PM -0700, Ira Weiny wrote:
> On Wed, Jun 22, 2022 at 04:29:05AM -0500, Rebecca Mckeever wrote:
> > These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> > simulator, which can be specified when running make. These patches also
> > implement the functionality for these options.
> 
> I seem to be missing patch 3/4 and I don't see it on lore?
> 
> https://lore.kernel.org/linux-mm/004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com/
> 
> Did it get sent?  Did it define the ASSERT_*() macros?

That's strange, my email shows that it was sent to linux-mm@kvack.org and
linux-kernel@vger.kernel.org but I'm not seeing it on lore either.
Should I resend just patch 3/4? For now, you can take a look at v1.
Patch 3 is unchanged from v1, which is showing up on lore:

https://lore.kernel.org/linux-mm/fe34452209f54287023ccacd666eade81ecd9a24.1655878337.git.remckee0@gmail.com/T/#u

It does not define the ASSERT_*() macros, that happens in patch 2.
Patch 3 implements MEMBLOCK_DEBUG.

Thanks,
Rebecca

> 
> Ira
> 
> > 
> > VERBOSE
> > Usage:
> > 
> > $ make VERBOSE=1
> > 
> > Passing VERBOSE=1 will enable verbose output from Memblock simulator. For
> > each test, the verbose output includes the name of the memblock function
> > being tested, the name of the test, and whether the test passed or failed.
> > Since all the tests in Memblock simulator run as one monolithic test, this
> > output is a quick way to get a summary of test results.
> > 
> > MEMBLOCK_DEBUG
> > Usage:
> > 
> > $ make MEMBLOCK_DEBUG=1
> > 
> > Passing MEMBLOCK_DEBUG=1 will enable memblock_dbg() messages. These
> > are debug messages built into several functions in memblock that include
> > information such as the name of the function and the size and start and
> > end addresses of the memblock region.
> > 
> > Rebecca Mckeever (4):
> >   memblock tests: add user-provided arguments to Makefile
> >   memblock tests: add verbose output to memblock tests
> >   memblock tests: set memblock_debug to enable memblock_dbg() messages
> >   memblock tests: remove completed TODO items
> > 
> >  tools/testing/memblock/Makefile               |   4 +
> >  tools/testing/memblock/README                 |  10 +-
> >  tools/testing/memblock/TODO                   |  14 +-
> >  tools/testing/memblock/internal.h             |   7 +
> >  .../testing/memblock/scripts/Makefile.include |  10 +
> >  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
> >  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
> >  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
> >  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
> >  tools/testing/memblock/tests/common.c         |  58 +++
> >  tools/testing/memblock/tests/common.h         |  54 +++
> >  11 files changed, 913 insertions(+), 356 deletions(-)
> > 
> > ---
> > Changes
> > 
> > v1 -> v2
> > PATCH 2, in common.c:
> >   Remove #ifdef VERBOSE around prefixes and related constants
> >   Add __maybe_unused to prefixes
> >   Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
> >     immediately after the other constants
> >   Add #ifdef VERBOSE around definitions for test_*() and prefix_*()
> > 
> > v2 -> v3
> > PATCH 1:
> >   Add Reviewed-by tag
> > ---
> > 
> > -- 
> > 2.34.1
> > 
> > 
