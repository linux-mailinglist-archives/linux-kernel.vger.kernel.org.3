Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305B480C86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhL1SZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:25:29 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40758 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbhL1SZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:25:28 -0500
Received: by mail-lf1-f43.google.com with SMTP id bu9so43059378lfb.7;
        Tue, 28 Dec 2021 10:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKBT3fVk+5Ze7NnqHlV8mvrLrX1N9Lsru+aK5EZ1DF8=;
        b=3eWJBQgcJa20v1TPqVAEAae9Erxczyi5LbLqlrEI24MLkKHOdWFuBle/VxCDsnMcaM
         NphfJJazS0kZOw1Ov5K0larJTnJxj9OJ5jQQRo623Piqox+xDEXpkELa3hgGVGjYuTBd
         Od7uXhtCleCSU/26IjB9Aj+xw0Cxf8cINB26pbq1uT+bRVNuywN9SHcUS3m++83kxhYV
         5KE6I/uAVWAC51RytDHB7z2SuyXfu15hD7lJjPUZmOa7F4H+KeVlBL2QNY/9kjurEbRf
         oUCKAuc16B3F6NcAr/xvjH4OnHvhOj7VSbBgZwL8xuGfb2pCm/2OeDI/lDYCAhKw9LF3
         avAQ==
X-Gm-Message-State: AOAM533Lx6ERSf6v/iCKbFFpDDfyeKkRGxRCSpaGdF7lKnj4hZix69DM
        lxCG5H1KO+xEFbZ4XBs0d1cfzkLWZFHMaBR4wlA=
X-Google-Smtp-Source: ABdhPJyyFBRF35kVUSEDJz3P8BXqrVfQ80r4TpH8NbNlUiO8eSbhXahKQ5aLrAcoEmxoqo10qmly0tg23Tze8xqyTJQ=
X-Received: by 2002:a05:6512:3d21:: with SMTP id d33mr20525401lfv.481.1640715926035;
 Tue, 28 Dec 2021 10:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20211225005558.503935-1-standby24x7@gmail.com>
In-Reply-To: <20211225005558.503935-1-standby24x7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 10:25:08 -0800
Message-ID: <CAM9d7cj0dQvoio-T0yNZzo+AGGDxCFtRWuDxBunFEkipWtDxZA@mail.gmail.com>
Subject: Re: [PATCH] perf bpf: Fix a typo in bpf_counter_cgroup.c
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 24, 2021 at 4:57 PM Masanari Iida <standby24x7@gmail.com> wrote:
>
> This patch fixes a spelling typo in error message.
>
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/bpf_counter_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
> index cbc6c2bca488..fea5f2ca03f6 100644
> --- a/tools/perf/util/bpf_counter_cgroup.c
> +++ b/tools/perf/util/bpf_counter_cgroup.c
> @@ -266,7 +266,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
>                 idx = evsel->core.idx;
>                 err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
>                 if (err) {
> -                       pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
> +                       pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
>                                idx, evsel__name(evsel), evsel->cgrp->name);
>                         goto out;
>                 }
> --
> 2.25.0
>
