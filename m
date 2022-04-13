Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758124FFFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbiDMUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiDMUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:15:42 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5B47EB30;
        Wed, 13 Apr 2022 13:13:19 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id o2so5476028lfu.13;
        Wed, 13 Apr 2022 13:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0axfJZEmxaCKVXrZmpXmL0/SQ+GEx15ttfkdwtz2SM=;
        b=PwXtHJRZKEGg5kNGcq4zFPILRsRU/Zre+9gYC/nbNHa61SzylEhyVELuV18Y1Aiv2z
         i1AMB4sbRCxezZDvkYEsmBd94uBtqxKXovgQc1QF8ZPApxbXJNOBc4Hqt5v+lK0YdOeg
         aT8wV46U32Q80RUuIYncaYGhGOUz+14ZyAgJgoymNOOns50L/tQNgxoMLYzs1IXpcZqg
         X5yQjSBJoWqKzABg7cBAY5t2ekBDzV2hz0PkGwCK5mOM/dadZccdWRJ34cMCykyfWK9/
         6gcYVIfQXmMj0RdbTZQGc5W+JY79uFarpsgCnfV/1fpRDzLf9DrnH0dC8jZ57B8B+8x8
         PNfQ==
X-Gm-Message-State: AOAM5331gpUtjz7tQRRCgZfF0Ym7r13afD42YiavD4MPb5S6/32OoWml
        zwHy4WA5fk38AEkSlHpKJ8b7rSVCFLS/Qb6tCOW30MhaCDY=
X-Google-Smtp-Source: ABdhPJy1isnh+7QvMjsmVHdZrXueS0QGj3+d+hinbJpnLqYqybSfjS1qBFHn71ijHEKcQekpZF+Jn37JPzMMudkclcU=
X-Received: by 2002:ac2:5df8:0:b0:46d:9fc:ff0f with SMTP id
 z24-20020ac25df8000000b0046d09fcff0fmr1010479lfq.454.1649880797787; Wed, 13
 Apr 2022 13:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220412062133.2546080-1-irogers@google.com> <20220412062133.2546080-3-irogers@google.com>
In-Reply-To: <20220412062133.2546080-3-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Apr 2022 13:13:06 -0700
Message-ID: <CAM9d7cgaYm7r=ZisuPFR5nvYdyaYOKaBiL_3StmGPQ=gVy3zrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf test: Add basic perf record tests
To:     Ian Rogers <irogers@google.com>
Cc:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Mon, Apr 11, 2022 at 11:21 PM Ian Rogers <irogers@google.com> wrote:
>
> Test the --per-thread flag.
> Test Intel machine state capturing.

Probably we want to add more later..

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record.sh | 37 ++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100755 tools/perf/tests/shell/record.sh
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> new file mode 100755
> index 000000000000..2c85e73a0af4
> --- /dev/null
> +++ b/tools/perf/tests/shell/record.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +# perf record tests
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +err=0
> +test_per_thread() {
> +  echo "Basic --per-thread mode test"
> +  perf record -o - --per-thread true | perf report -i - > /dev/null

I think it should check the output of the perf report.
The current code produces no samples..

  $ perf record --per-thread -o- true | perf report -i- -q
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  Error:
  The - data has no samples!

We can just grep 'true' in the comm.

Thanks,
Namhyung


> +  echo "Basic --per-thread mode test [Success]"
> +}
> +
> +test_register_capture() {
> +  echo "Register capture test"
> +  if ! perf list | egrep -q 'br_inst_retired.near_call'
> +  then
> +    echo "Register capture test [Skipped missing instruction]"
> +    return
> +  fi
> +  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> +  then
> +    echo "Register capture test [Skipped missing registers]"
> +    return
> +  fi
> +  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p -c 1000 --per-thread true | perf script -F ip,sym,iregs  -i - | egrep -q "DI:"
> +  then
> +    echo "Register capture test [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +  echo "Register capture test [Success]"
> +}
> +
> +test_per_thread
> +test_register_capture
> +exit $err
> --
> 2.35.1.1178.g4f1659d476-goog
>
