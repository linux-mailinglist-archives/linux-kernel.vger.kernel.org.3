Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8FD57B988
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiGTPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241275AbiGTPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:23:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0F15B7AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:23:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i132-20020a1c3b8a000000b003a2fa488efdso1564044wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slmyMPLStcdVZwVLrygegZI1kQWoRXJ3dHO76YDTpRY=;
        b=HIhV3Fd6zMou+mYxHrh3EwfKVqnGb8wEko3bWRabyZeaVFndg3i21gDTZYKU4QH+U+
         ceaCmAfpX1NMgjhfDGx4UySpyEinYNowzRP7cFJRtqspUSkZIR2zjdPU8Gn7M0H6VQWx
         B3ybGupwWxzX5e2wtNdoemR9WFi5dPRa9TeZSbSnHoLoeV/L688W4Kv11U68i6CaqIvn
         uiaRX7PjPvyU0C0H5C5GXfZss8yQw1k3hMQhZ9JXJzEisI+okjAVN2JnoxjGu3G4Es6Y
         +kY3oLBP7KynlFqDXyPzuq/rcV8M/Le1dOaWLGpb3ON+93C8x2JKUBBkSxJmL+fDzeAI
         q/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slmyMPLStcdVZwVLrygegZI1kQWoRXJ3dHO76YDTpRY=;
        b=yfKBrC2iDckRjcqmJpoPQbFxWOldqEVhDZ3fihdYE7K32eRs5RaE9aWIuwlLM0f3Xx
         BHYAhNckAilxRz39LPtWS0tyLHfAi5MfkK0oEcg5EYhJHeUcN26TWOHjiueXc8c51AOp
         j6blOGWV+THhnJRNGXQiepwmn+SbWRn2PLTqjYhkXOzGlQEF4zgOrAtiuZGcyKE7dwfG
         XqsIScSRVphiUi3D1jls+6N5XkriR+YDsfs1vSkQSQWTxapXmSSzvoSdSx7X8ejLR2xE
         6imL8Aq5zldnOAB4dkcMEVaecpkyrMJWKmlUmdSr7YVuI/4mUPcGtXc/3/UVxfje01Uo
         sziw==
X-Gm-Message-State: AJIora/L3+tQyhYADqwhCNdMjP/IOQccXJpjam5PLExEypDRTFIgeOv7
        UlaiwU/UHnsOLrklMcjRzft+DKTsc10MNOx63Acmrw==
X-Google-Smtp-Source: AGRyM1vb0saAhlewKLRMkgo4BMvL28iEly+NJOS9mGiKUFwMGQzov9Fw2dnpVoeLMPQGJoQSPfnpkfZDFIn0qF4i0sU=
X-Received: by 2002:a05:600c:20e:b0:3a3:214c:7ffb with SMTP id
 14-20020a05600c020e00b003a3214c7ffbmr494719wmi.1.1658330623182; Wed, 20 Jul
 2022 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-4-elver@google.com>
In-Reply-To: <20220704150514.48816-4-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:23:31 -0700
Message-ID: <CAP-5=fWWB7qnxn0WMwqGuiO=CXqfBdvjAWMc52BHSJciz04gCg@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] perf/hw_breakpoint: Clean up headers
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
>
> Clean up headers:
>
>  - Remove unused <linux/kallsyms.h>
>
>  - Remove unused <linux/kprobes.h>
>
>  - Remove unused <linux/module.h>
>
>  - Remove unused <linux/smp.h>
>
>  - Add <linux/export.h> for EXPORT_SYMBOL_GPL().
>
>  - Add <linux/mutex.h> for mutex.
>
>  - Sort alphabetically.
>
>  - Move <linux/hw_breakpoint.h> to top to test it compiles on its own.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2:
> * Move to start of series.
> ---
>  kernel/events/hw_breakpoint.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index fd5cd1f9e7fc..6076c6346291 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -17,23 +17,22 @@
>   * This file contains the arch-independent routines.
>   */
>
> +#include <linux/hw_breakpoint.h>
> +
> +#include <linux/bug.h>
> +#include <linux/cpu.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
>  #include <linux/irqflags.h>
> -#include <linux/kallsyms.h>
> -#include <linux/notifier.h>
> -#include <linux/kprobes.h>
>  #include <linux/kdebug.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/percpu.h>
>  #include <linux/sched.h>
> -#include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/list.h>
> -#include <linux/cpu.h>
> -#include <linux/smp.h>
> -#include <linux/bug.h>
>
> -#include <linux/hw_breakpoint.h>
>  /*
>   * Constraints data
>   */
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
