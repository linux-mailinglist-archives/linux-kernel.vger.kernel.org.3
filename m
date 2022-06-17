Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0C54FCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFQSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFQSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:31:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDAF33350;
        Fri, 17 Jun 2022 11:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B896B82A03;
        Fri, 17 Jun 2022 18:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098C7C3411B;
        Fri, 17 Jun 2022 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655490698;
        bh=2/knutDxckjBdkBXfrZLSAKW2wg72XY5+Fy5skCxEVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MF5JdofyYxxqaZmk43bNRCfBOacUQ3k+eK3Ow+OY1V525OWbgv5koJy9Tr8ZNInpo
         YDQCY7bkTboxclR2QJbf/OJ6uuD6Sag6yesPKdWq/z3uZ2c70pQ6DMv+8SyhG8nfH7
         VXTW3VvVeW+1BQBsmizWooSX1iW0mO8+RkZ0vOdK2lveM/eRfDbBjla/Idx+I9nUYf
         QhKavYZ6mNUX/L0Sh0/AY5pAhy5nMFQ7al+M4+jf8mhK8dxSAztFEd72ACq+OY6b+x
         gMZ7fmJdVAtHskdpR3TpKuM87mBo8Fdgz7M8M8KEg2Wqr+RVHKH9WqgBC8+W5hMgrR
         qOvj7+/fd+RDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 678864096F; Fri, 17 Jun 2022 15:31:35 -0300 (-03)
Date:   Fri, 17 Jun 2022 15:31:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf expr: Allow exponents on floating point values
Message-ID: <YqzIh1qx976G96NB@kernel.org>
References: <20220527020653.4160884-1-irogers@google.com>
 <a959de1b-c938-0e9f-73a4-89fbeb33cf97@linux.ibm.com>
 <CAP-5=fVY-tdEzXi8fcPGQdQf+F93OTzA7z6UksQy=c6Vh7uPpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVY-tdEzXi8fcPGQdQf+F93OTzA7z6UksQy=c6Vh7uPpA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 15, 2022 at 10:16:32PM -0700, Ian Rogers escreveu:
> On Wed, Jun 8, 2022 at 10:47 PM kajoljain <kjain@linux.ibm.com> wrote:
> 
> > Patch looks fine to me
> >
> > Reviewed-By: Kajol Jain<kjain@linux.ibm.com>
> >
> 
> Thanks! Arnaldo, can this one go in?

Sure, applied.

- Arnaldo
 
> Ian
> 
> 
> >
> > On 5/27/22 07:36, Ian Rogers wrote:
> > > Pass the optional exponent component through to strtod that already
> > > supports it. We already have exponents in ScaleUnit and so this adds
> > > uniformity.
> > >
> > > Reported-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/expr.c | 2 ++
> > >  tools/perf/util/expr.l  | 2 +-
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > > index d54c5371c6a6..5c0032fe93ae 100644
> > > --- a/tools/perf/tests/expr.c
> > > +++ b/tools/perf/tests/expr.c
> > > @@ -97,6 +97,8 @@ static int test__expr(struct test_suite *t
> > __maybe_unused, int subtest __maybe_u
> > >       ret |= test(ctx, "2.2 > 2.2", 0);
> > >       ret |= test(ctx, "2.2 < 1.1", 0);
> > >       ret |= test(ctx, "1.1 > 2.2", 0);
> > > +     ret |= test(ctx, "1.1e10 < 1.1e100", 1);
> > > +     ret |= test(ctx, "1.1e2 > 1.1e-2", 1);
> > >
> > >       if (ret) {
> > >               expr__ctx_free(ctx);
> > > diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> > > index 0a13eb20c814..4dc8edbfd9ce 100644
> > > --- a/tools/perf/util/expr.l
> > > +++ b/tools/perf/util/expr.l
> > > @@ -91,7 +91,7 @@ static int literal(yyscan_t scanner)
> > >  }
> > >  %}
> > >
> > > -number               ([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)
> > > +number               ([0-9]+\.?[0-9]*|[0-9]*\.?[0-9]+)(e-?[0-9]+)?
> > >
> > >  sch          [-,=]
> > >  spec         \\{sch}
> >

-- 

- Arnaldo
