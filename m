Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871B44C4AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbiBYQfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiBYQff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:35:35 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C90D1DA02C;
        Fri, 25 Feb 2022 08:35:02 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so3952982otp.13;
        Fri, 25 Feb 2022 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9GsfwK/nnIuvlsQePdP4EURIXceQzXyDH1BCPBGoi+U=;
        b=Vv/M8ZG32wzw1rrwR/d4eeKsaEy0VF0bJ73vy+vyM2M+21IrgGjszCep9Yo2UT3viw
         OjFxygiHOfxLn080ne1912tyaI+k670e47U8LhaHEKb15ztkLBIzTsriBz8eE7D1kFo4
         JFZy315oqAxtsgKVbtkeF0wC6uO+m5Zcuu1+8RV6JH96YEriTer3tsEez8VAa70UCt7c
         OA7YUgbvb73aljPFidzliv7aMF3YFJzDKuU/qiV488JIlAS55ydZ9DGlT9/SbIxJJoo6
         CydHabNmRz2AJuNsS4xl1Eiaukg/Jmz2PU7s8gVNhYObuN6un5p84GTGl7CXtSfgBgd4
         mIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9GsfwK/nnIuvlsQePdP4EURIXceQzXyDH1BCPBGoi+U=;
        b=vu8xwv78c952GFmZLrV9y0Jf+9srsN9rtOguayDzYwYMFtpvDfVTj5LaAGs55+52rP
         W1atQfyVqlGJeRrok1oj0L6qPGvZoUEM8zQ6xdnwJsjSmF130ou2TgXDb2rYGH4nJtFI
         Uvkhu2gw9EWJkk7NucAjOWy8C/NiZrV+GlzDOTrsZ0MtwhYXKVuwY8fKVxLiifE0UKon
         s+mbgbO2jVNxLZSbD7VR5edgdq9nddaOcvo2/xkUI8p5B7xHdpim5FAJW3xlDcmwcYJu
         HzJITnT9JnP1jvGs/f0MHDny4nBFlMkHaHwzqQRgA8TjkpkOV+TFu2sOhfNppuUTqjX3
         cs9w==
X-Gm-Message-State: AOAM533iZEYT+XEHPCXr6eWf63Pk6Nrn28mvfWkWIkyrQ4hjeEnNBKXR
        HzwyTK/KG7jFHGSKgg4gKTw=
X-Google-Smtp-Source: ABdhPJwqYObN05dUBNTk7kp/IjdAMHXp6A8IHvo5mIvhsd8df6mIkGQ1utinVKYHlbSfR0JwbAYNjg==
X-Received: by 2002:a05:6830:1087:b0:5af:3e61:509c with SMTP id y7-20020a056830108700b005af3e61509cmr3084399oto.57.1645806901356;
        Fri, 25 Feb 2022 08:35:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w5-20020a4a5d05000000b0031c67a9b54bsm1284414ooa.45.2022.02.25.08.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:35:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <31ac0f93-f52a-f2d0-60f1-3a34c485f014@roeck-us.net>
Date:   Fri, 25 Feb 2022 08:34:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] dt-bindings: watchdog: imx7ulp-wdt: Add imx93 compatible
 string
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, wim@linux-watchdog.org,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220215081202.787853-1-peng.fan@oss.nxp.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220215081202.787853-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 00:12, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The wdog on i.MX93 is modified from i.MX8ULP with some changes,
> it uses one compatible string, so add i.MX93 support.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> index fb603a20e396..12da179ed6c0 100644
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
> @@ -19,6 +19,7 @@ properties:
>         - items:
>             - const: fsl,imx8ulp-wdt
>             - const: fsl,imx7ulp-wdt
> +      - const: fsl,imx93-wdt
>   
>     reg:
>       maxItems: 1

