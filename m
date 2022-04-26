Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543BC50F335
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbiDZH7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbiDZH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:59:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B4419028
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:56:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so15623786edt.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QCkAWQl5OzafSw/w5XY+gBWNToUQg7Ssi/Vfa8NOYnk=;
        b=C7g6N2Ew98GR2Heo34ZeLiYmawz0IxdKRnqMbuRY6WbxbEifgefRyaijaLZwhplkHV
         hO0ZNP3zWBK7PrXskFz4OTbNO4m3LLXOpH9Nh8B1zMxolgUodylxmvGj8wF8pCpt7xl+
         VOwCabNZ0NIVoTPWd2z4Q/I454EthoH+dVZgXHlN1sil3cYuNrZcNhcXLfOCFQ+hY44B
         FnUxvQjqQVatKedu5ZxggxkItCYmhJ9Gp/t4T9Y7FAA6AYtHISo6o/r6xUCrKBMun/M5
         L3M8h7ULHG3ysIa1U7ygR02UqXpv2mXlvAjMZFzNT3bJBRUip59WZVc0T+r5Md/SI9X9
         g9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QCkAWQl5OzafSw/w5XY+gBWNToUQg7Ssi/Vfa8NOYnk=;
        b=zJHUm1rLohI/GaI2Ic6dsxpJ2+aeRwBFynVPUDX3Kjke8ZF/uFc8AK6twNj7NeySZY
         sVnCs3zWBtY/ihIYAZGgf2375xjLuRpO4q4nM4RGX4texzVQ9iz5g5bmbWXMJ+J63IYH
         TkJuW45JLFCyZ8BItmAsWO/XHgJ/ZAHryr/4dKgyazH0pTDeqczFAjiEv8Ahr80AotFi
         l3Dz6Xl8+sF+2y00T0XcMXUv7mlrbV5X+AArmp94rE3AEWqAq7DT8RZC9iCxb3cEmJwn
         BfS4eFBosbcISxyvzEhpN73RCZvN9osZo6zhfIwmANbsSMXBa5dPexFukyLPuIytvfU3
         D0zg==
X-Gm-Message-State: AOAM531Fbt2pILBfiXRRrKqRwVKozD7DnBLeMRa3LsXlzmdNKliWcjtY
        N4cHT+ix17w1v5Cyrn7XLGVq8p7Co3FPEw==
X-Google-Smtp-Source: ABdhPJyDmnBpx4hnM0HvEzf1tfmy38ZpvYc4jFzRem11dTFx48HGYzumITkBu9oT8cm7BelgqplEEw==
X-Received: by 2002:a05:6402:304a:b0:423:c3b8:cfc5 with SMTP id bs10-20020a056402304a00b00423c3b8cfc5mr23165580edb.406.1650959801194;
        Tue, 26 Apr 2022 00:56:41 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id dd6-20020a1709069b8600b006df08710d00sm4565877ejc.85.2022.04.26.00.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:56:40 -0700 (PDT)
Message-ID: <5ea0ddc9-c4b1-a2c6-059c-5e47ec076bca@linaro.org>
Date:   Tue, 26 Apr 2022 09:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH] riscv: dts: sifive: fu540-c000: align dma node
 name with dtschema
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>
References: <20220407193856.18223-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407193856.18223-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 21:38, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Fixes dtbs_check warnings like:
> 
>   dma@3000000: $nodename:0: 'dma@3000000' does not match '^dma-controller(@.*)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Hi Palmer,

I already resent this patch, pinged. Can you pick it up?

Best regards,
Krzysztof
