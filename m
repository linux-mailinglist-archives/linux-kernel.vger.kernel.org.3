Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E44709D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbhLJTLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:11:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB632C061746;
        Fri, 10 Dec 2021 11:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13785CE2D0F;
        Fri, 10 Dec 2021 19:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C990C00446;
        Fri, 10 Dec 2021 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163294;
        bh=z3sezbLgZh/y8qDAsW6jd6WdSWNncBRZ7pPOSFYAk48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/1UpjXnbt8RpBhSm1bxPs0Fgj8o7daTj17D5QRdevmhIB2fsHTuvraPmiBHd7GAL
         z1rnKuhO+HgU9FMwY+UUWGn+fXwK5ob2eEXReQgk8NdDGfiWvY6lQjoXTc61EC4ov0
         KftOIOmChIxwzQKvl9i3VqO/7IExEAXhNWolt7Dqo6hAGR00T7t3ESva7f2JYKFI1q
         U0OBpyxj2YMBpQNVeInlbDd3T4nsYqn7AooGYieabL8LojyzfjCz4KZQ9Rotd1s4wk
         z1RSFZhBc+Aa4u2mYYkPHxj19TuMHClOEmx8aByZUAFKVDBRjWuKOlxZqVnyHhbpv7
         trr9249WvRPLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 425A9405D8; Fri, 10 Dec 2021 16:08:12 -0300 (-03)
Date:   Fri, 10 Dec 2021 16:08:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
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
Subject: Re: [PATCH 01/22] libperf: Add comments to perf_cpu_map.
Message-ID: <YbOlnH0NLQdAECcK@kernel.org>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-2-irogers@google.com>
 <a3cf5b74-1a1b-ef85-1ad3-034e797848e2@huawei.com>
 <CAP-5=fV5YDghE5pHZX2+OxguZaeO_JSSXimghUGLhCaCOoCH0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV5YDghE5pHZX2+OxguZaeO_JSSXimghUGLhCaCOoCH0w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 08, 2021 at 06:34:14AM -0800, Ian Rogers escreveu:
> On Wed, Dec 8, 2021 at 4:06 AM John Garry <john.garry@huawei.com> wrote:
> >
> > On 08/12/2021 02:45, Ian Rogers wrote:
> > > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > > index 840d4032587b..1c1726f4a04e 100644
> > > --- a/tools/lib/perf/include/internal/cpumap.h
> > > +++ b/tools/lib/perf/include/internal/cpumap.h
> > > @@ -4,9 +4,16 @@
> > >
> > >   #include <linux/refcount.h>
> > >
> > > +/**
> > > + * A sized, reference counted, sorted array of integers representing CPU
> > > + * numbers. This is commonly used to capture which CPUs a PMU is associated
> > > + * with.
> > > + */
> > >   struct perf_cpu_map {
> > >       refcount_t      refcnt;
> > > +     /** Length of the map array. */
> > >       int             nr;
> > > +     /** The CPU values. */
> > >       int             map[];
> >
> > would simply more distinct names for the variables help instead of or in
> > addition to comments?

Well, in this case the typical usage doesn't help, as 'struct
perf_cpu_map' are being used simply as "map" where it should be cpu_map,
so we would have:

	cpu_map->nr

And all should be obvious, no? Otherwise we would have redundant 'cpu',
like:

	cpu_map->nr_cpus

And 'map' should really be entries, so:

	cpu_map->entries[index];

Would be clear enough, o?
 
> Thanks John! I agree. The phrase that is often used is intention
> revealing names. The kernel style for naming is to be brief:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#naming
> These names are both brief. nr is a little unusual, of course an
> integer is a number - size and length are common names in situations
> like these. In this case number makes sense as it is the number of
> CPUs in the array, and there is a certain readability in saying number
> of CPUs and not length or size of CPUs. The name map I have issue
> with, it is always a smell if you are calling a variable a data type.
> Given the convention in the context of this code I decided to leave
> it. Something like array_of_cpu_values would be more intention
> revealing but when run through the variable name shrinkifier could end
> up as just being array, which would be little better than map.
> 
> The guidance on comments is that they are good and to focus on the
> what of what the code is doing:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting
> refcnt was intention revealing enough and so I didn't add a comment to it.
> 
> > Generally developers don't always check comments where the struct is
> > defined when the meaning could be judged intuitively
> 
> Agreed. I think there could be a follow up to change to better names.
> As I was lacking a better suggestion I think for the time being, and
> in this patch set, we can keep things as they are.
> 
> Thanks,
> Ian
> 
> > Thanks,
> > John
> >

-- 

- Arnaldo
