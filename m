Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD957539E94
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbiFAHko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350080AbiFAHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B449980B0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 00:40:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd25so997118edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 00:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l7TEguCV3bHxH1ooF3Innn0Opm0fu14XFHYMOfbKGqU=;
        b=lgnqdVduDuNgqmyc+sIIalJPqCT67e+P3sPh/g/Xz535CuZFNx4OspsTjfhU3tFYXi
         s4vmpESR5jxBGuGczA/QRaM7OUt/39fhpjlmw8mt6r0mCkp/dYh2WbfuXqL2XuXiowOf
         hzhBv8cjrLPr9Q5VnS3ZXFBMQGXGnyFB3Cp4+worHHqacaJxLD3IJX7CsqGRyOFS+I1s
         d7FN4iEhQ6+z5ujqnTyumJIOD8pnNkYbVVBx2Au+nIL9VPCvScnOj9AXsjBBVHyaYaFI
         WjGUtLNG/SDKKZ227oEzSKiHPPGGdSh5bjKzcr0tPJJT4rD2mmkr1/V/zAhKyu/cNSql
         0lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l7TEguCV3bHxH1ooF3Innn0Opm0fu14XFHYMOfbKGqU=;
        b=T9Csu8Cu7fBM2rsWoblyOuTZaZdw35hUHMYlAjr2ufwWTBRqqz5e5hv+Enfh8T53Pw
         xyfRNJxIe6Fv3SEgM5zxU6L/RQPYJAt7fyVmCpBeVEAI+SGuc1Y4mE5KmLI0zPazyw2m
         iYcDJVXE0GQtGU/ELywCKwlX9uq6SVGgVR3a1LvQFfmjzwkE3iE3sehLfn7Xse8R2IKf
         64YhbpWVZL9eTLsoiH8PpfsR+nbAuv5fjqwL+nFRuU6kSmsWsg6h9LWhXW56LBuqC/6r
         pSt5Ay7aYDmu5f8OMfZ37NCUOw/mwEdakN0G/y9PUKNhdV4LxghfjmzoXN8w2jGbYvjQ
         adgg==
X-Gm-Message-State: AOAM533DZJyr4OjGuYWDElCx2LT8/6dZHze2bvXxPVW+dY+16IXxZ3oW
        0UjkqlWGLooObi76jCOl6P8Fjw==
X-Google-Smtp-Source: ABdhPJy5x6UmrG7WFUrsv0PFwzYgrUr0txqI5V+1UG7Z/FTx0cCH0pbCsudU1wKRuFnj6t/f8+qY7A==
X-Received: by 2002:a50:ec12:0:b0:42d:cbcf:a629 with SMTP id g18-20020a50ec12000000b0042dcbcfa629mr17700214edr.224.1654069237872;
        Wed, 01 Jun 2022 00:40:37 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709063b4900b007043b29dfd9sm373733ejf.89.2022.06.01.00.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:40:37 -0700 (PDT)
Message-ID: <c8573547-10e1-4e69-75c9-06cd40c5faf7@linaro.org>
Date:   Wed, 1 Jun 2022 09:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] [PATCH] dt-bindings: arm: add BCM6878 soc to
 binding document
Content-Language: en-US
To:     Anand Gore <anand.gore@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     florian.fainelli@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        tomer.yacoby@broadcom.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220531184645.2836581-1-anand.gore@broadcom.com>
 <20220531114639.v2.2.I383a14e417ffde9d8180ee578abbafdf09141c29@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531114639.v2.2.I383a14e417ffde9d8180ee578abbafdf09141c29@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2022 20:46, Anand Gore wrote:
> Add BCM6878 SOC device tree description to bcmbca binding document.
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> 
> ---
> 
> Changes in v2:
> - Remove extra empty lines
> - Simplify subject line

Nothing changed around subject.



Best regards,
Krzysztof
