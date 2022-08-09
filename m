Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5205D58E330
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiHIW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:29:21 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3264461137
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:29:21 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M2SRN4dlqzDqPk;
        Tue,  9 Aug 2022 22:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660084160; bh=bxkp1AbEEmASMq6wNRTBOspgx/GG8ESxLsd3fxutOSs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sq+QxUzZgFfIILhCGhOZbD3AjFsIYrtlTxfEkLJ1g6b7mmPtMIYV1L7W2ivIAy3rU
         SXbO7KbjhJx66ypui2b7M99FfZgay+qg32ZQDsfVx6Mi4qcyjZwNJMOYleVO5fn5q+
         gHuDb5W0LqlpY7Uk7LaTYkMtX5UflqSOJtZveFm0=
X-Riseup-User-ID: 2618FD945E2B50D9DFB62AE0E0DA186343BD3BC3C45C0CAEA433E84A8156F7E6
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M2SRL72nFz5w5b;
        Tue,  9 Aug 2022 22:29:18 +0000 (UTC)
Message-ID: <35b3f394-19ca-84cf-d885-9418b5163066@riseup.net>
Date:   Tue, 9 Aug 2022 19:29:17 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/5] lib/test_cpumask: follow KUnit style guidelines
Content-Language: en-US
To:     Sander Vanheule <sander@svanheule.net>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
References: <cover.1660068429.git.sander@svanheule.net>
 <c3b4b27a1135558e1eb30261ce7e2df3cb43ec6e.1660068429.git.sander@svanheule.net>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <c3b4b27a1135558e1eb30261ce7e2df3cb43ec6e.1660068429.git.sander@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/22 15:08, Sander Vanheule wrote:
> The cpumask test suite doesn't follow the KUnit style guidelines, as
> laid out in Documentation/dev-tools/kunit/style.rst.  The file is
> renamed to lib/cpumask_kunit.c to clearly distinguish it from other,
> non-KUnit, tests.
> 
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@riseup.net/
> Suggested-by: Maíra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

> ---
>  lib/Kconfig.debug                       | 7 +++++--
>  lib/Makefile                            | 2 +-
>  lib/{test_cpumask.c => cpumask_kunit.c} | 0
>  3 files changed, 6 insertions(+), 3 deletions(-)
>  rename lib/{test_cpumask.c => cpumask_kunit.c} (100%)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 072e4b289c13..bcbe60d6c80c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2029,13 +2029,16 @@ config LKDTM
>  	Documentation on how to use the module can be found in
>  	Documentation/fault-injection/provoke-crashes.rst
>  
> -config TEST_CPUMASK
> -	tristate "cpumask tests" if !KUNIT_ALL_TESTS
> +config CPUMASK_KUNIT_TEST
> +	tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
>  	default KUNIT_ALL_TESTS
>  	help
>  	  Enable to turn on cpumask tests, running at boot or module load time.
>  
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
>  	  If unsure, say N.
>  
>  config TEST_LIST_SORT
> diff --git a/lib/Makefile b/lib/Makefile
> index c95212141928..22eafcd39b51 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_TEST_BPF) += test_bpf.o
>  obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
>  obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
>  CFLAGS_test_bitops.o += -Werror
> +obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
>  obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
>  obj-$(CONFIG_TEST_SIPHASH) += test_siphash.o
>  obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
> @@ -99,7 +100,6 @@ obj-$(CONFIG_TEST_HMM) += test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) += test_kprobes.o
>  obj-$(CONFIG_TEST_REF_TRACKER) += test_ref_tracker.o
> -obj-$(CONFIG_TEST_CPUMASK) += test_cpumask.o
>  CFLAGS_test_fprobe.o += $(CC_FLAGS_FTRACE)
>  obj-$(CONFIG_FPROBE_SANITY_TEST) += test_fprobe.o
>  #
> diff --git a/lib/test_cpumask.c b/lib/cpumask_kunit.c
> similarity index 100%
> rename from lib/test_cpumask.c
> rename to lib/cpumask_kunit.c
