Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F163355B40F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiFZUow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 16:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiFZUov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 16:44:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C631EEB5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:44:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw20so15112564ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+NiKnLEANxLAPhew67VDLJo2BLnUAn/GY67TsCLrKkQ=;
        b=e0DR+7Flsxt4JCftlM/n7rZXiVyC+6Wu49NvaZtQoeVAo+kDEbS5v+G0pLT0pdcBKZ
         3CsqdXyDndrUmP+hJjly12AOjr5jVB6bnAyq9VVrUxPAjBJXcUAJLm6egZm+oUBX672W
         QCTYvn9hLMA373G23Vs1nAtWcwvMZ3o4YFrAj3tV7aZjKiJtBFFB8B+oV8DAuCx16ejo
         9OElXexSkFUAruKSSGU7UCaf5sQdtze7H8D8BK5Cy3Yi3TlDgWJQUCzIoMgRGGucpAxy
         l2hPej2sc5yYU+Z9k/Cc9LRFoCAtnt3CXtgj2NHMsA4JTAieo5+t0TQfeyKiT9HX7nMG
         +G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+NiKnLEANxLAPhew67VDLJo2BLnUAn/GY67TsCLrKkQ=;
        b=ypQWLhxh8KX5cKl25zyQf5hwUx0WrIUVcrNQP30JPFin7bZiXbksWuZdR4LVeStxiI
         xa41uVNg8sw+JOYstWHvoBfhYw9XLxhNxyWL7S0HeHXpMLwfXbbyh+Rvis/6egZvWhc6
         N5MNJ8TcAQkfKnEy2r7608DmRz4OsU/it7YYvfOLAdpAWDArqA8ETacscRKYxgPafEk0
         pi3OxgDD2cDlVM03o548qNZqtRhoFfI/LVEHYNk3OE9z85yA2fqnXBhj3rHmpaXqX/Y8
         01gn1/hydKlSqBdqZRKQbsksB9MfcDce7NCbli/SpNSYrEGPSD6NjCCjoqtdhBA7SnSs
         dy7w==
X-Gm-Message-State: AJIora/xn19DPHCWAN07wUaMKgBdiCApJzh7H9bLOHR9XvkTFlASEqSo
        p+euDUVCvaSOhBItCMOkCU4=
X-Google-Smtp-Source: AGRyM1sihdHv4mKJi+4Gh/l2yvDSlHnR/tA+lgO5Su0blV9xf5TiG1xEgZoWHv7dfccYoxyLf4jFJw==
X-Received: by 2002:a17:906:66d4:b0:70f:e86d:61b with SMTP id k20-20020a17090666d400b0070fe86d061bmr9656981ejp.401.1656276286306;
        Sun, 26 Jun 2022 13:44:46 -0700 (PDT)
Received: from [192.168.1.100] (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id y1-20020aa7c241000000b004355dc75066sm6368347edo.86.2022.06.26.13.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 13:44:45 -0700 (PDT)
Message-ID: <3a177ab1-5e56-e3bf-4756-4532957fca7d@gmail.com>
Date:   Sun, 26 Jun 2022 22:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] staging: r8188eu: remove rtw_usleep_os
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220602194807.281115-1-martin@kaiser.cx>
 <20220626180603.287054-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220626180603.287054-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/22 20:06, Martin Kaiser wrote:
> Remove the rtw_usleep_os helper function. There are only two callers, both
> of which call rtw_usleep_os(100). This is equivalent to msleep(1).
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> changes in v2:
> - use msleep(1) instead of usleep_range
> 
>   drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
>   drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
>   drivers/staging/r8188eu/include/osdep_service.h | 2 --
>   drivers/staging/r8188eu/os_dep/osdep_service.c  | 8 --------
>   4 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> index 45e85b593665..cf9020a73933 100644
> --- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> +++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
> @@ -273,7 +273,7 @@ static s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
>   			err = -1;
>   			break;
>   		}
> -		rtw_usleep_os(100);
> +		msleep(1);
>   	}
>   
>   	return err;
> diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> index 5549e7be334a..5b65313e0b9d 100644
> --- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> +++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
> @@ -243,7 +243,7 @@ static int efuse_read_phymap_from_txpktbuf(
>   			if (reg)
>   				break;
>   
> -			rtw_usleep_os(100);
> +			msleep(1);
>   		} while (time_before(jiffies, timeout));
>   
>   		/* data from EEPROM needs to be in LE */
> diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
> index 1d97d5be46d5..72990a1cdc66 100644
> --- a/drivers/staging/r8188eu/include/osdep_service.h
> +++ b/drivers/staging/r8188eu/include/osdep_service.h
> @@ -76,8 +76,6 @@ void *rtw_malloc2d(int h, int w, int size);
>   		spin_lock_init(&((q)->lock));			\
>   	} while (0)
>   
> -void rtw_usleep_os(int us);
> -
>   static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
>   {
>   	return del_timer_sync(ptimer);
> diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
> index 812acd59be79..3504a0a9ba87 100644
> --- a/drivers/staging/r8188eu/os_dep/osdep_service.c
> +++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
> @@ -42,14 +42,6 @@ Otherwise, there will be racing condition.
>   Caller must check if the list is empty before calling rtw_list_delete
>   */
>   
> -void rtw_usleep_os(int us)
> -{
> -	if (1 < (us / 1000))
> -		msleep(1);
> -	else
> -		msleep((us / 1000) + 1);
> -}
> -
>   static const struct device_type wlan_type = {
>   	.name = "wlan",
>   };

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
