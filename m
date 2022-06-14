Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4954B22F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiFNNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiFNNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:19:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055A93B2BA;
        Tue, 14 Jun 2022 06:19:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso6158259pja.2;
        Tue, 14 Jun 2022 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9cxMNNp1BtJt3TGma82UM2bScNKre105K9dVdZaAX8=;
        b=lrsjyBBCntMBTFq4cT+9G3pQ2IYJr9rJ0xWzgJw76PsubdbuND/4zWlmmLGx9CxfiM
         jJotFUrYpecpFXXTzVw/9wmklMaXTCxP8+lrTNC1OD/WXfwUPlW1SJoeI22o+/q1anzh
         XAy+WFU8ksOYNVKICdCzAemv67PWOCXroX6bfWqhx/VcZwynJnY45LOF6g5v9FKXw+5G
         PkjhATZVspguDZblsPynDRgw4DpTVo+ciIShf+m5iMY/cJkGqzGY5TxdXxEf4j2+OzdR
         jIF75omnQMhheWmRx6HmAD/6UAByMKKp3yw+Et3R1R3uWSgVhDaMiHivwAXD7H1vFOJd
         rcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T9cxMNNp1BtJt3TGma82UM2bScNKre105K9dVdZaAX8=;
        b=jRjvKcE2MD7N1RJq7zYWNku6mWs1YS90ON67tNwTl9/iTT8UqJHR7mFC1xoT/K+AhH
         14GX7Fi3KfEsblHf0f6XLN3VGp5KqulTxiLB2skLdF8/PrIIT2ziCQW2XPbDORQYnpdw
         FmaZxdScwsDuiDZfEEBodFtcdUOYtzJOdTW5beFT76BLnspYdreXXWKn8xP06s8UE7Gk
         jelm+KYpeScpJX6Dl/XzHwynkJxng+fBm79w/5FDI+rChHUFSt4OuuKZFIIUz5wc+Se+
         C85suk4V4tyn9WN8WVooB3Ynpce3srnFMIdFYVqoBcRVpL0Ffa2cFERZtETKK7IFwFJI
         AVdg==
X-Gm-Message-State: AJIora+Q9kVmk1pVsLnEolDITAoUxDjdkVJ67aonKX2OmJycrj1WvT4G
        WLaiGM3Fq3XfQDxMqX2fPhI=
X-Google-Smtp-Source: AGRyM1soISn/1msPSTPyqUSDK43sljLYAA5mruRM3ByYJHSqzyIpfs9KXjXNCE0JaNd4uGjDBqsDcw==
X-Received: by 2002:a17:90b:3802:b0:1e3:3f3a:3621 with SMTP id mq2-20020a17090b380200b001e33f3a3621mr4560581pjb.65.1655212757362;
        Tue, 14 Jun 2022 06:19:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902864900b00168c1668a49sm7191387plt.85.2022.06.14.06.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 06:19:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e44c0dfa-927d-7c08-66f0-6c79be1595b1@roeck-us.net>
Date:   Tue, 14 Jun 2022 06:19:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] driver: hwmon: remove NULL check before kvfree
Content-Language: en-US
To:     Dongliang Mu <dzm91@hust.edu.cn>, Jean Delvare <jdelvare@suse.com>,
        Eddie James <eajames@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        mudongliang <mudongliangabcd@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614085634.123101-1-dzm91@hust.edu.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220614085634.123101-1-dzm91@hust.edu.cn>
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

On 6/14/22 01:56, Dongliang Mu wrote:
> From: mudongliang <mudongliangabcd@gmail.com>
> 
> kvfree can handle NULL pointer as its argument.
> According to coccinelle isnullfree check, remove NULL check
> before kvfree operation.
> 

Please add driver information to your subject lines, and drop
"driver:". It should be

  [PATCH] hwmon: (occ) remove NULL check before kvfree

> Signed-off-by: mudongliang <mudongliangabcd@gmail.com>

Please provide your full name here. This should be

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Thanks,
Guenter

> ---
>   drivers/hwmon/occ/p9_sbe.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index 42fc7b97bb34..01405ae2f9bd 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -55,8 +55,7 @@ static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
>   	mutex_lock(&ctx->sbe_error_lock);
>   	if (!ctx->sbe_error) {
>   		if (resp_len > ctx->ffdc_size) {
> -			if (ctx->ffdc)
> -				kvfree(ctx->ffdc);
> +			kvfree(ctx->ffdc);
>   			ctx->ffdc = kvmalloc(resp_len, GFP_KERNEL);
>   			if (!ctx->ffdc) {
>   				ctx->ffdc_len = 0;
> @@ -171,8 +170,7 @@ static int p9_sbe_occ_remove(struct platform_device *pdev)
>   	ctx->sbe = NULL;
>   	occ_shutdown(occ);
>   
> -	if (ctx->ffdc)
> -		kvfree(ctx->ffdc);
> +	kvfree(ctx->ffdc);
>   
>   	return 0;
>   }

