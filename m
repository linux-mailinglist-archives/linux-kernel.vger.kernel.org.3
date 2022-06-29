Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910E355FE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiF2LOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiF2LN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:13:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A463E0F7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:13:56 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fw3so4213830ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 04:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UhmgpOcezzyFajwTFaNzK7CkQEDuKl2reo2f9k791Ls=;
        b=EPawy1i0Li88//He37rCi9is/lItqMERZZbwYPZER6pZyrNX1juDwsn0d9v+DtYeJB
         LtMWBTswmNJ3hGiDDFMzXS1KU6olLcQLOpUJdrsDWRCDEZz2ai44lcCgMcxwhNcqfXBD
         90ebxDEMsWs87RNeelHOwJeNgXOK9+T6kKjAQallgo/4U5JIJgCSv+aaTHjivaYSlJ21
         jtGeq6KYeRslLak4eN/lP0CRGSwmjOUDi03hv3BGQ8+jx1GtZFKYpH+mAlDZUVF5NfSy
         tO55q9QZUUxLAxySfmJCB/L3U07Z/k3fByuK0Q/DHBH9J2Y5+1os8ojHMFa9kLtBNaQs
         ykpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UhmgpOcezzyFajwTFaNzK7CkQEDuKl2reo2f9k791Ls=;
        b=qGbAzd/8UlxJ6jZxrwVOczRMh2ciYa5FU5PXEkRINbDR/2HjfiMPpcS6nLurnbescf
         fr24xyjBOjFBNnPcrLdYi+p3CLXIlDN0Q7wDoi8B9mhnVB3+wqu5xAymdqu+L/OQwlwh
         6uEp+H147BzR/HotG6P51CXIVhgo2npAXwu9n9hH84MJcN05+huNw9clFxfD+BpvvhPk
         REy5K6oANUcijkoYplaiplgzmShc45f/EZNc44MjFiw94qvq+K/5U4IuBhwFgThBqGNN
         Bzu0Wuwh68VzzFHpP9b1A67IpoYebmxYr059PmOkEKGYqUhQrTD4ixe1bue+ZOTdket9
         zMKw==
X-Gm-Message-State: AJIora8SXP1ZGLWVMCfLiu8rd19BTL1YW4IXb8tcyUZabMJLPfW2zLZ4
        oaKEwcX8fv+Ok1GSSTK4g6ot0g==
X-Google-Smtp-Source: AGRyM1unLZatMNde2GWDa2eWPWHi6q6KWw4D80BqHxdj1KohpSJH6cPJnOOKCZG5LBUtQr/6jbO1Qg==
X-Received: by 2002:a17:906:284c:b0:727:3773:1a53 with SMTP id s12-20020a170906284c00b0072737731a53mr2710286ejc.765.1656501234848;
        Wed, 29 Jun 2022 04:13:54 -0700 (PDT)
Received: from [192.168.0.184] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ov24-20020a170906fc1800b006f3ef214d9fsm7552947ejb.5.2022.06.29.04.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 04:13:54 -0700 (PDT)
Message-ID: <be1abd3a-5aa7-ec9c-5be7-e3c6bbd08979@linaro.org>
Date:   Wed, 29 Jun 2022 13:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 2/5] dt-bindings: clock: Add AST2500/AST2600 HACE reset
 definition
Content-Language: en-US
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Dhananjay Phadke <dhphadke@microsoft.com>,
        Johnny Huang <johnny_huang@aspeedtech.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-3-neal_liu@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220629094426.1930589-3-neal_liu@aspeedtech.com>
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

On 29/06/2022 11:44, Neal Liu wrote:
> Add HACE reset bit definition for AST2500/AST2600.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---
>  include/dt-bindings/clock/aspeed-clock.h  | 1 +
>  include/dt-bindings/clock/ast2600-clock.h | 1 +
>  2 files changed, 2 insertions(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
