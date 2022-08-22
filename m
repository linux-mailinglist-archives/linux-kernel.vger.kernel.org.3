Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D459C181
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiHVORY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbiHVOPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3BB39B83;
        Mon, 22 Aug 2022 07:15:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9964611CE;
        Mon, 22 Aug 2022 14:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9E2C433D7;
        Mon, 22 Aug 2022 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661177727;
        bh=Oix1p2KbrDnzMNau0mgxNi6/FmkSa6JsnVHCR7S3pq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qz4dQihBJnv7vwUTo/pigPTkragOf2QAU/3EvXOLuKewKuDVF0wDk0KZjJhZ4uD+F
         yvbhv7mft0DlJoaswJqNWZdZ7C2To3dDw4RaSD6u8zM0GYYErkeAmmZoHSZU4gOmN/
         NnHScIf3PiiGYvtpMASXpOKmKN766VFb3UqOhdsXlpc1u8qWU+SxCYWLA1RkzlnWA9
         /kHtLRDhoS2XEfqvLppnlxMXdcSa2HXutkz6vnXAkRoy/06fzsjL+8cDTrS8aLegV8
         61cthCAgtg+1tzZUCJITye/NVq3ggDgIDhxCSsuR+FklDHNHMeZINKN9PJ/BLIAgpa
         KCkJkDJOwwsCg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87AA2404A1; Mon, 22 Aug 2022 11:15:24 -0300 (-03)
Date:   Mon, 22 Aug 2022 11:15:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        irogers@google.com, john.garry@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf metrics: Variable type completion
Message-ID: <YwOPfKRggard+jGh@kernel.org>
References: <20220816173804.7539-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816173804.7539-1-gaoxin@cdjrlc.com>
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

Em Wed, Aug 17, 2022 at 01:38:04AM +0800, Xin Gao escreveu:
> 'unsigned int' is better than 'unsigned'.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ee8fcfa115e5..8926de9617ef 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1620,7 +1620,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
>  				    struct rblist *new_metric_events,
>  				    struct rblist *old_metric_events)
>  {
> -	unsigned i;
> +	unsigned int i;
>  
>  	for (i = 0; i < rblist__nr_entries(old_metric_events); i++) {
>  		struct rb_node *nd;
> -- 
> 2.30.2

-- 

- Arnaldo
