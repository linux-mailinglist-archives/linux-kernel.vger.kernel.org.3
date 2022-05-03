Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC951835F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiECLlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiECLlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:41:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E301D35254
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:37:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gh6so32957394ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QVp3RkrsZjknN37lAxJZhaR2zOHWGKJGvjIrozmrcSE=;
        b=tLQIXAep+KkODb2kR+H3gzQ6jOvCX3R6P+mOUJCrE1CJ6CpXrCtUbTQ0KpW4ygvB20
         W9go6Cj1n8KEishC2RUv6sjlqCg6Orly2xx3FECOPACCBFqVdsNaud4d71tdKyw7J9B+
         EAa79rJ4Sntra6vgOkRMew7unZedgmc3lm18k871vDFf8Pl5T4pRmCwTfj/DuRBtPa5f
         AP9l4RG7FcTQ29MDY0mMFQlzlkCIOt3XG2avd10re0f5jn+jY0aDETvIM6hdYZhW9bUy
         iHg4ZntHsvderHpMV5R97DTwIj6wIVWwZd6vgelRAFH27QW+GW0pqgmdV036LoBDvA0r
         SYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QVp3RkrsZjknN37lAxJZhaR2zOHWGKJGvjIrozmrcSE=;
        b=6xzBkl+TD/j+dqIwDfBMpU44mQrSajIvIE3l+MyGzce2U91v968/pt4vsipNrG4TuX
         dH3FuRoiLcVMl3Kca/0DQ1fl5JGX9bGTHNmreynMhLZ/lJHQaZkpUghzesorOcMtXQys
         eI2MqBNs9nx0e6tadisni11FkWgqlL5adNQ1n1gGNcE8Jj3/FTaQ5Ybl7yZnGpEsH80H
         eFvJs0EbuYi8y8V1p5HqBIpy0I+WWCrpSAdVyElaCUqmPSO033pXrRe5M024kPv89z1i
         J/a9/6GGY19n1BzQZrbdKhkpiarMuSBG8YHdBGlLqR+R/XdyyP/Ue5QJzpo7HonX6sws
         Jfhw==
X-Gm-Message-State: AOAM531zDSrT4wXlFeQ3VaKn+bgTRrld40rAQ7c1126jiu2ar5loCgPX
        MHzr0sw2Xa/WLL29eNGFcjqVUg==
X-Google-Smtp-Source: ABdhPJzxvzxgUY0kSWz6s201m+ymj+wkPW3O8HI9frx8YpxBCkivKl1bsuIkyh+cfHW9VMvSQH2zmw==
X-Received: by 2002:a17:906:c1d6:b0:6d6:e0a3:bbc7 with SMTP id bw22-20020a170906c1d600b006d6e0a3bbc7mr15490136ejb.484.1651577864342;
        Tue, 03 May 2022 04:37:44 -0700 (PDT)
Received: from [192.168.0.202] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zd7-20020a17090698c700b006f3ef214dfesm4569152ejb.100.2022.05.03.04.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 04:37:43 -0700 (PDT)
Message-ID: <f42cb4d0-7133-eea5-b456-b5169bebfad1@linaro.org>
Date:   Tue, 3 May 2022 13:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC v2 1/2] clk: hisilicon: add CRG driver Hi3521a SoC
Content-Language: en-US
To:     "Marty E. Plummer" <hanetzer@startmail.com>, arnd@arndb.de,
        cai.huoqing@linux.dev, christian.koenig@amd.com,
        devicetree@vger.kernel.org, gengdongjiu@huawei.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@armlinux.org.uk, michael@walle.cc, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, novikov@ispras.ru, olof@lixom.net,
        p.yadav@ti.com, rdunlap@infradead.org, richard@nod.at,
        robh+dt@kernel.org, sboyd@kernel.org, soc@kernel.org,
        sumit.semwal@linaro.org, tudor.ambarus@microchip.com,
        vigneshr@ti.com, xuwei5@hisilicon.com
References: <20220501054440.2434247-1-hanetzer@startmail.com>
 <20220501173423.2473093-1-hanetzer@startmail.com>
 <20220501173423.2473093-2-hanetzer@startmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501173423.2473093-2-hanetzer@startmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2022 19:34, Marty E. Plummer wrote:
> Add CRG driver for Hi3521A SoC. CRG (Clock and Reset Generator) module
> generates clock and reset signals used by other module blocks on SoC.
> 
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> ---
>  drivers/clk/hisilicon/Kconfig             |   8 ++
>  drivers/clk/hisilicon/Makefile            |   1 +
>  drivers/clk/hisilicon/crg-hi3521a.c       | 141 ++++++++++++++++++++++
>  include/dt-bindings/clock/hi3521a-clock.h |  34 ++++++

Bindings go to separate patch. Your patchset is unmerge'able.

Best regards,
Krzysztof
