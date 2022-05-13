Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA752627B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380500AbiEMNAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350313AbiEMNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:00:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1510F9B1A0;
        Fri, 13 May 2022 06:00:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id j12so10048594oie.1;
        Fri, 13 May 2022 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LlC3aCZiZ0EPde09Twew33remzitl9lLb/l+WCKCHVM=;
        b=S+h29lSDZpBV9M6ecbR7fmi2PbqV7lIbOuC2N3dEbu/43j886nQAlCpzXDDfCkesFQ
         PDmGBJv3iOzTCvb6UNK+ofYqR0jdk2vgATm3RNVWkDd0ib/PHnSlViyMUtlLva2zKjhU
         lUlOBs4DADLlMaeu7v+Qy9wDb+J8uPkF9qckDw6eoexPqom2dcAyZuOF2dh36DWAy6Ad
         wmcUzb+DnJ3779q0Dm23qzZ2/Ov3Q6/SkSbT4SH8z8ixNu2/ftXzBzcwCTwC+NI9CW0k
         YoIODjo1+WXc6LQrCMrUL/+40yzTjGURmsdp/KCLmg0Y1XUnIzUCGO7HccVBQudNVp7T
         U+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LlC3aCZiZ0EPde09Twew33remzitl9lLb/l+WCKCHVM=;
        b=zfYtOf1Qdr1V2tlNgA7Lvdx2s5SFg5rRz82WY1T9q9fxqSVnLs7Z5RGagHBt5bWcJw
         zkFc6RF7QSNdoM7dJ6PATDPr8al+hk29VDeiPLacX9cxLYOMm/kB+MlWwwnAZeYnHzcH
         LumxAPZ4s7Lu/HJ3TWedxdiZGP4SQETpNtEetG/8oGZ6sHnY0ZbctQF4wj5xHyNJLl1c
         JkWTPuU58Splf4nzkxTYFdD3ggN+++40c08dFHYbBIHxf/jyMnuONlwE7JF7GbSX09OV
         h0Mf4m7t142IK0UUxTEHcP32GlUefGSSKJGFvGsUO7KvTUBXtm3cVuYDe6Nm54Red2fC
         Xxiw==
X-Gm-Message-State: AOAM532SjoEBRX8yjML5dck5BNP342YGAlesCOreQ7RAZH/5+0wmfGB2
        klgBJQqX83HooaxM3FGHEek=
X-Google-Smtp-Source: ABdhPJwo+e/brtBBR3rQZyQmtiDw179fmOi+hU1nYGgGnPDiLqOHGYz+GXLRxMn9UVjmBpqK8FTCsA==
X-Received: by 2002:a05:6808:198a:b0:326:9d3c:5078 with SMTP id bj10-20020a056808198a00b003269d3c5078mr7598668oib.112.1652446835205;
        Fri, 13 May 2022 06:00:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6-20020a05680805c600b00326e2284976sm952673oij.15.2022.05.13.06.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 06:00:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5efc656b-6913-eb8f-b43a-d046a10670e7@roeck-us.net>
Date:   Fri, 13 May 2022 06:00:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] hwmon: (ltq-cputemp) restrict build to SOC_XWAY
Content-Language: en-US
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eckert.Florian@googlemail.com,
        kernel testrobot <lkp@intel.com>
References: <20220513073221.48744-1-fe@dev.tdt.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220513073221.48744-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/22 00:32, Florian Eckert wrote:
> This driver can only be built if the target is set to SOC_XWAY, because
> only then the used macros 'ltq_cgu_*'  are available.
> 
> To clarify this, the Kconfig is adjusted so that the driver can only be
> selected when the SOC_XWAY is also selected.
> 

Already queued.

Thanks,
Guenter

> Reported-by: kernel testrobot <lkp@intel.com>
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
> 
> This is a fix for an issue, that was reported by the 'kernel testrobot'.
> 
>   drivers/hwmon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 68a8a27ab3b7..1122c0519410 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -960,7 +960,7 @@ config SENSORS_LTC4261
>   
>   config SENSORS_LTQ_CPUTEMP
>   	bool "Lantiq cpu temperature sensor driver"
> -	depends on LANTIQ
> +	depends on LANTIQ && SOC_XWAY
>   	help
>   	  If you say yes here you get support for the temperature
>   	  sensor inside your CPU.

