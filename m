Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76B54636B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhK3OfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhK3OfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:35:09 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB67C061574;
        Tue, 30 Nov 2021 06:31:50 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id r26so41552207oiw.5;
        Tue, 30 Nov 2021 06:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmAztSnWMiSquOCMQYsGYthvjjOlOm6J9hF0lmVx1Lo=;
        b=TW3XzJS9rC6ZxGSptghg0OQ8j+T5g2EOaW3raWxSWQYXT07CcY3x0wJmwXEoN+A+ky
         qT5I4NGtEMdpXXq4JLf/W3YtRArKeajaVB18mFfzIGZQSQiQn8ZHgIc5v5+582T4uY2w
         +LS6ZRO6LJEtYyCBVKQHLT1WJr8Tz6sIghBcfapKUp1mQ1Ry0mCnyRwAz7H/zs3H6pts
         u7DELFtISRVzPDcZDR8znnFcGxWmy3wyRKPwwNtJirV1mUIiZV90cFOJSPqStOlIAwQD
         47u6nniGvlo0Lwo/LQ86WsvC5eQaHj566ta/hk6tSJ22wQTTcdJ09vl7y7KV0KcUaR1g
         98aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmAztSnWMiSquOCMQYsGYthvjjOlOm6J9hF0lmVx1Lo=;
        b=dI1QWOBDoFcgSxEsA5Vs6BPUKJeHIneIIEobKQlo6UH76AObLzfohA2NSq3LT5So9a
         nJOeXKrjvRXHTD4FU0fVZUq3vSpuyxTSaVnWTGU3y5yuQ2hpoy7AhfKC+vRiF3hT7hUh
         yHsmSnvXxb/Z/oVJDl6H6tqhRtY/UUi4ewdSt3ClVL9MbhHZhu0Yqo9ShzqeF5ZT7OLy
         fp8rPg3ROEOP6wg8DhcLXqyRc93v16SUG/zH379EZ6F4MaFRaR8HFj+tNTuWAsunS5DP
         Uo055So7J2S/7uL/icJiyfuwcW0wODsIy6TqnVkn3osJfcwxmi5Gfh/9pZehrHcc1mOw
         POIw==
X-Gm-Message-State: AOAM532gCOn2kBdqgehk3YnJ8jBMR1xSQDFNE/lkuZYX3Le0aVt8qCtu
        gbh18R1t5M8+e9DGnVVe+QE=
X-Google-Smtp-Source: ABdhPJyP6TXpW3iu55mL8Q1gkVNFPsHG0PuYQTnc7SmPml7hD6bZEeegNceEBW9bFX49Rxlp8mlqlA==
X-Received: by 2002:a05:6808:211f:: with SMTP id r31mr4482712oiw.64.1638282708518;
        Tue, 30 Nov 2021 06:31:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17sm3187176oth.17.2021.11.30.06.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 06:31:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6: phycore-som: set watchdog timeout
 mode to shutdown
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     support.opensource@diasemi.com, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-4-andrej.picej@norik.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7164c047-63a2-4c3f-b09b-64dc00683723@roeck-us.net>
Date:   Tue, 30 Nov 2021 06:31:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211130134242.3516619-4-andrej.picej@norik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 5:42 AM, Andrej Picej wrote:
> Enable system restart when the watchdog timeout occurs.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---
>   arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> index a80aa08a37cb..743343e525cf 100644
> --- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
> @@ -111,6 +111,7 @@ da9062_onkey: onkey {
>   		watchdog {
>   			compatible = "dlg,da9062-watchdog";
>   			dlg,use-sw-pm;
> +			dlg,wdt-sd = <1>;

dlg,wdt-sd should be defined as bool.

Guenter
