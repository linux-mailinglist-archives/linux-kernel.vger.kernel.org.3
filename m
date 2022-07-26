Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95F1581B25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiGZUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGZUfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:35:54 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173910CB;
        Tue, 26 Jul 2022 13:35:53 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so66518wme.0;
        Tue, 26 Jul 2022 13:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzfldDnwiZ1L6vukyYNiW1lGtHYIp/Q69JeDkFAi97M=;
        b=NrBKrq5r54CNRqCiHqc+b0XCUq+6TNDZRGDtHsxLbYGlx7g2URPcV3bKsqigURnhDk
         xLN9L/OSOiI/ApnuRADRiey8zBDOAl16OsZwMWxB1hqQRRG4YiaBpMPfqKa7RxArAB9C
         1iLMkphn+eyY77ecHJ50QhdbGN3LdA0aBrjJ24Ll8FjNbs+o+aswEBenYfCoXpK/9hgM
         wAo5uts4yAa8FDtmUNPMEGS9A9WUE+mdXgAXgwHKYFqFd0LufUcOScwhdX4TotHCdNkW
         51xMUhp8Pu8RBrQrx0Q1LnBpWIBOo4sMe043enOzzBITyUBbqa2K6+QgJOeOQiIDWhGy
         6vyw==
X-Gm-Message-State: AJIora8G2l+MeNPHMiNgOxDa/BBLsbbykbEu3UxotVVNZ65Io3v2eAnA
        bQC60pfwV0LSJj6sVy3q1foilSrtg5ohocCOJhw=
X-Google-Smtp-Source: AGRyM1tmpHDUGYkF3Pa0LuFMVPwSUfzWWt+oKsCfgWxV9rShxvWw0PrOPEUryVbTGeQlSFOd0x7JI+YXckH6bcc0s5E=
X-Received: by 2002:a05:600c:2d4c:b0:3a3:22c0:c3dd with SMTP id
 a12-20020a05600c2d4c00b003a322c0c3ddmr618767wmg.107.1658867752308; Tue, 26
 Jul 2022 13:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com> <YuBDw/+7McESS05X@kernel.org>
In-Reply-To: <YuBDw/+7McESS05X@kernel.org>
From:   Akemi Yagi <toracat@elrepo.org>
Date:   Tue, 26 Jul 2022 13:35:40 -0700
Message-ID: <CABA31DoEJEyVeUgzROzzj_OA2exmj69WamaavQWi=7nWq52dxw@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Alan Bartlett <ajb@elrepo.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:

> > So I'm somewhat concerned about perf supporting unsupported
> > distributions and this holding the code base back. RHEL7 was launched
> > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > Maintenance Support 2" phase which is defined to mean [2]:
[...]

> In this specific supporting things that people report using, like was
> done in this case, isn't such a big problem.
>
> Someone reported a problem in a system they used, the author of the code
> in question posted a patch allowing perf to be used in such old systems,
> doesn't get in the way of newer systems, small patch, merged, life goes
> on.
>
> Sometimes some organizations are stuck with some distro till they can go
> thru re-certifications, bidding for new hardware, whatever, and then
> they want to continue using the latest perf on those systems because
> they want to benefit from new features we're working on that work on
> such systems. If the cost is small, like in this case, I see no problems
> to have perf working on such older systems.
>
> - Arnaldo

Just wanted to make a note about the "old" systems.

While RHEL 7 might be regarded as "old" in general, it may not be so
in the world of Enterprise Linux. A graph of EPEL mirror stats [1],
while it is from about a year ago, shows EL 7 (RHEL 7 and its
rebuilds) has a huge user base and was still growing quite fast.

By the way, my main workstation runs RHEL 7. ;-)

Akemi

[1] https://twitter.com/mattdm/status/1447224008831811588
