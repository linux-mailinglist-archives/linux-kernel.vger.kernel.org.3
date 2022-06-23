Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C26557322
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiFWGar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiFWGap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:30:45 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A543387B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:30:44 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-101b4f9e825so20941041fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OHUqu3uiTH5k20lesFs+yOO4/P24En0BSTW5y2O8uV0=;
        b=mgiLVWvdmEhQSQmlEeMJR/dxFVJ7YXC1vBayafzySC5xvt56qglh2tGzIpUf556bzc
         IFae/rkrNzOgGdcog/y2GAewpIRXkhwDRLwhtX9KmqNSJq1HvdedIe0boUjNBxS9wVkV
         qGAfaemevVKqpRYa1Dn27FW4fKH5MpgCCd7sV3E/sqXrJ+l1lmckmrYuBxmlG/baNHKd
         kvR86bij9u7qZ/7Lsb7PtJ45nB2fc5F3Pr107lXkGgizGk7YDCw81+3zQ073aGdWRoRY
         dHJYhlaUILV/eCy2wGLIZIvU0pMOnKEAB9HWaSNiGe8eQW8Mhd+N0xmQ6zEpJ6buiwNx
         XSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OHUqu3uiTH5k20lesFs+yOO4/P24En0BSTW5y2O8uV0=;
        b=jUwG1zs51ZuGFSMKcGHd6aBtxnyxpaQ+qW1/cv8A3ti2iEVy8TvblhHLWM2TkzVIDb
         /3gDHf0DuT7K6kTFtOTwgqHgg4dHTcvhJnLblgECYBuTy/3lU4A0dxHkip/BOTwY+ocY
         9NoFIsKnv7a12HuH/2bUQpi5qk/orpHr4K3Klad1rKvCNq9AyjLce+sj9GuVhcKDfajG
         7l+QKgOy+7bQfONipK1JzygtRhv9MHUWA5D6SJtHOhzqJoN+2RbL0tvWPV3iwo0JVOes
         XGzLqVhzjfdP6XiWlwZeUAQJnSVG23e/mSTfzIQWmhRhdnynirOl0iukO26Otl/ZE1A2
         eiOw==
X-Gm-Message-State: AJIora8u4m+gouC0/E7dH97dQZyb10AUMi6nF0bJkSsbdFE6eUGdExSP
        jbYr7kpPji6lOS9ElrVl8hzWCVSwMfg=
X-Google-Smtp-Source: AGRyM1vwmkBbryL4LpyXE55sidYEPWBAwlm29SUpAttUrWXE4HURaaep8Z24+p9VPXssEI31PbL3Qw==
X-Received: by 2002:a05:6870:5819:b0:101:f651:99a2 with SMTP id r25-20020a056870581900b00101f65199a2mr1531563oap.167.1655965843302;
        Wed, 22 Jun 2022 23:30:43 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id r25-20020a05683001d900b0060c10396c82sm12170287ota.58.2022.06.22.23.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:30:43 -0700 (PDT)
Date:   Thu, 23 Jun 2022 01:30:42 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 2/4] memblock tests: add verbose output to memblock
 tests
Message-ID: <YrQIkswtqUAz9cUt@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <004e021cc3cb7be8749361b3b1cb324459b9cb9f.1655889641.git.remckee0@gmail.com>
 <YrPsUrJ5R5UaIGBS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrPsUrJ5R5UaIGBS@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:30:10PM -0500, Mike Rapoport wrote:
> On Wed, Jun 22, 2022 at 04:29:07AM -0500, Rebecca Mckeever wrote:
> > Add and use functions for printing verbose testing output.
> > 
> > If the Memblock simulator was compiled with VERBOSE=1:
> >   prefix_push() appends the given string to a prefix string that will be
> >     printed in the test functions.
> >   prefix_pop() removes the last prefix from the prefix string.
> >   prefix_reset() clears the prefix string.
> >   test_fail() prints a message after a test fails containing the test
> >     number of the failing test and the prefix.
> >   test_pass() prints a message after a test passes containing its test
> >     number and the prefix.
> >   test_print() prints the given formatted output string.
> > 
> > If the Memblock simulator was not compiled with VERBOSE=1, these
> > functions do nothing.
> > 
> > Add the assert wrapper macros ASSERT_EQ(), ASSERT_NE(), and ASSERT_LT().
> > If the assert condition fails, these macros call test_fail() before
> > executing assert().
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
> >  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
> >  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
> >  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
> >  tools/testing/memblock/tests/common.c         |  58 +++
> >  tools/testing/memblock/tests/common.h         |  54 +++
> >  6 files changed, 880 insertions(+), 344 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > index d1aa7e15c18d..96df033d4300 100644
> > --- a/tools/testing/memblock/tests/alloc_api.c
> > +++ b/tools/testing/memblock/tests/alloc_api.c
> 
> ...
> 
> > @@ -729,6 +820,12 @@ static int alloc_no_memory_check(void)
> >  
> >  int memblock_alloc_checks(void)
> >  {
> > +	static const char func_testing[] = "memblock_alloc";
> > +
> > +	prefix_reset();
> > +	prefix_push(func_testing);
> > +	test_print("Running %s tests...\n", func_testing);
> 
> Why not 
> 
> 	test_print("Running memblock_alloc tests...\n");
> 
> ?
> 
> (applies to other cases below)

Both prefix_push() and test_print() are using that string, and I thought
it made sense to use a constant instead of hard coding the string in both
places. Is it better to hard code the string in this case?
> 
> > +
> >  	reset_memblock_attributes();
> >  	dummy_physical_memory_init();
> 
> ...
> 
> > diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> > index 963a966db461..f6eaed540427 100644
> > --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> > +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> 
> ...
> 
> > @@ -378,6 +423,12 @@ static int alloc_from_min_addr_cap_check(void)
> >  
> >  int memblock_alloc_helpers_checks(void)
> >  {
> > +	static const char func_testing[] = "memblock_alloc_from";
> > +
> > +	prefix_reset();
> > +	prefix_push(func_testing);
> > +	test_print("Running %s tests...\n", func_testing);
> > +
> >  	reset_memblock_attributes();
> >  	dummy_physical_memory_init();
> >  
> > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > index 6390206e50e1..601f4a7ee30d 100644
> > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> 
> ...
> 
> > @@ -1150,6 +1263,12 @@ static int alloc_try_nid_low_max_check(void)
> >  
> >  int memblock_alloc_nid_checks(void)
> >  {
> > +	static const char func_testing[] = "memblock_alloc_try_nid";
> > +
> > +	prefix_reset();
> > +	prefix_push(func_testing);
> > +	test_print("Running %s tests...\n", func_testing);
> > +
> >  	reset_memblock_attributes();
> >  	dummy_physical_memory_init();
> >  
> > @@ -1170,5 +1289,7 @@ int memblock_alloc_nid_checks(void)
> >  
> >  	dummy_physical_memory_cleanup();
> >  
> > +	prefix_pop();
> > +
> >  	return 0;
> >  }
> > diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> > index a7bc180316d6..f223a9a57be7 100644
> > --- a/tools/testing/memblock/tests/basic_api.c
> > +++ b/tools/testing/memblock/tests/basic_api.c
> > @@ -4,21 +4,30 @@
> >  #include "basic_api.h"
> >  
> >  #define EXPECTED_MEMBLOCK_REGIONS			128
> > +#define FUNC_ADD					"memblock_add"
> > +#define FUNC_RESERVE					"memblock_reserve"
> > +#define FUNC_REMOVE					"memblock_remove"
> > +#define FUNC_FREE					"memblock_free"
> >  
> >  static int memblock_initialization_check(void)
> >  {
> > -	assert(memblock.memory.regions);
> > -	assert(memblock.memory.cnt == 1);
> > -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> > -	assert(strcmp(memblock.memory.name, "memory") == 0);
> > +	prefix_push(__func__);
> >  
> > -	assert(memblock.reserved.regions);
> > -	assert(memblock.reserved.cnt == 1);
> > -	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
> > -	assert(strcmp(memblock.reserved.name, "reserved") == 0);
> > +	ASSERT_NE(memblock.memory.regions, NULL);
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> > +	ASSERT_EQ(strcmp(memblock.memory.name, "memory"), 0);
> >  
> > -	assert(!memblock.bottom_up);
> > -	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
> > +	ASSERT_NE(memblock.reserved.regions, NULL);
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.max, EXPECTED_MEMBLOCK_REGIONS);
> > +	ASSERT_EQ(strcmp(memblock.reserved.name, "reserved"), 0);
> > +
> > +	ASSERT_EQ(memblock.bottom_up, false);
> > +	ASSERT_EQ(memblock.current_limit, MEMBLOCK_ALLOC_ANYWHERE);
> > +
> > +	test_pass();
> > +	prefix_pop();
> >  
> >  	return 0;
> >  }
> > @@ -40,14 +49,19 @@ static int memblock_add_simple_check(void)
> >  		.size = SZ_4M
> >  	};
> >  
> > +	prefix_push(__func__);
> > +
> >  	reset_memblock_regions();
> >  	memblock_add(r.base, r.size);
> >  
> > -	assert(rgn->base == r.base);
> > -	assert(rgn->size == r.size);
> > +	ASSERT_EQ(rgn->base, r.base);
> > +	ASSERT_EQ(rgn->size, r.size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.total_size, r.size);
> >  
> > -	assert(memblock.memory.cnt == 1);
> > -	assert(memblock.memory.total_size == r.size);
> > +	test_pass();
> > +	prefix_pop();
> >  
> >  	return 0;
> >  }
> > @@ -69,18 +83,27 @@ static int memblock_add_node_simple_check(void)
> >  		.size = SZ_16M
> >  	};
> >  
> > +	prefix_pop();
> > +	prefix_push("memblock_add_node");
> > +	prefix_push(__func__);
> 
> I think there is no need to change the prefix from memblock_add to
> memblock_add_node here.
> 
> ok 3 : memblock_add: memblock_add_node_simple_check: passed
> 
> provides enough information.
>

Will do.

> > +
> >  	reset_memblock_regions();
> >  	memblock_add_node(r.base, r.size, 1, MEMBLOCK_HOTPLUG);
> >  
> > -	assert(rgn->base == r.base);
> > -	assert(rgn->size == r.size);
> > +	ASSERT_EQ(rgn->base, r.base);
> > +	ASSERT_EQ(rgn->size, r.size);
> >  #ifdef CONFIG_NUMA
> > -	assert(rgn->nid == 1);
> > +	ASSERT_EQ(rgn->nid, 1);
> >  #endif
> > -	assert(rgn->flags == MEMBLOCK_HOTPLUG);
> > +	ASSERT_EQ(rgn->flags, MEMBLOCK_HOTPLUG);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.total_size, r.size);
> >  
> > -	assert(memblock.memory.cnt == 1);
> > -	assert(memblock.memory.total_size == r.size);
> > +	test_pass();
> > +	prefix_pop();
> > +	prefix_pop();
> > +	prefix_push(FUNC_ADD);
> >  
> >  	return 0;
> >  }
> 
> -- 
> Sincerely yours,
> Mike.

Thanks,
Rebecca
