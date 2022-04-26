Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A355A50F34D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbiDZIFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344533AbiDZIE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:04:57 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD872D1DA;
        Tue, 26 Apr 2022 01:01:41 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-d39f741ba0so18585496fac.13;
        Tue, 26 Apr 2022 01:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+k/vWst8QqDFSt1ZAyLvE8FjMbyoQWQixLDB5Dm7QsI=;
        b=Hp59PvT0XPuyWuOddkSu4ENmY7GjFtNdCn58WSscz4g6VOtKytsOrlOe4h52c5RNS8
         ow0Y3exeppIMyqoJFD2g3KJDJp76xjq4JIQUVt1ub24NAp2Shv57E9JEMMo2Ddzfi1OF
         cPiX/Znj4n9UVliSAqaSIGna/ikGAYmdyCVSNgfwiciN+0vXwSCPkfz/YcloqW+/r8QR
         CEDJUfwdHjuk8onzLFDZWDkpiBYvUQhMr1lZZ51718rMSBjDePDeUeAvf+el0mOpdIcm
         K1pYEyDAhC92GL7PcOsODs82FAYS14JqlY+HW8rXjVi0CyaSY3VkNWZWo+qkbzQLWuSk
         V9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+k/vWst8QqDFSt1ZAyLvE8FjMbyoQWQixLDB5Dm7QsI=;
        b=MomEbXAJGPk83gxzNLfr4eiaWyH608RsPczmUm4JhqRLy6DNsAVmUk6isgZh/huaLb
         VUEMGoZ7Qe6JgmjjZ3bNLsQWKyeD4htJ3bFhvJL1Kzm3Y4iwalZs5nJaBns6LBrjM6te
         oRbYC3upSeQFTOppP30N9nJzmHcTNzJ2UcEdJ1Hun1Lfd1VrV8QTDZMTDCpuu2cU6XGZ
         4ws4tbjqqFJG14b5gfP3+JFnTa4yNKrvMUg2UHLzPPhYDKJTiV+Qd7QyWmfZASJrpVUS
         BJa5sFNk2l7jyvZld6v/3RiMK4kn60Ki88h/UyrJbGgIHQZkxe5Q19WBwz68AtaPzU1y
         /HfA==
X-Gm-Message-State: AOAM532mfr5NcfLII1Xi6GEN75I3omNX8WEGwU/7liYORF88ajjD+LY3
        26Rv+zY5iarEqe8qUbVptiG3/knfIvc=
X-Google-Smtp-Source: ABdhPJyoj3KDX/uI0OjjYkVYttauPzLMsRpHV5Z3cGKt4H+TmaK3IiYsvbcxeMYpyYoJbIs+eyoqdw==
X-Received: by 2002:a05:6870:4341:b0:d3:1412:8ecb with SMTP id x1-20020a056870434100b000d314128ecbmr8848810oah.36.1650960100917;
        Tue, 26 Apr 2022 01:01:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z5-20020a0568301da500b006054fd8c847sm4698847oti.11.2022.04.26.01.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 01:01:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f991b4d-8f02-6c07-a8b6-2861837a0224@roeck-us.net>
Date:   Tue, 26 Apr 2022 01:01:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 4/4] watchdog: iTCO_wdg: Make code more clearly with
 macro definition
Content-Language: en-US
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>, wim@linux-watchdog.org,
        tzungbi@kernel.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650957029-910-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1650957029-910-5-git-send-email-liuxp11@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/22 00:10, Liu Xinpeng wrote:
> Using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS reduces redundant code.
> 
> Signed-off-by: Liu Xinpeng <liuxp11@chinatelecom.cn>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>   drivers/watchdog/iTCO_wdt.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 3f2f4343644f..8d24cf4f4ca3 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -635,22 +635,18 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
>   
>   	return 0;
>   }
> +#endif /* CONFIG_PM_SLEEP */
>   
>   static const struct dev_pm_ops iTCO_wdt_pm = {
> -	.suspend_noirq = iTCO_wdt_suspend_noirq,
> -	.resume_noirq = iTCO_wdt_resume_noirq,
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
> +				      iTCO_wdt_resume_noirq)
>   };
>   
> -#define ITCO_WDT_PM_OPS	(&iTCO_wdt_pm)
> -#else
> -#define ITCO_WDT_PM_OPS	NULL
> -#endif /* CONFIG_PM_SLEEP */
> -
>   static struct platform_driver iTCO_wdt_driver = {
>   	.probe          = iTCO_wdt_probe,
>   	.driver         = {
>   		.name   = DRV_NAME,
> -		.pm     = ITCO_WDT_PM_OPS,
> +		.pm     = &iTCO_wdt_pm,
>   	},
>   };
>   
Sorry, I fail to see how this is an improvement.

Guenter
