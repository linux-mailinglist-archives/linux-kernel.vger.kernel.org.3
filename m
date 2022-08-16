Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F059536E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiHPHIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiHPHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:07:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31145124F44
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:39:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f4so5290447qkl.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=zWOSu0AQyXMllOf0K9uNlKMi3D8DQnHUUK1GVgxJZ4M=;
        b=WPwIu1bLc1jBO7d/x5vuzw2Rek/uuqQvmJUTNQEVSnw1++9OlfDgjTZJZXjN4cy9+s
         QNyU/Ptphn+FrPf45STtTViwb+NlPqpSRByd20Viv0RJWaMaqIug09W45UOXaL8sWQNO
         o2rsOBWoMV9yx0HbXeGkapbmhYssK9InMxCu0lnt2du6d+5SjI4tR4kAVFi7d0vUTPB2
         HU2DRdF9QBAGz59xApU+YENHi38xhbLSbWgvJBOqGqeGf+ADtxedEeg8DrcdY/PocYFd
         MI+/Y31IeCqqwG1eYALcZGZ2+KhnsyvV8VCGjs9PsNRn+isaB3WDiVXAJAa/kOpbd9DG
         e/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zWOSu0AQyXMllOf0K9uNlKMi3D8DQnHUUK1GVgxJZ4M=;
        b=PjduDzosVhj1/dNZYaa4xoshEE3MV4UjFzshPJ3YtdceHPq+JGhUo2uNm95qf0ew1e
         7u+ZU/0wX1UNnY1lfXktijzlxAc6nXpsRpnLciq7oF5lx4+uwbq7VbIk+asxqguKPHDl
         I9mIEKu/9IlZrF99KQwMChdzdPfrT5BUA3GyB0j5ocXm3acnmDcRPB0+iFP6+6+Nofeo
         Aoi+9HaHunc7RJnwbBZnRJ3+zv/8owrjZ2N+7L5TOzgS8cNKSr9aFCT3UGtCaGLgxYQb
         Adq6ppNz1EZ5Ixx9MDuDeTAyDdrVThyw3BU00gGq2O20TK7jwZRvTVEUUZks5iEZXgfi
         2Tcw==
X-Gm-Message-State: ACgBeo2cAR++2I6SssLgaQE8Lf2X9QeVdSRvaWRSRNWxhaouNT/29L3d
        GzghdXNCjA2l72MyYSvPJwQg36gU0ozRAg==
X-Google-Smtp-Source: AA6agR6e178nfpwK8qG+OXgwESC+DMixmFzsLVLG3OW6FDmKJ/O9TeuTbFp1QSyYBsXo1xWtbQXVKg==
X-Received: by 2002:a05:620a:1906:b0:6b8:ac92:1f1c with SMTP id bj6-20020a05620a190600b006b8ac921f1cmr13475286qkb.633.1660617593178;
        Mon, 15 Aug 2022 19:39:53 -0700 (PDT)
Received: from sophie ([185.156.46.184])
        by smtp.gmail.com with ESMTPSA id j17-20020ac86651000000b003436103df40sm9183739qtp.8.2022.08.15.19.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 19:39:52 -0700 (PDT)
Date:   Mon, 15 Aug 2022 21:39:51 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/8] memblock tests: add labels to verbose output for
 generic alloc tests
Message-ID: <20220816023951.GB3590@sophie>
References: <cover.1660454730.git.remckee0@gmail.com>
 <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
 <63e9e964-021e-e141-00f8-afd7feb774fb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e9e964-021e-e141-00f8-afd7feb774fb@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 05:15:47PM +0800, Huang, Shaoqin wrote:
> I found original some of test function has the prefix `top_down` and
> `bottom_up`, and some of test function didn't have the prefix.
> 
> In this patch, it just modified these functions which didn't have the prefix
> `top_down` or `bottom_up`, and now there are two style about these test
> functions in the code.
> 
> One is:
> 	run_top_down(alloc_in_between_generic_check);
> 	run_bottom_up(alloc_in_between_generic_check);
> 
> Another one is:
> 	memblock_set_bottom_up(false);
> 	alloc_top_down_before_check();
> 	memblock_set_bottom_up(true);
> 	alloc_bottom_up_before_check();
> 
> Thus there gonna be two output style, here is an example:
> ok 89 : memblock_alloc_from: top-down: alloc_from_simple_generic_check:
> passed
> ok 90 : memblock_alloc_from: bottom-up: alloc_from_simple_generic_check:
> passed
> 
> ok 99 : memblock_alloc_try_nid: alloc_try_nid_top_down_simple_check: passed
> ok 100 : memblock_alloc_try_nid: alloc_try_nid_bottom_up_simple_check:
> passed
> 
> It may make confuse if one is printed between the colon and one is inside
> the function name.
> 
> So maybe make the style consistent is more make sense. And I think this can
> be done by modify all these function name which with `top_down` and
> `bottom_up` inside, and replace them with your new run_top_down() and
> run_bottom_up() functions.
> 
So you're saying use run_top_down() and run_bottom_up() even for functions
with `top_down` and `bottom_up` in the name, but don't change the names?

> On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> > Generic tests for memblock_alloc*() functions do not use separate
> > functions for testing top-down and bottom-up allocation directions.
> > Therefore, the function name that is displayed in the verbose testing
> > output does not include the allocation direction.
> > 
> > Add an additional prefix when running generic tests for
> > memblock_alloc*() functions that indicates which allocation direction is
> > set. The prefix will be displayed when the tests are run in verbose mode.
> > 
> > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > ---
> >   tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
> >   .../memblock/tests/alloc_helpers_api.c        | 12 +++----
> >   tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
> >   tools/testing/memblock/tests/common.h         | 16 +++++++++
> >   4 files changed, 44 insertions(+), 56 deletions(-)
> > 
> > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > index 71c89cb9b2a8..73c2c43e702a 100644
> > --- a/tools/testing/memblock/tests/alloc_api.c
> > +++ b/tools/testing/memblock/tests/alloc_api.c
> > @@ -752,10 +752,8 @@ static int alloc_after_check(void)
> >   static int alloc_in_between_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_in_between_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_in_between_generic_check();
> > +	run_top_down(alloc_in_between_generic_check);
> > +	run_bottom_up(alloc_in_between_generic_check);
> >   	return 0;
> >   }
> > @@ -774,10 +772,8 @@ static int alloc_second_fit_check(void)
> >   static int alloc_small_gaps_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_small_gaps_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_small_gaps_generic_check();
> > +	run_top_down(alloc_small_gaps_generic_check);
> > +	run_bottom_up(alloc_small_gaps_generic_check);
> >   	return 0;
> >   }
> > @@ -785,10 +781,8 @@ static int alloc_small_gaps_check(void)
> >   static int alloc_all_reserved_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_all_reserved_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_all_reserved_generic_check();
> > +	run_top_down(alloc_all_reserved_generic_check);
> > +	run_bottom_up(alloc_all_reserved_generic_check);
> >   	return 0;
> >   }
> > @@ -796,10 +790,8 @@ static int alloc_all_reserved_check(void)
> >   static int alloc_no_space_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_no_space_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_no_space_generic_check();
> > +	run_top_down(alloc_no_space_generic_check);
> > +	run_bottom_up(alloc_no_space_generic_check);
> >   	return 0;
> >   }
> > @@ -807,10 +799,8 @@ static int alloc_no_space_check(void)
> >   static int alloc_limited_space_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_limited_space_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_limited_space_generic_check();
> > +	run_top_down(alloc_limited_space_generic_check);
> > +	run_bottom_up(alloc_limited_space_generic_check);
> >   	return 0;
> >   }
> > @@ -818,10 +808,8 @@ static int alloc_limited_space_check(void)
> >   static int alloc_no_memory_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_no_memory_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_no_memory_generic_check();
> > +	run_top_down(alloc_no_memory_generic_check);
> > +	run_bottom_up(alloc_no_memory_generic_check);
> >   	return 0;
> >   }
> > diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> > index 796527cf3bd2..1ccf02639ad6 100644
> > --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> > +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> > @@ -357,10 +357,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
> >   static int alloc_from_simple_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_from_simple_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_from_simple_generic_check();
> > +	run_top_down(alloc_from_simple_generic_check);
> > +	run_bottom_up(alloc_from_simple_generic_check);
> >   	return 0;
> >   }
> > @@ -368,10 +366,8 @@ static int alloc_from_simple_check(void)
> >   static int alloc_from_misaligned_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_from_misaligned_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_from_misaligned_generic_check();
> > +	run_top_down(alloc_from_misaligned_generic_check);
> > +	run_bottom_up(alloc_from_misaligned_generic_check);
> >   	return 0;
> >   }
> > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > index 71b7beb35526..82fa8ea36320 100644
> > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> > @@ -1142,10 +1142,8 @@ static int alloc_try_nid_cap_min_check(void)
> >   static int alloc_try_nid_min_reserved_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_try_nid_min_reserved_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_try_nid_min_reserved_generic_check();
> > +	run_top_down(alloc_try_nid_min_reserved_generic_check);
> > +	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
> >   	return 0;
> >   }
> > @@ -1153,10 +1151,8 @@ static int alloc_try_nid_min_reserved_check(void)
> >   static int alloc_try_nid_max_reserved_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_try_nid_max_reserved_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_try_nid_max_reserved_generic_check();
> > +	run_top_down(alloc_try_nid_max_reserved_generic_check);
> > +	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
> >   	return 0;
> >   }
> > @@ -1164,10 +1160,8 @@ static int alloc_try_nid_max_reserved_check(void)
> >   static int alloc_try_nid_exact_address_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_try_nid_exact_address_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_try_nid_exact_address_generic_check();
> > +	run_top_down(alloc_try_nid_exact_address_generic_check);
> > +	run_bottom_up(alloc_try_nid_exact_address_generic_check);
> >   	return 0;
> >   }
> > @@ -1175,10 +1169,8 @@ static int alloc_try_nid_exact_address_check(void)
> >   static int alloc_try_nid_reserved_full_merge_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_try_nid_reserved_full_merge_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_try_nid_reserved_full_merge_generic_check();
> > +	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
> > +	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
> >   	return 0;
> >   }
> > @@ -1186,10 +1178,8 @@ static int alloc_try_nid_reserved_full_merge_check(void)
> >   static int alloc_try_nid_reserved_all_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_try_nid_reserved_all_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_try_nid_reserved_all_generic_check();
> > +	run_top_down(alloc_try_nid_reserved_all_generic_check);
> > +	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
> >   	return 0;
> >   }
> > @@ -1197,10 +1187,8 @@ static int alloc_try_nid_reserved_all_check(void)
> >   static int alloc_try_nid_low_max_check(void)
> >   {
> >   	test_print("\tRunning %s...\n", __func__);
> > -	memblock_set_bottom_up(false);
> > -	alloc_try_nid_low_max_generic_check();
> > -	memblock_set_bottom_up(true);
> > -	alloc_try_nid_low_max_generic_check();
> > +	run_top_down(alloc_try_nid_low_max_generic_check);
> > +	run_bottom_up(alloc_try_nid_low_max_generic_check);
> >   	return 0;
> >   }
> > diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> > index 7a16a7dc8f2c..e0dd5b410099 100644
> > --- a/tools/testing/memblock/tests/common.h
> > +++ b/tools/testing/memblock/tests/common.h
> > @@ -101,4 +101,20 @@ static inline void test_pass_pop(void)
> >   	prefix_pop();
> >   }
> > +static inline void run_top_down(int (*func)())
> > +{
> > +	memblock_set_bottom_up(false);
> > +	prefix_push("top-down");
> > +	func();
> > +	prefix_pop();
> > +}
> > +
> > +static inline void run_bottom_up(int (*func)())
> > +{
> > +	memblock_set_bottom_up(true);
> > +	prefix_push("bottom-up");
> > +	func();
> > +	prefix_pop();
> > +}
> > +
> >   #endif
