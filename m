Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E930523808
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiEKQE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiEKQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:04:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0719C3A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:04:08 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bv19so5011357ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wQ+4WhV6k9PLSLRu2ycXl8Jd/rTXVtAwxYwfDpJmHeQ=;
        b=FQkLZaRRby2FjgefqVXwZG5cd45AVoW5mBxIPs4/ACAjlfIUckJBfr7AgNJi1sA2PE
         ReehVHy+e71raZyAeffWYbk7GbIefoArYARSe77wZVjnD+2Lo9wxrNlVlhwG9W+YXezH
         UKayJlTm+Q5LNRo3yWmDq1Oe0fUV42F59X2waMA6k5OADRwy1mCKDOztRyTvlDazQtKy
         ipFNeMcr3uMJvngEOqbq68KVUZ8xU9bvzXIeGbWMwzpaDofS6Snx/XEqAJgtqn44AU6+
         aUfO0pbfTmbtc5tf0dsM3GASHxBAoc1kg8Og7SFY40rubqtkzTDwV9bZQnurARlWEfaf
         rcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wQ+4WhV6k9PLSLRu2ycXl8Jd/rTXVtAwxYwfDpJmHeQ=;
        b=GbDQbHAPNd5P8ZFku5IWEZCPkIkN2ujw2m1japUadDpJWbOP1KEHR7L3JbDkPDFD5S
         GDAF/4bnYgFZ17QGjuFoXgECxd2JF+2Dw0Z1GuvYsWeneZXm3Xa34PH/6fAUfD2H0fzo
         zPZqbeUzxLp8UUi2yIrPtbRiXAdYgTgn2wPEIQF73IWhKWTvjXZXo+3poTy/RjQFbVfU
         h81x5TgfiLTC8cXDe/NnwuS7Nlvy2kkwDhe5jLWvu5CX9jmU/lOIlI6W6l36qmGOXXOq
         bDhp56xL6FUW4vqkNio+4hzwsdRvlTyjMzLjqYJKcAnUKNF3AV2d1cQjNmuUb+QW8Xma
         +RRA==
X-Gm-Message-State: AOAM530iFIS9GYsQqW964fn/cwebK4EPQB/aU4SEA7ikSrIWSGbUO1ar
        zVbCPthhAhBIhiJmw7N4h1CqPA==
X-Google-Smtp-Source: ABdhPJyzXUV5jsqnDfWfN4VVucH3ddXpg1wmvj8zlxv9ouygUIznS3UcqdagiJVmiKJiJn3K6R3VJA==
X-Received: by 2002:a17:906:dc93:b0:6f4:6a27:41ed with SMTP id cs19-20020a170906dc9300b006f46a2741edmr25797324ejc.36.1652285047009;
        Wed, 11 May 2022 09:04:07 -0700 (PDT)
Received: from [192.168.0.155] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f19-20020a50ee93000000b0042617ba63b1sm1325703edr.59.2022.05.11.09.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 09:04:06 -0700 (PDT)
Message-ID: <9dd9d22c-6933-3790-35e8-8de197d05d39@linaro.org>
Date:   Wed, 11 May 2022 18:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] MIPS: Loongson64: DTS: Add Loongson-2K1000 DTS
 related smp support
Content-Language: en-US
To:     Qing Zhang <zhangqing@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangtiezhu@loongson.cn
References: <20220511083007.17700-1-zhangqing@loongson.cn>
 <20220511083007.17700-2-zhangqing@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511083007.17700-2-zhangqing@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 10:30, Qing Zhang wrote:
> Add the device tree node and connect it to the CPU nodes.

>  
> +	ipi: interrupt-controller@1fe11000 {
> +		compatible = "loongson, mmio-ipi";

No spaces in compatibles. The compatible needs bindings.


Best regards,
Krzysztof
