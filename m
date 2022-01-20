Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D7049551B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377499AbiATT6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiATT6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:58:51 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707CDC061574;
        Thu, 20 Jan 2022 11:58:51 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id s9so10458342oib.11;
        Thu, 20 Jan 2022 11:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cMSYOOirRbmB4CuiP19pVfQ8SAEbMYedFbvRx1ugaeY=;
        b=U09yDaEIseG7zVAOlncNJCApY+NkMrp25gGn2zZdkCYaf99GeWcO4TCTPnxMeda49k
         N63nQQKGxUUyEPnTt3SDGtZsUfgZT6rbgcSCG5qYHFGEj0+GzkegXY+Mj/qy619j7LGW
         horPght71ErI+GAKCSQ8EFmq8mJoIeKdgDsjNfmyMsL2DQzdQ+kRsAT9ClIk9PjBiTii
         rJeszWPmZtwNSrlL+MWRDBK2+O9tRMTtuqcFNFfDfJouGBLtqa/vOdBmo+2DGXBLQFdP
         Jkgpsjk5FNV0lhVnwEGXRyQpLxuE/vvBQxPyxMAQ5TODfTbrmuoczCRlZ9JlpRhrZtFw
         sH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cMSYOOirRbmB4CuiP19pVfQ8SAEbMYedFbvRx1ugaeY=;
        b=EDwPicFTgajLTtKuZjtvpVU4FmBv9UledgRmbSrdSzJnjaUnhi0AjLV334oB9qFjKq
         NMVEYMb7TmyHnSWqSkH5HHxAd3PmFF9oV4uVhdNh574zbQ9QYPhTbbeYVCAeD1bBpxD1
         7scpiRKNU4hRu5nWsEcwQySDSfhWi2C2/bmKnE6Uw7pFpNT30RVGnFZndqyIZMXvNWmB
         q+3Lp3I7rMJzmGny/ufSxI9K2zOOR5GJXnQ/bZ1aH7pzDK++jEXh1j6GCKCCfXvD/4AT
         8J1TIJw3+PMGvfaYW+UdzHZUJDFP7iepTDAqIQUsY8igKIvwN3AvZTFrNhkBxk7aZGWO
         TTbQ==
X-Gm-Message-State: AOAM530ZFbqeu5cvnixV3aVxxe0F9vhfV3VqWVrFCTJbq/OAUnqMwLeS
        lpWgRfY/URD+LP6CJn72rac71ukc+zc=
X-Google-Smtp-Source: ABdhPJzLiNl70STng0A+cOuw/BUoEcvsNlKo2E795+VlffZHR/tnYamuVO45GxiAEfJNQO8lF7Y8eA==
X-Received: by 2002:a05:6808:10d5:: with SMTP id s21mr432377ois.49.1642708730435;
        Thu, 20 Jan 2022 11:58:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm56077oou.48.2022.01.20.11.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 11:58:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] dt-bindings: watchdog: fsl-imx7ulp-wdt: Fix
 assigned-clock-parents
To:     Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220120172333.1628990-1-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f1df742c-2f97-75d6-9fe2-4cc508dc9937@roeck-us.net>
Date:   Thu, 20 Jan 2022 11:58:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220120172333.1628990-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/22 9:23 AM, Rob Herring wrote:
> The schema has a typo with 'assigned-clocks-parents'. As it is not
> required to list assigned clocks in bindings, just drop the assigned-clocks
> property definitions to fix this.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml     | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> index fb603a20e396..4ca8a31359a5 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> @@ -29,12 +29,6 @@ properties:
>     clocks:
>       maxItems: 1
>   
> -  assigned-clocks:
> -    maxItems: 1
> -
> -  assigned-clocks-parents:
> -    maxItems: 1
> -
>     timeout-sec: true
>   
>   required:
> @@ -56,7 +50,7 @@ examples:
>           interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
>           clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
>           assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
> -        assigned-clocks-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
> +        assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
>           timeout-sec = <40>;
>       };
>   
> 

