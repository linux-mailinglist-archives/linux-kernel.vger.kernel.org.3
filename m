Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B85427FB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiFHHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345387AbiFHH2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 03:28:25 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CD61EB436;
        Tue,  7 Jun 2022 23:57:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q11so11620613oih.10;
        Tue, 07 Jun 2022 23:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nFNxK00ysgg5yIErGrG7byPW6A2B7y+hYrnWZTc6uNQ=;
        b=ivFLPYVWTCnwgJpjYdRAcGh3XmysCVxE2blQ3z8PcxVgkRJhhBK/u6Qcmm/3t+GWHe
         QZLV+BXXmak7M0qfNJp9mj7VWD28ZaJexJLKv7CYeGPzwcnqjYJRVpF5JE5Ld7fpYCBx
         HFrVQGPhx1LznW6/Cz/SyPFPx+3slfZ6U1bvF4TiUaL9BHKn6uIzEcZy7X051gPIhTq6
         WyKZUNGJAJ72x54IkF3tDS3GKS9i6yWS2xSpEPkM6RG4VHHVkS176n7zhjthhZU2iLJv
         L5RU8we47eTyWwYXhm8W0dTjE+ZEoIAmdcm2ptuEttaeaOK5E2BSMPiwDYoC7/fPwkkf
         7etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nFNxK00ysgg5yIErGrG7byPW6A2B7y+hYrnWZTc6uNQ=;
        b=WFmFbtaVVRv3yZdSHaVXV+BlH2aJXQJ3RV2GVW5QJyAIw30WIcehib8+MA0FNOtYNh
         250gWd3rLyaaGFLKRkYucaJLaY1Fzu+MB3OSryKxz5dtwXO7PG4mmcuXGbgtKW6qr/Qa
         EG+bStoZ/mlxibYxbfjhM4AHG6Mjh1E2mUqP7gvIk31n2dKi10in1ZRuayaHabEfyr5s
         b9aQR8MlVB4juujJVPS0qs3hE2RITnBBSV2yMBUMVDP92wXaki1na5YkaNxdReDRwT9m
         AIQN0oUjaWxK1zyffvJUwBUXyxWzBAXpx5etdBTuzcq+hdC7AxX7623soFsbSg5nmqzu
         qT+Q==
X-Gm-Message-State: AOAM530ybMPXWgh+3U/Q6AdopiwzZh7cFOf7q9yzjk2HBFlVsZEvd9tu
        8To70TdkzhNPpgRiAwEWuMU=
X-Google-Smtp-Source: ABdhPJwjio8ewPtep8UaxlEbXsif2fgQMkRulDfiEgHmP/u58V9T1nJfrvEXiIhEhGDqFe+UgkOIpg==
X-Received: by 2002:a05:6808:1448:b0:326:e239:a490 with SMTP id x8-20020a056808144800b00326e239a490mr1602576oiv.253.1654671454189;
        Tue, 07 Jun 2022 23:57:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6-20020a9d71c6000000b0060affecb2a5sm10379788otj.17.2022.06.07.23.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 23:57:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e8347ef4-ef25-0941-3403-2819131cc9b8@roeck-us.net>
Date:   Tue, 7 Jun 2022 23:57:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] watchdog:Fix typo in comment
Content-Language: en-US
To:     luoxueqin <luoxueqin66@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        luoxueqin <luoxueqin@kylinos.cn>
References: <20220608060933.13062-1-937225041@qq.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220608060933.13062-1-937225041@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/7/22 23:09, luoxueqin wrote:
> From: luoxueqin <luoxueqin@kylinos.cn>
> 

"luoxueqin" is not a name. Please use your full name.

Guenter

> Spelling mistake in comment.
> 
> Signed-off-by: luoxueqin <luoxueqin@kylinos.cn>
> ---
>   drivers/watchdog/pc87413_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
> index 9f9a340427fc..c7f745caf203 100644
> --- a/drivers/watchdog/pc87413_wdt.c
> +++ b/drivers/watchdog/pc87413_wdt.c
> @@ -442,7 +442,7 @@ static long pc87413_ioctl(struct file *file, unsigned int cmd,
>   	}
>   }
>   
> -/* -- Notifier funtions -----------------------------------------*/
> +/* -- Notifier functions -----------------------------------------*/
>   
>   /**
>    *	pc87413_notify_sys:

