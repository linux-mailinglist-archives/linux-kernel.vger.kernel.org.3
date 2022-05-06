Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7451CDFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387730AbiEFA7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383414AbiEFA7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:59:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720965EDF8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:55:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso3517026wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tOCD/bY0fRj1LfkiQycYLQOJvIRS+ASET+v1HdabggE=;
        b=eFb1TtI2XQ6u9j0P2nEl4PU4irAq46hfSMMcm7YL2W5KEUctYfSvc8WVrcnRfsOhzM
         5O5qOYRtfmGAChPiVYLzluANN4FGpx0k022c/a0/XfRNEIIKHUzq6ejWK0WoquCGu6nj
         S/3w6xRuex2HCpOaPzzh0tnAMRXJayJvBiPjwkVQPP1AGI7cbnBIV4M+5FJL1uJNyn4h
         /7sx3gJuBaX0f3XvaJsBOEHFKwDzq20IOJuZjFSFVqfqMd4OWPPo/S9rmqCZ1UHbhpzy
         38rFDnemGjITJcDtltAEez8HVmMmV8Baj8kom3f20WWEZO7Pd63bXryr1tbuefaEbAFp
         OrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOCD/bY0fRj1LfkiQycYLQOJvIRS+ASET+v1HdabggE=;
        b=gI3n/wYoqoP8SnQDTur9DrGzDfiqX4mtaS5L9wM6mEAGd5GVsiQj3MyGLAOndfteLi
         GbrwAVxW058c4oynnP8nWf6CsLioZU4nsnwh+Oj/h3Qb00tH0zOfHVJAjM6wgSK69W0W
         GL2vCzogmhbvi1R0e7W8PvU75d3G9nK6IFO2CVYtIMhmhESULoPi9ExrTjS4ktWAUNHD
         RhFjUtAeu3PHaJWOETIMjs1WbdXhD3LQ4h8j2inHYJsBn8MqqnPnGJFJQn9+Ute9NCAD
         25g1DqXubxPz/4u2fGIoO/i6XDOXmjnKGSyStMrjO4ddbAObppQXZ38mHf/nEsVdXmCl
         uI9Q==
X-Gm-Message-State: AOAM533MZDnrp2d6yWF1UKaB7IOVdZnBvAYPWqXIXoVxZJLTGaIeMUfH
        5yKrKa+HB/NfEagQ38huyv5cMJ+jNagyA/oz/keQcg==
X-Google-Smtp-Source: ABdhPJzWd1OxJnYu3PjW0FeUmQ5NRBnNqKH7CdeirYelhIxIjFt+aPmQv7EcmD2VK2PM9pf+vDmrJ9uOOg6L2LFYCM8=
X-Received: by 2002:a05:600c:2315:b0:394:1f6:f663 with SMTP id
 21-20020a05600c231500b0039401f6f663mr7273458wmo.115.1651798538840; Thu, 05
 May 2022 17:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220505165639.361733-1-adrian.hunter@intel.com> <20220505165639.361733-22-adrian.hunter@intel.com>
In-Reply-To: <20220505165639.361733-22-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 5 May 2022 17:55:25 -0700
Message-ID: <CAP-5=fWednJQmogBst5LVia8WehaR39o53_dxCJUmaYWpGN2FQ@mail.gmail.com>
Subject: Re: [PATCH V1 21/23] libperf evsel: Add comments for booleans
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 5, 2022 at 9:58 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add comments for 'system_wide' and 'requires_cpu' booleans
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/include/internal/evsel.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 77fbb8b97e5c..f613c3ae868e 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -49,7 +49,15 @@ struct perf_evsel {
>
>         /* parse modifier helper */
>         int                      nr_members;
> +       /*
> +        * system_wide is for events that need to be on every CPU, irrespective
> +        * of user requested CPUs or threads.

Will the cpu map agree with this? If not, what is the case for
all_cpus computed in propagate maps? Could we add this to comment.

> +        */
>         bool                     system_wide;
> +       /*
> +        * Some events, for example uncore events, require a CPU.
> +        * i.e. it cannot be -1

nit: perhaps "cannot be 'any CPU' (-1)."

Thanks,
Ian

> +        */
>         bool                     requires_cpu;
>         int                      idx;
>  };
> --
> 2.25.1
>
