Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE63591611
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiHLTo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHLToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:44:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA8B3B10;
        Fri, 12 Aug 2022 12:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62626B80B47;
        Fri, 12 Aug 2022 19:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF2CC433C1;
        Fri, 12 Aug 2022 19:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333461;
        bh=d5J6Tp9FjVhG52G1LaTPAJ5Rqy6Kg9F7GY/P/tvC9NQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=og8sctg7iDKGe0tQTuHc5OtoqdUaXvBn2vJ/J+O5Hb8rw4P/QOW82wRIHSp8rSxej
         IgmzwKQtUca3HtelL99Xcwh4FwWh9VYGDTJXVhK9EU8wPMJ55Xwiq3bWRHLprFtzrY
         Uz75L2ZEvvXFITeJrOfA+CjfdWIfVNBmRyJQnEkkE+x2aLBC7fpsfSewj52u+59KXr
         kGKLJhBaC7s/6oWc1WKaZz1lE+aguGlqN1Jguzoc/Pb3ePrHOjxad21du0y4aW7zqz
         Fjujcn6U8HoVgwLs/siLPCRoyHu+/7sOIXa2uj28t7rwrXi/DFtJ83AynQKxeM7d+e
         CB4sTWmr0YdaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8B9C94035A; Fri, 12 Aug 2022 16:44:18 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:44:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix typo in comments
Message-ID: <YvatkpgGPbbI6JsI@kernel.org>
References: <20220807074753.7857-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807074753.7857-1-dengshaomin@cdjrlc.com>
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

Em Sun, Aug 07, 2022 at 03:47:53AM -0400, shaomin Deng escreveu:
> Delete the rebundant word "then" in comments.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  tools/perf/tests/perf-time-to-tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index 4ad0dfbc8b21..79a0d7fc6522 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -64,7 +64,7 @@ static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
>   * This function implements a test that checks that the conversion of perf time
>   * to and from TSC is consistent with the order of events.  If the test passes
>   * %0 is returned, otherwise %-1 is returned.  If TSC conversion is not
> - * supported then then the test passes but " (not supported)" is printed.
> + * supported then the test passes but " (not supported)" is printed.
>   */
>  static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>  {
> -- 
> 2.35.1

-- 

- Arnaldo
