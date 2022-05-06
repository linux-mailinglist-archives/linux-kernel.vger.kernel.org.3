Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A873851E05A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443920AbiEFUzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346231AbiEFUzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:55:43 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434896E8E9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:51:59 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id s1so3226445uac.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRtXk2NS2oWzNZ21ZA/x0HHZFmCBasDl3JsMdw59QeE=;
        b=C/97EjllEfm3x20bYNfOjWluflE6TusTk6H3zZb4N7BB1PRUwHKC7TQ894mY5UtE7+
         VaNZOpIr1WCx2BOpL8bKakm8y32jSvTB7RwrPBrKB9u0QwAi5u6FegAoiBBqovVvQlfY
         z0YP50O6RoovOabLN17av8Cxaat61EgcPF1MIwadEUM1SkL2TEMVO/Awv6Pua2Qt6Lje
         LP0B8oT/bYPKb9f8IkrrYGpligunlg0eAuAJCL4hhYgg2iWNPigyJ8FiCZheGJEx/C0H
         +mtoHVe39Vh4dtgDuRW/wQw8amWZzfdOqinQpCEgILdbmNFzmL2gD3oSPbco1E4GC9vm
         C7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRtXk2NS2oWzNZ21ZA/x0HHZFmCBasDl3JsMdw59QeE=;
        b=XzLS7t304GUueqfO9B9mqPw1ltWVtyPgP0RzX5BERamNUI2xSvXKy4O1fCENfI9+GT
         92yXfdZWKf29XB3bc0zilHDwMbklSGNeAf5iG3LcQQFTp7/F3c1gzPv1KuZNiguXGEjs
         zN5cLaC+OoH8L3JrNpJDwB56x+mF4I5AHIUcwB3lMogA1QmO3+ROBQ2E5fIvjT3z2h8g
         3af26XjNuVYIlYUYNJT1D5kRM/vnp5PApsKILISH7jRHdPBlVTJuOJwEsACTGoVMdeDx
         A3dXhi5ZSTMqrzGOmnjYVey6nsK4GXj3VBCU0gS+xmsimwH3UypQ1pzvP9ce71qXJ0E3
         cgfg==
X-Gm-Message-State: AOAM530WqFB+FMgNUG3epKkunUy6iR573rjFvqU+QRrTgjQWVuOAsDOh
        WJqRuJc/ToaefdCswwcpevRX5xYo8VyGPgYVEMSuMw==
X-Google-Smtp-Source: ABdhPJwDLJtMEwsOIeRwITNz4DWQv8HawdW9qjHZbLrxADt9TxYwJg5qFvvFH+ISS6QmphxYvAqOQeBR0+SFOvoWCTA=
X-Received: by 2002:ab0:2a87:0:b0:362:9cdb:8b64 with SMTP id
 h7-20020ab02a87000000b003629cdb8b64mr1688385uar.83.1651870318184; Fri, 06 May
 2022 13:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com> <20220506122601.367589-22-adrian.hunter@intel.com>
In-Reply-To: <20220506122601.367589-22-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 May 2022 13:51:44 -0700
Message-ID: <CAP-5=fWjpP8hhzPuS7tvGaPh9UFJ7Fdyg0B41B4100XbsqFUBA@mail.gmail.com>
Subject: Re: [PATCH V2 21/23] libperf evsel: Add comments for booleans
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

On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add comments for 'system_wide' and 'requires_cpu' booleans
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/lib/perf/include/internal/evsel.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 77fbb8b97e5c..cc8f1ba790bd 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -49,7 +49,16 @@ struct perf_evsel {
>
>         /* parse modifier helper */
>         int                      nr_members;
> +       /*
> +        * system_wide is for events that need to be on every CPU, irrespective
> +        * of user requested CPUs or threads. Map propagation will not override
> +        * this events own_cpus, which will contribute to evlist all_cpus.

So this muddies my understanding of cpus and own_cpus (sigh, again
undocumented). I believe cpus to be the set of CPUs (or any CPU, aka
dummy) that perf_event_open happens on. all_cpus in evlist is the
union of all the evsels cpus (ie not related to own_cpus as described
here). Own_cpus I believe to be what's computed at parse-event time
from sysfs. Is this a typo in the comment or quite likely my error?

Thanks,
Ian

> +        */
>         bool                     system_wide;
> +       /*
> +        * Some events, for example uncore events, require a CPU.
> +        * i.e. it cannot be the 'any CPU' value of -1.
> +        */
>         bool                     requires_cpu;
>         int                      idx;
>  };
> --
> 2.25.1
>
