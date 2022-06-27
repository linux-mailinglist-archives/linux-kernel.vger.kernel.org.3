Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61155C388
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiF0Gsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiF0Gsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:48:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B810B2F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:48:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb34so16948172ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RWjYnqvzKyDfj8b/7IK5P24LKA/09SVZpmj45NDb/k8=;
        b=NYZ/s/Tb3UkyIWJGVPhIHRe0KWMNs9rwQ4YOsUw1UvszbA5TvQMvy+KyUh1UFtUoK7
         /KOtH1L96WVtgL9WhUpN4VeybY8vsqKQ/koqr+bwHvw/HMGBuHEHDSKR5pKAYq46PmRP
         JbVNxPjBKnofexI/kw5mShTGzugVNA3efhisLiMm6gTzwsf3OG54qwgRT0li2ULmi0q/
         gVwOxsB3d25vCgr0kJKuve2crC1u0yjACp+L9VPIMAFKK1ijJ7cA2RkVa2dP1YknLbSS
         3zcVxmOE1Os+4nCKlPdfd2BNeDbqWdnfJT5B8TKtRwbOtowOuEcNZPjPY1kp7uJmyE0U
         Mdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RWjYnqvzKyDfj8b/7IK5P24LKA/09SVZpmj45NDb/k8=;
        b=MsAiCvq+Pw7LlLOP8UVasMFX0wQBalYEZz022vHocGkjLoL3yYl0TzVcotJdqhE1aQ
         LKn/qyS/UyvmAED2Nfn5A5lqt60s6/qdQMD1yj7sFr8o/G517c4dv/KwRo4WLamTlB3J
         Impzynq6FOApr2pFkgXHMgWl06MXOqtM9GhE/VpNRVvGPMu8JYK4gqn4t+LIwt/92Leh
         gOfJ43BpA7RJQy1YOme60aUB8ocLs4j+jxQiCwzQMzTDXVusOXQ66imI7Dt/Np3zKwLV
         NlC8pFUaKDx0Op0aOZEt1rgPx5TbbBHBM41u+liY7ZsmJW9+WnKqat7vPK2l6JgaCJTB
         9z5Q==
X-Gm-Message-State: AJIora/J85F6adh3xvOHGZl/AKCsfa22+pGAOAVyM7hLtL9X3URtnefO
        jnsSK8c86RsKeym4/cQLXuaEtLaJCvXTAg==
X-Google-Smtp-Source: AGRyM1vJDZS0a5cPJDbxysakksp3r4tjzZ0oY+DetVZ8VFerGJs8WYrxYY1hEVLNOUj1BrAazRNjyA==
X-Received: by 2002:a17:907:3e84:b0:6fe:8c5f:d552 with SMTP id hs4-20020a1709073e8400b006fe8c5fd552mr11407516ejc.710.1656312513224;
        Sun, 26 Jun 2022 23:48:33 -0700 (PDT)
Received: from [192.168.0.246] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h26-20020aa7c61a000000b00435cfa7c6f5sm6794624edq.46.2022.06.26.23.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 23:48:32 -0700 (PDT)
Message-ID: <9dbe7dc9-aac9-7d1b-eccf-5d4c8683065b@linaro.org>
Date:   Mon, 27 Jun 2022 08:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] riscv: dts: align gpio-key node names with dtschema
Content-Language: en-US
To:     Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220624170811.66395-1-krzysztof.kozlowski@linaro.org>
 <daf4a88e-ea33-be74-7e0a-b2ff20ea734f@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <daf4a88e-ea33-be74-7e0a-b2ff20ea734f@microchip.com>
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

On 26/06/2022 22:56, Conor.Dooley@microchip.com wrote:
> 
> 
> On 24/06/2022 18:08, Krzysztof Kozlowski wrote:
>> The node names should be generic and DT schema expects certain pattern
>> (e.g. with key/button/switch).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Are you planning to change them all & then change the pattern
> property to complain if "key" is missing?

Yes, I put the link to original patchset doing this:

> Thanks,
> Conor.
> 
>>
>> ---
>>
>> See: https://lore.kernel.org/all/20220616005224.18391-1-krzysztof.kozlowski@linaro.org/

Specifically one of the first patches:
https://lore.kernel.org/all/20220616005333.18491-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof
