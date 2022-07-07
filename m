Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F6569AAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiGGGrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiGGGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:47:07 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B92C640
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:47:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id j23so4336843lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ORqi6wxL3kK6m9SHgKlfeEe+zmKSxqFTgb7yiNIvOeU=;
        b=PraNs8gbpIt1Zs2+HzsxBWREEY9MzvD2us1oVGkjux8QNNHhQxXEfXEjV0Wxe4o3jR
         ZQlr47z3zj2GV5Ky41fn2utvGmCATv6SB0zDerZUdXAeAw0JPx2SXs5omCwZrfUZ9HBN
         X5ovgRJXELEd8rb+mI/fXw8h0Y66oO8bsA+0L1dQtP5Zy1H+s/VwO+9ZkDXXwsDRKaN1
         hrkZHfaEt73O6HmvPJc1b2iyvFwxsyFrqUDE7b987AtcxEgXt5G/xyE5ybZQmhONU22N
         2OE0zAdpb40Un4DQs2u+joOQjbqaS5XsSVBRvJqe142EJExfS7YlInY8zuflROo9vSw+
         m1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ORqi6wxL3kK6m9SHgKlfeEe+zmKSxqFTgb7yiNIvOeU=;
        b=fe0haYAtwEUkDLMpMpOF0stBqaaxSDZu+e/1W9fAX0w64jmbXvGxzyuu6hacOxQ43j
         5nRcjfqpN0s3O0CM+CTCXX2oTbyJoeaXaCfUSgE+Wenm/KILrITum3dy7BoBZ+tD61+L
         EH8Ef43v0HV6AfiAdVaOexdtAu9hH1tYKhcwo2dhRgYeRUG9dGupYyDYg6YLY0WaMJwD
         ImByrV09+svZ8V6h5sTuult1G2wd6J7trZxe/wHi1TXXfmI6+B7lrex1l1lQkRonNn1/
         ONoLDyMAa5mYRZ18T6LnqkON4GKMsaFPm0vKALX+f+7k7CyYpQc3QlPIRm85IC4D5qNQ
         dRSg==
X-Gm-Message-State: AJIora+UwLPYeb10GWIqF6Ce/fXXGnwSycTbbZphqAxt228llgUEuJfI
        sces+wtvUmSGfmw6j05m//qALznaPZ1G6D+J
X-Google-Smtp-Source: AGRyM1u71iUPG3at0BpkKCazPwBmgMYBMalIpGwgfvn4YnquFPcwW+Y5hM3ZZajjLRXJGbGxm8go3w==
X-Received: by 2002:a05:651c:2127:b0:25a:897b:1413 with SMTP id a39-20020a05651c212700b0025a897b1413mr25381590ljq.121.1657176424814;
        Wed, 06 Jul 2022 23:47:04 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id y8-20020a197508000000b0048745483f2asm515250lfe.23.2022.07.06.23.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 23:47:04 -0700 (PDT)
Message-ID: <d5845ed7-5d40-bac3-a522-a14c8876cfea@linaro.org>
Date:   Thu, 7 Jul 2022 08:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220707054044.22266-1-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707054044.22266-1-jimmy.chen@moxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2022 07:40, Jimmy Chen wrote:
> Moxa UC8210/8220 use Freescale i.MX7d CPU
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index ef524378d449..00b2df05087e 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -767,6 +767,8 @@ properties:
>                - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
>                - zii,imx7d-rmu2            # ZII RMU2 Board
>                - zii,imx7d-rpu2            # ZII RPU2 Board
> +              - moxa,uc-8210              # MOXA UC-8210 board
> +              - moxa,uc-8220              # MOXA UC-8220 board

Entries go here ordered alphabetically.

Best regards,
Krzysztof
