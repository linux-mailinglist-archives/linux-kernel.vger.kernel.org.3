Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC0566A09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiGELnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiGELm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:42:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF8017057
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:42:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id r9so14150893ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=IKFzC2WnGUeD5q+RVNdKS9eslmn2mdX7LBfEuxyO6s0=;
        b=shqlCX3emJgRu1Pna1MbtQuzhWuZhEs8PAA3jmb+7RwgySeFo2pGBXoPkUWUROHBBE
         FWZbGO4cg3CylTU9GMQKslQU32a7dGi3+ijWcXfay2OlHKiQLs0ykj2NaBe5N/JhzfcN
         19xo3isaGrJzv1Q6jLa3uCX3qtqId5yQXZkG1gBtCYGF9m1D6W3K+PvTsvtnG5Opat8v
         o/P62oNI8QylZ5Yj9Mg4YLSpYBwicg168DhTBaEd/0wSpdFVgRCtBlwvqtwmYWdcyAny
         cvAgYT0jpvypq33fbyiza+NiaR+g6NRINmr2/Nr/4ON2zNx8q/MXLtSKOCtFe4MVAc5m
         LPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=IKFzC2WnGUeD5q+RVNdKS9eslmn2mdX7LBfEuxyO6s0=;
        b=Ho58WCZYKLRh1AWOkiFgK6OB+YLiEu3yKgPoXEQS3He2wwZCqMTK2Gcdx/5YjfwsNB
         uhqLG5SixaBX0yutBxAu3q/72KnULteAGkHTkguKNQQxL5PXZSmmb1SGsVHoOyYG1HrX
         DAi3l6NACgOvoy9b7d0VacqG9epy95NamK9PXErMj7yJVv9a8tLC34rtiKw6+psdk8sS
         DUINdxhU/8yNOW2SFdDG9WHY/sPxQTKSv2LBoceWGWF8Nvrvv6zzYrNnrQTsZLZIEyLD
         yEw1f30cVTHuPmiTsAMOjHelZ1o97HaJJYupTYpH2O3Ia7UIBl3vIfzCbz/HYtlP6yTv
         FyeQ==
X-Gm-Message-State: AJIora/7a6upbR+m6Ex1R/NPChz+3Wcc7/twgqa7RNj3MHkwyW9kPMJ2
        aWZM+jzj3e+b1CjOSpm1vGmqaw==
X-Google-Smtp-Source: AGRyM1ux3EckAJGDpDmodjM6QA+G+YsFdxnyaku2jwEufpmBJihqJQ038PHElZsdEF7+/vgSvGrxFw==
X-Received: by 2002:a05:651c:1a12:b0:25b:f6ec:c71 with SMTP id by18-20020a05651c1a1200b0025bf6ec0c71mr16262193ljb.253.1657021375670;
        Tue, 05 Jul 2022 04:42:55 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id w8-20020a056512098800b0047255d21124sm5673760lft.83.2022.07.05.04.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 04:42:55 -0700 (PDT)
Message-ID: <3a01a031-356e-fde2-b160-0676fb542f51@linaro.org>
Date:   Tue, 5 Jul 2022 13:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 36/40] ARM: dts: aspeed: align gpio-key node names with
 dtschema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     soc@kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
 <20220616005333.18491-36-krzysztof.kozlowski@linaro.org>
 <5e0d5cca-c4a8-6651-0e67-47b5fc23c5c7@linaro.org>
In-Reply-To: <5e0d5cca-c4a8-6651-0e67-47b5fc23c5c7@linaro.org>
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

On 27/06/2022 10:49, Krzysztof Kozlowski wrote:
> On 16/06/2022 02:53, Krzysztof Kozlowski wrote:
>> The node names should be generic and DT schema expects certain pattern
>> (e.g. with key/button/switch).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 30 ++++++------
>>  .../boot/dts/aspeed-bmc-bytedance-g220a.dts   | 48 +++++++++----------
>>  arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |  8 ++--
>>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 12 ++---
>>  .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   | 22 ++++-----
>>  arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts   | 23 ++++-----
>>  arch/arm/boot/dts/aspeed-bmc-opp-mowgli.dts   | 20 ++++----
>>  arch/arm/boot/dts/aspeed-bmc-opp-nicole.dts   |  2 +-
>>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  2 +-
>>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  2 +-
>>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts    | 30 ++++++------
>>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   | 12 ++---
>>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts   |  4 +-
>>  .../boot/dts/aspeed-bmc-opp-witherspoon.dts   | 16 +++----
>>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  4 +-
>>  15 files changed, 118 insertions(+), 117 deletions(-)
>>
> 
> Joel,
> 
> Any comments on the Aspeed patches? Do you intend to take them or shall
> I handle them with the rest?

These are still not in next and still not response here, so I'll pick
them up.

Best regards,
Krzysztof
