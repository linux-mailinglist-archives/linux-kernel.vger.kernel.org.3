Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFC3599542
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbiHSGNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbiHSGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:13:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39546E2C6D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:12:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x5so2689322qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=BUbzJhFPA1Z2NBgyEfkTrK70QfO7lAh48LLWLp+ZvU0=;
        b=MplCQttaW5mc/lV8VEefCfRrvxQ4jgt064EhH5Hfaar4f67KqUIQcKVFMh+dcq//xJ
         w22xN9YhUVvgA3mMJ5+61CnsqeUPuQ150Qmz3otINlbYmY67UvK1ZbzF1v9FiSYKajf3
         3L1pLMcl5dkJbIUbnH5kUsdbA6g2coP9pfWC4LcLa4Ft+DkXC/WzmP2PnyLF6Ncqxy8m
         sSkcv8HKMNN5pexzCLRwTFDsDK0fo6BlZUjRWm7trV1A0fKqpIIkXkaaeQlQXCVI3KgB
         p4iDaIMvsrWWoQW8voC434Im1rtJMjLtIsALyPe3vA0ULHUz8tFkFa1seGRiMed5FmBn
         Motw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=BUbzJhFPA1Z2NBgyEfkTrK70QfO7lAh48LLWLp+ZvU0=;
        b=FDhtS57llo7HmH44p46CxHsddQyE3Pa9Izer23crjJ6CRcRvEnhGe4/VGQEncvtKDh
         /QmnL/FjbBnv+GaTvmSL0J8grubqutah5aN++aP36m9OkaH6PDEQeQIz0DDClaqRTDGK
         xHwqIvSx5zPkfniucp4ASObzTdpFtUiEX5oi5TirsVhOmfZtjZYg1YJHvaK002PQfsuW
         z4nYDFd9VGx2pfgQRBRbBVtDRgKkv/X9wjv86hSROYx2n7W1EWbcTxY26A06vd1vc+v8
         DBooduAxwn9LWK8aPGXarrTwNTaaVQpsaJRWTSPYILNU/JpoEuBMhFmqS57mrmce+vCk
         35iQ==
X-Gm-Message-State: ACgBeo0p3cnPy3V39VyXbiiR80dBeI965wFuhE+u3v4eb6rXRaF1VItq
        kOnMCUN09AP+5807JFkffjQHgw62zOc=
X-Google-Smtp-Source: AA6agR5JeopRbiwTXmXBOpCTKjCdAcq1mtKPgZny3pC5VluySqaylmIl/+ohceXTdLctQSqnsDYEJw==
X-Received: by 2002:a05:622a:195:b0:344:5630:dcc with SMTP id s21-20020a05622a019500b0034456300dccmr5387911qtw.598.1660889538986;
        Thu, 18 Aug 2022 23:12:18 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id d134-20020ae9ef8c000000b006b942f4ffe3sm3025364qkg.18.2022.08.18.23.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:12:18 -0700 (PDT)
Date:   Thu, 18 Aug 2022 23:10:05 -0700
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/8] memblock tests: add additional tests for basic api
 and memblock_alloc
Message-ID: <20220819061005.GB3930@sophie>
References: <cover.1660454730.git.remckee0@gmail.com>
 <816c5d36d18944171b3fa4964ce75d91f8096bf1.1660454730.git.remckee0@gmail.com>
 <ef2001eb-1833-edf0-9dc0-ab5aaeb0d51f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2001eb-1833-edf0-9dc0-ab5aaeb0d51f@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shaoqin,

On Mon, Aug 15, 2022 at 06:19:38PM +0800, Huang, Shaoqin wrote:
> Hi, Rebecca.
> 
> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> > Add tests for memblock_add(), memblock_reserve(), memblock_remove(),
> > memblock_free(), and memblock_alloc() for the following test scenarios.
> > 
> > memblock_add() and memblock_reserve():
> > - add/reserve a memory block in the gap between two existing memory
> >    blocks, and check that the blocks are merged into one region
> > - try to add/reserve memblock regions that extend past PHYS_ADDR_MAX
> > 
> > memblock_remove() and memblock_free():
> > - remove/free a region when it is the only available region
> >      + These tests ensure that the first region is overwritten with a
> >        "dummy" region when the last remaining region of that type is
> >        removed or freed.
> > - remove/free() a region that overlaps with two existing regions of the
> >    relevant type
> > - try to remove/free memblock regions that extend past PHYS_ADDR_MAX
> > 
> > memblock_alloc():
> > - try to allocate a region that is larger than the total size of available
> >    memory (memblock.memory)
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   tools/testing/memblock/tests/alloc_api.c |  44 ++
> >   tools/testing/memblock/tests/basic_api.c | 499 +++++++++++++++++++++++
> >   2 files changed, 543 insertions(+)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > index 73c2c43e702a..fe1ee3b2e851 100644
> > --- a/tools/testing/memblock/tests/alloc_api.c
> > +++ b/tools/testing/memblock/tests/alloc_api.c
> > @@ -470,6 +470,40 @@ static int alloc_no_memory_generic_check(void)
> >   	return 0;
> >   }
> > +/*
> > + * A test that tries to allocate a region that is larger than the total size of
> > + * available memory (memblock.memory):
> > + *
> > + *  +-----------------------------------+
> > + *  |                 new               |
> > + *  +-----------------------------------+
> > + *  |                                 |
> > + *  |                                 |
> > + *  +---------------------------------+
> > + *
> > + * Expect no allocation to happen.
> > + */
> > +static int alloc_too_large_generic_check(void)
> > +{
> > +	struct memblock_region *rgn = &memblock.reserved.regions[0];
> > +	void *allocated_ptr = NULL;
> > +
> > +	PREFIX_PUSH();
> > +
> > +	setup_memblock();
> > +
> > +	allocated_ptr = memblock_alloc(MEM_SIZE + SZ_2, SMP_CACHE_BYTES);
> > +
> > +	ASSERT_EQ(allocated_ptr, NULL);
> > +	ASSERT_EQ(rgn->size, 0);
> > +	ASSERT_EQ(rgn->base, 0);
> > +	ASSERT_EQ(memblock.reserved.total_size, 0);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> >   /*
> >    * A simple test that tries to allocate a small memory region.
> >    * Expect to allocate an aligned region at the beginning of the available
> > @@ -814,6 +848,15 @@ static int alloc_no_memory_check(void)
> >   	return 0;
> >   }
> > +static int alloc_too_large_check(void)
> > +{
> > +	test_print("\tRunning %s...\n", __func__);
> > +	run_top_down(alloc_too_large_generic_check);
> > +	run_bottom_up(alloc_too_large_generic_check);
> > +
> > +	return 0;
> > +}
> > +
> >   int memblock_alloc_checks(void)
> >   {
> >   	const char *func_testing = "memblock_alloc";
> > @@ -836,6 +879,7 @@ int memblock_alloc_checks(void)
> >   	alloc_no_space_check();
> >   	alloc_limited_space_check();
> >   	alloc_no_memory_check();
> > +	alloc_too_large_check();
> >   	dummy_physical_memory_cleanup();
> > diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> > index 66f46f261e66..ef5642d0863b 100644
> > --- a/tools/testing/memblock/tests/basic_api.c
> > +++ b/tools/testing/memblock/tests/basic_api.c
> > @@ -326,6 +326,102 @@ static int memblock_add_twice_check(void)
> >   	return 0;
> >   }
> > +/*
> > + * A test that tries to add two memory blocks that don't overlap with one
> > + * another and then add a third memory block in the space between the first two:
> > + *
> > + *  |        +--------+--------+--------+  |
> > + *  |        |   r1   |   r3   |   r2   |  |
> > + *  +--------+--------+--------+--------+--+
> > + *
> > + * Expect to merge the three entries into one region that starts at r1.base
> > + * and has size of r1.size + r2.size + r3.size. The region counter and total
> > + * size of the available memory are updated.
> > + */
> > +static int memblock_add_between_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t total_size;
> > +
> > +	rgn = &memblock.memory.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = SZ_1G,
> > +		.size = SZ_8K
> > +	};
> > +	struct region r2 = {
> > +		.base = SZ_1G + SZ_16K,
> > +		.size = SZ_8K
> > +	};
> > +	struct region r3 = {
> > +		.base = SZ_1G + SZ_8K,
> > +		.size = SZ_8K
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	total_size = r1.size + r2.size + r3.size;
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_add(r2.base, r2.size);
> > +	memblock_add(r3.base, r3.size);
> > +
> > +	ASSERT_EQ(rgn->base, r1.base);
> > +	ASSERT_EQ(rgn->size, total_size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A simple test that tries to add a memory block r when r extends past
> > + * PHYS_ADDR_MAX:
> > + *
> > + *                               +--------+
> > + *                               |    r   |
> > + *                               +--------+
> > + *  |                            +----+
> > + *  |                            | rgn|
> > + *  +----------------------------+----+
> > + *
> > + * Expect to add a memory block of size PHYS_ADDR_MAX - r.base. Expect the
> > + * total size of available memory and the counter to be updated.
> > + */
> > +static int memblock_add_near_max_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t total_size;
> > +
> > +	rgn = &memblock.memory.regions[0];
> > +
> > +	struct region r = {
> > +		.base = PHYS_ADDR_MAX - SZ_1M,
> > +		.size = SZ_2M
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	total_size = PHYS_ADDR_MAX - r.base;
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r.base, r.size);
> > +
> > +	ASSERT_EQ(rgn->base, r.base);
> > +	ASSERT_EQ(rgn->size, total_size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> >   static int memblock_add_checks(void)
> >   {
> >   	prefix_reset();
> > @@ -339,6 +435,8 @@ static int memblock_add_checks(void)
> >   	memblock_add_overlap_bottom_check();
> >   	memblock_add_within_check();
> >   	memblock_add_twice_check();
> > +	memblock_add_between_check();
> > +	memblock_add_near_max_check();
> >   	prefix_pop();
> > @@ -604,6 +702,102 @@ static int memblock_reserve_twice_check(void)
> >   	return 0;
> >   }
> > +/*
> > + * A test that tries to mark two memory blocks that don't overlap as reserved
> > + * and then reserve a third memory block in the space between the first two:
> > + *
> > + *  |        +--------+--------+--------+  |
> > + *  |        |   r1   |   r3   |   r2   |  |
> > + *  +--------+--------+--------+--------+--+
> > + *
> > + * Expect to merge the three entries into one reserved region that starts at
> > + * r1.base and has size of r1.size + r2.size + r3.size. The region counter and
> > + * total for memblock.reserved are updated.
> > + */
> > +static int memblock_reserve_between_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t total_size;
> > +
> > +	rgn = &memblock.reserved.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = SZ_1G,
> > +		.size = SZ_8K
> > +	};
> > +	struct region r2 = {
> > +		.base = SZ_1G + SZ_16K,
> > +		.size = SZ_8K
> > +	};
> > +	struct region r3 = {
> > +		.base = SZ_1G + SZ_8K,
> > +		.size = SZ_8K
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	total_size = r1.size + r2.size + r3.size;
> > +
> > +	reset_memblock_regions();
> > +	memblock_reserve(r1.base, r1.size);
> > +	memblock_reserve(r2.base, r2.size);
> > +	memblock_reserve(r3.base, r3.size);
> > +
> > +	ASSERT_EQ(rgn->base, r1.base);
> > +	ASSERT_EQ(rgn->size, total_size);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A simple test that tries to reserve a memory block r when r extends past
> > + * PHYS_ADDR_MAX:
> > + *
> > + *                               +--------+
> > + *                               |    r   |
> > + *                               +--------+
> > + *  |                            +----+
> > + *  |                            | rgn|
> > + *  +----------------------------+----+
> > + *
> > + * Expect to reserve a memory block of size PHYS_ADDR_MAX - r.base. Expect the
> > + * total size of reserved memory and the counter to be updated.
> > + */
> > +static int memblock_reserve_near_max_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t total_size;
> > +
> > +	rgn = &memblock.reserved.regions[0];
> > +
> > +	struct region r = {
> > +		.base = PHYS_ADDR_MAX - SZ_1M,
> > +		.size = SZ_2M
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	total_size = PHYS_ADDR_MAX - r.base;
> > +
> > +	reset_memblock_regions();
> > +	memblock_reserve(r.base, r.size);
> > +
> > +	ASSERT_EQ(rgn->base, r.base);
> > +	ASSERT_EQ(rgn->size, total_size);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> >   static int memblock_reserve_checks(void)
> >   {
> >   	prefix_reset();
> > @@ -616,6 +810,8 @@ static int memblock_reserve_checks(void)
> >   	memblock_reserve_overlap_bottom_check();
> >   	memblock_reserve_within_check();
> >   	memblock_reserve_twice_check();
> > +	memblock_reserve_between_check();
> > +	memblock_reserve_near_max_check();
> >   	prefix_pop();
> > @@ -887,6 +1083,155 @@ static int memblock_remove_within_check(void)
> >   	return 0;
> >   }
> > +/*
> > + * A simple test that tries to remove a region r1 from the array of
> > + * available memory regions when r1 is the only available region.
> > + * Expect to add a memory block r1 and then remove r1 so that a dummy
> > + * region is added. The region counter stays the same, and the total size
> > + * is updated.
> > + */
> > +static int memblock_remove_only_region_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +
> > +	rgn = &memblock.memory.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = SZ_2K,
> > +		.size = SZ_4K
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_remove(r1.base, r1.size);
> > +
> > +	ASSERT_EQ(rgn->base, 0);
> > +	ASSERT_EQ(rgn->size, 0);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.total_size, 0);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A simple test that tries remove a region r2 from the array of available
> > + * memory regions when r2 extends past PHYS_ADDR_MAX:
> > + *
> > + *                               +--------+
> > + *                               |   r2   |
> > + *                               +--------+
> > + *  |                        +---+....+
> > + *  |                        |rgn|    |
> > + *  +------------------------+---+----+
> > + *
> > + * Expect that only the portion between PHYS_ADDR_MAX and r2.base is removed.
> > + * Expect the total size of available memory to be updated and the counter to
> > + * not be updated.
> > + */
> > +static int memblock_remove_near_max_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t total_size;
> > +
> > +	rgn = &memblock.memory.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = PHYS_ADDR_MAX - SZ_2M,
> > +		.size = SZ_2M
> > +	};
> > +
> > +	struct region r2 = {
> > +		.base = PHYS_ADDR_MAX - SZ_1M,
> > +		.size = SZ_2M
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	total_size = r1.size - (PHYS_ADDR_MAX - r2.base);
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_remove(r2.base, r2.size);
> > +
> > +	ASSERT_EQ(rgn->base, r1.base);
> > +	ASSERT_EQ(rgn->size, total_size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +	ASSERT_EQ(memblock.memory.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A test that tries to remove a region r3 that overlaps with two existing
> > + * regions r1 and r2:
> > + *
> > + *            +----------------+
> > + *            |       r3       |
> > + *            +----------------+
> > + *  |    +----+.....   ........+--------+
> > + *  |    |    |r1  :   :       |r2      |     |
> > + *  +----+----+----+---+-------+--------+-----+
> > + *
> > + * Expect that only the intersections of r1 with r3 and r2 with r3 are removed
> > + * from the available memory pool. Expect the total size of available memory to
> > + * be updated and the counter to not be updated.
> > + */
> > +static int memblock_remove_overlap_two_check(void)
> > +{
> > +	struct memblock_region *rgn1, *rgn2;
> > +	phys_addr_t r1_size, r2_size, r2_end, r3_end, total_size;
> > +
> > +	rgn1 = &memblock.memory.regions[0];
> > +	rgn2 = &memblock.memory.regions[1];
> > +
> > +	struct region r1 = {
> > +		.base = SZ_16M,
> > +		.size = SZ_32M
> > +	};
> > +	struct region r2 = {
> > +		.base = SZ_64M,
> > +		.size = SZ_64M
> > +	};
> > +	struct region r3 = {
> > +		.base = SZ_32M,
> > +		.size = SZ_64M
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	r2_end = r2.base + r2.size;
> > +	r3_end = r3.base + r3.size;
> > +	r1_size = r3.base - r1.base;
> > +	r2_size = r2_end - r3_end;
> > +	total_size = r1_size + r2_size;
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_add(r2.base, r2.size);
> > +	memblock_remove(r3.base, r3.size);
> > +
> > +	ASSERT_EQ(rgn1->base, r1.base);
> > +	ASSERT_EQ(rgn1->size, r1_size);
> > +
> > +	ASSERT_EQ(rgn2->base, r3_end);
> > +	ASSERT_EQ(rgn2->size, r2_size);
> 
> I think these variable like r1.size and r1_size is a little confused, at
> least the readability is not very clear.
> 
> Maybe modify the r1_size to new_r1_size is more clear, and all other r*_size
> and r*_end.
> 
> It also can use other names, thus make these variable distingush and more
> clear.
> 
I'll update the r*_size names to new_r*_size. I'll leave the r*_end
variables as-is because in this case the end of rgn2 (the region created
from r2) does not change. The end of rgn1 does change, so I would update
the name of r1_end if it was used.

> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 2);
> > +	ASSERT_EQ(memblock.memory.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> >   static int memblock_remove_checks(void)
> >   {
> >   	prefix_reset();
> > @@ -898,6 +1243,9 @@ static int memblock_remove_checks(void)
> >   	memblock_remove_overlap_top_check();
> >   	memblock_remove_overlap_bottom_check();
> >   	memblock_remove_within_check();
> > +	memblock_remove_only_region_check();
> > +	memblock_remove_near_max_check();
> > +	memblock_remove_overlap_two_check();
> >   	prefix_pop();
> > @@ -1163,6 +1511,154 @@ static int memblock_free_within_check(void)
> >   	return 0;
> >   }
> > +/*
> > + * A simple test that tries to free a memory block r1 that was marked
> > + * earlier as reserved when r1 is the only available region.
> > + * Expect to reserve a memory block r1 and then free r1 so that r1 is
> > + * overwritten with a dummy region. The region counter stays the same,
> > + * and the total size is updated.
> > + */
> > +static int memblock_free_only_region_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +
> > +	rgn = &memblock.reserved.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = SZ_2K,
> > +		.size = SZ_4K
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	reset_memblock_regions();
> > +	memblock_reserve(r1.base, r1.size);
> > +	memblock_free((void *)r1.base, r1.size);
> > +
> > +	ASSERT_EQ(rgn->base, 0);
> > +	ASSERT_EQ(rgn->size, 0);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.reserved.total_size, 0);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A simple test that tries free a region r2 when r2 extends past PHYS_ADDR_MAX:
> > + *
> > + *                               +--------+
> > + *                               |   r2   |
> > + *                               +--------+
> > + *  |                        +---+....+
> > + *  |                        |rgn|    |
> > + *  +------------------------+---+----+
> > + *
> > + * Expect that only the portion between PHYS_ADDR_MAX and r2.base is freed.
> > + * Expect the total size of reserved memory to be updated and the counter to
> > + * not be updated.
> > + */
> > +static int memblock_free_near_max_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t total_size;
> > +
> > +	rgn = &memblock.reserved.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = PHYS_ADDR_MAX - SZ_2M,
> > +		.size = SZ_2M
> > +	};
> > +
> > +	struct region r2 = {
> > +		.base = PHYS_ADDR_MAX - SZ_1M,
> > +		.size = SZ_2M
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	total_size = r1.size - (PHYS_ADDR_MAX - r2.base);
> > +
> > +	reset_memblock_regions();
> > +	memblock_reserve(r1.base, r1.size);
> > +	memblock_free((void *)r2.base, r2.size);
> > +
> > +	ASSERT_EQ(rgn->base, r1.base);
> > +	ASSERT_EQ(rgn->size, total_size);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 1);
> > +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A test that tries to free a reserved region r3 that overlaps with two
> > + * existing reserved regions r1 and r2:
> > + *
> > + *            +----------------+
> > + *            |       r3       |
> > + *            +----------------+
> > + *  |    +----+.....   ........+--------+
> > + *  |    |    |r1  :   :       |r2      |     |
> > + *  +----+----+----+---+-------+--------+-----+
> > + *
> > + * Expect that only the intersections of r1 with r3 and r2 with r3 are freed
> > + * from the collection of reserved memory. Expect the total size of reserved
> > + * memory to be updated and the counter to not be updated.
> > + */
> > +static int memblock_free_overlap_two_check(void)
> > +{
> > +	struct memblock_region *rgn1, *rgn2;
> > +	phys_addr_t r1_size, r2_size, r2_end, r3_end, total_size;
> > +
> > +	rgn1 = &memblock.reserved.regions[0];
> > +	rgn2 = &memblock.reserved.regions[1];
> > +
> > +	struct region r1 = {
> > +		.base = SZ_16M,
> > +		.size = SZ_32M
> > +	};
> > +	struct region r2 = {
> > +		.base = SZ_64M,
> > +		.size = SZ_64M
> > +	};
> > +	struct region r3 = {
> > +		.base = SZ_32M,
> > +		.size = SZ_64M
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	r2_end = r2.base + r2.size;
> > +	r3_end = r3.base + r3.size;
> > +	r1_size = r3.base - r1.base;
> > +	r2_size = r2_end - r3_end;
> > +	total_size = r1_size + r2_size;
> 
> Same as above.
> 
> > +
> > +	reset_memblock_regions();
> > +	memblock_reserve(r1.base, r1.size);
> > +	memblock_reserve(r2.base, r2.size);
> > +	memblock_free((void *)r3.base, r3.size);
> > +
> > +	ASSERT_EQ(rgn1->base, r1.base);
> > +	ASSERT_EQ(rgn1->size, r1_size);
> > +
> > +	ASSERT_EQ(rgn2->base, r3_end);
> > +	ASSERT_EQ(rgn2->size, r2_size);
> > +
> > +	ASSERT_EQ(memblock.reserved.cnt, 2);
> > +	ASSERT_EQ(memblock.reserved.total_size, total_size);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> >   static int memblock_free_checks(void)
> >   {
> >   	prefix_reset();
> > @@ -1174,6 +1670,9 @@ static int memblock_free_checks(void)
> >   	memblock_free_overlap_top_check();
> >   	memblock_free_overlap_bottom_check();
> >   	memblock_free_within_check();
> > +	memblock_free_only_region_check();
> > +	memblock_free_near_max_check();
> > +	memblock_free_overlap_two_check();
> 
> Others looks good to me.
> 
> >   	prefix_pop();

Thanks,
Rebecca
