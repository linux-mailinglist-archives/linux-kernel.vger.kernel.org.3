Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8958975A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiHDFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiHDFel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:34:41 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F33E74D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:34:40 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-10cf9f5b500so23196619fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eqO2GtYLnN7H8loOSrIFFhgBlZEWlA8JNy12iUGG61Q=;
        b=RZjZyF5xtsj0J3nCLe9sOFJt1ljNSoVHUxDn259NuaKelwtuaZ+c6PVRsJgiGhWfVr
         3GglKu8mYbVF3PqI5Mpfx8aimJgq0Yht5I6ucsiZ+lxUeekSszKKBpVZgFk9evQ3bktW
         5QFsC7JBfjYD3s/QZmKlW4r3MwRwOtSRcqj4U1ixw/2FaV3Cb1x4+B8oIMto8DiVxVNd
         E0cN4Y5P3U1p0/F/Tf8sqG+3LIRGTftPxBDEkElrWztgdn+a/BUmftAb+0zLS8IaMFXF
         zfLRi4DisS+NqeUdWn5+kseUYhh9c/PsVomP8YEuWUdWwe0npi/MzvVwUgq+N+V3a7t3
         860g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eqO2GtYLnN7H8loOSrIFFhgBlZEWlA8JNy12iUGG61Q=;
        b=3XhddSauQYc1sr6JkrdnmUXsjQLKmBwt4EQGazqfXXdF51Juyyqfwd+ck/cxRXBuL/
         QblseyUtfSGenJ0gljJ2pbB0gAIITjw52WqbTW2Z0jdGYZUSnhLjM7vzaSAcgg9ntdCU
         IRIk6kr7HsWR7fB58/4XlnQLf92NZplKJqLZUz9bekcIZR5pUXSzuvCRJuWFqnjazPHn
         cqH0ZKs7JUi8PfOxesr1DBBrir0YEVyont3WvIHVerIYNoHR4Tf2/yZ8M2LgalfQDJR8
         L8KBd2+3s7ORFdgymam35gZCSYvnI2Og9BSkCuWi06QGGz5azCZvt2zdM+OI0ItzFFCs
         2qyA==
X-Gm-Message-State: ACgBeo0q+86zpukv5bspl1tWdEh7e8WGx9hw1vCmxnMmjKRe6pMsY4zF
        GMNjB6rpa82XDop8Pd9JHIpsoRRUFkg=
X-Google-Smtp-Source: AA6agR6gxBIJ8ej0i+PQkYdQATuG4G3BJiABwM5HLlbKJrD2l+1XykpH/W056KEDm561Fnh/2tF0Dw==
X-Received: by 2002:a05:6870:41c3:b0:10c:529c:3844 with SMTP id z3-20020a05687041c300b0010c529c3844mr61434oac.0.1659591279368;
        Wed, 03 Aug 2022 22:34:39 -0700 (PDT)
Received: from bertie (072-190-140-095.res.spectrum.com. [72.190.140.95])
        by smtp.gmail.com with ESMTPSA id r14-20020a056830120e00b0061c3246bd42sm4491510otp.44.2022.08.03.22.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:34:39 -0700 (PDT)
Date:   Thu, 4 Aug 2022 00:34:38 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memblock test: Add test to memblock_add() 129th region
Message-ID: <YutabjAN+hJwUaoF@bertie>
References: <20220801064901.980558-1-shaoqin.huang@intel.com>
 <YujPDHym0Ly8sxqP@kernel.org>
 <4c8def19-650e-7bc3-a581-3ce2b7c0b3cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c8def19-650e-7bc3-a581-3ce2b7c0b3cf@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:38:37PM +0800, Huang, Shaoqin wrote:
> 
> 
> On 8/2/2022 3:15 PM, Mike Rapoport wrote:
> > On Mon, Aug 01, 2022 at 02:48:36PM +0800, shaoqin.huang@intel.com wrote:
> > > From: Shaoqin Huang <shaoqin.huang@intel.com>
> > > 
> > > Add 129th region into the memblock, and this will trigger the
> > > memblock_double_array() function, this needs valid memory regions. So
> > > using dummy_physical_memory_init() to allocate some valid memory, when
> > > memblock_double_array() choose a new memory region from memory.regions,
> > > it will always choose a valid memory region if we add all valid memory
> > > region, so the memblock_double_array() must success.
> > > 
> > > Another thing should be done is to restore the memory.regions after
> > > memblock_double_array(), due to now the memory.regions is pointing to a
> > > memory region allocated by dummy_physical_memory_init(). And it will
> > > affect the subsequent tests if we don't restore the memory region. So
> > > Simply record the origin region, and restore it after the test.
> > > 
> > > Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> > > ---
> > > Changelog:
> > > ----------
> > > v2:
> > >    - Use ASSERT_EQ() to replace assert().
> > >    - Not to expose memory_block, and add a function get_memory_block_base() to
> > >    get the memory_block.base.
> > >    - Add two functions for common usage, and now it has been used by this patch
> > >    to allocate many valid memory regions and free them at the end.
> > > 
> > >   tools/testing/memblock/tests/basic_api.c | 54 ++++++++++++++++++++++++
> > >   tools/testing/memblock/tests/common.c    | 38 +++++++++++++++--
> > >   tools/testing/memblock/tests/common.h    |  6 +++
> > >   3 files changed, 95 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> > > index 66f46f261e66..46948d5a975e 100644
> > > --- a/tools/testing/memblock/tests/basic_api.c
> > > +++ b/tools/testing/memblock/tests/basic_api.c
> > > @@ -326,6 +326,59 @@ static int memblock_add_twice_check(void)
> > >   	return 0;
> > >   }
> > > +static int memblock_add_many_check(void)
> > > +{
> > > +	void *base[INIT_MEMBLOCK_REGIONS + 1];
> > > +	void *orig_region;
> > > +	struct region r = {
> > > +		.base = SZ_16K,
> > > +		.size = MEM_SIZE,
> > > +	};
> > > +
> > > +	PREFIX_PUSH();
> > > +
> > > +	reset_memblock_regions();
> > > +	memblock_allow_resize();
> > > +
> > > +	dummy_physical_memory_many_init(base, INIT_MEMBLOCK_REGIONS);
> > 
> > Why do we need this?
> 
> I want to memblock_add() 128 regions that every region has a valid
> "physical" memory. So it can make sure the memblock_double_array() success
> when add a 129-th region.
> 

> In the last patch, I didn't put this function here, I just memblock_add()
> 128 region at here. And after I think if we can encapsulate it to a
> function, later it can be used to init some valid memory regions into the
> memblock.
> 
> And if no others may be use this functions, the function is not needed.
> 
> > 
> > dummy_physical_memory_init() allocates the "physical" memory, so to trigger
> > memblock_double_array() it's enough to memblock_add() 129 non-intersecting
> > chunks in the range [memory_block.base, memory_block.base + MEM_SIZE].
> > If MEM_SIZE of 16k won't be enough, it can be increased.
> > 
> 
> Yes. And now MEM_SIZE of 16k is enough, no need to increase it now.
> 
I experimented with only calling dummy_physical_memory_init() once at the
beginning and then adding all 129 regions into the memory allocated with
that call. I found that it only works if at least one of the regions is
SZ_16K or larger. I think this is because memblock_double_array() needs to
find a contiguous region large enough to hold
PAGE_ALIGN(new regions array). If all the regions are SZ_8K or smaller, I
get the error message:

memblock: Failed to double memory array from 128 to 256 entries !

What I did was increase MEM_SIZE to SZ_32K, then memblock_add a SZ_16K
region after calling dummy_physical_memory_init() once. Then, I made the
remaining regions SZ_16, with a SZ_16 gap between each region.

> > > +
> > > +	orig_region = memblock.memory.regions;
> > > +
> > > +	/* This adds the 129 memory_region, and makes it double array. */
> > > +	dummy_physical_memory_init();
> > > +	append_memblock();
> > > +	base[INIT_MEMBLOCK_REGIONS] = get_memory_block_base();
> > > +
> > > +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 1);
> > > +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
> > > +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> > > +
> > > +	/* The base is very small, so it should be insert to the first region. */
> > > +	memblock_add(r.base, r.size);
> > > +	ASSERT_EQ(memblock.memory.regions[0].base, r.base);
> > > +	ASSERT_EQ(memblock.memory.regions[0].size, r.size);
> > > +
> > > +	ASSERT_EQ(memblock.memory.cnt, INIT_MEMBLOCK_REGIONS + 2);
> > > +	ASSERT_EQ(memblock.memory.total_size, (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
> > > +	ASSERT_EQ(memblock.memory.max, INIT_MEMBLOCK_REGIONS * 2);
> > > +
> > > +	/* Free these allocated memory. */
> > > +	dummy_physical_memory_many_cleanup(base, INIT_MEMBLOCK_REGIONS + 1);
> > > +
> > > +	/*
> > > +	 * The current memory.regions is occupying a range of memory that
> > > +	 * allocated from dummy_physical_memory_init(). After free the memory,
> > > +	 * we must not use it. So restore the origin memory region to make sure
> > > +	 * the tests can run as normal and not affected by the double array.
> > > +	 */
> > > +	memblock.memory.regions = orig_region;
> > > +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
> > > +
> > > +	test_pass_pop();
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int memblock_add_checks(void)
> > >   {
> > >   	prefix_reset();
> > > @@ -339,6 +392,7 @@ static int memblock_add_checks(void)
> > >   	memblock_add_overlap_bottom_check();
> > >   	memblock_add_within_check();
> > >   	memblock_add_twice_check();
> > > +	memblock_add_many_check();
> > >   	prefix_pop();
> > > diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> > > index e43b2676af81..960b3ce07696 100644
> > > --- a/tools/testing/memblock/tests/common.c
> > > +++ b/tools/testing/memblock/tests/common.c
> > > @@ -5,8 +5,6 @@
> > >   #include <linux/memory_hotplug.h>
> > >   #include <linux/build_bug.h>
> > > -#define INIT_MEMBLOCK_REGIONS			128
> > > -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> > >   #define PREFIXES_MAX				15
> > >   #define DELIM					": "
> > > @@ -58,10 +56,20 @@ void reset_memblock_attributes(void)
> > >   	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
> > >   }
> > > +void *get_memory_block_base(void)
> > > +{
> > > +	return memory_block.base;
> > > +}
> > > +
> > > +void append_memblock(void)
> > > +{
> > > +	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> > > +}
> > > +
> > >   void setup_memblock(void)
> > >   {
> > >   	reset_memblock_regions();
> > > -	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> > > +	append_memblock();
> > >   }
> > >   void dummy_physical_memory_init(void)
> > > @@ -75,6 +83,30 @@ void dummy_physical_memory_cleanup(void)
> > >   	free(memory_block.base);
> > >   }
> > > +void dummy_physical_memory_many_init(void *base[], int cnt)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < cnt; i++) {
> > > +		dummy_physical_memory_init();
> > > +		append_memblock();
> > > +		base[i] = memory_block.base;
> > > +
> > > +		ASSERT_EQ(memblock.memory.cnt, i + 1);
> > > +		ASSERT_EQ(memblock.memory.total_size, (i + 1) * MEM_SIZE);
> > > +	}
> > > +}
> > > +
> > > +void dummy_physical_memory_many_cleanup(void *base[], int cnt)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < cnt; i++) {
> > > +		memory_block.base = base[i];
> > > +		dummy_physical_memory_cleanup();
> > > +	}
> > > +}
> > > +
> > >   static void usage(const char *prog)
> > >   {
> > >   	BUILD_BUG_ON(ARRAY_SIZE(help_opts) != ARRAY_SIZE(long_opts) - 1);
> > > diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> > > index 3e7f23d341d7..848900aa8db6 100644
> > > --- a/tools/testing/memblock/tests/common.h
> > > +++ b/tools/testing/memblock/tests/common.h
> > > @@ -11,6 +11,8 @@
> > >   #include <../selftests/kselftest.h>
> > >   #define MEM_SIZE SZ_16K
> > > +#define INIT_MEMBLOCK_REGIONS			128
> > > +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
> > >   /**
> > >    * ASSERT_EQ():
> > > @@ -68,8 +70,12 @@ struct region {
> > >   void reset_memblock_regions(void);
> > >   void reset_memblock_attributes(void);
> > >   void setup_memblock(void);
> > > +void append_memblock(void);
> > > +void *get_memory_block_base(void);
> > >   void dummy_physical_memory_init(void);
> > >   void dummy_physical_memory_cleanup(void);
> > > +void dummy_physical_memory_many_init(void *base[], int cnt);
> > > +void dummy_physical_memory_many_cleanup(void *base[], int cnt);
> > >   void parse_args(int argc, char **argv);
> > >   void test_fail(void);
> > > -- 
> > > 2.30.2
> > > 
> > > 
> > 
Thanks,
Rebecca
