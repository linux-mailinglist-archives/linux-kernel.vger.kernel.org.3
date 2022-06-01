Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6CF53A399
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352481AbiFALHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352474AbiFALHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:07:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1FA17ABE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 04:07:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v19so1673064edd.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 04:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H0ece/IDP7RdIvy51D5F2zJdLXLmLswCl9L/sPADS14=;
        b=Gw2IkXH0AxoQW7eV/fyLtVJXgYNj3yp2/vDlyx3L992+MyWBLy201VqcAOHwG7mxge
         ELtYHKv5BrHIaEwSYaYPCtKJNRQP/JI9TmS0Tl3JuEy9QmiPVPykG3VXalmU2tEhvrGT
         loTE2guxJvC2opKPUauvpFgESwofZPRZiyAQyivxl9qkkJUIxVSzB/lruTWB9PvjzRmS
         sr6/ilJQk50sNQ7KgZzUFYFkkVdvCgDkfOHwxTBIX4dMFMCnO1OJSmzKWeUiv7wrgUT/
         ExLAs5kiWKrWoj+vETqnuFG4fMv5nqLrejtAIa9nnPSX+Yyo5mUwuB3lsT/cIt/aKIY3
         RotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H0ece/IDP7RdIvy51D5F2zJdLXLmLswCl9L/sPADS14=;
        b=dcTkDNTV8EtF/sDRv+Gj64N6vm3TNK4B4KplhB8faST62LyceFGgLllxQmNDyS9ks6
         22F4+L2LoOd1Oy3Q06ipzkuA8KAyVQ5wxDmY8KYWdXJwyGXfAPUroZkeImGJfjlmD3hJ
         ecnLUhAzO7Mu2GhZo0DGuhbLlyYCx9aLTl5+3cbq9e1aBjuPGFa/t4VqurMXGKKTSURk
         PG/K2FodhPPpCT/av5wrYwolgDHXXQczTHGaZqgsWF0jAL0JwZFbWUU30UBAl9a0dYQn
         ep0G0TOXNqK338wNQAskjxmIhHiwRLh+Sj+wF1zH4apeTf1ZFmKMrhyFy0mwHe3FEmgY
         l1Pw==
X-Gm-Message-State: AOAM530Xyom+Qa8wk+XwruJNrjj2uJPduFMBtkc0iHA5BUuyzni5RCIW
        oDwAtlzOp07KRKd92msJdsUoJA==
X-Google-Smtp-Source: ABdhPJxliq2zoQ7EY75YWWIwkNtBeKvlUu6ft5cqp9PCjRrmQSQdP2fZQajwIK1mJ3JRnyAOtaVuFw==
X-Received: by 2002:a05:6402:3906:b0:42a:ad43:6477 with SMTP id fe6-20020a056402390600b0042aad436477mr69832096edb.20.1654081652247;
        Wed, 01 Jun 2022 04:07:32 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f1-20020a056402160100b0042de839eb2csm778928edv.27.2022.06.01.04.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 04:07:31 -0700 (PDT)
Message-ID: <fdbb08a7-393b-73e4-7b63-dd668c23874d@linaro.org>
Date:   Wed, 1 Jun 2022 13:07:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mt6397: Add compatibles for MT6331
 RTC and keys
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <20220520124617.228808-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520124617.228808-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 14:46, AngeloGioacchino Del Regno wrote:
> MT6331 is a multifunction device, providing RTC, keys and more: add
> the necessary compatibles to start implementing the basics.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
