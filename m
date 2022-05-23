Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5ED5312C5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiEWObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiEWOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:30:58 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6432AD7;
        Mon, 23 May 2022 07:30:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w130so18063522oig.0;
        Mon, 23 May 2022 07:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QTLxi3i1Dh63AaBqqywvdv1nsYvnlCRlV0axCBCsMZo=;
        b=P3C4rSGg9aR9oj+dyS+yhdQvSXSGMVQJxeBVll2aZxxom4uZ+LCK+KsM0913N+OlFU
         IrYz+avVRclep9WR51PSIkXtKhrYfGiu1XIq7GGf4i4/B/CzT98BeBGVJoxGQA/6mqqv
         tvjKy0iOb4yiWPF93deVDZh3ZJq/ct6AeDBwgKYKMOV1VYigvhs9OyeeBECwJrwoTBkd
         9H38T9jasr6UHhilGGgkKpLS5UhNiUgqXTAX6GhxWwasvweg9nVT8v6ILqRVFq6Vz9xR
         fvbv3BTLHuGT+v0GwmgIsiCniF7tLwRJeGncwQH1vmSxpNS/gtgVMG7QYPLX0qbqQRy9
         o3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QTLxi3i1Dh63AaBqqywvdv1nsYvnlCRlV0axCBCsMZo=;
        b=NnZCJGxs9I3HFuf9Uuvv5RZRhpj5dOs3/bdESDcU27e+EkcC4bZ8V4VXuA/tK7fLpv
         2yrmpUFHafmVgGImQTzAtKFhDlrexQkfLqPD97EWUpTpG/yGMBxSRtijDsi2yuqt6FXW
         dlFkZqZzGYjmNnq4Fj7RIgJKa88kE/D3yttVYv4MumE2gJBXDQR1q0dc1mHkXUoqs247
         jG2rt2/GEG1iPBrd7LmVE1Zm8XxvISqsehkXq5dpD+cvXRYhsSqaeGtDFDT/L+ei8/X9
         W6BksQ/xP8kfY2fD/4dJyf6IzOF6LN5wSyeC3+Nu+hCWt2Yuvffj1aCwLCyMAkIf8hH2
         SecQ==
X-Gm-Message-State: AOAM531W6VsMauS4UP5WAbNKYKQzyTCFUPU1D5h4LHya1Htp0r79+OGd
        2MhO1+7kQg+cokuy4PVDU2pT6TbReVnCEw==
X-Google-Smtp-Source: ABdhPJwmd/WZv/khpVJ6dz8/+YETqXIh/fB3qdGDstfp4doFkwGQnGaTYUtysoG07larAH6qpz33/A==
X-Received: by 2002:a05:6808:19a9:b0:32b:56bd:27bd with SMTP id bj41-20020a05680819a900b0032b56bd27bdmr1490212oib.218.1653316256731;
        Mon, 23 May 2022 07:30:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g16-20020a4a2510000000b0035eb4e5a6b0sm4143957ooa.6.2022.05.23.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:30:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 07:30:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Change all version strings match kernel
Message-ID: <20220523143054.GA3164771@roeck-us.net>
References: <20220510235412.3627034-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510235412.3627034-1-keescook@chromium.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 04:54:12PM -0700, Kees Cook wrote:
> It's not meaningful for the GCC plugins to track their versions separately
> from the rest of the kernel. Switch all versions to the kernel version.
> 
> Fix mismatched indenting while we're at it.
> 
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I see random build failures with this patch in linux-next.

Error log:
cc1plus: fatal error: ./include/generated/utsrelease.h: No such file or directory

The problem doesn't happen all the time. Is there some missing dependency ?

Guenter

> ---
>  scripts/gcc-plugins/Makefile                  | 9 +++++----
>  scripts/gcc-plugins/latent_entropy_plugin.c   | 2 +-
>  scripts/gcc-plugins/randomize_layout_plugin.c | 2 +-
>  scripts/gcc-plugins/sancov_plugin.c           | 2 +-
>  scripts/gcc-plugins/stackleak_plugin.c        | 2 +-
>  scripts/gcc-plugins/structleak_plugin.c       | 2 +-
>  6 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index 148f4639cf09..6f0aecad5d67 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -28,10 +28,11 @@ GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
>  
>  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
>  		  -include $(srctree)/include/linux/compiler-version.h \
> -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
> -		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> -		   -ggdb -Wno-narrowing -Wno-unused-variable \
> -		   -Wno-format-diag
> +		  -include $(objtree)/include/generated/utsrelease.h \
> +		  -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
> +		  -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> +		  -ggdb -Wno-narrowing -Wno-unused-variable \
> +		  -Wno-format-diag
>  
>  plugin_ldflags	= -shared
>  
> diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
> index 8425da41de0d..5d415b2572a8 100644
> --- a/scripts/gcc-plugins/latent_entropy_plugin.c
> +++ b/scripts/gcc-plugins/latent_entropy_plugin.c
> @@ -82,7 +82,7 @@ __visible int plugin_is_GPL_compatible;
>  static GTY(()) tree latent_entropy_decl;
>  
>  static struct plugin_info latent_entropy_plugin_info = {
> -	.version	= "201606141920vanilla",
> +	.version	= UTS_RELEASE,
>  	.help		= "disable\tturn off latent entropy instrumentation\n",
>  };
>  
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 65aee5d6d91e..ea2aea570404 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -34,7 +34,7 @@ __visible int plugin_is_GPL_compatible;
>  static int performance_mode;
>  
>  static struct plugin_info randomize_layout_plugin_info = {
> -	.version	= "201402201816vanilla",
> +	.version	= UTS_RELEASE,
>  	.help		= "disable\t\t\tdo not activate plugin\n"
>  			  "performance-mode\tenable cacheline-aware layout randomization\n"
>  };
> diff --git a/scripts/gcc-plugins/sancov_plugin.c b/scripts/gcc-plugins/sancov_plugin.c
> index 23bd023a283b..f3d629555b84 100644
> --- a/scripts/gcc-plugins/sancov_plugin.c
> +++ b/scripts/gcc-plugins/sancov_plugin.c
> @@ -26,7 +26,7 @@ __visible int plugin_is_GPL_compatible;
>  tree sancov_fndecl;
>  
>  static struct plugin_info sancov_plugin_info = {
> -	.version	= "20160402",
> +	.version	= UTS_RELEASE,
>  	.help		= "sancov plugin\n",
>  };
>  
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 42f0252ee2a4..de817d54b8af 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -44,7 +44,7 @@ static bool verbose = false;
>  static GTY(()) tree track_function_decl;
>  
>  static struct plugin_info stackleak_plugin_info = {
> -	.version = "201707101337",
> +	.version = UTS_RELEASE,
>  	.help = "track-min-size=nn\ttrack stack for functions with a stack frame size >= nn bytes\n"
>  		"arch=target_arch\tspecify target build arch\n"
>  		"disable\t\tdo not activate the plugin\n"
> diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
> index 74e319288389..86b608a24ec0 100644
> --- a/scripts/gcc-plugins/structleak_plugin.c
> +++ b/scripts/gcc-plugins/structleak_plugin.c
> @@ -37,7 +37,7 @@
>  __visible int plugin_is_GPL_compatible;
>  
>  static struct plugin_info structleak_plugin_info = {
> -	.version	= "20190125vanilla",
> +	.version	= UTS_RELEASE,
>  	.help		= "disable\tdo not activate plugin\n"
>  			  "byref\tinit structs passed by reference\n"
>  			  "byref-all\tinit anything passed by reference\n"
> -- 
> 2.32.0
> 
