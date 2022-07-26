Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234C5581A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 21:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiGZTnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiGZTnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 15:43:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088F530545;
        Tue, 26 Jul 2022 12:43:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AAD28CE1B09;
        Tue, 26 Jul 2022 19:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED5CC433D6;
        Tue, 26 Jul 2022 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658864582;
        bh=XI0jgUmI2iNd1Q+wYXwScLx8biTvp7S+wXgGGnG4Sm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MTLGKs2s7xrqMgMvJszNIfuYaxjg2/bdh1sS0STkNxPfac5GfJ0bbRYTKQZU2vyMF
         Z9PlFkixMxKGACA4n01vocJRchjJocDTUUxeqO7TjtLS3DcK9sPomRY6x33KEYaEfW
         afpKRgdIVixJ4O2034vGCU2hvyjdDFDzkljNoC+Nh9Kdn4yZR2SL8SSpTfQ2P/vGoE
         mX/r9JcEPh/ISezyjPhwUMjqG382LW9dPeImWoq9gfiF+ACS/RFCiPe919Hu/WOD2y
         jLPrwiufiaBtF9V8BAXLmrLUslH0L9UMyyI0hmdX+PnwHtKargImVxxGghVXScHVLO
         ZENWV9jYwbq9A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0CA4240374; Tue, 26 Jul 2022 16:43:00 -0300 (-03)
Date:   Tue, 26 Jul 2022 16:42:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
Message-ID: <YuBDw/+7McESS05X@kernel.org>
References: <20220725104220.1106663-1-leo.yan@linaro.org>
 <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
> On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
> >
> > On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >
> > > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > > The distro doesn't upgrade from python2 to python3, this causes the
> > > > building error that the python script is not python2 compliant.
> > > >
> > > > To fix the building failure, this patch changes from the python f-string
> > > > format to traditional string format.
> > >
> > > Thanks, applied.
> > >
> > > - Arnaldo
> >
> > Leo / Arnaldo,
> >
> > Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> > ELRepo Project) experienced when attempting to build on RHEL7.
> >
> > So --
> >
> > Tested-by: Alan Bartlett <ajb@elrepo.org>
> >
> > Hopefully you will get it to Linus in time for -5.19 GA.
 
> So I'm somewhat concerned about perf supporting unsupported
> distributions and this holding the code base back. RHEL7 was launched
> 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> Maintenance Support 2" phase which is defined to mean [2]:
> 
> ```
> During the Maintenance Support Phase for Red Hat Enterprise Linux
> Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
> Linux version 7, Red Hat defined Critical and Important impact
> Security Advisories (RHSAs) and selected (at Red Hat discretion)
> Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
> become available. Other errata advisories may be delivered as
> appropriate.
> 
> New functionality and new hardware enablement are not planned for
> availability in the Maintenance Support (RHEL 8 & 9) Phase and
> Maintenance Support 2 (RHEL 7) Phase.
> ```
> 
> >From this definition, why would RHEL7 pick up a new perf tool? I don't
> think they would and as such we don't need to worry about supporting
> it. RHEL8 defaults to python 3 and full support ends for it next year.
> Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
> this in future. I think the bar for caring should be "will the distro
> pick up our code", if we don't do this then we're signing up to not
> allowing tools to update for 10 years! If someone is building a kernel
> and perf tool on RHEL7 then they should be signing up to also deal
> with tool chain issues, which in this case can mean installing
> python3.

In this specific supporting things that people report using, like was
done in this case, isn't such a big problem.

Someone reported a problem in a system they used, the author of the code
in question posted a patch allowing perf to be used in such old systems,
doesn't get in the way of newer systems, small patch, merged, life goes
on.

Sometimes some organizations are stuck with some distro till they can go
thru re-certifications, bidding for new hardware, whatever, and then
they want to continue using the latest perf on those systems because
they want to benefit from new features we're working on that work on
such systems. If the cost is small, like in this case, I see no problems
to have perf working on such older systems.

- Arnaldo
