Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758FE582A85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiG0QRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234775AbiG0QRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:17:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BA24BD12;
        Wed, 27 Jul 2022 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LPMXQOBIpXqbSvMXkjlhNJufQOlEa4d6lTn7ztnWQ7c=; b=cWWgFHkQUPkWGVGqx1nyuq4Shl
        9ZKbn8quhLObL5rHVgUmgSTkw9rB7EQfw5lTsGf3YbvDAgJ7x13CqDu1fgYh2b2vaxb+KBhZyu+UR
        kMOkMjT6vPHv/hngmrhDzKJC26EBy1fQfP1QFwbOSQEWiwQWFihM1d2/8a+XR0tjj6GNqkD98Es7a
        JyZjuwfXhKWJ3lfxMTju+ZyH7ZwYmX+e2IFSkMf/ljAtlLd7gPSFf3B55DHtFbNwC2Uc52VX5BkgU
        NLfx8dck9+HoHcg4pWSvCOMXy7qjUiRwcVtNHJp3pWyA9xvCIJ1gpNB1eur90Bjeai/hFXRAQTqlA
        rpIVTCGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjiZ-000kUq-MJ; Wed, 27 Jul 2022 16:17:04 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49BE2980403; Wed, 27 Jul 2022 18:17:03 +0200 (CEST)
Date:   Wed, 27 Jul 2022 18:17:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
Message-ID: <YuFk/6rY4OXHlmjA@worktop.programming.kicks-ass.net>
References: <20220725104220.1106663-1-leo.yan@linaro.org>
 <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org>
 <CABA31DoEJEyVeUgzROzzj_OA2exmj69WamaavQWi=7nWq52dxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABA31DoEJEyVeUgzROzzj_OA2exmj69WamaavQWi=7nWq52dxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 01:35:40PM -0700, Akemi Yagi wrote:

> By the way, my main workstation runs RHEL 7. ;-)

That seems highly irresponsible, given the amount of security bugs fixed
by all the relevant projects.
