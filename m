Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C8458D436
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiHIHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237617AbiHIHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:07:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144A920F48
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:07:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by6so3693808ljb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 00:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5cX2FjpaCeXNTpNO7qo5KdXM1KhzEfhCk5l6TMEAkAM=;
        b=bYAmBGuiawkSqwvugOpDMMfoM40W4nOgATPmkvtnFXxvAAIgnqQf/XMLZdLEc/jrK0
         +mQ3xXbBiJbEYQLQH6nhkFceR78h99NDh3yrdzPB2N7CQmqQ/t4ZIOjmrrePXAfMyBRw
         pHNL6XS6A/3xEU7fjPxPtEZpt+quGn82A+xSyYYLUa9uMjWGB6XttyBFyUnM1YuCPUuN
         Wz/5Q4QcrZfjiz+Df4KgkJcxHojnOykH9gr7Y/JxXiwbFhSbd+/mTdUhqUCbAB1ykJki
         08L4SFRwjJ5XOkexwVX6rMae6hScdtt1hsKckpOjeG1me/ZPJu1rG1DXzhauOIs74xab
         XhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5cX2FjpaCeXNTpNO7qo5KdXM1KhzEfhCk5l6TMEAkAM=;
        b=krCi9sUfZy8GkHyvSFexvyIhwb+DOrah/K6VWiXEt+P14OypxMhqM/51kvgwpLI/7N
         6bEb75vIe4VPtVRNyzIvQR9FeWhFqmnRVaUfHkw/fgjpfLTzTyL84m00E3L/5eVv6dvE
         i0hpD56pHB1U2qVMMs/wmBJBj8xG6sTzqdMvYPOrrmEW52Zn4NPszd8MUU56piJoz0mY
         SxpsW5/4WmpNxMXzpWCN3/GZkQXfYnb1RF+m0HdnJ/WnAg5RGRrv8ujYqfjBL71Hxz1V
         QGimwgZFpj3uFuEJgQbJuObgDpdc/A93mbhUuKeMIqq7z32iuwINWfsXMg8z3TE4Q5IC
         c1Ew==
X-Gm-Message-State: ACgBeo3SbFTxjDDWMvEqxmx6XIv7JuIrKxslq8+Ov6ZdLsWRSTaAzyV8
        SreXmVLMCaLo1h6ydOAuYbWkpw==
X-Google-Smtp-Source: AA6agR4HKU2C1jFEKKweegAzGgtCrsZkPiIN9yrBZ2cotFJAkBhntVQ2emk3xc47DkyAc14F/J4yKg==
X-Received: by 2002:a2e:bc20:0:b0:25e:67c1:c6d7 with SMTP id b32-20020a2ebc20000000b0025e67c1c6d7mr7689616ljf.356.1660028824351;
        Tue, 09 Aug 2022 00:07:04 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k15-20020a0565123d8f00b0048b05882c28sm1651465lfv.271.2022.08.09.00.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 00:07:03 -0700 (PDT)
Message-ID: <7f87a846-9e00-7fec-45dc-4a1b5004971c@linaro.org>
Date:   Tue, 9 Aug 2022 10:07:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/2] arm64: dts: exynos850: Add cmu and sysmmu nodes
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808201724.27831-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808201724.27831-1-semen.protsenko@linaro.org>
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

On 08/08/2022 23:17, Sam Protsenko wrote:
> Now that all clock domains needed for SysMMUs are implemented [1]
> (pending), and the basic SysMMU v7 support is ready as well [2], let's
> add all related CMU and SysMMU nodes to Exynos850 SoC device tree.
> 
> All those SysMMU instances were tested with "emulated translation"
> driver [4] on E850-96 board: both the emulated translation and fault
> handling were verified.
> 
> This patch series depends on [1], so it must be taken into the account
> when merging it.
> 
> [1] https://lkml.org/lkml/2022/8/8/752

It should not be sent separately then, unless you are fine waiting
entire cycle for this to land.

Best regards,
Krzysztof
