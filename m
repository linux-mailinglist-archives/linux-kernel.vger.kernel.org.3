Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7BA4E6771
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352079AbiCXRGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiCXRGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:06:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCCCB0D12;
        Thu, 24 Mar 2022 10:04:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so5775773pjo.1;
        Thu, 24 Mar 2022 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=STMU7e/I1m6VY6MjvIoI76oz7x7+nWXzvbO+4NLxw0s=;
        b=JSTzQSr8a6ZV3CML3sQN/TWvPdbiQsTWJhG0wSSRtNr0MFPFt1eJMYS2u2lUa8X2y9
         8CYfd1wDhQl103rijG5UpmGdXeQ4pGUS8aG53v0DKJkfJfjt07wYbCJz9Gfq4rTBJCSH
         cD8mCnXDywf1XZ9SEnt057QMM2oEW5bKnaV4Umj8uzeFpFdLPtT2QKmmy2ehyqQu1aDC
         QIdajoXJydC8sFtFi+654fInQ/JC0tCP4c7AByNs4AiZffn6jBZ6S+PheMInlG6EMqWn
         V1a+1Ikd4oIomJWbiqplvpXvoDsIa0sDeq+JchDAwg7ytkRWxblCXzCqN2mfP3JN+g3M
         EJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=STMU7e/I1m6VY6MjvIoI76oz7x7+nWXzvbO+4NLxw0s=;
        b=WALNx3kgR2ApQsljmFtpA9f/+YvQWyZs3cABsjyiCWoDM2BPwKst5W9wzu3ODgoR+/
         TlOBzHaVhqnxDV2eAkXW8Z2krbW416HA80pFh/LGU8PP3NJ9i/M8LEi76hPiRVdgENqY
         +iLmwJHkBH5zLm39opJ2HT9ByAr5tm1ZEjYyIxWR0xIEoTP6lUaOH/OTKQok1aY4cYBh
         jauRI/TG5PKly+dczH5LMOtQg28d3V2M1g+3Lj44gdJDqu899pn9FvZ8saIw764EZgGr
         g+JHOBA0HTrTrU4WQrPOsLazpUT4rUoNHbxjA1/6KwsQQpA14ruY4gsrR0XFNTyTelH6
         x98A==
X-Gm-Message-State: AOAM531Y4HszFCwTtY7mt9NLRiVX1R+JJnm6zlKVTQwokUFJFRfIBfC/
        GVmXEjt5xMQNGdp8auT9MGI=
X-Google-Smtp-Source: ABdhPJyqnVKumV45iugDqVnPP9eNJESsThCjmfsGBkuivLqQTsBP+aQqhmb7Usy13oPb4HSIXacstQ==
X-Received: by 2002:a17:90a:a78f:b0:1bc:8042:9330 with SMTP id f15-20020a17090aa78f00b001bc80429330mr19740927pjq.229.1648141486862;
        Thu, 24 Mar 2022 10:04:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o65-20020a17090a0a4700b001bef5cffea7sm7331537pjo.0.2022.03.24.10.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 10:04:45 -0700 (PDT)
Message-ID: <2a8afc70-c0d8-2b37-9d49-9a054a30ea4b@gmail.com>
Date:   Thu, 24 Mar 2022 10:04:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] soc: bcm: Check for NULL return of devm_kzalloc()
Content-Language: en-US
To:     QintaoShen <unSimple1993@163.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
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

+Rafal,

On 3/24/22 01:35, QintaoShen wrote:
> As the potential failuer of allocation, devm_kzalloc() may return NULL.

s/failuer/failure/

> Then the 'pd->pmb' and the follow lines of code may bring null pointer dereference.
> 
> Therefore, it is better to check the return value of devm_kzalloc() to avoid this confusion.
> 
> Signed-off-by: QintaoShen <unSimple1993@163.com>

Fixes: 8bcac4011ebe ("soc: bcm: add PM driver for Broadcom's PMB")

> ---
>   drivers/soc/bcm/bcm63xx/bcm-pmb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
> index 7bbe46e..55bf389 100644
> --- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
> +++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
> @@ -311,6 +311,8 @@ static int bcm_pmb_probe(struct platform_device *pdev)
>   
>   	for (e = table; e->name; e++) {
>   		struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
> +		if (!pd)
> +			return -ENOMEM;

I am of two minds as to what the appropriate behavior could be here, we 
could equally use an:

		if (!pd)
			continue;

or do what you are doing.

>   
>   		pd->pmb = pmb;
>   		pd->data = e;


-- 
Florian
