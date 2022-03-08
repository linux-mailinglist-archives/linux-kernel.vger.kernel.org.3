Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B914D14F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbiCHKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiCHKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:43:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33256424B7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:42:19 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so27742293wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnB4E2V55eX3VFINFuDFHwNcAhziinbz9b0wRuMwc+w=;
        b=fF6muMrgXM8f0RIMY234w716dRJ8RS4wG9Cz5fspMkIRXJU3uPQlgAiCrW+r1NQd6z
         TOClkWuWJKjg795h5BXTdIVKAY4Ncc4SEY8IIvecvVcoDXGXroeo9zqrXDUiXOGfBB3c
         TIFJej4H+ZqjxiO+05Ex9MjCUiiJHXdD9popyq6IMVcWa2dK8vesakQqzXQtVugM4c+e
         S8U76KsfZ7DEMlQsmQFNIEBEHFOWL0xJRKhV/6jpnKuGYZLBdJpt7YBTeI+t815z/3NB
         0RCsj02qkiwgo8ivFKwlpILSrCeAnJtKYv5FHtYsZz5G81Cj81VWh7b95kKrHI7Ou2v/
         kzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnB4E2V55eX3VFINFuDFHwNcAhziinbz9b0wRuMwc+w=;
        b=2wOmNmv+XVGl1HbQS+kqs4j+H4PoqI0MpfkSdVf/kntTbTwIni064q+5oK1TAAlRUw
         8xsEMDBiUg0gqr++zgYTYRh5m3mI+zgp08DDnU6GhOEW3nvZ4XcYtUA/gBCMCH6zSfij
         KwkjZwYVhrBJy83nhXirIRgXgg61ZmAnmYCuLFFAIcIpEqnU2YzelBkxxiwyXpmS/Ylk
         Eq/6zNGz5rkotKZtsiiB33kqUHyzL34cCxmhfjiVZo6QhgZCTGi+3bDK5szNAa5NOB7L
         azVLSp7v9xLoKIZV0qJBTSmrJbc/1g3t+HpLttUlxHpXLc6IvR57mmzOSjkENr4UX7L7
         zDmg==
X-Gm-Message-State: AOAM53312ZaAEQoR7fTt4GTgBeYdAcYTb27QecEvzjrAnl/Adj5ozDga
        zYbCSInY1P567nsjENVQbiebNw==
X-Google-Smtp-Source: ABdhPJxgZfuaDVziIe9PiECs3rj7gmTY4BbG6vcBdQdsLR2Q2enkI0hmUI0jNAMExBq17Y2M3WyA1Q==
X-Received: by 2002:a05:6000:1a8f:b0:1e8:3301:1273 with SMTP id f15-20020a0560001a8f00b001e833011273mr11762921wry.707.1646736137719;
        Tue, 08 Mar 2022 02:42:17 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0037bd5fabd10sm2060594wmq.48.2022.03.08.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:42:17 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:42:15 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configs/debug: set CONFIG_DEBUG_INFO=y properly
Message-ID: <20220308104215.q4asb6z3vicq2vja@maple.lan>
References: <20220301202920.18488-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301202920.18488-1-quic_qiancai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:29:20PM -0500, Qian Cai wrote:
> CONFIG_DEBUG_INFO can't be set by user directly,

What do you mean by "can't be set by user directly"? DEBUG_INFO
is fully controlable via menuconfig.


> so set CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y instead.
> Otherwise, we end up with no debuginfo in vmlinux which is
> a big no-no for kernel debugging.
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  kernel/configs/debug.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/configs/debug.config b/kernel/configs/debug.config
> index e9ffb0cc1eec..07df6d93c4df 100644
> --- a/kernel/configs/debug.config
> +++ b/kernel/configs/debug.config
> @@ -16,7 +16,7 @@ CONFIG_SYMBOLIC_ERRNAME=y
>  #
>  # Compile-time checks and compiler options
>  #
> -CONFIG_DEBUG_INFO=y
> +CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

Does this change actually work in the kernels it has merged into?

DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT existence is predicated on DEBUG_INFO
being set. It makes no sense at all to set the former without the later.

I tried this with ARCH=arm64 and it is clearly not working and should
probably be reverted from v5.17:
~~~
maple$ git describe
v5.17-rc7
maple$ make defconfig
*** Default configuration is based on 'defconfig'
#
# No change to .config
#
maple$ scripts/config --disable DEBUG_INFO && make oldconfig
#
# configuration written to .config
#
maple$ grep DEBUG_INFO .config
# CONFIG_DEBUG_INFO is not set
maple$ make debug.config
<removed-long-output-here>
maple$ grep DEBUG_INFO .config
# CONFIG_DEBUG_INFO is not set
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
           ^^^^^^^^^
	       ^
maple$ echo CONFIG_DEBUG_INFO=y kernel/configs/debug_info.config
CONFIG_DEBUG_INFO=y kernel/configs/debug_info.config
maple$ make debug_info.config
Using .config as base
Merging ./kernel/configs/debug_info.config
Value of CONFIG_DEBUG_INFO is redefined by fragment ./kernel/configs/debug_info.config:
Previous value: # CONFIG_DEBUG_INFO is not set
New value: CONFIG_DEBUG_INFO=y

#
# merged configuration written to .config (needs make)
#
#
# configuration written to .config
#
maple$ grep DEBUG_INFO .config
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
~~~


Daniel.
