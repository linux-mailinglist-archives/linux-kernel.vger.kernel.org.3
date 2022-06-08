Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F075424C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiFHET7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiFHETb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:19:31 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5485C2FDBE1;
        Tue,  7 Jun 2022 18:41:33 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e5e433d66dso25449231fac.5;
        Tue, 07 Jun 2022 18:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ouh168Efujq50ZkwUeyvKvmPIKYBEgMwS6iqFnHPOo=;
        b=OUEONxD7ri2U9Ybh50bsIdP8XdebA8KMNQi2Ov2WJ4/pfunTJ6lnJVdlRrloNIuw65
         98oS7vutzV1t4GsJAGt7nF2ILmE3+cj5annOU+KwX+C6t3qTf7sYmB6xFt1vtde7RQOT
         Gm5YKARgJWi9s0Si8N+UO0k0TIgH+TfWhLLNzmSoECNNv8pa4FJ4XyBrdG9K6Zsz12Yo
         aH4zgEamuDU8egBe5fZd0QfO7TGywpkN7hztYvdbcwLhS06uqibwJg0nmHp/RMZoMybq
         fzL6LTIQPH6p0aTkRniNLGhmhEJFAOI47wYEz5CBxTH8i5yJk2n6qVStA+4gUX4jURh3
         mP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0ouh168Efujq50ZkwUeyvKvmPIKYBEgMwS6iqFnHPOo=;
        b=H0KA0HtvMSaOEO9X+1zSyqaypWolg3+Pl84O372+53VfB8/IX7TyFLNE3HQp1TDnMq
         TDrvQIq8H+GcjlJIqxkn0gIsITdpXQmHL8p45FbW7ujmOkKNkaYNZijsQUpBM3y750FX
         +Lt+ymvNQ2VRRRG2No2u9ZSXTNYA3fW9IbyXtAfMlqvqccyezASGLDu/64JtXJtwl7cI
         qrXwEhIWbVr/GSrQobqVW3otFfuP5xVjbrATt6k4rVvguTqT4bOaC9VEMp0avan+UMNT
         ddKo0wiX4rV355feXxk9QWPMySED41WaD95k/NEAjLrVULEBmr1bMPVBcFOM2if/BH3p
         7zdA==
X-Gm-Message-State: AOAM531g8KzfzJzOEGcbDsAQZ9CG/OQiDQYHCCpeeK9H0DouojelZvzx
        ebaZlUxyCrogbXwk0Ao7aIE=
X-Google-Smtp-Source: ABdhPJx5Sw3k/c5BjHYKSJHnKPHs7ncwHuxaACWn5BpLfWWiiad0396Y/mFmS4Ro+1NA0gnkNn4nmg==
X-Received: by 2002:a05:6870:c59b:b0:f1:231c:c82c with SMTP id ba27-20020a056870c59b00b000f1231cc82cmr1026289oab.217.1654652492374;
        Tue, 07 Jun 2022 18:41:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830144f00b0060b0bf08ef8sm9704313otp.7.2022.06.07.18.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 18:41:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4ebf3fb3-47c8-b4b4-e9b2-630e3f540316@roeck-us.net>
Date:   Tue, 7 Jun 2022 18:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/1] MIPS: Loongson-3: fix compile mips cpu_hwmon as
 module build error.
Content-Language: en-US
To:     Yupeng Li <liyupeng@zbhlos.com>, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, tsbogend@alpha.franken.de,
        jdelvare@suse.com
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, caizp2008@163.com
References: <20220608011229.2056016-1-liyupeng@zbhlos.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220608011229.2056016-1-liyupeng@zbhlos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 18:12, Yupeng Li wrote:
>    set cpu_hwmon as a module build with loongson_sysconf, loongson_chiptemp
>    undefined error,fix cpu_hwmon compile options to be bool.Some kernel
>    compilation error information is as follows:
> 
>    Checking missing-syscalls for N32
>    CALL    scripts/checksyscalls.sh
>    Checking missing-syscalls for O32
>    CALL    scripts/checksyscalls.sh
>    CALL    scripts/checksyscalls.sh
>    CHK     include/generated/compile.h
>    CC [M]  drivers/platform/mips/cpu_hwmon.o
>    Building modules, stage 2.
>    MODPOST 200 modules
> ERROR: "loongson_sysconf" [drivers/platform/mips/cpu_hwmon.ko] undefined!
> ERROR: "loongson_chiptemp" [drivers/platform/mips/cpu_hwmon.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:92：__modpost] 错误 1
> make: *** [Makefile:1261：modules] 错误 2
> 
> Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/platform/mips/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
> index d421e1482395..6b51ad01f791 100644
> --- a/drivers/platform/mips/Kconfig
> +++ b/drivers/platform/mips/Kconfig
> @@ -17,7 +17,7 @@ menuconfig MIPS_PLATFORM_DEVICES
>   if MIPS_PLATFORM_DEVICES
>   
>   config CPU_HWMON
> -	tristate "Loongson-3 CPU HWMon Driver"
> +	bool "Loongson-3 CPU HWMon Driver"
>   	depends on MACH_LOONGSON64
>   	select HWMON
>   	default y

