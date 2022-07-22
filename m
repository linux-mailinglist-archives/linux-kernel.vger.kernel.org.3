Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52D357E377
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiGVPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiGVPL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:11:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7629748E;
        Fri, 22 Jul 2022 08:11:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id pc13so4634305pjb.4;
        Fri, 22 Jul 2022 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j+3wVTvGNsgRtb3ownmTQT3YcIvi/kCzqEmckstv6z8=;
        b=dPXmbvHRXT1HcA2mLdT8HfXyolOznSZ9ht8R/QXAzt1N4A+h3HLkA7qHEd1KcpZIR4
         9w3MBpwzG+YUPnUeZEKMAEVy22v9xjeLR9qNXq9LLeCt53LfsUZWhCUidR0HjtHSdPov
         5Ir+EGAHG693kyZffP39Cw6g0jnBXs1m/kL0AmMznYDXWwFStMDfyHMSj+hFUkSlYWFD
         90Ck/REvw6sAjxjYXsccuFvUUCgQ8HKMAzVS+QL3Y1C86DMnPujDzRQBT31jppM6xtPE
         y9y6251oNg7ugN/NmFxZkZZQfIbzdLhogxAWoEgvrYQZzbIRpS+G1QQHCGz8ztFfIM+V
         N8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j+3wVTvGNsgRtb3ownmTQT3YcIvi/kCzqEmckstv6z8=;
        b=uaDG0nAj5Urqqpum5+upcua5Tna2nhZadam2i1HNPmOsYMGYLReQ4g1Vs5FRB5BR1P
         fPQNaJM6A4VkbksCDurN7tFksSjEoE58GVjuRXN5lvZOkml/NoiFY298RCQGbHc4+1ZN
         GgJv8+trSU4hnZl5CeoEMCZjCXZgc2QsWxdJUMuqT8eLIkaOSs5HWWKW7SA0W0DJ5Cqi
         eZ87VefiT6QE/NEV1PhIudzujBJdD0crDJDxGbrjljf+I1+NN06WV+vcvIwmucZzVzFv
         U2sf9FQAdzMtfZZFV2EynnqytK7sU0Q2XPPKadQquh4OTXVNpRK1HnzMQLBh/+5OTS9p
         LiqA==
X-Gm-Message-State: AJIora96U2WyV5eNk0dJ7ckvsB+P860bV+MYjT2ropKDNiB+u79hoS00
        xTqrxxxol55wyQgMjY5HVDyee5rtTe9mww==
X-Google-Smtp-Source: AGRyM1upmoix8sELExi6juhAcvu8o2HpurcLMdmUy2ml1NhvQJK0PsJ1qgBljrcq0Lf0aNQeRORUcA==
X-Received: by 2002:a17:902:a3cc:b0:16d:1af4:6359 with SMTP id q12-20020a170902a3cc00b0016d1af46359mr386477plb.56.1658502688796;
        Fri, 22 Jul 2022 08:11:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090abd8f00b001f21f7821e0sm3495531pjr.2.2022.07.22.08.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 08:11:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <231de7ae-a7b0-14f0-6778-91ad9cf4223f@roeck-us.net>
Date:   Fri, 22 Jul 2022 08:11:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] watchdog: dw_wdt: Fix comment typo
Content-Language: en-US
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220716041951.34714-1-wangborong@cdjrlc.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220716041951.34714-1-wangborong@cdjrlc.com>
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

On 7/15/22 21:19, Jason Wang wrote:
> The double `have' is duplicated in the comment, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/dw_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
> index cd578843277e..3208ce305335 100644
> --- a/drivers/watchdog/dw_wdt.c
> +++ b/drivers/watchdog/dw_wdt.c
> @@ -218,7 +218,7 @@ static int dw_wdt_set_timeout(struct watchdog_device *wdd, unsigned int top_s)
>   
>   	/*
>   	 * Set the new value in the watchdog.  Some versions of dw_wdt
> -	 * have have TOPINIT in the TIMEOUT_RANGE register (as per
> +	 * have TOPINIT in the TIMEOUT_RANGE register (as per
>   	 * CP_WDT_DUAL_TOP in WDT_COMP_PARAMS_1).  On those we
>   	 * effectively get a pat of the watchdog right here.
>   	 */

