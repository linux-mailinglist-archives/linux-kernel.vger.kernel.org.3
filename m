Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986FD4FE394
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355317AbiDLOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiDLOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:21:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DE72B257;
        Tue, 12 Apr 2022 07:18:46 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k10so19221280oia.0;
        Tue, 12 Apr 2022 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=obv/k21gZE+V92h4u03QULKQ3LtytSGxFnD77czROmA=;
        b=EAAEBVlOAqOyiW1tC4Ocs2HJi/WOyZDgN6RRcmql+HY0hA5+QGV21TCNUGhH7JNB2l
         Hk6t4IG8jK1vQQOuNFGfg1JLiYkuTqIwejo1POrVPR0NQlp43e819Jbkm48JQDWYtIjT
         +lb2T9w+vDUG2AX1oky5qrJhRe0hdu9s0ivy0yDKgOhddOykO60QR8M72Ycf/oqTwpEU
         2kpvfBakSQK0sCU7mM1O3Q+DQ87dIdJeQDJOVU3r6x5pq6Tnzrq5lx6fo7DdEWnKaSpk
         m5TxC9gPV6zqyrEAHJyrzOPGzxhDfZ5TIOc2MbkzmF2dVSq2gFWWaEgA4yN7qt+kuG7O
         ucSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=obv/k21gZE+V92h4u03QULKQ3LtytSGxFnD77czROmA=;
        b=Yst6+xzFMQtnzGyF1A88qCLANA3/A2nmyODgSIzunPKC9crbNE3FmsNUVxJPsZ9Gmw
         NuTDgX6HM5VrLYF+IsaKVy3CZXwX+GPV10UHmYUHsGe4Mt55Pqwdl2ASYnvg23U/awII
         paIMHiiVCqWkDJ45C3ty9fEyW5+OD5yKjKAGlXjt6Im9MPnkAZ0ZRx3JDMDEFeZ10FJf
         i+7uiRt/Zn4x+H3+hxf/v0jqFnm3bbEXvYfKEfAq59pYUJn4cDLZ8CbJAkPDXNyPekub
         LqKitoyis8sgUex0vThddQgdVr1JjaIb2STQBobwAbCpOkifHy7e5xuaPIgcbHpXH8+m
         c/Mg==
X-Gm-Message-State: AOAM532ZMwemuBdNMqLkUpR87yAH8up4yqVNqFKw68J5JvYBcasQaEC0
        6yCD3MJRJ1+ludhqu2yXWGA=
X-Google-Smtp-Source: ABdhPJwwRy1UvOvDwBp6yA+VwcIK7ZVdFBc4qHV4BN+/MjC7zbwOdmbapdiftY1O+qAYdRi6vD4Nuw==
X-Received: by 2002:a05:6808:4cf:b0:2ef:8af8:4a4 with SMTP id a15-20020a05680804cf00b002ef8af804a4mr1843693oie.159.1649773126149;
        Tue, 12 Apr 2022 07:18:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1-20020a05683003c100b005c927b6e645sm13487706otc.20.2022.04.12.07.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 07:18:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4dc6a76b-cdb4-e43e-cd04-4d77f9133ddf@roeck-us.net>
Date:   Tue, 12 Apr 2022 07:18:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] watchdog: rti-wdt: Fix pm_runtime_get_sync() error
 checking
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Tero Kristo <t-kristo@ti.com>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220412070824.23708-1-linmq006@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220412070824.23708-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 00:08, Miaoqian Lin wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1, so a test for negative
> value should be used to check for errors.
> 
> Fixes: 2d63908bdbfb ("watchdog: Add K3 RTI watchdog support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/rti_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index db843f825860..00ebeffc674f 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -226,7 +226,7 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   
>   	pm_runtime_enable(dev);
>   	ret = pm_runtime_get_sync(dev);
> -	if (ret) {
> +	if (ret < 0) {
>   		pm_runtime_put_noidle(dev);
>   		pm_runtime_disable(&pdev->dev);
>   		return dev_err_probe(dev, ret, "runtime pm failed\n");

