Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC00E578AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbiGRTdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGRTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:33:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925830F6C;
        Mon, 18 Jul 2022 12:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C7C6B81742;
        Mon, 18 Jul 2022 19:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB661C341C0;
        Mon, 18 Jul 2022 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658172779;
        bh=FMa1KhlAiwp2G1WhEAkwuw6/wN8S4rjQj7kD636hpCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4T3XGYkIt1++7T3uifcQ426CtNptZxWaZCOJrRNNldzsShwMlGDkFa8ZyYXykYHY
         H2Hh5mJvvHuNXPrRivmLCk/1YaZ5nEzM4mkTK9cUa4A/KCIDiJswzjOIIU8uGg8He3
         Ql4qtnLSJqf0Jh++KvGKmfovIIS0B1FAG0cRej8y/ZhFOqPT6i6B181nZ4clew/KJ8
         itvrSpsploLChFRPWMRAWOoEWJIf80wUDul9nNJ7E+3wX2xVW8yscLXE92MeCjOFtj
         l9BWTzGI1D+jiL4wRat4S0G+My6yZLZSWB5zJCAwJXnepkM3mLquhYGRwIgRiIhq5D
         uuxw+n7FfZ2kw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A08340374; Mon, 18 Jul 2022 16:32:56 -0300 (-03)
Date:   Mon, 18 Jul 2022 16:32:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Blake Jones <blakejones@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add a "-m" option to "perf buildid-list".
Message-ID: <YtW1aFY4MyeqxhdH@kernel.org>
References: <20220629213632.3899212-1-blakejones@google.com>
 <Yr6u/jdLvg2TcT8s@krava>
 <YtVzVZoo5PTj0qXH@kernel.org>
 <CAP_z_CjUi-Uk_mftfw33+eac13sLyHMBtQJd8V393SaD4OocNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP_z_CjUi-Uk_mftfw33+eac13sLyHMBtQJd8V393SaD4OocNg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 18, 2022 at 10:07:32AM -0700, Blake Jones escreveu:
> Fabulous, thanks!
> 
> On Mon, Jul 18, 2022 at 7:51 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> wrote:
> > > > Signed-off-by: Blake Jones <blakejones@google.com>
> > >
> > > Acked-by: Jiri Olsa <jolsa@kernel.org>
> >
> > To clarify, b4 found v3 and that was the one applied.

Now fixing this:

  28     5.28 debian:experimental-x-mips    : FAIL gcc version 11.2.0 (Debian 11.2.0-18)
    builtin-buildid-list.c: In function 'buildid__map_cb':
    builtin-buildid-list.c:32:24: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
       32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
          |                    ~~~~^                  ~~~~~~~~~~
          |                        |                     |
          |                        long unsigned int     u64 {aka long long unsigned int}
          |                    %16llx
    builtin-buildid-list.c:32:30: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
       32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
          |                          ~~~~^                        ~~~~~~~~
          |                              |                           |
          |                              long unsigned int           u64 {aka long long unsigned int}
          |                          %16llx
    cc1: all warnings being treated as errors
  29    23.06 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110
  30     6.08 debian:experimental-x-mipsel  : FAIL gcc version 11.2.0 (Debian 11.2.0-18)
    builtin-buildid-list.c: In function 'buildid__map_cb':
    builtin-buildid-list.c:32:24: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
       32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
          |                    ~~~~^                  ~~~~~~~~~~
          |                        |                     |
          |                        long unsigned int     u64 {aka long long unsigned int}
          |                    %16llx
    builtin-buildid-list.c:32:30: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u64' {aka 'long long unsigned int'} [-Werror=format=]
       32 |         printf("%s %16lx %16lx", bid_buf, map->start, map->end);
          |                          ~~~~^                        ~~~~~~~~
          |                              |                           |
          |                              long unsigned int           u64 {aka long long unsigned int}
          |                          %16llx
    cc1: all warnings being treated as errors


These should use PRIx64, etc.

- Arnaldo
