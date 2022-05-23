Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5413531978
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiEWUH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiEWUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:07:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EECB954A3;
        Mon, 23 May 2022 13:07:24 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id m25so19136653oih.2;
        Mon, 23 May 2022 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=5VgQT8K1FyKEoolAoPMmYXbF0kmo6XWGxV/7Bz8lAHU=;
        b=nYbpPsvXC0KEE7WSIsSuO9pUrLaICdMYJH7MRhfnH4a5FklA1MGCb3fzVXapwc/07f
         opBGExTn/KbDQSTOV2iQcuizp+m6qKz4ppJNSEzZal9RmUpke/itKeufO09fau//BgYd
         HXyo/RUrTjP1CZ7Frs6J0pykjxDxK4mhWOw3MoTqplmSn5VrXTvvPHWczFQuX9H/Rsm3
         wuIwmBUDwAQcmBkwBJdKhTLjxuJrbdRrHSLTgVx0aOO8BZxAhE6G7o/5jIaWAoGYK4tx
         nOVAPZo1taKFtPhk0qCU7bpOKRD5eTqnV/912gyeFgf5DihU9E5HQkdnbYM2AP6pLYKD
         jdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=5VgQT8K1FyKEoolAoPMmYXbF0kmo6XWGxV/7Bz8lAHU=;
        b=ZGnBK0PS0EGGNcSgRBFT9RjWbm41Jax7LZLal80LyXXhKKAVWDJf8aWlJ00J6STPdY
         qN8IlrYYYVc6CBsLmX3Rrcx+kDbCWtJqqsSs+RTKDdsBNzk1aab7a7FJUGSvI56C3V5/
         1QBAlR9m2YQJ4J0qlt2kD64W3vxgKmOMX0ZncGgIvzRCcKtvr3WNqhURW1gmqoIDakCz
         YKmNI4tnDBC7vPyHsvBtF9mlERadWdCFlfvb5moYKQFYkgLTR93exJJByuYDOYd1Df9z
         gQd+4DZES9A7nBZ3WJdxoer6xzt7kNv58yl/KREqwkOSy1qMkqIOj2v0xExEi2thN+Jk
         L0uA==
X-Gm-Message-State: AOAM5333vFXhm5Bczh+rR9MB49Xc9wg1XsNTn1G8BWymAy7AoQVm946F
        tneGhDgbuUYFQTIdfI/5lOQ=
X-Google-Smtp-Source: ABdhPJxQ8/nPC9mzkYgT6gZ4xy/6uIcigaDtlBKE31YJwSM9DgkfBW3YxKzowPvxhxfXENnpYzEnWg==
X-Received: by 2002:a05:6808:1a17:b0:32b:7ae1:e7e1 with SMTP id bk23-20020a0568081a1700b0032b7ae1e7e1mr403092oib.275.1653336443863;
        Mon, 23 May 2022 13:07:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i2-20020a056870344200b000f200155e06sm4157841oah.54.2022.05.23.13.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:07:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 23 May 2022 13:07:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Require utsrelease.h before scripts target
Message-ID: <20220523200722.GA3879929@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

On Mon, May 23, 2022 at 01:02:22PM -0700, Kees Cook wrote:
> The "utsrelease.h" target was in parallel with the "scripts" target,
> which meant -j1 or unlucky parallel builds from a distclean state would
> fail to build the GCC plugins.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-mm/202205230239.EZxeZ3Fv-lkp@intel.com
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/YouX6g1T7w3FDeM8@cmpxchg.org
> Fixes: 61f60bac8c05 ("gcc-plugins: Change all version strings match kernel")
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

I was able to reproduce the problem with the following change
in Makefile.

 include/generated/utsrelease.h: include/config/kernel.release FORCE
+       sleep 2
        $(call filechk,utsrelease.h)

With this patch, the problem is gone.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  Makefile                     | 2 +-
>  scripts/gcc-plugins/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 91c91fcf3c24..c04420d5aa3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1175,7 +1175,7 @@ include/config/kernel.release: FORCE
>  # Carefully list dependencies so we do not try to build scripts twice
>  # in parallel
>  PHONY += scripts
> -scripts: scripts_basic scripts_dtc
> +scripts: include/generated/utsrelease.h scripts_basic scripts_dtc
>  	$(Q)$(MAKE) $(build)=$(@)
>  
>  # Things we need to do before we recursively start building the kernel
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index 6f0aecad5d67..c29334669a16 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -64,5 +64,5 @@ $(foreach m, $(notdir $(plugin-multi)), $(eval $(obj)/$m: $(addprefix $(obj)/, $
>  quiet_cmd_plugin_cxx_o_c = HOSTCXX $@
>        cmd_plugin_cxx_o_c = $(HOSTCXX) $(plugin_cxxflags) -c -o $@ $<
>  
> -$(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE
> +$(plugin-objs): $(obj)/%.o: $(src)/%.c $(objdir)/include/generated/utsrelease.h FORCE
>  	$(call if_changed_dep,plugin_cxx_o_c)
> -- 
> 2.32.0
> 
