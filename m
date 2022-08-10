Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0658E606
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 06:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiHJEI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 00:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiHJEHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 00:07:17 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93558804A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 21:07:12 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id d126so9660279vsd.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 21:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=kId4f7EFjsEjFMSrpydg8ZX9Mg4oRHnhV5YqGXmEmjc=;
        b=j2ki4tni3g6nBYQqwaytdaVv6qwPS6ruweZxdiBxWUeoRTDtqr6Vir+5QCso8yFy8r
         Kg6a1BiK2D4hvi+Wf+fIp8OGBUqyGsgNkeFU42f8AhY0ErH9w/FkICNTJYDXF073/vGE
         OIjQOEqf6ig8scxay8TTF+AXvV9ELZGY0/S0fQLbhl7y+T/PFZZlWSdtukb+iQZsnZ9F
         2a6ylr65u39Okn37Vfj8ogkd12dgbwnWu+ZGGOWuCswmCxo7h1VlYh6DL75WKI2jIiL0
         diKuQwezVjmm+4afVXkaS4mG/20qu5A0vHCu7MknIjUFl9ypYaXAhXGMkiiLNopnuWbS
         zWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=kId4f7EFjsEjFMSrpydg8ZX9Mg4oRHnhV5YqGXmEmjc=;
        b=ZHAPH4Y/XG+A8cFZ/nnQ6tmlJMopSEd50ADoG0kjM6Ae6CtoXEPjYfTCKbwm0Gpm44
         4X3Vjhpbs2+wPuzQikkuxGnSLXaHg6AE64U+TIhbsOrHEOJqbcLuRT/30JG4qPBwJ/EZ
         gByo2IQMznG53nmO7wlcdgJTKac2qJPFkHZdtjGzH57dxPgY/EEnT+YdweVGsmJIXq7k
         /b33OiqoL5Z83kATzCl64gptJ3fEQ48/fLwEYRMXtxm68x8cldPY3ew7DVDAqoVcYURv
         jkUc1C+E2vjLGFtBQT5L6OKaoyovVaDP4FuG+Z53c7NQ2WOos2vWxxY2jkRJ1PNqspKL
         wDZg==
X-Gm-Message-State: ACgBeo3ljMvwe45C6Z4mXsi9KSPoK8CM4pVItrC2EHvAGWwQ8kYrUVqW
        5XLaJoZTKKRyrat44HUdWbPpO/Ub/BWjJLnE8S1N8LlxU7mb+9UM
X-Google-Smtp-Source: AA6agR7TLVbT9sTVkcHT8wCvR1LVwK2JoG4ffOJBT4jGlw7c5VgolsH4t6Y+Q9kR1KN9UAxfD316fRFZ/2qefziYMSk=
X-Received: by 2002:a67:cb0c:0:b0:357:9897:32d4 with SMTP id
 b12-20020a67cb0c000000b00357989732d4mr10983722vsl.18.1660104420961; Tue, 09
 Aug 2022 21:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660068429.git.sander@svanheule.net> <c3b4b27a1135558e1eb30261ce7e2df3cb43ec6e.1660068429.git.sander@svanheule.net>
In-Reply-To: <c3b4b27a1135558e1eb30261ce7e2df3cb43ec6e.1660068429.git.sander@svanheule.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 12:06:49 +0800
Message-ID: <CABVgOSnzy385jkjOK44DqBZSyDKKWvJdCrJk1kQtBvi2wRKdcg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] lib/test_cpumask: follow KUnit style guidelines
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> wrot=
e:
>
> The cpumask test suite doesn't follow the KUnit style guidelines, as
> laid out in Documentation/dev-tools/kunit/style.rst.  The file is
> renamed to lib/cpumask_kunit.c to clearly distinguish it from other,
> non-KUnit, tests.
>
> Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c73@r=
iseup.net/
> Suggested-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---

Thanks: it's definitely nicer to have this match the KUnit style.

If renaming causes problems, we could live without it, but I'd prefer
this to go through as-is.

Reviewed-by: David Gow <davidgow@google.com>


>  lib/Kconfig.debug                       | 7 +++++--
>  lib/Makefile                            | 2 +-
>  lib/{test_cpumask.c =3D> cpumask_kunit.c} | 0
>  3 files changed, 6 insertions(+), 3 deletions(-)
>  rename lib/{test_cpumask.c =3D> cpumask_kunit.c} (100%)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 072e4b289c13..bcbe60d6c80c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2029,13 +2029,16 @@ config LKDTM
>         Documentation on how to use the module can be found in
>         Documentation/fault-injection/provoke-crashes.rst
>
> -config TEST_CPUMASK
> -       tristate "cpumask tests" if !KUNIT_ALL_TESTS
> +config CPUMASK_KUNIT_TEST
> +       tristate "KUnit test for cpumask" if !KUNIT_ALL_TESTS
>         depends on KUNIT
>         default KUNIT_ALL_TESTS
>         help
>           Enable to turn on cpumask tests, running at boot or module load=
 time.
>
> +         For more information on KUnit and unit tests in general, please=
 refer
> +         to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
>           If unsure, say N.
>
>  config TEST_LIST_SORT
> diff --git a/lib/Makefile b/lib/Makefile
> index c95212141928..22eafcd39b51 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_TEST_BPF) +=3D test_bpf.o
>  obj-$(CONFIG_TEST_FIRMWARE) +=3D test_firmware.o
>  obj-$(CONFIG_TEST_BITOPS) +=3D test_bitops.o
>  CFLAGS_test_bitops.o +=3D -Werror
> +obj-$(CONFIG_CPUMASK_KUNIT_TEST) +=3D cpumask_kunit.o
>  obj-$(CONFIG_TEST_SYSCTL) +=3D test_sysctl.o
>  obj-$(CONFIG_TEST_SIPHASH) +=3D test_siphash.o
>  obj-$(CONFIG_HASH_KUNIT_TEST) +=3D test_hash.o
> @@ -99,7 +100,6 @@ obj-$(CONFIG_TEST_HMM) +=3D test_hmm.o
>  obj-$(CONFIG_TEST_FREE_PAGES) +=3D test_free_pages.o
>  obj-$(CONFIG_KPROBES_SANITY_TEST) +=3D test_kprobes.o
>  obj-$(CONFIG_TEST_REF_TRACKER) +=3D test_ref_tracker.o
> -obj-$(CONFIG_TEST_CPUMASK) +=3D test_cpumask.o
>  CFLAGS_test_fprobe.o +=3D $(CC_FLAGS_FTRACE)
>  obj-$(CONFIG_FPROBE_SANITY_TEST) +=3D test_fprobe.o
>  #
> diff --git a/lib/test_cpumask.c b/lib/cpumask_kunit.c
> similarity index 100%
> rename from lib/test_cpumask.c
> rename to lib/cpumask_kunit.c
> --
> 2.37.1
>
