Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D83591615
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiHLTpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiHLTpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:45:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BAB2C655;
        Fri, 12 Aug 2022 12:45:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 446DCB82530;
        Fri, 12 Aug 2022 19:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55BCC433C1;
        Fri, 12 Aug 2022 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333517;
        bh=x1LU+rAvb8hdghngd6mOm6I1j9i/SCpuuWgVazGA4lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7YuuTDIyssLuPFnNI+uXPsguE/r1Jp6vG+Dd2TDRGjn4egzts02WhcfM8ND6g8rP
         m5HOn4tJQdcugRSzJtgi1vTLhWKZmaT7ylONwrli3NrMyQhHw5/zztVR+kDLkS0PSm
         ZNvP7ZPhuN4KDsdzjuUHmANAqd6d72e733J7ihcJWtpI1EuvS9uFDx9PPO0mkzJu89
         ujI+JxreS5r0LrO1FSFp1inT05x+bFMKrc3wuF2MMQYsOmAbOBN+NPWKYmVrfrWLm3
         ae2PhJETMOiAa3ZSMjyPYDEmT3YG46fLrXsRb8qTjGVD+ik24Jqd1UdIsYEzMkAvGc
         zXig8rz6czXZg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F36B4035A; Fri, 12 Aug 2022 16:45:14 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:45:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] perf trace: Fix typo in comments
Message-ID: <YvatyuGaOq6PIQXW@kernel.org>
References: <20220807084629.23121-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807084629.23121-1-dengshaomin@cdjrlc.com>
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

Em Sun, Aug 07, 2022 at 04:46:29AM -0400, shaomin Deng escreveu:
> Delete repeated word "and" in comments.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 7aefecb23a17..2f7b1111d8e9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2748,7 +2748,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  
>  		/*
>  		 * Suppress this argument if its value is zero and
> -		 * and we don't have a string associated in an
> +		 * we don't have a string associated in an
>  		 * strarray for it.
>  		 */
>  		if (val == 0 &&
> -- 
> 2.35.1

-- 

- Arnaldo
