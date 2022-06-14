Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA0554BA84
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiFNT3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 15:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiFNT3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:29:06 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFC7140AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:29:05 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h192so9392578pgc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m8sRbdjaWLngut7z7gVlgUwSBUU63aye8jnOzp6qH2M=;
        b=XgMzpWyS3GjTNjevMNPR6KHcV1KnEtzYTsTPCzt2HHnoRzI5Gxvo6rArgXxftkImB8
         5+XgxUWNBlFrNVbfPzyO/XWLXROuSLIJ8MpRYoUffONgcpPtsJpL6BYXq6k2BXbBeZ+7
         YX7RfGu5IgOZRN9mhVB1XXhgx9+i0tKZ0PENvVSKUhGhFYUiVqnCJBszGSWmd+vZ8Iq5
         0xFRwFZdxTgIEAaotIQftpbtFAWZNXK8v8aX/ix2/WEYrYV+biOz3rEn1++aebyy85EC
         PvpqUHPVXwLRjvkwttP/kfbSwEpfscSpDTvtvmhLMz3OkFH1JLLLgxsyxo2+0NK5SYk9
         DW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m8sRbdjaWLngut7z7gVlgUwSBUU63aye8jnOzp6qH2M=;
        b=0M82e2Sk41wz3SKj12CHoXhlH+boEWewaOjeOAS+6VALExgE3ctmH13CekwpYF6eFo
         ZX8tAy1V0iVR2a7+lbTEVLVsF/Um4PP+MnsGhvvKFMuoNqs1o495GQD0Xd52I0fqvZiS
         0IuIkRYUBgKIVPnQAsya4oR0H3J8VFoSG4efcT/M417Jt64jtp0lXa0nXnr7WCrIYMb5
         omq+cbNw7ck6z1y4zzTGylsP69XxbH4sp3i/JumqxrjGvRnR+M9xBTvJyZwLI3sCGrqy
         i4gqV+4nVRDXn7SZ/6FcJMQZhHaNPzOwx9IU4GwyyNw13fCSnkUXPIlONTOaM8WzSF6+
         2n3g==
X-Gm-Message-State: AOAM532Nomrzzj0UEGh0MQ1Q205i1ezYIGNoe6NdmYPSHxqrAFooShgX
        el3BpUdzpWbFQYjYFQ0J87KrLQ==
X-Google-Smtp-Source: ABdhPJzixjJR7IV+cO3qB/NPWSKaVfHJnhwUbB+QxeJXWqo4cRUqxA3i998JbaHyIfQwna+qI6BoyA==
X-Received: by 2002:a63:6a06:0:b0:3fd:5a1d:85c5 with SMTP id f6-20020a636a06000000b003fd5a1d85c5mr5876118pgc.130.1655234945184;
        Tue, 14 Jun 2022 12:29:05 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm7590691plp.302.2022.06.14.12.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:29:04 -0700 (PDT)
Message-ID: <475873e3-4166-4e34-7ccc-363dd8963cce@linaro.org>
Date:   Tue, 14 Jun 2022 21:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MAINTAINERS: adjust ARM/INTEL IXP4XX ARM ARCHITECTURE to
 ixp4xx clean-up
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220601050200.22213-1-lukas.bulwahn@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220601050200.22213-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2022 07:02, Lukas Bulwahn wrote:
> Commit c83227a5d05e ("irq/gpio: ixp4xx: Drop boardfile probe path") and
> commit 155e4306107f ("clocksource/drivers/ixp4xx: Drop boardfile probe
> path") remove files include/linux/irqchip/irq-ixp4xx.h and
> include/linux/platform_data/timer-ixp4xx.h, but miss to adjust MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> Remove file entries for those files in ARM/INTEL IXP4XX ARM ARCHITECTURE.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> Linus, please pick this minor non-urgent clean-up patch for ixp4xx arm.
> 
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 58e751b9346e..e0f5895feb6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2196,8 +2196,6 @@ F:	drivers/clocksource/timer-ixp4xx.c
>   F:	drivers/crypto/ixp4xx_crypto.c
>   F:	drivers/gpio/gpio-ixp4xx.c
>   F:	drivers/irqchip/irq-ixp4xx.c
> -F:	include/linux/irqchip/irq-ixp4xx.h
> -F:	include/linux/platform_data/timer-ixp4xx.h
>   
>   ARM/INTEL KEEMBAY ARCHITECTURE
>   M:	Paul J. Murphy <paul.j.murphy@intel.com>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
