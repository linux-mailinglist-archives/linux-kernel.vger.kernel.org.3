Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C34E8136
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiCZN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiCZN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:56:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DFD27FCF;
        Sat, 26 Mar 2022 06:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF5F1B8093C;
        Sat, 26 Mar 2022 13:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A46C340EE;
        Sat, 26 Mar 2022 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648302876;
        bh=tpj4OYga0btXBeWUbbOyEBya0KUQhNIu70pMx0FFR+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pC5bd1M8keEZTGI+g36EAA1WcN2uAqK19jpI/xZhwXA15rg3UfnQZdpwgsyKQBbT4
         24eA+/wErB/sMcYeAuAae1HYusiC4azTxCGqn6UMNXs6ClCcz3yzq1Id0jeMTHV3lp
         QvpPJ4RRof8D6qULdkt90wE3OH5Rcy8CW3xaCfPKKq65AUMeYLUXqGD85gBwIei8ne
         GMIpg/6f490FxlFyDOxor3HCFXD6GUS2OqTiCCMZVodCErePotJ+6xOh4nzjxFPDUR
         yR8z2ggLW9lLUtVUGsOS0H4UVO+LFHGggW4K8d10QvfM8+NjCUkfxKSE/qnFYV/nnZ
         +ocLUG3Ej85qQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5930140407; Sat, 26 Mar 2022 10:54:34 -0300 (-03)
Date:   Sat, 26 Mar 2022 10:54:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        leo.yan@linaro.org, benh@kernel.crashing.org,
        Nick.Forrington@arm.com, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 3/4] perf mem: Support mem_lvl_num in c2c command
Message-ID: <Yj8bGiAlZL9mUW+c@kernel.org>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-4-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324183323.31414-4-alisaidi@amazon.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 24, 2022 at 06:33:22PM +0000, Ali Saidi escreveu:
> In addition to summarizing data encoded in mem_lvl also support data
> encoded in mem_lvl_num.
> 
> Since other architectures don't seem to populate the mem_lvl_num field
> here there shouldn't be a change in functionality.

I'm removing this one as well, will wait for further discussion as the
other two got yanked out as per Leo's review comments.

The first patch is in with Leo's ack.

- Arnaldo
 
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Tested-by: German Gomez <german.gomez@arm.com>
> Reviewed-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/mem-events.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ed0ab838bcc5..e5e405185498 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
>  	u64 daddr  = mi->daddr.addr;
>  	u64 op     = data_src->mem_op;
>  	u64 lvl    = data_src->mem_lvl;
> +	u64 lnum   = data_src->mem_lvl_num;
>  	u64 snoop  = data_src->mem_snoop;
>  	u64 lock   = data_src->mem_lock;
>  	u64 blk    = data_src->mem_blk;
> @@ -527,16 +528,18 @@ do {				\
>  			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
>  			if (lvl & P(LVL, IO))  stats->ld_io++;
>  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> -			if (lvl & P(LVL, L3 )) {
> +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> +				stats->ld_l1hit++;
> +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> +				stats->ld_l2hit++;
> +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3)) {
>  				if (snoop & P(SNOOP, HITM))
>  					HITM_INC(lcl_hitm);
>  				else
>  					stats->ld_llchit++;
>  			}
>  
> -			if (lvl & P(LVL, LOC_RAM)) {
> +			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
>  				stats->lcl_dram++;
>  				if (snoop & P(SNOOP, HIT))
>  					stats->ld_shared++;
> -- 
> 2.32.0

-- 

- Arnaldo
