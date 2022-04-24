Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0466F50D3E6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbiDXRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 13:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236252AbiDXRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 13:25:18 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D7BCB4F;
        Sun, 24 Apr 2022 10:22:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v65so10041632oig.10;
        Sun, 24 Apr 2022 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gJyERW7nV1azvnBTWPVilJ/+td61cNeV8dCVgXesf3Q=;
        b=dGy6/ijHGSinpAhXyG50I7RMcLyJtabc5wZ/L46eLgalkIKeHi3fGhilfEreEqlBb1
         Fvd3D+kM6A90QO2tKrAi/MY3ZRLeMInuqhFHGvWqXJJPTE7DSCwa2Ht6+LxVIjtgmTPV
         ouSMIas5WDanAud3e75o10rtT4I2riCdDrNbSc7yWNuu8MVOYsai8reuO9cpPfX9TQDK
         SxHqfq+1Xpw+17Fpj8zCsysSJ9NLuBi5V/4ILQ2Qs2BmEKfEs6aAirtwLb6RIihx7PI3
         Z/05U9IyzdmaLUhu40xXSe9BRxORba0uqA3I+2sMooDBzXhvP+JqPbVZCswE/uTh4hBU
         a9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gJyERW7nV1azvnBTWPVilJ/+td61cNeV8dCVgXesf3Q=;
        b=LLbJzMznwdHhg/85v8V4kwlqVZHOQgwM49nHpPtbDHInOxRj8tN7c/ch7M/M29fedn
         JFejatifnaK/WgOZLNFL27r7m3+GAE/vRtMjOycfp7x8NV9ZOQb7mfhtfrmK3PD2HAGm
         p5o7yepg9VSHa29ELVkPMBuYHPxIpNxO6q46RaELPpVw89QlMUYMaBUju9VhaaB6o0jW
         YYHyLK5I8SjiVwSi5msDkHMJfc6JV38Blw+iohgB2UM1JOTgtk1OQ79SEYsfoHw5ixJp
         Vo9dj+lN/PnMWdZPaJW+Rd6J0ad2wCPbeh5bhZ4Ivhi8RTYcME4SvMFSdOj9af3pLpxt
         7D9w==
X-Gm-Message-State: AOAM530yuoGpg8X3ufxugAQwcxyRumo/v8kM3L17NDYdbsmONPfeObf4
        0chbPTSgEmPkXCsVJNGhXPdusm6wuNE=
X-Google-Smtp-Source: ABdhPJyhmqtv3yVUfBGfryC42dIVU6dGijgvoVy604uCSr07RfjCw61rqfszzV/H/S9wdO2aAJC+KQ==
X-Received: by 2002:a05:6808:218e:b0:322:8478:cac9 with SMTP id be14-20020a056808218e00b003228478cac9mr10782271oib.99.1650820936612;
        Sun, 24 Apr 2022 10:22:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v26-20020a05683011da00b0060554e2fd07sm2939626otq.58.2022.04.24.10.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Apr 2022 10:22:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4c8673de-2503-7f9d-01ae-8f059e8a58ed@roeck-us.net>
Date:   Sun, 24 Apr 2022 10:22:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: watchdog: uniphier: Use
 unevaluatedProperties
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1649317606-21267-1-git-send-email-hayashi.kunihiko@socionext.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1649317606-21267-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On 4/7/22 00:46, Kunihiko Hayashi wrote:
> This refers common bindings, so this is preferred for
> unevaluatedProperties instead of additionalProperties.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> index a059d16cb4f2..90698cfa8f94 100644
> --- a/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
> @@ -19,7 +19,7 @@ properties:
>   required:
>     - compatible
>   
> -additionalProperties: false
> +unevaluatedProperties: false
>   
>   examples:
>     - |

