Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39A2591613
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiHLToy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbiHLTov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:44:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E2B3B19;
        Fri, 12 Aug 2022 12:44:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3500CB82338;
        Fri, 12 Aug 2022 19:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB859C433C1;
        Fri, 12 Aug 2022 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660333488;
        bh=Cas4dDMZOh38DQ20jCc5TMeI69TAyRgs9/nTjOovOw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlO5dTCMbl89kQA4p0skeSLQHr6w5lEdtBxydEovPl5eTMNS9GJIiFtJYOk3PH4GM
         dReKVgqiqDEZwBIyA3hts/nijoqJOJguM2XboHOUr82kYUTVQGEeRaAjoi3oWNIp/b
         CvxDLxYXyiheiWXDElqlH7yMEAVspBaFN0E6MwUek3ERQf2zx8ahcWxmRn33e3iWdp
         x12k8y4pDe9Kr+nFAibqURXJ8suBb5jeb1NVQXNs6lX+wSEQKKJuTTvlCCXlpHQ7SJ
         8yHboAMrS0khkeJXnECF3sAXLUpEVpTJ49z+VVTTZWLIqXnG9rcVvwD4r61E5N/IDL
         3H7bvbYldHl2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 772414035A; Fri, 12 Aug 2022 16:44:45 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:44:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Delete repeated word "from"
Message-ID: <YvatrYe+e7i5Q6Od@kernel.org>
References: <20220807080642.13004-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220807080642.13004-1-dengshaomin@cdjrlc.com>
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

Em Sun, Aug 07, 2022 at 04:06:42AM -0400, shaomin Deng escreveu:
> Delete the repeated word "from" in code.
 

Thanks, applied.

- Arnaldo

> Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 7cf21ab16f4f..ebe5fdecdb0c 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3847,7 +3847,7 @@ int cmd_script(int argc, const char **argv)
>  	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
>  			"Run xed disassembler on output", parse_xed),
>  	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
> -			"Decode calls from from itrace", parse_call_trace),
> +			"Decode calls from itrace", parse_call_trace),
>  	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
>  			"Decode calls and returns from itrace", parse_callret_trace),
>  	OPT_STRING(0, "graph-function", &symbol_conf.graph_function, "symbol[,symbol...]",
> -- 
> 2.35.1

-- 

- Arnaldo
