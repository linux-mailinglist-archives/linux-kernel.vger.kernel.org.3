Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF6599450
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 07:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245695AbiHSFGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 01:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243443AbiHSFGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 01:06:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1935CAC7B
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:06:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h22so2645599qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=yI/daoJZy1aUYv6PMGwWKM8GoZWc7pMTccjjkYejaw4=;
        b=ntXvLUAxrfdiUAbLWhidU4I2VdQS6twqmPFlQ4CKnhOenumibQ4ekc/58Zy+gb6SP6
         zkCUNuTdWSMXOo7UsQ1SFt2hg0oxzJkXNlbRsKspf/PfCSAz60UA1nXg9MBs4PPdUojv
         lL5Lwr3JRg5mZHgaClbebbGdiivDRQR8F210644SAG5cNMpqOgNAXK+K39Gq6lvxVrDb
         HQ8na+dDfaWLqbcOd0CZhItqY6cB1WDap3a3ZNEeRFyLi3tIQyg/A6ttRlTq3R5o+0vj
         4Mkh+uZa/X9sq9JdDIs4knX06H217YOs5kXnWwqEBWKpXZy6MpP4ZZ90prgVwJe3BSnY
         utKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=yI/daoJZy1aUYv6PMGwWKM8GoZWc7pMTccjjkYejaw4=;
        b=5AqGCpw5yGTzQd9ygOCfXWEoa2Vlng/UTCMTQbaon/EszXVJHtGyJzsxatLbhdEVO7
         FhsaANeiv4g9zBEDHpyMwrll10DyhvvGCJrUcxhbt5ZERGdA8MZw6dG62wI+2qqZmDTh
         YuoImdRNmAi0H5j/1jF1JUJGI71XwDWuWTYEANp12j1T6hGQ/eXU5CCRbMB5Rz0xHnEO
         6nzl/CzAZh5GNUsYp3gB9AWM1KNbTTkCZmqAHXmWqlO4SJaHTbGBEbd3Ek+jm2KKNAFW
         x1iRIWGJmEPDjO88ms7FhAawMgt7gI1n5q2fEag5zcCaGa00iWiC1DpF+DDfgmHTHTq9
         n7zg==
X-Gm-Message-State: ACgBeo0J+UkqPKB+rxnOO4Mz3u5PCyETb/z+kh5u6GtztFK3Ev5IAOoN
        +BGqqGIaF9smUFX2u0tVbNM=
X-Google-Smtp-Source: AA6agR6kziPNsPanO4R5DNL91dGfaSWmyNBPu2AWC92jEAptFpPOnapqUlo13MJfk/2dB6w0WLSSxg==
X-Received: by 2002:ac8:5e10:0:b0:344:6932:6c11 with SMTP id h16-20020ac85e10000000b0034469326c11mr5336904qtx.420.1660885569793;
        Thu, 18 Aug 2022 22:06:09 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id ga10-20020a05622a590a00b003430589dd34sm2427322qtb.57.2022.08.18.22.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 22:06:09 -0700 (PDT)
Date:   Thu, 18 Aug 2022 22:03:58 -0700
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     "Huang, Shaoqin" <shaoqin.huang@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/8] memblock tests: add labels to verbose output for
 generic alloc tests
Message-ID: <20220819050358.GA3930@sophie>
References: <cover.1660454730.git.remckee0@gmail.com>
 <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
 <63e9e964-021e-e141-00f8-afd7feb774fb@intel.com>
 <20220816023951.GB3590@sophie>
 <03f8614e-2bd7-afa8-6744-14397cbc9cb1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f8614e-2bd7-afa8-6744-14397cbc9cb1@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:08:44AM +0800, Huang, Shaoqin wrote:
> 
> 
> On 8/16/2022 10:39 AM, Rebecca Mckeever wrote:
> > On Mon, Aug 15, 2022 at 05:15:47PM +0800, Huang, Shaoqin wrote:
> > > I found original some of test function has the prefix `top_down` and
> > > `bottom_up`, and some of test function didn't have the prefix.
> > > 
> > > In this patch, it just modified these functions which didn't have the prefix
> > > `top_down` or `bottom_up`, and now there are two style about these test
> > > functions in the code.
> > > 
> > > One is:
> > > 	run_top_down(alloc_in_between_generic_check);
> > > 	run_bottom_up(alloc_in_between_generic_check);
> > > 
> > > Another one is:
> > > 	memblock_set_bottom_up(false);
> > > 	alloc_top_down_before_check();
> > > 	memblock_set_bottom_up(true);
> > > 	alloc_bottom_up_before_check();
> > > 
> > > Thus there gonna be two output style, here is an example:
> > > ok 89 : memblock_alloc_from: top-down: alloc_from_simple_generic_check:
> > > passed
> > > ok 90 : memblock_alloc_from: bottom-up: alloc_from_simple_generic_check:
> > > passed
> > > 
> > > ok 99 : memblock_alloc_try_nid: alloc_try_nid_top_down_simple_check: passed
> > > ok 100 : memblock_alloc_try_nid: alloc_try_nid_bottom_up_simple_check:
> > > passed
> > > 
> > > It may make confuse if one is printed between the colon and one is inside
> > > the function name.
> > > 
> > > So maybe make the style consistent is more make sense. And I think this can
> > > be done by modify all these function name which with `top_down` and
> > > `bottom_up` inside, and replace them with your new run_top_down() and
> > > run_bottom_up() functions.
> > > 
> > So you're saying use run_top_down() and run_bottom_up() even for functions
> > with `top_down` and `bottom_up` in the name, but don't change the names?
> > 
> 
> Yes. We can't delete these `top_down` and `bottom_up` in the name and makes
> two functions to have the same name. Due to these functions with `top_down`
> and `bottom_up` have different implementation.
> 
> If use run_top_down() and run_bottom_up() for these functions. We can get
> the consistent output style, but a little redundant output(Maybe this isn't
> a good idea).
> 
Yes, I think the output would be too redundant. Even though there are
two different output styles, the style is consistent within each pair of
tests. So there is at least a consistent pattern.

> > > On 8/14/2022 1:53 PM, Rebecca Mckeever wrote:
> > > > Generic tests for memblock_alloc*() functions do not use separate
> > > > functions for testing top-down and bottom-up allocation directions.
> > > > Therefore, the function name that is displayed in the verbose testing
> > > > output does not include the allocation direction.
> > > > 
> > > > Add an additional prefix when running generic tests for
> > > > memblock_alloc*() functions that indicates which allocation direction is
> > > > set. The prefix will be displayed when the tests are run in verbose mode.
> > > > 
> > > > Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> > > > ---
> > > >    tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
> > > >    .../memblock/tests/alloc_helpers_api.c        | 12 +++----
> > > >    tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
> > > >    tools/testing/memblock/tests/common.h         | 16 +++++++++
> > > >    4 files changed, 44 insertions(+), 56 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
> > > > index 71c89cb9b2a8..73c2c43e702a 100644
> > > > --- a/tools/testing/memblock/tests/alloc_api.c
> > > > +++ b/tools/testing/memblock/tests/alloc_api.c
> > > > @@ -752,10 +752,8 @@ static int alloc_after_check(void)
> > > >    static int alloc_in_between_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_in_between_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_in_between_generic_check();
> > > > +	run_top_down(alloc_in_between_generic_check);
> > > > +	run_bottom_up(alloc_in_between_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -774,10 +772,8 @@ static int alloc_second_fit_check(void)
> > > >    static int alloc_small_gaps_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_small_gaps_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_small_gaps_generic_check();
> > > > +	run_top_down(alloc_small_gaps_generic_check);
> > > > +	run_bottom_up(alloc_small_gaps_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -785,10 +781,8 @@ static int alloc_small_gaps_check(void)
> > > >    static int alloc_all_reserved_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_all_reserved_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_all_reserved_generic_check();
> > > > +	run_top_down(alloc_all_reserved_generic_check);
> > > > +	run_bottom_up(alloc_all_reserved_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -796,10 +790,8 @@ static int alloc_all_reserved_check(void)
> > > >    static int alloc_no_space_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_no_space_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_no_space_generic_check();
> > > > +	run_top_down(alloc_no_space_generic_check);
> > > > +	run_bottom_up(alloc_no_space_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -807,10 +799,8 @@ static int alloc_no_space_check(void)
> > > >    static int alloc_limited_space_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_limited_space_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_limited_space_generic_check();
> > > > +	run_top_down(alloc_limited_space_generic_check);
> > > > +	run_bottom_up(alloc_limited_space_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -818,10 +808,8 @@ static int alloc_limited_space_check(void)
> > > >    static int alloc_no_memory_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_no_memory_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_no_memory_generic_check();
> > > > +	run_top_down(alloc_no_memory_generic_check);
> > > > +	run_bottom_up(alloc_no_memory_generic_check);
> > > >    	return 0;
> > > >    }
> > > > diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
> > > > index 796527cf3bd2..1ccf02639ad6 100644
> > > > --- a/tools/testing/memblock/tests/alloc_helpers_api.c
> > > > +++ b/tools/testing/memblock/tests/alloc_helpers_api.c
> > > > @@ -357,10 +357,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
> > > >    static int alloc_from_simple_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_from_simple_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_from_simple_generic_check();
> > > > +	run_top_down(alloc_from_simple_generic_check);
> > > > +	run_bottom_up(alloc_from_simple_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -368,10 +366,8 @@ static int alloc_from_simple_check(void)
> > > >    static int alloc_from_misaligned_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_from_misaligned_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_from_misaligned_generic_check();
> > > > +	run_top_down(alloc_from_misaligned_generic_check);
> > > > +	run_bottom_up(alloc_from_misaligned_generic_check);
> > > >    	return 0;
> > > >    }
> > > > diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
> > > > index 71b7beb35526..82fa8ea36320 100644
> > > > --- a/tools/testing/memblock/tests/alloc_nid_api.c
> > > > +++ b/tools/testing/memblock/tests/alloc_nid_api.c
> > > > @@ -1142,10 +1142,8 @@ static int alloc_try_nid_cap_min_check(void)
> > > >    static int alloc_try_nid_min_reserved_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_try_nid_min_reserved_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_try_nid_min_reserved_generic_check();
> > > > +	run_top_down(alloc_try_nid_min_reserved_generic_check);
> > > > +	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -1153,10 +1151,8 @@ static int alloc_try_nid_min_reserved_check(void)
> > > >    static int alloc_try_nid_max_reserved_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_try_nid_max_reserved_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_try_nid_max_reserved_generic_check();
> > > > +	run_top_down(alloc_try_nid_max_reserved_generic_check);
> > > > +	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -1164,10 +1160,8 @@ static int alloc_try_nid_max_reserved_check(void)
> > > >    static int alloc_try_nid_exact_address_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_try_nid_exact_address_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_try_nid_exact_address_generic_check();
> > > > +	run_top_down(alloc_try_nid_exact_address_generic_check);
> > > > +	run_bottom_up(alloc_try_nid_exact_address_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -1175,10 +1169,8 @@ static int alloc_try_nid_exact_address_check(void)
> > > >    static int alloc_try_nid_reserved_full_merge_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_try_nid_reserved_full_merge_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_try_nid_reserved_full_merge_generic_check();
> > > > +	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
> > > > +	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -1186,10 +1178,8 @@ static int alloc_try_nid_reserved_full_merge_check(void)
> > > >    static int alloc_try_nid_reserved_all_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_try_nid_reserved_all_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_try_nid_reserved_all_generic_check();
> > > > +	run_top_down(alloc_try_nid_reserved_all_generic_check);
> > > > +	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
> > > >    	return 0;
> > > >    }
> > > > @@ -1197,10 +1187,8 @@ static int alloc_try_nid_reserved_all_check(void)
> > > >    static int alloc_try_nid_low_max_check(void)
> > > >    {
> > > >    	test_print("\tRunning %s...\n", __func__);
> > > > -	memblock_set_bottom_up(false);
> > > > -	alloc_try_nid_low_max_generic_check();
> > > > -	memblock_set_bottom_up(true);
> > > > -	alloc_try_nid_low_max_generic_check();
> > > > +	run_top_down(alloc_try_nid_low_max_generic_check);
> > > > +	run_bottom_up(alloc_try_nid_low_max_generic_check);
> > > >    	return 0;
> > > >    }
> > > > diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
> > > > index 7a16a7dc8f2c..e0dd5b410099 100644
> > > > --- a/tools/testing/memblock/tests/common.h
> > > > +++ b/tools/testing/memblock/tests/common.h
> > > > @@ -101,4 +101,20 @@ static inline void test_pass_pop(void)
> > > >    	prefix_pop();
> > > >    }
> > > > +static inline void run_top_down(int (*func)())
> > > > +{
> > > > +	memblock_set_bottom_up(false);
> > > > +	prefix_push("top-down");
> > > > +	func();
> > > > +	prefix_pop();
> > > > +}
> > > > +
> > > > +static inline void run_bottom_up(int (*func)())
> > > > +{
> > > > +	memblock_set_bottom_up(true);
> > > > +	prefix_push("bottom-up");
> > > > +	func();
> > > > +	prefix_pop();
> > > > +}
> > > > +
> > > >    #endif

Thanks,
Rebecca
