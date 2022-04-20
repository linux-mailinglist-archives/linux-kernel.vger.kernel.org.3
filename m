Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD72508D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380635AbiDTQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351893AbiDTQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:37:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44DC44A14;
        Wed, 20 Apr 2022 09:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9997BB82043;
        Wed, 20 Apr 2022 16:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3DFC385A1;
        Wed, 20 Apr 2022 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472466;
        bh=6dOodVlqYYemmOJ8+Jo4pQMwH/KjxBbts+kyWpeDKbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lif7pDUAWBG+r/5eb+R4QoGwfqcNYXeGVSwHqYGhoRm/Erol75XzYSXDdFcxXKVIV
         YtBEdw+yKpH2B4AwYXZ8yHu0AbjZKaUSaYzBwnlYbvwiSqadtbM7mKAucLXNdhTyAQ
         xatDZkVnlPQn95oe3DLIh21HKsQPLEW8ob7bkHo1GZ2ANIXUg6OjSA9o78LFjpuRvu
         zoQjbCM886cG6Pg9mPfmnXYYV0tA98duqSIMe+qqx5Q/ajifsT35l/Ajdw2RGJhmaV
         RNLtonTaMn9KAg4mnF45hf5ELW1MN/KZZyBkxaGVkC+CR9AnXHif84gRwl1TgsZ6a1
         YP3RbAbeYb99A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87F9A400B1; Wed, 20 Apr 2022 13:34:23 -0300 (-03)
Date:   Wed, 20 Apr 2022 13:34:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf: print warning when HAVE_DEBUGINFOD_SUPPORT is not
 set
Message-ID: <YmA2D04uy5ijwe1c@kernel.org>
References: <35bae747-3951-dc3d-a66b-abf4cebcd9cb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35bae747-3951-dc3d-a66b-abf4cebcd9cb@suse.cz>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 20, 2022 at 03:32:55PM +0200, Martin Liška escreveu:
> When one requests debuginfod, either via --debuginfod option, or
> with a perf-config value, complain when perf is not built with it.
> 
> Signed-off-by: Martin Liska <mliska@suse.cz>

I'll go and apply this manually:

⬢[acme@toolbox perf]$ am
warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: perf: print warning when HAVE_DEBUGINFOD_SUPPORT is not set
error: corrupt patch at line 19
Patch failed at 0001 perf: print warning when HAVE_DEBUGINFOD_SUPPORT is not set
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf]$ git am --abort
⬢[acme@toolbox perf]$ vim ~/wb/1.patch
⬢[acme@toolbox perf]$ patch -p1 < ~/wb/1.patch
patching file tools/perf/util/util.c
Hunk #1 FAILED at 430.
1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/util.c.rej
⬢[acme@toolbox perf]$ git diff
⬢[acme@toolbox perf]$
⬢[acme@toolbox perf]$ cat tools/perf/util/util.c.rej
--- tools/perf/util/util.c
+++ tools/perf/util/util.c
@@ -430,4 +430,9 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
  		setenv("DEBUGINFOD_URLS", di->urls, 1);

  	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
+
+#ifndef HAVE_DEBUGINFOD_SUPPORT
+	if (di->set)
+		pr_warning("WARNING: debuginfod support requested, but perf is not built with it\n");
+#endif
  }
⬢[acme@toolbox perf]$

> ---
>  tools/perf/util/util.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index fb4f6616b5fa..289d83baaa2f 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -430,4 +430,9 @@ void perf_debuginfod_setup(struct perf_debuginfod *di)
>  		setenv("DEBUGINFOD_URLS", di->urls, 1);
>  	pr_debug("DEBUGINFOD_URLS=%s\n", getenv("DEBUGINFOD_URLS"));
> +
> +#ifndef HAVE_DEBUGINFOD_SUPPORT
> +	if (di->set)
> +		pr_warning("WARNING: debuginfod support requested, but perf is not built with it\n");
> +#endif
>  }
> -- 
> 2.35.3

-- 

- Arnaldo
