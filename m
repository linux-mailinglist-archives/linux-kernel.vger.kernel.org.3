Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BA589EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiHDPcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiHDPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:32:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B0A101E6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 08:32:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z12so60126wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CrO/3RU8M4nH9jMDntBlAOSvA7YlDjMGyHvPq8QzUzs=;
        b=s0c2ZVE8y5v9vqetvKgmMKu7YpiWXb4MB9+f7m5KRzf8MhMKCJVXoJysG8RDxbejFA
         AB282uHImzYppKPoQlVjwTRtdS8rkHTzhJkLrfEPqRun3Nzclw5YCJ6HkFsJGHWShLC6
         qpG1n1+GKERtQcAHJWhm2rIznqOgKie9bHVH41BcAjvarorbr+jXfsQIeLddyx4eJPBL
         r1K0hhWVqvnMkRz5/KglSCylYK2VbhLjmO3QLBAeWEbsKJT404n+URIdDHNS/MOpHeT5
         rFIF2hkAJ/7cwQAiBN3s+BzWaNUQAWQwsv6cWT+17aRIiP3O4KrGBwPlzCF2W5u9jNF/
         yNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CrO/3RU8M4nH9jMDntBlAOSvA7YlDjMGyHvPq8QzUzs=;
        b=nfYpJplVsS3tGjXTk9TSYt3ROID6+ryHS0TvD/Hw9r3Zs9IkJnkomISb5WEIoG0Jma
         jbwrV/kuLaZfdhmYwlVSztjl1vuq7WUuL3roJSvdCTJdKFEFjLzmAYOl/4clOMnRp/P4
         FOKlasE2c04ahRFN01Dk/0Re45k7e8UFrVk8c40rOizl2aFlgc0j82o4A1KT72LyEg70
         GVPVuh1qGM5iXIz6hghLPr48tz6JhHdLaOb1icJQlQJDc1GSbPUkDT840Isey+tsKetd
         TRjPS0ddS+fr89xqsHy3g4aGLVl9gepOleWvgmwqUmgIv1VY7LKdiGwVlNwLUL4qhV0h
         g9CQ==
X-Gm-Message-State: ACgBeo1w8rd8FYFe6S+vKAXt+q9YC5myNbsNL+ognO2omJP+BFcuwTVP
        VIacEYrn7iRPKnN/Y79rANFj/0LCHljliXX7AynlPQ==
X-Google-Smtp-Source: AA6agR6bLbjn/TQWap24acgv/E89tnpB1mXoFYikwI6a3vU5NoiTNsEUdSfg1wb1gOon55LZvbwxBGADrSxSv1MTagI=
X-Received: by 2002:adf:e28d:0:b0:21e:4c3b:b446 with SMTP id
 v13-20020adfe28d000000b0021e4c3bb446mr1791886wri.300.1659627154121; Thu, 04
 Aug 2022 08:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220804005213.71990-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220804005213.71990-1-yang.lee@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 4 Aug 2022 08:32:22 -0700
Message-ID: <CAP-5=fX_2sfYOa+4=28-JKfYoTg9wG3i8MRkGvqc3fLE1R=qYQ@mail.gmail.com>
Subject: Re: [PATCH -next] perf stat: Remove duplicated include in builtin-stat.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
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

On Wed, Aug 3, 2022 at 5:52 PM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> util/topdown.h is included twice in builtin-stat.c,
> remove one of them.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1818
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3d22543fc305..e326226656e4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -71,7 +71,6 @@
>  #include "util/bpf_counter.h"
>  #include "util/iostat.h"
>  #include "util/pmu-hybrid.h"
> - #include "util/topdown.h"
>  #include "asm/bug.h"
>
>  #include <linux/time64.h>
> --
> 2.20.1.7.g153144c
>
