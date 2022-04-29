Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95607515628
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381102AbiD2U7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbiD2U7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:59:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDE78CD91
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:55:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z99so10369269ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=odFeoUtD+7OIfOjcCxQ9wfXNR7wVZhijBGF51FWGtSw=;
        b=rE3Eu+h5/rF6eon9FdzUJ/dS8L+nePq2WYpXSQQZR5/UfOZYailhJXzjVlqNPyQVx1
         AG7UavQcFGu3QXL4YzSWmGMnK78wgk/qzwjCwBg7WXYBEUlXQ/+HGgFusFqXicLULFG3
         h442HKo878osClxO3VWeVI8jAN4Ter/I7cSb0eFdYjPUbcUfru460vxPZjCM1JoAnufl
         s0Z/HZlaf53Qs67dEapm0SPgGhLrx/rUb6DkpTtcKmWkk/nC+I6t5Aziq0+d/RdzYHtl
         vKhfZ5bH0LFFOQXRisNZ8Tgqu3szAp1qAh6Sy9BSl5Eao474yaVTjXWfCrZgvlScN2fH
         8wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=odFeoUtD+7OIfOjcCxQ9wfXNR7wVZhijBGF51FWGtSw=;
        b=t4F6M6YkYNFDBuEeFxBSeLZ0JI/dOHPruipldCGLbbPVkFXl4ViabmUR77bg+M0EvM
         CSvd4u3trg9mnrSicjfgWgbXvGNUrw4el1dYe1exrMNixUlat3mtmUEgfXpPXLp6mDV0
         o7eWekkXQRw1J2eH7KyweQ+EgPad4IX2Vi8FMJn24JeA3lUZXCwV3SSWsgRU+H3185ZB
         4iCDx5eQyHZbFFG9xxtShyZr4SrnERf4MsaHfDoq9MMsXqE1qOX3+p8LAJ2FdqkMtFNz
         zAoafixP5kFy40pmCmc6buPCF61GenIp7Ez2sa/avtTV5RxUSyN8Pq+lxEncj3BOR0Rt
         1NXw==
X-Gm-Message-State: AOAM531N54221B6WRtSKNQs89o5seVzCu6DNN2Aod3whcj9sQqObDN/f
        YMKcXOF8t8zhBxf1dGZ84ELetQ==
X-Google-Smtp-Source: ABdhPJyoJ3bmrABMI8yFtCqJfS6GezD6A0PfIiZPdI92UtPgc9/ENZq94mvA8yCzlYuZdxHhaeBKPg==
X-Received: by 2002:a05:6402:11cd:b0:425:ee49:58cb with SMTP id j13-20020a05640211cd00b00425ee4958cbmr1145388edw.157.1651265751805;
        Fri, 29 Apr 2022 13:55:51 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bo9-20020a0564020b2900b0042617ba63a5sm3310476edb.47.2022.04.29.13.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:55:51 -0700 (PDT)
Message-ID: <c962111d-09ab-36dc-6c12-5324e0f090b7@linaro.org>
Date:   Fri, 29 Apr 2022 22:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: media: s5c73m3: Fix reset-gpio
 descriptor
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429123740.147703-1-maira.canal@usp.br>
 <20220429123740.147703-3-maira.canal@usp.br>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220429123740.147703-3-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 14:37, Maíra Canal wrote:
> The reset-gpios is described as xshutdown-gpios on the required
> properties, as it is on the driver. Despite that, the device tree
> example set the property 'reset-gpios' instead of the property
> 'xshutdown-gpios'.
> 
> Therefore, this patch updates the example to match the property specified
> on the driver.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
