Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ECA48EBBB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiANOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiANOfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:35:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32392C061574;
        Fri, 14 Jan 2022 06:35:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8B7CB8260E;
        Fri, 14 Jan 2022 14:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7581EC36AEA;
        Fri, 14 Jan 2022 14:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642170914;
        bh=YJEetWShtnXEKH5zrhRuUCd8fnRphyJauxsmsUp8wQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=baWd8BFOA+M11mGJXSEjyNHoFPTnVyTYq04IxCCEp/s8K9sjF4rM3Wwkq1MwRhLmN
         F/X5ONZwXXsMjvZvOuHBga7LU8W6KnBa+Nza4IbqQXLIqmUPUeFTefqBFLP4z9nTgn
         aZOcTjctg0MhJuujqA4fEePdaO9/pddouZUNAsH/xnvybEL5P8BdjX6jsX7zxuCpG0
         5oLJF6tAzv/MCPdQnaCNtDAO24IbYMeCiwtKCsxyhn8q+Yc4htGCK5E3Vl7Yo1FoOR
         PTvQGP300KkA7mDqMg3Q5Q/vur62roVNvng39oBXSoxzIv6kVxVzsDeDCFxPTDUkeS
         VUBWH6e642B4w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B629A40714; Fri, 14 Jan 2022 11:35:12 -0300 (-03)
Date:   Fri, 14 Jan 2022 11:35:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with
 the kernel sources
Message-ID: <YeGKIAQ+INznx116@kernel.org>
References: <YeA2PAvHV+uHRhLj@kernel.org>
 <9d546cfa-93e0-5b53-9100-5e9b091fac1b@intel.com>
 <YeDAowKCU777NXSa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeDAowKCU777NXSa@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 14, 2022 at 08:15:31AM +0800, Huang Rui escreveu:
> On Fri, Jan 14, 2022 at 03:14:32AM +0800, Rafael J. Wysocki wrote:
> > On 1/13/2022 3:25 PM, Arnaldo Carvalho de Melo wrote:
> > > To pick up the changes in:
> > >
> > >    89aa94b4a218339b ("x86/msr: Add AMD CPPC MSR definitions")
<SNIP>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> 
> Thanks!
> 
> Acked-by: Huang Rui <ray.huang@amd.com>

Thanks, added both Acked-by tags to the patch.

- Arnaldo
