Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE6259C170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiHVOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiHVOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F921C103;
        Mon, 22 Aug 2022 07:14:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5359FB8121D;
        Mon, 22 Aug 2022 14:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FB3C433D6;
        Mon, 22 Aug 2022 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661177670;
        bh=8wNe5X0Gw72Wkro8f65zPAqWrnC1TRL8FVUyazCRskk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIRhJGrIFQM1rCi5O2pE7sn9WViboQmmh6IYQjLQCWAiAnueHwrl9+G/seCWRL551
         fcdA0Gq+Moosr2wjdv/Qeqa2lwzMJ8MiJZhZFSO55iZ6hvaAL79hDYgjkURoduOJBx
         ipkg5Js0atd0Np20uMv3cCLZEdvXZCaXPbbHM/qTemhUu9uGI5gFBKxakeRf8WjBOO
         TXs4jaCLJrueGTVy6DqukTjWYDw2qomsVU/BwOunytHSPI5JKHySmscIGpB8ng60Mg
         ZBVmeOuzqTddkRBCmgsWGgE0PqdVLezHobDytxHHTMvlMw65fTJYkx5UXQYHVMjbD0
         XqD+qT3PAd/FQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D8D35404A1; Mon, 22 Aug 2022 11:14:27 -0300 (-03)
Date:   Mon, 22 Aug 2022 11:14:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        irogers@google.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse-events: Variable type completion
Message-ID: <YwOPQ4rr9eBbrxxx@kernel.org>
References: <20220816174109.7718-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816174109.7718-1-gaoxin@cdjrlc.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 17, 2022 at 01:41:09AM +0800, Xin Gao escreveu:
> 'unsigned int' is better than 'unsigned'.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  tools/perf/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f516d3821d28..bc1230f68341 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1225,7 +1225,7 @@ static char *pmu_formats_string(struct list_head *formats)
>  	struct perf_pmu_format *format;
>  	char *str = NULL;
>  	struct strbuf buf = STRBUF_INIT;
> -	unsigned i = 0;
> +	unsigned int i = 0;
>  
>  	if (!formats)
>  		return NULL;
> -- 
> 2.30.2

-- 

- Arnaldo
