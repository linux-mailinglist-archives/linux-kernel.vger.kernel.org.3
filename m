Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E33556FAD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376959AbiFWBBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiFWBBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:01:08 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A90541F9B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:01:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k24so23408673oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HTsgBhm/o/POE84ZagYPea5g/wEfGrvEaZuql2akX8Q=;
        b=luP7QRCN4pK4yP/6BHzyWgQq/q4WvC6dyd0mnfav2FGYwz+rP7eP4AWFo0Uu+4sWgb
         LV4eh/ZWV4BbQH13zvuB7WX32sVMV5Cxf6dlLF2nXvckIhcpY2th3UTk7DsIvfOJFgKj
         zgrwsCYKHnGtjU6AqeqQckBvtjmhL+hOmWXx1wx75jfcHMs3HWdwPsQwJUGrKSUqt4Y+
         zX8RIBjRuklvwQ4/EriIaRYZNHwmBsUGURUa6Z/bFvH5yHDYZi9MfNnPJSENNj8RgMrK
         qD9KFnGimxI3itmMVdnNK79gPXAX3f1CfXDRlkvPDBLkzf5whk4xxO1DRhbP+azH73bh
         12Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HTsgBhm/o/POE84ZagYPea5g/wEfGrvEaZuql2akX8Q=;
        b=0Tt4Ubp8in80n8fX4z1Yxyy0+HHuEABo+sa3aNir9YjDnFdoQAKrspuoAT0Rd9OMl4
         2uqvh75vpmNYuoNfbXnCKiMiIxD+YBA0ZTWDloBXF94D/2BOB+fUR89pL+maLqjUgR6L
         a1JTV9xfWzdCnswUY9IlDwpd7ie66bX++kbT6f9Hgri+riPKt3USmbd8dO8NAukLMWwH
         s+o//2sgfrEcP4tlzJ7iRZ6UZKml1VXi463bPmBCfrjDXcuNg+Uc9vUXIt8tMshKld/X
         8umuvHY3jWbo07aoUvh7yIcSdqT0gN5i/tIvF93gqc2LGPat8n1Ffb4F+XoCvdR6zvR8
         TCfw==
X-Gm-Message-State: AJIora+zdJ9tP9iSZLK04RhnlQwVEUKKGraTKJolPeB9z2v7NpKVvuQF
        iuZLi6VBcU+F4BVCUuc6sG4=
X-Google-Smtp-Source: AGRyM1uqtsOJo9g9sNTQT300yh2v/9ie7zO7e7yXYQl/mrsXXvBIwJuOiVWLoO9+PqfcFqGj1ADnew==
X-Received: by 2002:a05:6808:1387:b0:333:4c4:ef81 with SMTP id c7-20020a056808138700b0033304c4ef81mr725105oiw.46.1655946062527;
        Wed, 22 Jun 2022 18:01:02 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id s204-20020aca45d5000000b0032f662af5d5sm12041579oia.1.2022.06.22.18.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 18:01:02 -0700 (PDT)
Date:   Wed, 22 Jun 2022 20:01:00 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrO7TK9DZygHIYb6@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <YrMkdPjftJz2J7Vx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrMkdPjftJz2J7Vx@kernel.org>
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

On Wed, Jun 22, 2022 at 09:17:24AM -0500, Mike Rapoport wrote:
> Hi Rebecca,
> 
> On Wed, Jun 22, 2022 at 04:29:05AM -0500, Rebecca Mckeever wrote:
> > These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> > simulator, which can be specified when running make. These patches also
> > implement the functionality for these options.
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
> 
> The patch changelog in a cover letter usually goes before the commit list
> and diffstat. 
>  
Thanks for letting me know, I will do that next time.

> > -- 
> > 2.34.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
