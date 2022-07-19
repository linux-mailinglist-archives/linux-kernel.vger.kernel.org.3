Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDC57A22A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbiGSOsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiGSOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA0EAC;
        Tue, 19 Jul 2022 07:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1D7EB81BA8;
        Tue, 19 Jul 2022 14:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7F5C341C6;
        Tue, 19 Jul 2022 14:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658242093;
        bh=jQDBpKUPuS4QC3Q9uIzC0xayggwQvXbVDlw0Rl50Qrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmcv5Xonpoy6zAUsawNh+VF2BMcBUnGoZfP9iiQ406knP1vTiDBKU1najtsnKDpXF
         giDdUVdBLAzAkiu3Rt8ntdKLHXVMpb6S4h144nfPQ3T76sHTyoADPBR1FA3Iq4NS+i
         M8R2UNjGm+RKLY0dAwMLqpEDxZgBYMujDEhz4YjpfPnnOv5MGwIS/+QKJcZVzHk3Ad
         PnSRZRh2TSBrgDa0KIryvGfF+WCcv2YYFny0iNemnnRENyhdDf6CkTeZr9Tt51Fkm9
         KQmqPYOtI1E2qyskqtsb2esOKOuXcTsQuSZBXEMnriOy9V2gBi3vlsJomZ5ziiog6Q
         cn0omvz00q47w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC3DE40374; Tue, 19 Jul 2022 11:48:10 -0300 (-03)
Date:   Tue, 19 Jul 2022 11:48:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, mhiramat@kernel.org, yangjihong1@huawei.com,
        irogers@google.com, chenzechuan1@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Fix comment typo
Message-ID: <YtbEKoMgrvNwiiM+@kernel.org>
References: <20220716043957.42829-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716043957.42829-1-wangborong@cdjrlc.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 16, 2022 at 12:39:57PM +0800, Jason Wang escreveu:
> The double `the' is duplicated in the comment, remove one.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  tools/perf/util/probe-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 062b5cbe67af..67c12d5303e7 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1349,7 +1349,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  				/*
>  				 * Adjust the number of lines here.
>  				 * If the number of lines == 1, the
> -				 * the end of line should be equal to
> +				 * end of line should be equal to
>  				 * the start of line.
>  				 */
>  				lr->end--;
> -- 
> 2.35.1

-- 

- Arnaldo
