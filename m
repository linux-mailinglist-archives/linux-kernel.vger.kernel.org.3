Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333A5858AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiG3FHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 01:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiG3FHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 01:07:33 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F3743E0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:07:32 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h188so7375664oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Y1zeaWamUJkQPoqw57iMcsEyqQJJUZsg7i2xpZ05Ko0=;
        b=fNJI/cHBkBa3pX6EstDSm75+7LcYSyAkeZ43H3UfyXfRaOOsD0+RO7H8lSpoRRxNM7
         6ox9cfohPCnm+f8KSRtrpKPZtrnLTies4I35P6DxwW2oZBIORY75RcmjqynGyZWOPy00
         NRJFZN3zgjXOzguJZ7c0LdLUjb4pWC6671k0d7njClU3yBzLgJ9pgfSYnYdwbQj/Pi36
         81k/4pT0xpEpepR5/OIgMbRhURhDRM9n84ZglXyjc+Np/6Gtz07OlcPng/YO1Sz1EGs3
         Y12XfyHqtrmQi1YGm4k67FiGWQzNDUjTV9zecqudrI3M7UNwrCv1AobgCpbszHnIwyWQ
         MexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Y1zeaWamUJkQPoqw57iMcsEyqQJJUZsg7i2xpZ05Ko0=;
        b=zObFO059w1szowOYLTbtje3lgTS2kX2LQkmmTZpp5I547LV5sYzcB44iJmUSoFujob
         rZNX9ZVcHnNd43KL1N32YC8b++og7epFxRgniiB1j/5rrNLXMhtiAJnzqwiydV7ry1OL
         1Pl0d1PBSP/EzEZWPK+HJ0R9I7u6pKfl8Ave5yQgk9mlRIqzf6dJ7Y83aIPmAmRBQRco
         o38PaUlW+jjDCD//Y1vvXVVng27U9z9EUoSGiiTU+5pKa7j8X1PUmh95FFNULdW5wliW
         k5Ny0kXFKRKqaihhfvfpcUXygdsyp9ejJeTUozLFtWKy3AOsH7nU2Q6sIOo8INNQ7dgS
         ya8A==
X-Gm-Message-State: AJIora/Pinqk5UrcYg9bwrKcDSx9oJmxpRO29IlwUvb8hRBLfHDPnssR
        zl2OCa6s08ZWGaz46Y41jrNLtPC4cWs=
X-Google-Smtp-Source: AGRyM1u46X8hqHHK4PcTNwz7kQxGLuDK/eah3EYPS46AsZGH92cjft0urTN3kUuKEpSWLiYHd5M97Q==
X-Received: by 2002:a05:6808:7cb:b0:33a:84f4:a930 with SMTP id f11-20020a05680807cb00b0033a84f4a930mr3163630oij.295.1659157651567;
        Fri, 29 Jul 2022 22:07:31 -0700 (PDT)
Received: from bertie (072-190-140-095.res.spectrum.com. [72.190.140.95])
        by smtp.gmail.com with ESMTPSA id bb7-20020a056820160700b00435f5744be3sm1596818oob.9.2022.07.29.22.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 22:07:31 -0700 (PDT)
Date:   Sat, 30 Jul 2022 00:07:29 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     shaoqin.huang@intel.com
Cc:     rppt@kernel.org, Karolina Drobnik <karolinadrobnik@gmail.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock test: Add test to memblock_add() 129th region
Message-ID: <YuS8kTgCBtdGy9XL@bertie>
References: <20220728190051.237437-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728190051.237437-1-shaoqin.huang@intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 01:00:47PM -0600, shaoqin.huang@intel.com wrote:
> From: Shaoqin Huang <shaoqin.huang@intel.com>
> 
I tested this out, and everything is working well. I have a couple of
suggestions for improvements.

> Add 129th region into the memblock, and this will trigger the
> memblock_double_array() function, this needs valid memory regions. So
> using dummy_physical_memory_init() to allocate some valid memory, when
> memblock_double_array() choose a new memory region from memory.regions,
> it will always choose a valid memory region if we add all valid memory
> region, so the memblock_double_array() must success.
> 
> Another thing should be done is to restore the memory.regions after
> memblock_double_array(), due to now the memory.regions is pointing to a
> memory region allocated by dummy_physical_memory_init(). And it will
> affect the subsequent tests if we don't restore the memory region. So
> Simply record the origin region, and restore it after the test.
> 
> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
> ---
>  tools/testing/memblock/tests/basic_api.c | 65 ++++++++++++++++++++++++
>  tools/testing/memblock/tests/common.c    |  9 ++--
>  tools/testing/memblock/tests/common.h    |  5 ++
>  3 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> index 66f46f261e66..ded93f97d98e 100644
> --- a/tools/testing/memblock/tests/basic_api.c
> +++ b/tools/testing/memblock/tests/basic_api.c
> @@ -326,6 +326,70 @@ static int memblock_add_twice_check(void)
>  	return 0;
>  }
>  
> +static int memblock_add_many_check(void)
> +{
> +	int i;
> +	void *base[INIT_MEMBLOCK_REGIONS + 1];
> +	void *orig_region;
> +	struct region r = {
> +		.base = SZ_16K,
> +		.size = MEM_SIZE,
> +	};
> +
> +	PREFIX_PUSH();
> +
> +	reset_memblock_regions();
> +	memblock_allow_resize();
> +
> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS; i++) {
> +		dummy_physical_memory_init();
> +		append_memblock();
> +		base[i] = memory_block.base;
> +
> +		assert(memblock.memory.cnt == i + 1);

Maybe you could call the ASSERT_EQ() macro here instead of directly
calling assert. That way, if the test fails in verbose mode, it will print
out the test prefix. This applies to the other asserts as well.

> +		assert(memblock.memory.total_size == (i + 1) * MEM_SIZE);
> +	}
> +
> +	orig_region = memblock.memory.regions;
> +
> +	/* This adds the 129 memory_region, and makes it double array. */
> +	dummy_physical_memory_init();
> +	append_memblock();
> +	base[i] = memory_block.base;
> +
> +	assert(memblock.memory.cnt == INIT_MEMBLOCK_REGIONS + 1);
> +	assert(memblock.memory.total_size == (INIT_MEMBLOCK_REGIONS + 1) * MEM_SIZE);
> +	assert(memblock.memory.max == INIT_MEMBLOCK_REGIONS * 2);
> +
> +	/* The base is very small, so it should be insert to the first region. */
> +	memblock_add(r.base, r.size);
> +	assert(memblock.memory.regions[0].base == r.base);
> +	assert(memblock.memory.regions[0].size == r.size);
> +
> +	assert(memblock.memory.cnt == INIT_MEMBLOCK_REGIONS + 2);
> +	assert(memblock.memory.total_size == (INIT_MEMBLOCK_REGIONS + 2) * MEM_SIZE);
> +	assert(memblock.memory.max == INIT_MEMBLOCK_REGIONS * 2);
> +
> +	/* Free these allocated memory. */
> +	for (i = 0; i < INIT_MEMBLOCK_REGIONS + 1; i++) {
> +		memory_block.base = base[i];
> +		dummy_physical_memory_cleanup();
> +	}
> +
This could be moved to a function in common.c since it may be useful if
we write similar tests later. For example:

void dummy_physical_memory_many_cleanup(void *base[], int cnt)
{
	for (int i = 0; i < cnt; i++) {
		memory_block.base = base[i];
		dummy_physical_memory_cleanup();
	}
}

Since the other usages of memory_block in basic_api.c do not need to
modify it, you could then replace those usages with a call to a function
from common.c like:

void *get_memory_block_base(void)
{
	return memory_block.base;
}

to avoid adding memory_block to common.h and changing to non-static in
common.c.

> +	/*
> +	 * The current memory.regions is occupying a range of memory that
> +	 * allocated from dummy_physical_memory_init(). After free the memory,
> +	 * we must not use it. So restore the origin memory region to make sure
> +	 * the tests can run as normal and not affected by the double array.
> +	 */
> +	memblock.memory.regions = orig_region;
> +	memblock.memory.cnt = INIT_MEMBLOCK_REGIONS;
> +
> +	test_pass_pop();
> +
> +	return 0;
> +}
> +
>  static int memblock_add_checks(void)
>  {
>  	prefix_reset();
> @@ -339,6 +403,7 @@ static int memblock_add_checks(void)
>  	memblock_add_overlap_bottom_check();
>  	memblock_add_within_check();
>  	memblock_add_twice_check();
> +	memblock_add_many_check();
>  
>  	prefix_pop();
>  
> diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
> index e43b2676af81..4741e860123a 100644
> --- a/tools/testing/memblock/tests/common.c
> +++ b/tools/testing/memblock/tests/common.c
> @@ -5,12 +5,10 @@
>  #include <linux/memory_hotplug.h>
>  #include <linux/build_bug.h>
>  
> -#define INIT_MEMBLOCK_REGIONS			128
> -#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>  #define PREFIXES_MAX				15
>  #define DELIM					": "
>  
> -static struct test_memory memory_block;
> +struct test_memory memory_block;
>  static const char __maybe_unused *prefixes[PREFIXES_MAX];
>  static int __maybe_unused nr_prefixes;
>  
> @@ -64,6 +62,11 @@ void setup_memblock(void)
>  	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
>  }
>  
> +void append_memblock(void)
> +{
> +	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
> +}
> +
>  void dummy_physical_memory_init(void)
>  {
>  	memory_block.base = malloc(MEM_SIZE);
> diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> index 3e7f23d341d7..8946a3b77f24 100644
> --- a/tools/testing/memblock/tests/common.h
> +++ b/tools/testing/memblock/tests/common.h
> @@ -11,6 +11,8 @@
>  #include <../selftests/kselftest.h>
>  
>  #define MEM_SIZE SZ_16K
> +#define INIT_MEMBLOCK_REGIONS			128
> +#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
>  
>  /**
>   * ASSERT_EQ():
> @@ -65,9 +67,12 @@ struct region {
>  	phys_addr_t size;
>  };
>  
> +extern struct test_memory memory_block;
> +
>  void reset_memblock_regions(void);
>  void reset_memblock_attributes(void);
>  void setup_memblock(void);
> +void append_memblock(void);
>  void dummy_physical_memory_init(void);
>  void dummy_physical_memory_cleanup(void);
>  void parse_args(int argc, char **argv);
> -- 
> 2.30.2
> 
Thanks,
Rebecca
