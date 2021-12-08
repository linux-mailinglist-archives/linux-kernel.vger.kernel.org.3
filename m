Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6431B46D5C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhLHOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhLHOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:37:59 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B259C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 06:34:28 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id 15so2356113ilq.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLmAKNLbTAWuT4pdffxRB8o0BB+BB6t/qftQkUXIbx4=;
        b=YrQqJPpYTpkkzvNOBwgtCrNy1IQVpPUfgqbU0wRgDhZZ2HQ0bld/GBtu2sFiM83ThE
         cNZ3sdcx7igG0vDmQ8Hjpcrn1ukaFrICSLxpmPjbprMzb9yD2jldjTQXpFhQa/jAN50L
         6Id9AWwyaAGqqsD6B5CfjGGggPCzY7q+O+6veNp9tHURo5wXZKkHh34TQwlHIqxC2WKN
         dFmtqO/7ay8WlVLI3QM5jhCwEJZ+buqR7Sx3pLc/Bu3VH1XOXJW1nm4eUvGBnLWE7Ggg
         0+WH2es7YFbQrb0cWtIFM70Nlw/DUer3O9pzejeh3yjSnZvQcTUsRfQlxzYFTuapCq5W
         DpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLmAKNLbTAWuT4pdffxRB8o0BB+BB6t/qftQkUXIbx4=;
        b=IjlSex1spHr6poS3l+4BAwPP3FAtg1eizRdqz7A/D9hOM2kh1PLCvYNeR2sdwhcF/8
         4S9fI+qHqlHyX5n/Qkx/aC6orYIVyn+/jG2KDMU6apt7wIz+v3Clyd9GqftMIBIsXwkN
         mBYOXzSgDUUUpCwlKGnffyVDgd1j1Q/ZDuBqHMPxXc9PZpWxgH1F8mz2RYmKaRYUyxLW
         d/ccoe9tNR3eKTe/cbNWnlCxvV161BOgOuRCdoKAqqmLNKHdLlgJLINlr5czjF/NJDiX
         O8AHTnUd14dch4MryrF8F7d32iwZLv7znhtlvaJxwUkM5Brk6kbB028OUsG0aZCFYErl
         BV1Q==
X-Gm-Message-State: AOAM532TPpOzLCZ5f/0vlimkWg5cciqv00LZmmjOOXA2/KuphV9rEBjV
        JUMdOpbAr1+8jjWQNYWz5yYln13LMZDI/r0RIruWIw==
X-Google-Smtp-Source: ABdhPJzMS7BtGIQh8cESpYHrbhMadhEtmLBuB9bFrx9/woxVFyhQcPmhwMltTsTby4MdsFXxO4pEUxFbcg/G+qcp0sU=
X-Received: by 2002:a05:6e02:190b:: with SMTP id w11mr8370029ilu.150.1638974067160;
 Wed, 08 Dec 2021 06:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com> <20211208024607.1784932-2-irogers@google.com>
 <a3cf5b74-1a1b-ef85-1ad3-034e797848e2@huawei.com>
In-Reply-To: <a3cf5b74-1a1b-ef85-1ad3-034e797848e2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Dec 2021 06:34:14 -0800
Message-ID: <CAP-5=fV5YDghE5pHZX2+OxguZaeO_JSSXimghUGLhCaCOoCH0w@mail.gmail.com>
Subject: Re: [PATCH 01/22] libperf: Add comments to perf_cpu_map.
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 4:06 AM John Garry <john.garry@huawei.com> wrote:
>
> On 08/12/2021 02:45, Ian Rogers wrote:
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > index 840d4032587b..1c1726f4a04e 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -4,9 +4,16 @@
> >
> >   #include <linux/refcount.h>
> >
> > +/**
> > + * A sized, reference counted, sorted array of integers representing CPU
> > + * numbers. This is commonly used to capture which CPUs a PMU is associated
> > + * with.
> > + */
> >   struct perf_cpu_map {
> >       refcount_t      refcnt;
> > +     /** Length of the map array. */
> >       int             nr;
> > +     /** The CPU values. */
> >       int             map[];
>
> would simply more distinct names for the variables help instead of or in
> addition to comments?

Thanks John! I agree. The phrase that is often used is intention
revealing names. The kernel style for naming is to be brief:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming
These names are both brief. nr is a little unusual, of course an
integer is a number - size and length are common names in situations
like these. In this case number makes sense as it is the number of
CPUs in the array, and there is a certain readability in saying number
of CPUs and not length or size of CPUs. The name map I have issue
with, it is always a smell if you are calling a variable a data type.
Given the convention in the context of this code I decided to leave
it. Something like array_of_cpu_values would be more intention
revealing but when run through the variable name shrinkifier could end
up as just being array, which would be little better than map.

The guidance on comments is that they are good and to focus on the
what of what the code is doing:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting
refcnt was intention revealing enough and so I didn't add a comment to it.

> Generally developers don't always check comments where the struct is
> defined when the meaning could be judged intuitively

Agreed. I think there could be a follow up to change to better names.
As I was lacking a better suggestion I think for the time being, and
in this patch set, we can keep things as they are.

Thanks,
Ian

> Thanks,
> John
>
