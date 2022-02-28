Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0264C70A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiB1PcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbiB1PcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:32:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705982D11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:31:31 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y5so5926228wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod-ie.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2gH1VCXMJOCAQZMMdwA8NKZMdwDagt75ou8aHbyIUz0=;
        b=ut095mw9H1t6WgZsq59Kx6N6Whm5l58tD/csnQyzg3sRwVkNtPbOH2gIYZjAuTVxAC
         Ce2d7THpNHlx6j19dQe43RctF+aIsxdP0i5oSb2/LWutEn86m1FUcLDgyQX2BjStHyMB
         EIP+HSGqPNF1ba/Ro8mPiVGGLedsrF4z9I0vpxLZRLk35Kr4RD6ckAxQG1AAUK81KCmS
         sBua87VSFTbs7gPuCbUSj/jLl/KeTqu/ugVmvnni49k1SqL8FeOi84ucN/MvOplUnBQl
         ag9y6SNSGeacwbh9fKaddv5Rzrriyli1zWir8LaDgeJu8MS9pNVvVTYLOW25huWzgyyj
         Tvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2gH1VCXMJOCAQZMMdwA8NKZMdwDagt75ou8aHbyIUz0=;
        b=fCMwxEERNUVj19x3kNLyvn3TbEoaRfBkUOoafJhLN5YEcmJgFz0bYfeFiyXNCVfHZC
         Tn8CmncDgSI/rXL/GgBweS3thPiCi2b3ud+zVXq4KhkMyE+6xKoMatRPJZWMQTqxn4Oc
         B0LZqe8TOyz02/w7Toa9HTFK8ueojSABoi1+zoL8I5Md1Ss2XdWZcFKTLg/51BdX8XPN
         8VMELQ3yAC+nlYjR1A41Ef58CZibYjKx2Inv4q/gBnkUwMfB4GE765qgPdU6ZUWeWo5C
         HFNx8a+jfA89NG8OUsupLVYwn6yQ4Chpkr4Ucks53n+J7EdC6CgkRIwrZX8/e8a0q6JR
         5Ylw==
X-Gm-Message-State: AOAM531AxRKTdZ5thLc+n9a8ppaZz0Yov4PPSsVYlDkQDRC+ZdIrZHvG
        1GSbpOHKKodg//w+xAlPY0HmGQ==
X-Google-Smtp-Source: ABdhPJwZs3W4atkmlIldxtmVDitUoNs7+KJXCw3zlG03aFYebo+mCuYCi1jBc6bDQT5J1LiMod30iQ==
X-Received: by 2002:a1c:f705:0:b0:37d:f2e5:d8ec with SMTP id v5-20020a1cf705000000b0037df2e5d8ecmr13878273wmh.21.1646062290040;
        Mon, 28 Feb 2022 07:31:30 -0800 (PST)
Received: from [10.205.160.53] ([95.83.233.50])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm18783669wmq.6.2022.02.28.07.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 07:31:29 -0800 (PST)
Message-ID: <b8eb2e55-b5a8-4a39-86cb-93cadbd67922@conchuod.ie>
Date:   Mon, 28 Feb 2022 15:35:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] SoC: polarfire: fix build warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20220228152658.3367506-1-arnd@kernel.org>
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220228152658.3367506-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had sent a fix for the build warning on saturday morning - but I guess 
you missed it.

Thanks for fixing it anyway :)
Conor.

On 28/02/2022 15:26, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added driver causes a build warning because of a missing
> prototype:
> 
> drivers/soc/microchip/mpfs-sys-controller.c:76:6: warning: no previous prototype for function 'mpfs_sys_controller_put' [-Wmissing-prototypes]
> 
> Link: https://lore.kernel.org/llvm/202202260947.F5T1YNao-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I've applied this to the arm/drivers branch as a fixup
> 
>   include/soc/microchip/mpfs.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
> index 6466515262bd..969b5239521e 100644
> --- a/include/soc/microchip/mpfs.h
> +++ b/include/soc/microchip/mpfs.h
> @@ -38,6 +38,8 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *mpfs_client, struct mp
>   
>   struct mpfs_sys_controller *mpfs_sys_controller_get(struct device *dev);
>   
> +void mpfs_sys_controller_put(void *data);
> +
>   #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
>   
>   #endif /* __SOC_MPFS_H__ */
