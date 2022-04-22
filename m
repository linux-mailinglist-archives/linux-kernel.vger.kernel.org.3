Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BF150C06F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiDVTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDVTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:34:52 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8196E26EDE6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:12:51 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e604f712ecso9573930fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7NoOp29Q/dMR2v1xp8JyZRZZvoakgizrx1i7zKIJPJA=;
        b=MvsU0Shq7Wl/izk/EJ6oMnzUpVSyo/bCeBwYPxWdAYO2/9ZUg6IRR1k16Uk4CzEWrL
         Dx22WIhqhvchO4CtnhICqZcmbvTOQyBGtmNp/E7QHGclmkG9RfeVhmMZFOIqgY28zJbi
         omzKxdl3vnnS3GlvrP2r4FCgkolfIn6+JQh7f9prIIUo0xYfo8rSs4DkN9dRK4ze3iSM
         TyeuzwzOBNKEwqy8ugHn0TA1LD1NFbgFndeGaifUZ05vTM/qfZEfNAaZtNs9r18TuSqA
         tW6u+2Uv84Ucz9Na8WgAb6cr1guTKv08Q0Vn0LTpV0wN7cXO46id9IUmfkkahe/mnrTG
         gRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=7NoOp29Q/dMR2v1xp8JyZRZZvoakgizrx1i7zKIJPJA=;
        b=PwngxHWo9K5wLxN4/A07CXUt0JS6GIDL3kC8C1YSLe3ysCOcBK4mC3afgKE9oel+FS
         m0UhzA97edWe+ClZ8dgN8rlgp4BUkNBUoKMXEINpg8BFAZr7nauAZrO4Abb9tzY9WVA1
         KwwfM6XZVqVIbRpP4kqSrW6Ll3HH0ZmQk3tBiF3Vd62OCPWnD01P7WajrU30yUBQGQBg
         H8WtyM0mV6poq7TzwflUtEgXvekCpGZZNAmGpW5wSSTkXj2+KJKSio4O4Wgl0y+JglHV
         sOr2MDu7BI+WacpPg3TGjUYwyHuavhihPyy9Qn1ccD0+4EGRdokihwIZGEcwK/eqP1CV
         c+qg==
X-Gm-Message-State: AOAM532p2jL82eWHzP5VZiB8TVi3x7wBzhlmTtUCXYJkObxVPGx5Ll4i
        wZhFD30kSoE8vT8gwo5hR31mmPqMPiM=
X-Google-Smtp-Source: ABdhPJwjv/+yziYSWHN+C3vFIgOEab+gBtdfs3eHbbzKdOzoUHNJ/g1C7Vgz2La9Z6n6TR8SnVwYrg==
X-Received: by 2002:a05:6808:138e:b0:322:2dcd:dc7d with SMTP id c14-20020a056808138e00b003222dcddc7dmr3025270oiw.159.1650652673572;
        Fri, 22 Apr 2022 11:37:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm1013602oia.31.2022.04.22.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:37:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 22 Apr 2022 11:37:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: rockchip: Fix compile-testing SoC drivers
Message-ID: <20220422183751.GA2653014@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:19:19AM -0700, Brian Norris wrote:
> Similar to commit 7f94b69ece51 ("ARM: ixp4xx: fix compile-testing soc
> drivers").
> 
> drivers/soc/rockchip/Kconfig makes plenty of provision for configuring
> drivers either for ARCH_ROCKCHIP or for COMPILE_TEST. But
> drivers/soc/Makefile pulls the rug out from under us, by refusing to
> build anything if we specified COMPILE_TEST but not ARCH_ROCKCHIP.
> 
> Currently, I'm not aware of anything that breaks without this patch, but
> it certainly makes for confusing builds (CONFIG_ROCKCHIP_PM_DOMAINS=y,
> but we didn't actually compile the driver?) and leaves room for future
> error (I have pending patches that break confusingly with COMPILE_TEST=y
> even though their Kconfig dependencies seem correct [1]).
> 
> Defer to drivers/soc/rockchip/{Makefile,Kconfig} to do the right thing.
> 
> [1] e.g.,
> https://lore.kernel.org/linux-rockchip/20220405184816.RFC.2.I2d73b403944f0b8b5871a77585b73f31ccc62999@changeid/
> [RFC PATCH 2/2] PM / devfreq: rk3399_dmc: Block PMU during transitions
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  drivers/soc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index fd7717d597fc..4c91705a8bb3 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -23,7 +23,7 @@ obj-y				+= pxa/
>  obj-y				+= amlogic/
>  obj-y				+= qcom/
>  obj-y				+= renesas/
> -obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
> +obj-y				+= rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
>  obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
>  obj-y				+= sunxi/
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
