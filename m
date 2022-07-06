Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D307568080
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiGFHxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiGFHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:53:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1572C237D8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:53:20 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e12so24493298lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h+bbHSPueC00viurENXKckyisi5g4je6s9N60gJDofs=;
        b=Hvboouj7AP8T1aQrkHArFUkYyIp275VDLRHTMsJ29X4740TB65mRCmNc5FpwA1MbJo
         V3cyMYplxSoANxavt8NZYfn6pfb96pqY4zqMhUF6ldcsnkfEETYrYby5LCgunRjKX3M1
         bhtROR6d07Mk5oWOQj10I/q06iqLhAd3xZXHNv43eZQoFkvVwF454+VvqrULZ6iLvcA6
         TSqxF4CmaDo4Sz1vvdTcFyp9Xc4v8JQ8SiNGOQMZc0zl4jawZ6VJwzG6thFqw/bs5Lg6
         ECvei3bcDU1sKcxtQG/n2Ach/w3aAjMX2jp325ySIaOsxMI1YdeMl2/q4CVVM//cH7bV
         z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h+bbHSPueC00viurENXKckyisi5g4je6s9N60gJDofs=;
        b=GdFkvZWeEwDJ4Jlx91GaG4enVSnp6dqahNu4UKPICurPvGI/mw+hkb894hVs88xR2O
         eL5bHRWRF8iNwIwH+AATO1NcR7PvfhjEI8CeVlVZ5Lpmdr365hUV2MHUo3bTMV0mKF8n
         vKGKGXiYau0ISvrT/g4/V3A283KRGFeoPgEXhTtMKVbckTvzwi55yhakburOMVMm1eK2
         8VjRHFuaVCXxsGXx3Kju9EsPyGu+j6flZdAr3wxEOUjdiDFW0AUyHmmn4IqSCVpwKtF6
         VV/sXAE6fcpLllA7mwldaYmpa3qIsH5gYPI8N/4TFSg0cDsqR4Pp3iZWIqqjqT+0Zajk
         9TOg==
X-Gm-Message-State: AJIora/SOlFyEnY3sSvcl1m8BQ9a7IKhtiw+QJV4CUIgmXYqgub0QQ1e
        K5Ol5oXu3s73oMsdDV8Ipj8byQ==
X-Google-Smtp-Source: AGRyM1vHtPiW4+AiTbJ8OolLiKzwYkxgs1joX+hBnsqDIuIIDY/NjV4d5x0dMPnjA1eE68UC/07uyw==
X-Received: by 2002:a05:6512:a82:b0:483:6de9:4f18 with SMTP id m2-20020a0565120a8200b004836de94f18mr5052290lfu.447.1657093999283;
        Wed, 06 Jul 2022 00:53:19 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512208600b0047f79487758sm6135446lfr.133.2022.07.06.00.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 00:53:18 -0700 (PDT)
Message-ID: <e2a1e0a5-6138-089a-c803-9f1b95b08f41@linaro.org>
Date:   Wed, 6 Jul 2022 09:53:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/9] dt-bindings: arm: add BCM63138 SoC
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        f.fainelli@gmail.com, anand.gore@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        philippe.reynes@softathome.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705172613.21152-1-william.zhang@broadcom.com>
 <20220705172613.21152-2-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705172613.21152-2-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 19:26, William Zhang wrote:
> Add BCM63138 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
