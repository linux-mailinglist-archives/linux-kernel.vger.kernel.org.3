Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70FF537154
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 16:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiE2OXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 10:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiE2OXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 10:23:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E85A0B7
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:23:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id gi33so16573281ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UJb4UDxzCMKxbf1CmD5HDQoIHrHBHy8/Ie4zmOsAWXA=;
        b=FT84ta8Yc+hWvvT79Z/EotgnhlCoMR/OVwCUPIcEFFM9M4v1BVvGqveMxavRNr5CmD
         /6Zt4vFAjSX9EqtxuLO9e3G1siSkcdvv0zot9hpX1hZA6Dzia+4OTFEP73ZZb0gR3xcg
         2dzF/atPOO9BE18dUZ2nhoQfJ555/XxBWRQhdjYf44S60Cn94N67QQ2d4MPTFeL8hta1
         gGJlEqXS525lItHW2cEshkDPK59W624fuOQi/w95SBBtEfxmg/bFtL72TDdF7Bzs9ac4
         +bA2xtkFxrw4UPjRvWnPJ9No/zNPHLyhcbO8Q1R5jOgzK/CPFyc1vrZeOYVuFZT4j95b
         NuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UJb4UDxzCMKxbf1CmD5HDQoIHrHBHy8/Ie4zmOsAWXA=;
        b=kcnZ/ogT1UfoX/vW6/q9KyQveBmqNkwECO2ZRk68H7Sd6x6bId19I0w/lcE+SdP1dV
         IoiT0zbgJTep55zgzGD++1ztduBVRMHT5EKjpp3Pr6obmO3EDPhaQFopGMO9XaNN08KL
         lfgoymE6yTlTXa6TgW1UIWmQ44XzIF3JZB/sigVi5XV+4/dp0AFplXsEEeiRZjr787W9
         SSrGuVQcaj58d8WFgsLE/nCZmedJB/EWr9i5UBTy/mE7Eow+8t1nTaISdwYmFKScgYSc
         h6/ZDCXZQK+swOC34SyL5M1gSq+pPcAK6c8zrTaJ1jTPF0COO3S0FMzgALjAvzUSgAlF
         QglQ==
X-Gm-Message-State: AOAM530sUb2+hBfz4/xJRtE9FskFEQhrFrkRlCJ22LnQ+9r/icBpPrDA
        UlL6Ws5VlvYnnxGnWtIBph0MqF6eNBMvXpYi
X-Google-Smtp-Source: ABdhPJw+XHJUIyCFpb2k4yaW9AsZyRMrdw/FOfP9vthEhZF1TwTLqKEs+OUv+NI5FuJxjhuKSVnhnQ==
X-Received: by 2002:a17:907:6e11:b0:6fe:feaa:bb04 with SMTP id sd17-20020a1709076e1100b006fefeaabb04mr26911341ejc.187.1653834194008;
        Sun, 29 May 2022 07:23:14 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090657ca00b006f52dbc192bsm3201856ejr.37.2022.05.29.07.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 07:23:13 -0700 (PDT)
Message-ID: <66d655bc-f08c-c6ea-8fc6-260f215a8b4c@linaro.org>
Date:   Sun, 29 May 2022 16:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add PinePhone Pro
 bindings
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <x@xff.cz>, Martijn Braam <martijn@brixit.nl>
References: <20220529031705.278631-1-tom@tom-fitzhenry.me.uk>
 <20220529031705.278631-2-tom@tom-fitzhenry.me.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220529031705.278631-2-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2022 05:17, Tom Fitzhenry wrote:
> Document board compatible names for Pine64 PinePhonePro.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
