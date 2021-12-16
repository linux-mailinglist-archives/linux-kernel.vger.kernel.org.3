Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2A477658
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhLPPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbhLPPs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:48:26 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FFC061401
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:48:25 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so7016030oos.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLYVphrI03cOaMaXMsK21ZtL1XoGKJxPiFCER5CAOEQ=;
        b=gtSDAbPFlBKKXa7Ijtgbyly6I0ScHq4dki0xsbGQjPydbRdl6ep2++FAi13gCdCsgh
         n6M+Kbqn34TivRx7BQnoUSozl2AyJ1twjlUi3M4r0usw8IO3WE9ibT5ydmXfdE/fcx9V
         q7IfEuHB0j8TLNLPxsNmPIHlYDUIc7FcBjnsAUYpxn29cPdLz0BeKSjBKUSxlHeNGLXS
         km3pO8vnmo55pVnbuSVrxqEDN5U69lIn99EBvlz3vPd+PTQ5HEjw/Jto5/gBBnU+SfxL
         A6hg6xR4CKKMTxH0FsiwrF2y383VeXB+clqoaeRBOTE5ZZCVmn7WfpWZL1F5UuprbKBP
         6KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLYVphrI03cOaMaXMsK21ZtL1XoGKJxPiFCER5CAOEQ=;
        b=AY5OZDnZH4vfPGqZ4o4haOIRjfp5RZGdrqEG8YPKNoPdNNmKLZ0DiBZJo3KOaKL4wJ
         W7pBtenfTKuW8ZfGRgIhxMJJasON80Z+AnzN4LzqDp1j+b0/y8TAgxBUnxVsOPr9UpN4
         Z7LmKR/g89OFovGeoXuhq8cHHwEeKRa8wNZGKSTiJpknHBujamnPrserkP00PWvOC2s4
         GYuFLllsnSzXBT1rQ+FFYrIYC/VslCeWOa3oh3MqMk6DUQ97KH2RbtXlhH04i00IDYp7
         aDIa4zMpDTtpRzwngFLTlCf++Bqkp/kGGfcVHT2RIi1lEE6lYrJ2ApnBvHMcbmsOdBkv
         HmEA==
X-Gm-Message-State: AOAM531PCFVDpzX1NBdWTKsI3l1sDtcyay/1NRh90PtWocMPFW1gJ+kI
        Eex8fmZ0Tdglu+vNUXD0VpCQgMnmfL+gcnE25a4UAw==
X-Google-Smtp-Source: ABdhPJwC53NEY9Ob9ITeOGSLZd5G3Un2sKLRHSxfJ6wWkqlQgmq9oG5Bdha0Qj28lftpYeogouu5vfZdvpvP2yQYevw=
X-Received: by 2002:a4a:a5cf:: with SMTP id k15mr11421017oom.70.1639669705074;
 Thu, 16 Dec 2021 07:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
In-Reply-To: <20211216151454.752066-1-tmricht@linux.ibm.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Dec 2021 16:48:13 +0100
Message-ID: <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Test 73 Sig_trap fails on s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 at 16:15, Thomas Richter <tmricht@linux.ibm.com> wrote:
>
> In Linux next kernel
> Commit 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
> introduced the new test which uses breakpoint events.
> These events are not supported on s390 and PowerPC and always fail:
>
>  # perf test -F 73
>  73: Sigtrap                                                         : FAILED!
>  #
>
> Fix it the same way as in the breakpoint tests in file
> tests/bp_account.c where these type of tests are skipped on
> s390 and PowerPC platforms.
>
> With this patch skip this test on both platforms.
>
> Output after:
>  # ./perf test -F 73
>  73: Sigtrap
>
> Fixes: 5504f67944484 ("perf test sigtrap: Add basic stress test for sigtrap handling")
>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Acked-by: Marco Elver <elver@google.com>

Thanks, and sorry for missing this case!

> ---
>  tools/perf/tests/sigtrap.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> index 1004bf0e7cc9..1f147fe6595f 100644
> --- a/tools/perf/tests/sigtrap.c
> +++ b/tools/perf/tests/sigtrap.c
> @@ -22,6 +22,19 @@
>  #include "tests.h"
>  #include "../perf-sys.h"
>
> +/*
> + * PowerPC and S390 do not support creation of instruction breakpoints using the
> + * perf_event interface.
> + *
> + * Just disable the test for these architectures until these issues are
> + * resolved.
> + */
> +#if defined(__powerpc__) || defined(__s390x__)
> +#define BP_ACCOUNT_IS_SUPPORTED 0
> +#else
> +#define BP_ACCOUNT_IS_SUPPORTED 1
> +#endif
> +
>  #define NUM_THREADS 5
>
>  static struct {
> @@ -122,6 +135,11 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
>         char sbuf[STRERR_BUFSIZE];
>         int i, fd, ret = TEST_FAIL;
>
> +       if (!BP_ACCOUNT_IS_SUPPORTED) {
> +               pr_debug("Test not supported on this architecture");
> +               return TEST_SKIP;
> +       }
> +
>         pthread_barrier_init(&barrier, NULL, NUM_THREADS + 1);
>
>         action.sa_flags = SA_SIGINFO | SA_NODEFER;
> --
> 2.33.1
>
