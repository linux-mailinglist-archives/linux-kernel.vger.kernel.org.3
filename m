Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382B5A11DB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiHYNVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbiHYNVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:21:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B23AA345
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:20:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so2511563wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=9Q+jKUSpU6kYeBsMhMpzIZThK1oQ2j5LfED+1XJW8bo=;
        b=NPOrDfXwhQw13PErVkRE/qRVT+13aqvs70sZW34P8u5ZPw3Xg8SlXtHWqoOR/28iAK
         ens5U16cjddk8184UsFHVQhwzz5bB/TV3Nq2ltCHUKTZ/srPrswr7HgSxFnNVwIFMJ6A
         oakgyqARdIGK7CEl7/nLf0eNdZ0SZ4iTO+hgwFUm1iUZqa/lrohhntohUrbNJF2/nS5F
         t4+c7OvfrG7QraiIfXRRN7PxBWjhqbzsWv/XOvwG8YtJ1jwm0V9TWsiXlR4Mamkt5Rlz
         E7XPGy0o9iUF7DHOu9Oszj4aU8seHqthrZu8kUFXvoun4MqDZ3zy60Tgf2qZLrEAlg2m
         KuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=9Q+jKUSpU6kYeBsMhMpzIZThK1oQ2j5LfED+1XJW8bo=;
        b=TRGKoQM8PB1FsCERGW5FxfrsoKS1nOAF0ZyJDmpFpG/8CEZ8L/2OalG/C29YsY0eZu
         9Zq69gbWpogEuxfAQjcOREkQ4fIl0FMrwfs5hKoXBYHycswcIx7yA5WI0Ee7J3q5lSZh
         WiKG2ES0zK44VXNjTbZMjuG9WQKMQ0W9jkQmIPZM7O1eRsOWq31P7E2AKZJNArB2NO5b
         vqQCPJIj2Y+H3LWtD4f47YlX9iMBM1QdGQ9AShaLcWxw5Zko05XrauUNnMz3Troiuw7l
         ytS/9Zs1vgyziC+Rquhjl53MAFaKYc2qGMfZ9B3EWgYiwzpinJnWBJqv4Li6MoEwR+QJ
         s6AA==
X-Gm-Message-State: ACgBeo1fNoWJyVqgN72JoQYk8HwZVUVOSbjj2mmRFu/YdYGjDbEwW4CC
        pK8jyEqhbBFqzF34wBQLAwQ=
X-Google-Smtp-Source: AA6agR73Jf/8yWY2aQLwOFfOqTij7LcqWKBfMA6FeN1t3BfqeohIqdN4nIfexvaK23Z1rLt6dImShA==
X-Received: by 2002:a1c:a4c6:0:b0:3a6:539b:a820 with SMTP id n189-20020a1ca4c6000000b003a6539ba820mr8251907wme.128.1661433656162;
        Thu, 25 Aug 2022 06:20:56 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l28-20020a056000023c00b00225213fd4a9sm19548439wrz.33.2022.08.25.06.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 06:20:55 -0700 (PDT)
Message-ID: <ceddc502-0176-cff8-f4f6-06606c42a662@gmail.com>
Date:   Thu, 25 Aug 2022 15:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] soc: mediatek: Let PMIC Wrapper and SCPSYS depend on
 OF
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>, linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220730144833.0a0d9825@endymion.delvare>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220730144833.0a0d9825@endymion.delvare>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/2022 14:48, Jean Delvare wrote:
> With the following configuration options:
> CONFIG_OF is not set
> CONFIG_MTK_PMIC_WRAP=y
> CONFIG_MTK_SCPSYS=y
> we get the following build warnings:
> 
>    CC      drivers/soc/mediatek/mtk-pmic-wrap.o
> drivers/soc/mediatek/mtk-pmic-wrap.c:2138:34: warning: ‘of_pwrap_match_tbl’ defined but not used [-Wunused-const-variable=]
> drivers/soc/mediatek/mtk-pmic-wrap.c:1953:34: warning: ‘of_slave_match_tbl’ defined but not used [-Wunused-const-variable=]
>    CC      drivers/soc/mediatek/mtk-scpsys.o
> drivers/soc/mediatek/mtk-scpsys.c:1084:34: warning: ‘of_scpsys_match_tbl’ defined but not used [-Wunused-const-variable=]
> 
> Looking at the code, both drivers can only bind to OF-defined device
> nodes, so these drivers are useless without OF and should therefore
> depend on it.
> 
> Also drop of_match_ptr() from both drivers. We already know what it
> will resolve to, so we might as well save cpp some work.
> 
> Developers or QA teams who wish to test-build the code can still do
> so by enabling CONFIG_OF, which is available on all architectures and
> has no dependencies.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202207240252.ZY5hSCNB-lkp@intel.com/
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chenglin Xu <chenglin.xu@mediatek.com>

Applied, thanks!

> ---
> Changes since v1:
>   * Drop of_match_ptr() (suggested by AngeloGioacchino Del Regno
> 
>   drivers/soc/mediatek/Kconfig         |    2 ++
>   drivers/soc/mediatek/mtk-pmic-wrap.c |    2 +-
>   drivers/soc/mediatek/mtk-scpsys.c    |    2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)
> 
> --- linux-5.18.orig/drivers/soc/mediatek/Kconfig	2022-07-28 11:22:23.098393325 +0200
> +++ linux-5.18/drivers/soc/mediatek/Kconfig	2022-07-28 11:23:58.635687065 +0200
> @@ -37,6 +37,7 @@ config MTK_INFRACFG
>   config MTK_PMIC_WRAP
>   	tristate "MediaTek PMIC Wrapper Support"
>   	depends on RESET_CONTROLLER
> +	depends on OF
>   	select REGMAP
>   	help
>   	  Say yes here to add support for MediaTek PMIC Wrapper found
> @@ -46,6 +47,7 @@ config MTK_PMIC_WRAP
>   config MTK_SCPSYS
>   	bool "MediaTek SCPSYS Support"
>   	default ARCH_MEDIATEK
> +	depends on OF
>   	select REGMAP
>   	select MTK_INFRACFG
>   	select PM_GENERIC_DOMAINS if PM
> --- linux-5.18.orig/drivers/soc/mediatek/mtk-pmic-wrap.c	2022-07-30 11:20:22.221919946 +0200
> +++ linux-5.18/drivers/soc/mediatek/mtk-pmic-wrap.c	2022-07-30 11:41:14.073038643 +0200
> @@ -2347,7 +2347,7 @@ static int pwrap_probe(struct platform_d
>   static struct platform_driver pwrap_drv = {
>   	.driver = {
>   		.name = "mt-pmic-pwrap",
> -		.of_match_table = of_match_ptr(of_pwrap_match_tbl),
> +		.of_match_table = of_pwrap_match_tbl,
>   	},
>   	.probe = pwrap_probe,
>   };
> --- linux-5.18.orig/drivers/soc/mediatek/mtk-scpsys.c	2022-07-30 11:20:22.221919946 +0200
> +++ linux-5.18/drivers/soc/mediatek/mtk-scpsys.c	2022-07-30 11:41:22.466154796 +0200
> @@ -1141,7 +1141,7 @@ static struct platform_driver scpsys_drv
>   		.name = "mtk-scpsys",
>   		.suppress_bind_attrs = true,
>   		.owner = THIS_MODULE,
> -		.of_match_table = of_match_ptr(of_scpsys_match_tbl),
> +		.of_match_table = of_scpsys_match_tbl,
>   	},
>   };
>   builtin_platform_driver(scpsys_drv);
> 
