Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1B57E2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbiGVOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 10:12:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFEC8C17E;
        Fri, 22 Jul 2022 07:12:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h132so4520570pgc.10;
        Fri, 22 Jul 2022 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rGz1Zajo5FVtqFz5vEyyJRNZNr5LdAGNcIBq+qrZIXM=;
        b=aF1Bmv8rfFQ5F2xxD5qoZU7OmNpcKkpTA1XMJkqhhml3BlnEGOFtO4RCWFNM+0LdSE
         flvLhRXyRo8UjZEYY8sOwbnsXZz1S9odCwfLvk7eRu+3VveC0iavNNmxbj7tQv+8c5pu
         fK41Xyp17MMP0lNAV2VYC5k6U/QAsC3AOaOU1IdjbCOlporZLEfNifCYwv+Ug7tpQTdu
         ftS4JhXI6MYugpORtjL/35ln926QCCU9soyyRuxbSWqqG9GOKIX0ClrmLB0oVeG1bBR/
         Ti28xv0mZ5I4pwIbcyVq7RZvtoMMOi4vg4Et0eozqnGmcCNztOQHeME4lYqYpqjm0Rjg
         hiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rGz1Zajo5FVtqFz5vEyyJRNZNr5LdAGNcIBq+qrZIXM=;
        b=y31cGN0XATg30umTryYcKHoh8aiFCH26fni4MnOXWh2fd/Epr2EOYzsyu6rH/7yMAW
         424Go+rZ27+XEyhf7uArV5di3opRyeCla2gGPn/DH0AYe4wb7nVeBGU3e7G6hyR6KUk2
         Ym8Qxcxyp6D76m3C0sU0JprOmCysYqYSa4WGjZmKwj36Jdc6fstiDsySOdb5hsEWgpKc
         Gn88Q8bC27FxQ6X1UkcuMdwgFzSieWKzPz22nYIy4VvyLq+rl8bEQLjFWDNsJQYRK28O
         1UNvogdFCgdU5oOYywVWvwOVa/q24s3XczsYNA0D+KKEgtklYElucchCRhtzGRdH1ymC
         S/fQ==
X-Gm-Message-State: AJIora8DSnGCg9s/MSrpqeKAKjLqKKphEGTaao3deWPZKS87KViuWDU8
        Hjf/R1hk81K1rFFBXi7hM6w=
X-Google-Smtp-Source: AGRyM1uW245I0U8aEFTW8t7+bl8YItixbWlQjb0V5VKN1Wo93AfsUMXIeUl6VnNqQdr1GRnfMBAOuA==
X-Received: by 2002:a63:4953:0:b0:41a:8f88:5705 with SMTP id y19-20020a634953000000b0041a8f885705mr28231pgk.386.1658499126488;
        Fri, 22 Jul 2022 07:12:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0b9700b001ece32cbec9sm5728290pjr.24.2022.07.22.07.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:12:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d97e9467-c6da-c304-c625-599a76b8b02e@roeck-us.net>
Date:   Fri, 22 Jul 2022 07:12:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] watchdog: f71808e_wdt: Add check for
 platform_driver_register
Content-Language: en-US
To:     williamsukatube@163.com, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
References: <20220722092503.2938544-1-williamsukatube@163.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220722092503.2938544-1-williamsukatube@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 02:25, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@gmail.com>
> 
> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
> 
> Fixes: 27e0fe00a5c61 ("watchdog: f71808e_wdt: refactor to platform device/driver pair")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/f71808e_wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 7f59c680de25..6a16d3d0bb1e 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -634,7 +634,9 @@ static int __init fintek_wdt_init(void)
>   
>   	pdata.type = ret;
>   
> -	platform_driver_register(&fintek_wdt_driver);
> +	ret = platform_driver_register(&fintek_wdt_driver);
> +	if (ret)
> +		return ret;
>   
>   	wdt_res.name = "superio port";
>   	wdt_res.flags = IORESOURCE_IO;

