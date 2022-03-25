Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333A24E7DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbiCYUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiCYUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158711E6EBC;
        Fri, 25 Mar 2022 12:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3DF561B43;
        Fri, 25 Mar 2022 19:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28852C004DD;
        Fri, 25 Mar 2022 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648237971;
        bh=T8OGOWwz7kfoxbwMbaXnY7tH1etjIVc+GciGN2apkwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yjkx/J16Z+JfCO/04NozBmw4mOdQf2Ke/0+14rPWPjfpo9pRHQgaZe+63pK0wywe0
         +Mz6XBa9NzAJXTV0yTBRLouk/Y/AgIs/9x62M1KwgyeL/RnW3TGEqqmZlvqYxBcv+N
         ST+83zw6ZQ2DSpYiBWTz/lydd4pLHfkd/leyaxzwfWJg2IaKBtz9I72K4tfsw2tx7b
         xpssA1ZB85wPZMYmsbl43KijbPdM90+0HfuwnohPH7hY2ZHKvEH/zEFNatKA0ZMK9f
         rpXSwzaDpIHx6hsqUv+iFF4xb1A2EO67aorYiA1PZq57RWTscxXpM5iWhCR9ECLhPU
         oDTVoWp4stI9Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A332340407; Fri, 25 Mar 2022 16:52:48 -0300 (-03)
Date:   Fri, 25 Mar 2022 16:52:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] libperf tests: Fix typo in the error message
Message-ID: <Yj4dkBf5HCiZpj0U@kernel.org>
References: <20220325043829.224045-1-nakamura.shun@fujitsu.com>
 <20220325043829.224045-2-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325043829.224045-2-nakamura.shun@fujitsu.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 25, 2022 at 01:38:23PM +0900, Shunsuke Nakamura escreveu:
> This patch corrects a typo in the error message.

Thanks, applied. Will wait for review for the other patches in this
series.

- Arnaldo

 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/tests/test-evlist.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index fa854c83b7e7..ed616fc19b4f 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -69,7 +69,7 @@ static int test_stat_cpu(void)
>  	perf_evlist__set_maps(evlist, cpus, NULL);
>  
>  	err = perf_evlist__open(evlist);
> -	__T("failed to open evsel", err == 0);
> +	__T("failed to open evlist", err == 0);
>  
>  	perf_evlist__for_each_evsel(evlist, evsel) {
>  		cpus = perf_evsel__cpus(evsel);
> @@ -130,7 +130,7 @@ static int test_stat_thread(void)
>  	perf_evlist__set_maps(evlist, NULL, threads);
>  
>  	err = perf_evlist__open(evlist);
> -	__T("failed to open evsel", err == 0);
> +	__T("failed to open evlist", err == 0);
>  
>  	perf_evlist__for_each_evsel(evlist, evsel) {
>  		perf_evsel__read(evsel, 0, 0, &counts);
> @@ -187,7 +187,7 @@ static int test_stat_thread_enable(void)
>  	perf_evlist__set_maps(evlist, NULL, threads);
>  
>  	err = perf_evlist__open(evlist);
> -	__T("failed to open evsel", err == 0);
> +	__T("failed to open evlist", err == 0);
>  
>  	perf_evlist__for_each_evsel(evlist, evsel) {
>  		perf_evsel__read(evsel, 0, 0, &counts);
> @@ -507,7 +507,7 @@ static int test_stat_multiplexing(void)
>  	perf_evlist__set_maps(evlist, NULL, threads);
>  
>  	err = perf_evlist__open(evlist);
> -	__T("failed to open evsel", err == 0);
> +	__T("failed to open evlist", err == 0);
>  
>  	perf_evlist__enable(evlist);
>  
> -- 
> 2.25.1

-- 

- Arnaldo
