Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87E547C86E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhLUUvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 15:51:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54424 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 15:51:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58E51617AF;
        Tue, 21 Dec 2021 20:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E08C36AE8;
        Tue, 21 Dec 2021 20:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640119897;
        bh=ShMB5dT68WayeT6e8kjQhcPaJ9uutezpuq7ANyz1efs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P62b7nzKPUeyjCy5kKVU6XcE48d/5ys6qChM/kEpDshfl2cv+xJ9FPlb9Ijoh4a8x
         mjxniL7ztsGdaBfq4yTq2sMVdu3xBOCUhwqFyAm2kMPV2z5YLjxBCJGvS2DFOgMBec
         ihZyJdofsCApswFmE1gaaESikr7T68FTeXOALvfMm6P2NZUwMgsUDgue89mJjN2F9U
         FEvJc9ZOsIJJHUbYgvQoXoYUqQSkVE0V+kEA+mE+Nii8czfWd8Xzx17QbjJvfEolya
         NuXSRo+a0GPVR4vif8QUKr7uIeh97NCY+NDlAZJv9+s1HaIJxgHIXU2HvpNHtjdWx+
         Whn0yNCOvQuDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6D6640B92; Tue, 21 Dec 2021 17:51:35 -0300 (-03)
Date:   Tue, 21 Dec 2021 17:51:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        inux-perf-users@vger.kernel.org
Subject: Re: [PATCH 03/12] perf test: Use 3 digits for test numbering now we
 can have more tests
Message-ID: <YcI+V/86hpWWyGA4@kernel.org>
References: <20211215160403.69264-1-carsten.haitzler@foss.arm.com>
 <20211215160403.69264-3-carsten.haitzler@foss.arm.com>
 <20211221123540.GA41974@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221123540.GA41974@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 21, 2021 at 08:35:40PM +0800, Leo Yan escreveu:
> On Wed, Dec 15, 2021 at 04:03:54PM +0000, carsten.haitzler@foss.arm.com wrote:
> > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > 
> > This is in preparation for adding more tests that will need the test
> > number to be 3 digts so they align nicely in the output.
> > 
> > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Cherry picking this one while the other issues get resolved.

Thanks, applied.

- Arnaldo
 
> > ---
> >  tools/perf/tests/builtin-test.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 849737ead9fd..8652dcc4912c 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -435,7 +435,7 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
> >  			continue;
> >  
> >  		st.file = ent->d_name;
> > -		pr_info("%2d: %-*s:", i, width, test_suite.desc);
> > +		pr_info("%3d: %-*s:", i, width, test_suite.desc);
> >  
> >  		if (intlist__find(skiplist, i)) {
> >  			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> > @@ -485,7 +485,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >  				continue;
> >  		}
> >  
> > -		pr_info("%2d: %-*s:", i, width, test_description(t, -1));
> > +		pr_info("%3d: %-*s:", i, width, test_description(t, -1));
> >  
> >  		if (intlist__find(skiplist, i)) {
> >  			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
> > @@ -525,7 +525,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
> >  							curr, argc, argv))
> >  					continue;
> >  
> > -				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
> > +				pr_info("%3d.%1d: %-*s:", i, subi + 1, subw,
> >  					test_description(t, subi));
> >  				test_and_print(t, subi);
> >  			}
> > @@ -560,7 +560,7 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
> >  		if (!perf_test__matches(t.desc, curr, argc, argv))
> >  			continue;
> >  
> > -		pr_info("%2d: %s\n", i, t.desc);
> > +		pr_info("%3d: %s\n", i, t.desc);
> >  
> >  	}
> >  
> > @@ -582,14 +582,14 @@ static int perf_test__list(int argc, const char **argv)
> >  		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
> >  			continue;
> >  
> > -		pr_info("%2d: %s\n", i, test_description(t, -1));
> > +		pr_info("%3d: %s\n", i, test_description(t, -1));
> >  
> >  		if (has_subtests(t)) {
> >  			int subn = num_subtests(t);
> >  			int subi;
> >  
> >  			for (subi = 0; subi < subn; subi++)
> > -				pr_info("%2d:%1d: %s\n", i, subi + 1,
> > +				pr_info("%3d:%1d: %s\n", i, subi + 1,
> >  					test_description(t, subi));
> >  		}
> >  	}
> > -- 
> > 2.32.0
> > 

-- 

- Arnaldo
