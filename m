Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D353EB48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiFFKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiFFKgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:36:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CE332EF8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654511812; x=1686047812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nAVo4ivaON+aBvtinwkYZb6v+oVPckrPtjZkC6sZwnw=;
  b=UMpMIfwmWvy7UG/mtAQyU+an2qciOmfGRcYrJX3EBe9yBxiAJO4B3NhO
   +f9NykyVJWsKDOdGSzcjHmhVtSWsPN2jhsoOXdo1NFA3crbGTeeOEcYRR
   aDkI3jFESH0e2VJmlYAsGrdb+CzjpcZ+RBzK6pS698YVr4FZkgIfBSTjK
   BPKdC6uYgHyLQjQHEVeuaGKwuM5bXlDISN8zqFmlpnzo1OgN9gbgtKvZa
   lgaqn14xwxdTMKUeOclcIKvmCnJabVoqXciXwrvNtDI8r1LJq4mZxCNQ7
   I9mAUddUQpzGJ8rHBJfR9rKAn5coOg4Nh9TE74yuJTzV3tmu7CvRakORz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="257089080"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="257089080"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:36:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="722746958"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:36:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nyA6I-000Ua3-SR;
        Mon, 06 Jun 2022 13:36:46 +0300
Date:   Mon, 6 Jun 2022 13:36:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] lib/test: Introduce cpumask KUnit test suite
Message-ID: <Yp3YvnaFIPxlPVqU@smile.fi.intel.com>
References: <cover.1654410109.git.sander@svanheule.net>
 <8b60c0d5add21b43dd75e92d48f2df011f63c6bf.1654410109.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b60c0d5add21b43dd75e92d48f2df011f63c6bf.1654410109.git.sander@svanheule.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 08:22:39AM +0200, Sander Vanheule wrote:
> Add a basic suite of tests for cpumask, providing some tests for empty
> and completely filled cpumasks.

Always in favour of a new test!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
> Changes since v2:
> - Rework for_each_* test macros, as suggested by Yury
> ---
>  lib/Kconfig.debug  |   9 ++++
>  lib/Makefile       |   1 +
>  lib/test_cpumask.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 142 insertions(+)
>  create mode 100644 lib/test_cpumask.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index b8cc65d22169..85f2eb5c0b07 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2100,6 +2100,15 @@ config LKDTM
>  	Documentation on how to use the module can be found in
>  	Documentation/fault-injection/provoke-crashes.rst
>  
> +config TEST_CPUMASK
> +	tristate "cpumask tests" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Enable to turn on cpumask tests, running at boot or module load time.
> +
> +	  If unsure, say N.
> +
>  config TEST_LIST_SORT
>  	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/Makefile b/lib/Makefile
> index 6f26a429115b..5abd7b2064f1 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
> +obj-$(CONFIG_TEST_CPUMASK) += test_cpumask.o
>  CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
>  obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
>  #
> diff --git a/lib/test_cpumask.c b/lib/test_cpumask.c
> new file mode 100644
> index 000000000000..3f43b9a6548c
> --- /dev/null
> +++ b/lib/test_cpumask.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KUnit tests for cpumask.
> + *
> + * Author: Sander Vanheule <sander@svanheule.net>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/cpumask.h>
> +
> +#define EXPECT_FOR_EACH_CPU_EQ(test, mask)			\
> +	do {							\
> +		const cpumask_t *m = (mask);			\
> +		int mask_weight = cpumask_weight(m);		\
> +		int cpu, iter = 0;				\
> +		for_each_cpu(cpu, m)				\
> +			iter++;					\
> +		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
> +	} while (0)
> +
> +#define EXPECT_FOR_EACH_CPU_NOT_EQ(test, mask)					\
> +	do {									\
> +		const cpumask_t *m = (mask);					\
> +		int mask_weight = cpumask_weight(m);				\
> +		int cpu, iter = 0;						\
> +		for_each_cpu_not(cpu, m)					\
> +			iter++;							\
> +		KUNIT_EXPECT_EQ((test), nr_cpu_ids - mask_weight, iter);	\
> +	} while (0)
> +
> +#define EXPECT_FOR_EACH_CPU_WRAP_EQ(test, mask)			\
> +	do {							\
> +		const cpumask_t *m = (mask);			\
> +		int mask_weight = cpumask_weight(m);		\
> +		int cpu, iter = 0;				\
> +		for_each_cpu_wrap(cpu, m, nr_cpu_ids / 2)	\
> +			iter++;					\
> +		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
> +	} while (0)
> +
> +#define EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, name)		\
> +	do {							\
> +		const cpumask_t *m = cpu_##name##_mask;		\
> +		int mask_weight = cpumask_weight(m);		\
> +		int cpu, iter = 0;				\
> +		for_each_##name##_cpu(cpu)			\
> +			iter++;					\
> +		KUNIT_EXPECT_EQ((test), mask_weight, iter);	\
> +	} while (0)
> +
> +static cpumask_t mask_empty;
> +static cpumask_t mask_all;
> +
> +static void test_cpumask_weight(struct kunit *test)
> +{
> +	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
> +	KUNIT_EXPECT_TRUE(test, cpumask_full(cpu_possible_mask));
> +	KUNIT_EXPECT_TRUE(test, cpumask_full(&mask_all));
> +
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_weight(&mask_empty));
> +	KUNIT_EXPECT_EQ(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask));
> +	KUNIT_EXPECT_EQ(test, nr_cpumask_bits, cpumask_weight(&mask_all));
> +}
> +
> +static void test_cpumask_first(struct kunit *test)
> +{
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first(&mask_empty));
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_first(cpu_possible_mask));
> +
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_first_zero(&mask_empty));
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_first_zero(cpu_possible_mask));
> +}
> +
> +static void test_cpumask_last(struct kunit *test)
> +{
> +	KUNIT_EXPECT_LE(test, nr_cpumask_bits, cpumask_last(&mask_empty));
> +	KUNIT_EXPECT_EQ(test, nr_cpumask_bits - 1, cpumask_last(cpu_possible_mask));
> +}
> +
> +static void test_cpumask_next(struct kunit *test)
> +{
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_next_zero(-1, &mask_empty));
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next_zero(-1, cpu_possible_mask));
> +
> +	KUNIT_EXPECT_LE(test, nr_cpu_ids, cpumask_next(-1, &mask_empty));
> +	KUNIT_EXPECT_EQ(test, 0, cpumask_next(-1, cpu_possible_mask));
> +}
> +
> +static void test_cpumask_iterators(struct kunit *test)
> +{
> +	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
> +	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
> +	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
> +
> +	EXPECT_FOR_EACH_CPU_EQ(test, &mask_empty);
> +	EXPECT_FOR_EACH_CPU_NOT_EQ(test, &mask_empty);
> +	EXPECT_FOR_EACH_CPU_WRAP_EQ(test, &mask_empty);
> +}
> +
> +static void test_cpumask_iterators_builtin(struct kunit *test)
> +{
> +	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, possible);
> +	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
> +	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
> +}
> +
> +static int test_cpumask_init(struct kunit *test)
> +{
> +	cpumask_clear(&mask_empty);
> +	cpumask_setall(&mask_all);
> +
> +	return 0;
> +}
> +
> +static struct kunit_case test_cpumask_cases[] = {
> +	KUNIT_CASE(test_cpumask_weight),
> +	KUNIT_CASE(test_cpumask_first),
> +	KUNIT_CASE(test_cpumask_last),
> +	KUNIT_CASE(test_cpumask_next),
> +	KUNIT_CASE(test_cpumask_iterators),
> +	KUNIT_CASE(test_cpumask_iterators_builtin),
> +	{}
> +};
> +
> +static struct kunit_suite test_cpumask_suite = {
> +	.name = "cpumask",
> +	.init = test_cpumask_init,
> +	.test_cases = test_cpumask_cases,
> +};
> +kunit_test_suite(test_cpumask_suite);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.36.1
> 

-- 
With Best Regards,
Andy Shevchenko


