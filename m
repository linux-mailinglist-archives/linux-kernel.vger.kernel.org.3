Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F418859C152
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiHVOGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiHVOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:06:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0079428725;
        Mon, 22 Aug 2022 07:06:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91FEE611AC;
        Mon, 22 Aug 2022 14:06:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA004C433B5;
        Mon, 22 Aug 2022 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661177167;
        bh=UMkROV881DKPEjhAUa1UoSgjDInquTrOOa9WqRsGrZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgJb8nov/pLvfdf7cJLsb0TqP1hmHnEd/zx6tfx9CctRYnAAWQsl17w998Smg3kUm
         JbxDEO9PKfQ7zzBcN+fSwORKE2PBO5Qrub7mx3ynrDlDFv59ztm+iNigJnJRUyKUWl
         cu86/q16v0T3RinDYU0YtVsj1Em1GYrT/rBiY9lZmwiEi6F4GGaMgC9oRDP4aMFVQi
         1iJQmIPMCuWmYxEAnXFqI4STsZfCA67h5DhstZXjWNMdsVlHkPH4QWVkQnPBP1lu6m
         dDFz7DwWqS3kkdkionJhAFqoRsAA75y/2VqYb4XMNrjJUh3Y4tRZQ6nN/8QHEpurZm
         ItrvCcT4bsjCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B20F404A1; Mon, 22 Aug 2022 11:06:04 -0300 (-03)
Date:   Mon, 22 Aug 2022 11:06:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/perf: fix repeated words in comments
Message-ID: <YwONTFjom5v6Y1T/@kernel.org>
References: <20220822123919.32547-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822123919.32547-1-yuanjilin@cdjrlc.com>
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

Em Mon, Aug 22, 2022 at 08:39:19PM +0800, Jilin Yuan escreveu:
>  Delete the redundant word 'and'.

Applied already https://lore.kernel.org/lkml/20220807084629.23121-1-dengshaomin@cdjrlc.com/
 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  tools/perf/builtin-trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 897fc504918b..2f7b1111d8e9 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2040,7 +2040,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
>  
>  			/*
>   			 * Suppress this argument if its value is zero and
> - 			 * and we don't have a string associated in an
> + 			 * we don't have a string associated in an
>   			 * strarray for it.
>   			 */
>  			if (val == 0 &&
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
> 2.36.1

-- 

- Arnaldo
