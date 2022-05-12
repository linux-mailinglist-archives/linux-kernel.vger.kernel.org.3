Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6973352450D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349941AbiELFfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349953AbiELFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:35:09 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4122240D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:34:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v12so5595863wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhLtVz1FRAzb3Wip7NWIfX+3QPBn/XeMwI4uERVQ/Jo=;
        b=RuvhUZUOlztbT/2DePt/FKUJBDqXzRIB/AYcHBvOOSd5Ov2BFpN+p0ymfOgTTEgXBc
         xKdzHwMen+4KfG53X/Pmz6+5hYc3+AI6nklFLzqDtFUgMuNmV9fDhCGGIW3KH108HBfZ
         r6zcm15GC9gEKRl1rLPdUXaAGo4V63Zq3q/JcCDOUlNEH3k1pI0TsX5/vpxH2VZUGDKX
         4HAuGUnPYBj/eLA/XOxBLDtzsHZJxSW/70+uHhT+yIUy8qMJziLdmwUOYgrOH3f2dg++
         N0vsujtEWqEkJVddToQjApEqj3G0AvnomJyxhiFZ+P7kobDyK9CNTJEl8VpWV1yBFotD
         0FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhLtVz1FRAzb3Wip7NWIfX+3QPBn/XeMwI4uERVQ/Jo=;
        b=6h0bBqAO+rbZ3xg/0xsOf2JofUzg6JweYCcRAvnNgd9TU0rPvBNkawNqETBKNRy1LH
         V78AJGoLltm4TXm/o534Z6kn9odgmPqTUr591kcn7vTeHOBL8qIn4SKiQjYYoCo666Cz
         G8dHH6PXjAO7sf0nh131AZuLqTWhFdFqdDrSe+Ttv1XrlSknAQ0kynXRRnz499qfxvB9
         SV8ECGaodl5NTHrhIHp7eOh/1WRRCbDsuJuHNJclF9WCOqQ/2WCe3l1BZPItaKrxhnVs
         ttQzJNkhuoR5W13ws6RlbFGzdcRbQnLKEPa3jmJPVH86BV93q3bIe/pebF1yF4gAEPRy
         N5Cw==
X-Gm-Message-State: AOAM533AMrpEMU91HKs+E/Ys/+i28uni3vmVztamYEvq0sqM7h4lmdZc
        RWd/Dxb++OMblemAHhkVo+ynWjlzJ3nF5XOrH2l+LQ==
X-Google-Smtp-Source: ABdhPJwsw+pEFXfJGAtDqTFXz+l63Dvsj9PSrLj9MNYGp95uyTjpMTyBFTpC8TXpj+3t/4tsfRV7D1nT4p+WD2pJ6Ds=
X-Received: by 2002:adf:d1e9:0:b0:20c:6c76:14d5 with SMTP id
 g9-20020adfd1e9000000b0020c6c7614d5mr26262739wrd.375.1652333679772; Wed, 11
 May 2022 22:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220506122601.367589-1-adrian.hunter@intel.com>
 <20220506122601.367589-22-adrian.hunter@intel.com> <CAP-5=fWjpP8hhzPuS7tvGaPh9UFJ7Fdyg0B41B4100XbsqFUBA@mail.gmail.com>
 <ec62edc2-f4fc-82db-c001-23d43137557c@intel.com>
In-Reply-To: <ec62edc2-f4fc-82db-c001-23d43137557c@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 11 May 2022 22:34:24 -0700
Message-ID: <CAP-5=fW4k0A_iYPYq5pS59GmvUa8uUkzS2c2C5ruyKd40wjU8A@mail.gmail.com>
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

On Wed, May 11, 2022 at 12:03 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 6/05/22 23:51, Ian Rogers wrote:
> > On Fri, May 6, 2022 at 5:26 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> Add comments for 'system_wide' and 'requires_cpu' booleans
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/lib/perf/include/internal/evsel.h | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> >> index 77fbb8b97e5c..cc8f1ba790bd 100644
> >> --- a/tools/lib/perf/include/internal/evsel.h
> >> +++ b/tools/lib/perf/include/internal/evsel.h
> >> @@ -49,7 +49,16 @@ struct perf_evsel {
> >>
> >>         /* parse modifier helper */
> >>         int                      nr_members;
> >> +       /*
> >> +        * system_wide is for events that need to be on every CPU, irrespective
> >> +        * of user requested CPUs or threads. Map propagation will not override
> >> +        * this events own_cpus, which will contribute to evlist all_cpus.
> >
> > So this muddies my understanding of cpus and own_cpus (sigh, again
> > undocumented). I believe cpus to be the set of CPUs (or any CPU, aka
> > dummy) that perf_event_open happens on. all_cpus in evlist is the
> > union of all the evsels cpus (ie not related to own_cpus as described
> > here). Own_cpus I believe to be what's computed at parse-event time
> > from sysfs. Is this a typo in the comment or quite likely my error?
>
> A 'system_wide' event is not created by the parser, so own_cpus is set
> by the code adding the event.

I think I may be misreading the comment. Perhaps it should read:

system_wide is for events that need to be on every CPU, irrespective
of user requested CPUs or threads. Map propagation will not override
this event's own_cpus and own_cpus don't contribute to the evlist
all_cpus.

It would be nice if there were a comment on own_cpus to explain its
relationship to cpus and more broadly when it is used. Fwiw, the parse
time copy is made here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf/core#n367

I worry that if own_cpus should be used in place of cpus then
iterators like evlist__for_each_cpu may need to handle this, and so
they'd be broken currently.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >> +        */
> >>         bool                     system_wide;
> >> +       /*
> >> +        * Some events, for example uncore events, require a CPU.
> >> +        * i.e. it cannot be the 'any CPU' value of -1.
> >> +        */
> >>         bool                     requires_cpu;
> >>         int                      idx;
> >>  };
> >> --
> >> 2.25.1
> >>
>
