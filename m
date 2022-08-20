Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1617359ACB0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbiHTImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbiHTImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:42:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD68A6DB
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:42:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g16so4771764qkl.11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=R+0WNPBIl0HuqlojWfX7vpKljMWq3/iAmKYaFMjduJA=;
        b=VgitokBh0UfodBVDwP5QzUgmzCc1285YPeTX48nhtaSQwXcQAElSCKFgAvO71CMP5k
         NKKFWRsm/EoeuP3fMv/hD+wvaPLKq6Jdr3fhUdtx8tIfqk/n81mymcC4xhWVVououEJt
         +9YC6Nvj1i5nmU0NmnXycBeh1Apz6pDorh8cCYMwRj8xq2l5CZp68X/yxTFKAAJhrlC4
         Y6cEaGRBmRcdD5udJmvDJK0Vkoh4AHmxwK4OVzL4rbBgDLkNomppT5+bbxgIClatql3s
         qYEP+dsxIwLty2/vjylzy1Ay8wQqEQL+l7BsSvYl5Ms70ep57z3cuGhFjeO0A+lCNHLI
         kz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=R+0WNPBIl0HuqlojWfX7vpKljMWq3/iAmKYaFMjduJA=;
        b=YRU9SFXIQtgJb0NfL4hHazwfq5X0MKx6GyZOx1/UNekxbyZ2uLi87dFOm/1oKqcpKk
         ntqZZtYrF469B3pWl9ss5/b3iLCdNYVK5u4PwoijX+fqxbFcrCEOJWrAtpWhOfqFrZ5F
         Vn9gHX/gAtK7I8KvpeesZbe5T1L7GEP56zHwGnUgqAdkbSmBYytJdWD5iwnwf0GDfoaH
         heRDisqL5JjQSdvCxmb6pPqLoKlFNmaAfG67UxXmJ+ktxqV7ju22HaTpf+7tHCzbSYB9
         rSueqf/QpTLvlhNbiKFan8ZPR0A5xh+wxercEWY/jIoShyHvNLd/tuQigMTKnPsAJzJO
         LRqg==
X-Gm-Message-State: ACgBeo2/kw/Ii0V+VLe/uFgJPqh+dqUYcSZlQaDjhiXmPfy4/zQupmLj
        AfBk2YD5xKZd3eGM/kX0oP4=
X-Google-Smtp-Source: AA6agR46OmbecUXN3wq6g//sjNTs+4oHgLPlMjuuGjTeJa3MDc62NnU4atwOGOGsciQe9e1MjXhzrA==
X-Received: by 2002:a05:620a:134f:b0:6bb:ffc4:d5b3 with SMTP id c15-20020a05620a134f00b006bbffc4d5b3mr66310qkl.327.1660984960728;
        Sat, 20 Aug 2022 01:42:40 -0700 (PDT)
Received: from sophie ([45.134.140.159])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b0031eebfcb369sm4410999qtp.97.2022.08.20.01.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 01:42:39 -0700 (PDT)
Date:   Sat, 20 Aug 2022 01:40:26 -0700
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 8/8] memblock tests: add tests for memblock_trim_memory
Message-ID: <20220820084026.GA13533@sophie>
References: <cover.1660454730.git.remckee0@gmail.com>
 <ebbd1fd2c2a3d223a744adf24b4293a559a7003a.1660454730.git.remckee0@gmail.com>
 <9f6a0b68-6777-dd88-929c-2d4303b28984@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f6a0b68-6777-dd88-929c-2d4303b28984@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:46:11AM +0800, Huang, Shaoqin wrote:
> 
> 
> On 8/14/2022 1:54 PM, Rebecca Mckeever wrote:
> > Add tests for memblock_trim_memory() for the following scenarios:
> > - all regions aligned
> > - one region unalign that is smaller than the alignment
> > - one region unaligned at the base
> > - one region unaligned at the end
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   tools/testing/memblock/tests/basic_api.c | 223 +++++++++++++++++++++++
> >   1 file changed, 223 insertions(+)
> > 
> > diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
> > index d7f008e7a12a..c8bb44f20846 100644
> > --- a/tools/testing/memblock/tests/basic_api.c
> > +++ b/tools/testing/memblock/tests/basic_api.c
> > @@ -8,6 +8,7 @@
> >   #define FUNC_RESERVE					"memblock_reserve"
> >   #define FUNC_REMOVE					"memblock_remove"
> >   #define FUNC_FREE					"memblock_free"
> > +#define FUNC_TRIM					"memblock_trim_memory"
> >   static int memblock_initialization_check(void)
> >   {
> > @@ -1723,6 +1724,227 @@ static int memblock_bottom_up_checks(void)
> >   	return 0;
> >   }
> > +/*
> > + * A test that tries to trim memory when both ends of the memory region are
> > + * aligned. Expect that the memory will not be trimmed. Expect the counter to
> > + * not be updated.
> > + */
> > +static int memblock_trim_memory_aligned_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t alignment = SMP_CACHE_BYTES;
> > +
> > +	rgn = &memblock.memory.regions[0];
> > +
> > +	struct region r = {
> > +		.base = alignment,
> > +		.size = alignment * 4
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r.base, r.size);
> > +	memblock_trim_memory(alignment);
> > +
> > +	ASSERT_EQ(rgn->base, r.base);
> > +	ASSERT_EQ(rgn->size, r.size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A test that tries to trim memory when there are two available regions, r1 and
> > + * r2. Region r1 is aligned on both ends and region r2 is unaligned on one end
> > + * and smaller than the alignment:
> > + *
> > + *                                     alignment
> > + *                                     |--------|
> > + * |        +-----------------+        +------+   |
> > + * |        |        r1       |        |  r2  |   |
> > + * +--------+-----------------+--------+------+---+
> > + *          ^        ^        ^        ^      ^
> > + *          |________|________|________|      |
> > + *                            |               Unaligned address
> > + *                Aligned addresses
> > + *
> > + * Expect that r1 will not be trimmed and r2 will be removed. Expect the
> > + * counter to be updated.
> > + */
> > +static int memblock_trim_memory_too_small_check(void)
> > +{
> > +	struct memblock_region *rgn;
> > +	phys_addr_t alignment = SMP_CACHE_BYTES;
> > +
> > +	rgn = &memblock.memory.regions[0];
> > +
> > +	struct region r1 = {
> > +		.base = alignment,
> > +		.size = alignment * 2
> > +	};
> > +	struct region r2 = {
> > +		.base = alignment * 4,
> > +		.size = alignment - SZ_2
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_add(r2.base, r2.size);
> > +	memblock_trim_memory(alignment);
> > +
> > +	ASSERT_EQ(rgn->base, r1.base);
> > +	ASSERT_EQ(rgn->size, r1.size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 1);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A test that tries to trim memory when there are two available regions, r1 and
> > + * r2. Region r1 is aligned on both ends and region r2 is unaligned at the base
> > + * and aligned at the end:
> > + *
> > + *                               Unaligned address
> > + *                                       |
> > + *                                       v
> > + * |        +-----------------+          +---------------+   |
> > + * |        |        r1       |          |      r2       |   |
> > + * +--------+-----------------+----------+---------------+---+
> > + *          ^        ^        ^        ^        ^        ^
> > + *          |________|________|________|________|________|
> > + *                            |
> > + *                    Aligned addresses
> > + *
> > + * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
> > + * Expect the counter to not be updated.
> > + */
> > +static int memblock_trim_memory_unaligned_base_check(void)
> > +{
> > +	struct memblock_region *rgn1, *rgn2;
> > +	phys_addr_t alignment = SMP_CACHE_BYTES;
> > +	phys_addr_t offset = SZ_2;
> > +	phys_addr_t r2_base, r2_size;
> > +
> > +	rgn1 = &memblock.memory.regions[0];
> > +	rgn2 = &memblock.memory.regions[1];
> > +
> > +	struct region r1 = {
> > +		.base = alignment,
> > +		.size = alignment * 2
> > +	};
> > +	struct region r2 = {
> > +		.base = alignment * 4 + offset,
> > +		.size = alignment * 2 - offset
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	r2_base = r2.base + (alignment - offset);
> > +	r2_size = r2.size - (alignment - offset);
> 
> Also the variable name.
> 
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_add(r2.base, r2.size);
> > +	memblock_trim_memory(alignment);
> > +
> > +	ASSERT_EQ(rgn1->base, r1.base);
> > +	ASSERT_EQ(rgn1->size, r1.size);
> > +
> > +	ASSERT_EQ(rgn2->base, r2_base);
> > +	ASSERT_EQ(rgn2->size, r2_size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 2);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * A test that tries to trim memory when there are two available regions, r1 and
> > + * r2. Region r1 is aligned on both ends and region r2 is aligned at the base
> > + * and unaligned at the end:
> > + *
> > + *                                             Unaligned address
> > + *                                                     |
> > + *                                                     v
> > + * |        +-----------------+        +---------------+   |
> > + * |        |        r1       |        |      r2       |   |
> > + * +--------+-----------------+--------+---------------+---+
> > + *          ^        ^        ^        ^        ^        ^
> > + *          |________|________|________|________|________|
> > + *                            |
> > + *                    Aligned addresses
> > + *
> > + * Expect that r1 will not be trimmed and r2 will be trimmed at the base.
> 								^
> 							at the end.

I forgot to make this change in v2. I will include it in v3.

> > + * Expect the counter to not be updated.
> > + */
> > +static int memblock_trim_memory_unaligned_end_check(void)
> > +{
> > +	struct memblock_region *rgn1, *rgn2;
> > +	phys_addr_t alignment = SMP_CACHE_BYTES;
> > +	phys_addr_t offset = SZ_2;
> > +	phys_addr_t r2_size;
> > +
> > +	rgn1 = &memblock.memory.regions[0];
> > +	rgn2 = &memblock.memory.regions[1];
> > +
> > +	struct region r1 = {
> > +		.base = alignment,
> > +		.size = alignment * 2
> > +	};
> > +	struct region r2 = {
> > +		.base = alignment * 4,
> > +		.size = alignment * 2 - offset
> > +	};
> > +
> > +	PREFIX_PUSH();
> > +
> > +	r2_size = r2.size - (alignment - offset);
> > +
> > +	reset_memblock_regions();
> > +	memblock_add(r1.base, r1.size);
> > +	memblock_add(r2.base, r2.size);
> > +	memblock_trim_memory(alignment);
> > +
> > +	ASSERT_EQ(rgn1->base, r1.base);
> > +	ASSERT_EQ(rgn1->size, r1.size);
> > +
> > +	ASSERT_EQ(rgn2->base, r2.base);
> > +	ASSERT_EQ(rgn2->size, r2_size);
> > +
> > +	ASSERT_EQ(memblock.memory.cnt, 2);
> > +
> > +	test_pass_pop();
> > +
> > +	return 0;
> > +}
> > +
> > +static int memblock_trim_memory_checks(void)
> > +{
> > +	prefix_reset();
> > +	prefix_push(FUNC_TRIM);
> > +	test_print("Running %s tests...\n", FUNC_TRIM);
> > +
> > +	memblock_trim_memory_aligned_check();
> > +	memblock_trim_memory_too_small_check();
> > +	memblock_trim_memory_unaligned_base_check();
> > +	memblock_trim_memory_unaligned_end_check();
> > +
> > +	prefix_pop();
> > +
> > +	return 0;
> > +}
> > +
> >   int memblock_basic_checks(void)
> >   {
> >   	memblock_initialization_check();
> > @@ -1731,6 +1953,7 @@ int memblock_basic_checks(void)
> >   	memblock_remove_checks();
> >   	memblock_free_checks();
> >   	memblock_bottom_up_checks();
> > +	memblock_trim_memory_checks();
> >   	return 0;
> >   }
> 
> Others looks good.

Thanks,
Rebecca
