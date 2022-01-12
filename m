Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA2B48CA85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355944AbiALR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:59:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48894 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355892AbiALR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:59:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E636198C;
        Wed, 12 Jan 2022 17:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8929C36AEA;
        Wed, 12 Jan 2022 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642010388;
        bh=Ls0HyapqDP6RLzagqMq2iLuycV6FXBNd3QfxH8Y1j9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACbzwXvIvbiRUMp3ICEq7LzZIy77X90vAF/EBkkFvJmt3FI5zxRHWrSl5BaNatEtA
         PvEwPsUJeyiQzN39VVXOHqvvPiptTnqxYy92kXJjZlUlrGpNT7G4qQF45BsJyLYNWW
         p8V5YIhL+ae4y4nG3a9WiKSDjJB8r/W+pIxMpjQLKdy75T2WFMhT9M25TQ4tdsTa48
         Z1Jf6rRkhpQN2kHn5kkWPvNyV4mdBzt5a9Dxkd3HwR1pIt/lmd4p8cwDnrk6vNqDXC
         c6RDwO3A9GQb19COqRSxYovi8vhKIBu4w7UrHl+adq2EwUiUD/ysuEeY5Qjg8pEoiP
         PU/QIP3fwFXCw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58A1640714; Wed, 12 Jan 2022 14:59:46 -0300 (-03)
Date:   Wed, 12 Jan 2022 14:59:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v3 1/2] perf test: Workload test of metric and
 metricgroups
Message-ID: <Yd8XEhgN/RCO8Q4l@kernel.org>
References: <20210917184240.2181186-1-irogers@google.com>
 <YU4iVcVc6uYAWft4@kernel.org>
 <158a1451-9d69-d67d-3fad-9e947112f9e6@huawei.com>
 <BD3A5CA5-B566-4FD9-9409-0329CC322060@gmail.com>
 <e7b20497-e2bb-0c63-3cea-b6f541e2361f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b20497-e2bb-0c63-3cea-b6f541e2361f@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 12, 2022 at 05:32:56PM +0000, John Garry escreveu:
> On 12/01/2022 13:34, Arnaldo Carvalho de Melo wrote:
> > > > > v3. Fix test condition (thanks to Paul A. Clarke<pc@us.ibm.com>). Add a
> > > > >       fallback case of a larger workload so that we don't ignore "<not
> > > > >       counted>".
> > > > > v2. Switched the workload to something faster.
> > > Hi Ian,
> > > 
> > > I just noticed that this test fails on my broadwell machine.
> > > 
> > > I am using acme perf/core @ 09dd3c22daaf
> > Hi,
> > 
> > Can you try with tmp.perf/perf_cpu instead?
> > 
> > There's a patch there that maybe fixes this.
> 
> Yeah, that (metricgroups) test passes on that branch. I assume it's the test
> script -a change...

Can I get  that as a Tested-by: you tag?

- Arnaldo
