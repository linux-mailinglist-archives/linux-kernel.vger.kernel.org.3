Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AB35ACB29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiIEGhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbiIEGhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:37:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFB618B36
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:37:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id k22so8214232ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Ir8Z6kAAaLgKpCIrzlxEoBl8v4o6tER9nDDTLM9h4WE=;
        b=s4PlrHu2wpYMFdgK0tnI0xEfHNt5I69y/rSVVx9CxWUig7AmvzCEUAnqRX0gEZd+sQ
         dqaepUZ/hMjYpzZPV14KGA9GNs4e7eSHOt3S5iSCmk3FkiZptPJJFY/bbZgjD+XmG2y1
         WDl25CK4lLXMd6u+REaWVEdpf2HDr6Uqo0vvKXlVaPh6w2dsp4wYSKkHKacFHamr5Aux
         tzpyVRMdVsKCPMQXQ0ZM1uHDLgG43D8FsOcrtI7XALidRs2vnCHK7i4G/grcCsoXeLtR
         GMYDY/Ll/oyskq0kzTII5Exc8sVER5jX0QifGOn9VamaCv2e69Wuymp3qFRqLpNw2eiC
         ITKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Ir8Z6kAAaLgKpCIrzlxEoBl8v4o6tER9nDDTLM9h4WE=;
        b=GGTuE83vb2+hIbrcdzddKpp4uhXSOPurA97d4ok1Yq+1FUmaHsbNM4EuxbM6VB+30d
         26Q90OXHgCu6Kcq0sLtxxt26xplyRlBcEkAPA9SM7n27T02LdfqiO55mLONQ9u5lcCHZ
         c+3EiZtiUzaPuWBbu+gLClQmLiV/9oWuUdjGeiH6S6aOfgvAvVwQ/aTarOYv3KynPy29
         YTbBA/KMMPKCgBLXKUdE/XtlB5Z7yk9xqNIdVkIbfB1jIEXM5RlqZMSEo4j0HcdbgA80
         Co3T+5uPRxbVJvVOa+AWrSKWVHO9wAug2Dpsuu7ngdMehh3Mji4lBksCfS4v9Culq42P
         CTnw==
X-Gm-Message-State: ACgBeo3pLxvCE8G1gi08gJd/Bwi1hIbmcZA05iC/puoe4X7p5T5LYU7f
        3lFAZ/2TCHSZodCmq0oBjsqna+ynllgftXEcGps=
X-Google-Smtp-Source: AA6agR6hcMcLOGAIpC04JGT3pJKk+nI4ByvMf31zJYpldBYrSVFGjiP+hP/aKEwqnPz5++VPhG1+JA==
X-Received: by 2002:a2e:940f:0:b0:261:b9ca:6207 with SMTP id i15-20020a2e940f000000b00261b9ca6207mr14547769ljh.192.1662359836600;
        Sun, 04 Sep 2022 23:37:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b0048a921664e8sm1094364lfr.37.2022.09.04.23.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Sep 2022 23:37:15 -0700 (PDT)
Message-ID: <0bafbdb6-7a38-57bb-1e84-30cc7a521867@linaro.org>
Date:   Mon, 5 Sep 2022 09:37:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2] dt-binding: gpio: publish binding IDs under dual
 license
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20220901163636.3930634-1-etienne.carriere@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901163636.3930634-1-etienne.carriere@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 19:36, Etienne Carriere wrote:
> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-3-Clause license terms. This change allows these GPIO generic
> bindings header file to be used in software components as bootloaders
> and OSes that are not published under GPLv2 terms.
> 
> All contributors to gpio.h file in copy.
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v1:
> - Publish under BSD-2-Clause instead of BSD-3-Clause.
> - Remove Charles Keepax from CC list.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
