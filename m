Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC6561D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiF3OFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiF3OE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:04:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A048A3153D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:53:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v9so11841761wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rjfE+t9jkRlM72f0scHUCfkpuAlgD5li+PY05b98rR4=;
        b=SUcOjYWdAUbK3PUmvOfPnuGQrySz8me2+gPGH8zBYw6JMnnp6/6EjP0QpJ+fDu0rVH
         PGXF01YQ3PeQ0BOxnVLJT6rVNCIJVAJZMkHmATtLiMUJHNCeddVcFwDMswPOJHpoLCAC
         XfEhV0arzxJlcv5NDL8KeM9VvLR84SKwkvqfcnEJh7WdvaddmeKPza2MjCKLC398YYTC
         Bgkg5LdEr+DvGDO3G9jeLx8lUo028SVMW+oF+jObBgC4sqiOHC23Tn0WaTi81V1OWJiz
         /pUi8H+ZHS5eD5sykwKiBe5Fvkvyx1oF6JSldMAp6Vlj4WLV6sU7TB7uu/x142mQZGBQ
         feww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rjfE+t9jkRlM72f0scHUCfkpuAlgD5li+PY05b98rR4=;
        b=E2t/HoNjVhuB7EFsKJo6U3t/8lW1lg8pAbM+rdYbp8k5/AttAxHLbaD/myCseUplNb
         cGbGtxo1u+YqKn/95tSpji5xHaEvjc6VhXjs88gHY1VEL+tFvxYuW7YhRbtVXHc2a8LI
         akleBVv5XctEMMb7dhZM/baaxgz8/cuOLarB0rLYNNiL0IoWsmUdfAol47U1PHseXCx7
         j6RqLmcNgi6pohw4c4DSSqThVgKn8dmiNUDxEXjuQBur+/YP7mNvToZx5pacVJB9g/bZ
         k2TSRREtXJe2ebpqPzk5jqRA7gjIjs8K4SLeXQLwmetrySuntTWxVcVSaNDHZ79lmuI1
         knbw==
X-Gm-Message-State: AJIora9hRncNMrKqf8YXwbTZPNDSuUhrJ521L4mWiN9lqbr4F+S6DjMU
        M5Q/V/sL6E8QJQMlWiN+n871Z66jAzv06A==
X-Google-Smtp-Source: AGRyM1sXoCUSDFAd2ZBXGMe4hTCD/ew3+1hPD1NM7OzuvrgkwjXj8PT/tePWw50cS1TevLQLVIzZMA==
X-Received: by 2002:a05:6000:1889:b0:21d:28e8:b6a with SMTP id a9-20020a056000188900b0021d28e80b6amr8178653wri.14.1656597210148;
        Thu, 30 Jun 2022 06:53:30 -0700 (PDT)
Received: from ?IPV6:2a02:768:2307:40d6::f9e? ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c204f00b0039c5cecf206sm6678987wmg.4.2022.06.30.06.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 06:53:28 -0700 (PDT)
Message-ID: <11474ae8-8f28-ad85-4abb-4da7fb3bd1ea@monstr.eu>
Date:   Thu, 30 Jun 2022 15:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arch: microblaze: Remove unused "select
 HANDLE_DOMAIN_IRQ"
Content-Language: en-US
To:     sunying@nj.iscas.ac.cn
Cc:     linux-kernel@vger.kernel.org
References: <20220629080652.28029-1-sunying@nj.iscas.ac.cn>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <20220629080652.28029-1-sunying@nj.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/22 10:06, sunying@nj.iscas.ac.cn wrote:
> From: Ying Sun <sunying@nj.iscas.ac.cn>
> 
> The "CONFIG_HANDLE_DOMAIN_IRQ" item has not been used right now.
> Remove the old unused selection in config MICROBLAZE.
> 
> Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
> ---
>   arch/microblaze/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 8cf429ad1c84..ed9ce6117263 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -45,7 +45,6 @@ config MICROBLAZE
>   	select ZONE_DMA
>   	select TRACE_IRQFLAGS_SUPPORT
>   	select GENERIC_IRQ_MULTI_HANDLER
> -	select HANDLE_DOMAIN_IRQ
>   
>   # Endianness selection
>   choice

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

