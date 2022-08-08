Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AE458C32C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiHHGOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiHHGOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:14:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640DB4D
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:14:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c17so11218810lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ompPcRph5SE2OcXFEkgWpzfcSKSgmCD4nTXnvDSGRVQ=;
        b=TaGrVBJes0/24VTEqZsfwl5xn/6YdzpvB/VFk7wDHgZBZCAXJv3dPYovHNi28fUwj7
         ySl+kIzkV5PcFebmdnCKE0BuUmAGA6ODFQj5b916U0+FmlkHoPgxog8bMqAm2L63oVPP
         loitqUG9ShBRalABJifTs9mnABU4/4D2H2fZCnWYnUDYkzN5bCiVuOs+SGBQSuKxEi7T
         RorieaqgkeFpJcjYzuqzeOb1/UxxqFG1eDgYy4FeYrBKetIMpi8DgM1wq9nHk1ahbLpe
         PGJMatMmmRqjc5EEa4+wM79vPea+ty42i2VaXe+XqdUueZQE1jWynDaJ+GRrqMJhwSpa
         Zh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ompPcRph5SE2OcXFEkgWpzfcSKSgmCD4nTXnvDSGRVQ=;
        b=kmfcuPE5kbWWKzNvu8vMOvpFKdh1xV62VI1HVb8nYS1Rwp+a2G5uQHEIDx//SkpC6/
         P7bKrudPKqhsfPhA+0eXzNiQTmJFny0aUZC/ZoB5wtl0kBM6fQdHex7oyLKtVssgpJNb
         cHY8JDyidP0Q8x6eIqXhv3qVoPd7jInfgUwBa3aT+OKox4jx57COSsT/DESOLZ8crH+u
         xGcSBAuS22Oyiuc4Rr9M16Uclu04yqb1g0WSdIBeN8uiDCqe4n+KhPk1ObKC5szfIHX9
         RWtOGhgJWqa8W1GfLjryig5KqruPdZUUYFPhUwgivFcP12w4JwlV1yJMw2a3+eqRItGg
         DEEQ==
X-Gm-Message-State: ACgBeo0y0vDpt3SzwqgbwVYZRQqbz3o5gikV7fSGbCZFqhQnvqxR2wFQ
        oaaakMLeyv6Oe4eUj1+V/y4VpqyB+XKcrW7D
X-Google-Smtp-Source: AA6agR7Z/MOhjFXYhQRjYiTUo4lEsDfla2XkL+FYEksAUOVz/UdD8SVoCa6se2b2K6jZ//oPCmuuTA==
X-Received: by 2002:ac2:5c02:0:b0:48b:29ed:6e1e with SMTP id r2-20020ac25c02000000b0048b29ed6e1emr5620328lfp.560.1659939270651;
        Sun, 07 Aug 2022 23:14:30 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512324600b0048b2245519asm1310057lfr.192.2022.08.07.23.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:14:30 -0700 (PDT)
Message-ID: <a02bd793-e2a4-6a46-4ab5-9bb8c5533df1@linaro.org>
Date:   Mon, 8 Aug 2022 09:14:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 3/4] arm64: dts: meson: Add DDR PMU node
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220805071426.2598818-1-jiucheng.xu@amlogic.com>
 <20220805071426.2598818-3-jiucheng.xu@amlogic.com>
 <e963157e-5ff0-f0c1-2299-50528cf291c3@linaro.org>
 <0fac4541-0d05-1076-487b-86a7b92da71e@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0fac4541-0d05-1076-487b-86a7b92da71e@amlogic.com>
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

On 05/08/2022 11:57, Jiucheng Xu wrote:
>>> +&ddr_pmu {
>>> +	compatible = "amlogic,g12a-ddr-pmu";
>>> +};
>> Adding nodes at the end causes conflicts. They should be added in some
>> order...
> Is alphabetical order okay?

Yes.


Best regards,
Krzysztof
