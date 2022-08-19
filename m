Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E1599C75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbiHSMpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349064AbiHSMpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:45:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C633E3C2E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:45:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s1so3183531lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=qqffeJ1cELkTvZi2yVxU+KEC+V9oMcB95umfP5C+/ms=;
        b=C0gCvt6FGl2dkLGc++ML4O+KSqvWSCQnKOwA9F5j3zwkJOsDpb2jOMd2PfEsq/TyRW
         lNxrVzNySX24r+5Vs1PXCzbOltRSDmMaCPqRv8vpqFqkDjqex2EgqF4zv5XAuO95nBDy
         WiJcuwyKZCyjxBwDw3q8F6HTLNIPapWU63m6yXKuohaY0aD3oWRQ2svfuhijls0dSy+7
         pZZ4t6quHgFo45JY9FIics9N+MpO670rTh/pTjPAjOP3SOAb7RYBZO4CglNALOVrhPJk
         oQt5uxxhVE1lBLUu6tiD2WvUCkfWsqZm3zMjGOXm468VqMMUMvnFsvfKJi4ck5ZLHoK/
         tkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=qqffeJ1cELkTvZi2yVxU+KEC+V9oMcB95umfP5C+/ms=;
        b=3Bi2qmU6Fs4g9eZlulG/n4HjuPoHSK1TrUJ8HN2Enr0Hxuty/Qt/zNMdPXNhi0XhXk
         gZoFEqYDQUBtC67ZsWCA1KJXEJ2Vtan1jJuVqjusCZW1ixd35t+T1cX58Ly7xBwO5YhJ
         p9tb0QaA4HUnPPW2dmvKvyDd9epKLXmqUVvj7QkYC0cWn9Vqquke4zFuzRkHc4jD8JLB
         mGhNdVHkDY99NN9da84e8c8QyzknYGL+0eZ9ZPLSVERG9zfOTbhOCkFIDq4UBvgTnYdH
         RmACGP/OzNN0tzGT5wIOZiEjzSUgIZSiDjdcf+EkAOgNpIrgocbO/6FsJHlAvd82xHV9
         EA7w==
X-Gm-Message-State: ACgBeo3gYYFHNkobxDt1+qLj80a9pLlFw+lfj3WU6zZ3dka2yQq9XzG4
        Q81OKWa+2v8BoAGXIhgHrEA1RQ==
X-Google-Smtp-Source: AA6agR7/PRkYQLtYE0l0kOSX2qoSLm7uckRWBd/nF3eYbhF9x+nTNIyBDipk1CoYBEgaYkztlr74kw==
X-Received: by 2002:a05:6512:282c:b0:492:b415:6def with SMTP id cf44-20020a056512282c00b00492b4156defmr2503429lfb.615.1660913111394;
        Fri, 19 Aug 2022 05:45:11 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id t5-20020a195f05000000b00491734dcb89sm624998lfb.196.2022.08.19.05.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 05:45:10 -0700 (PDT)
Message-ID: <0976b1c1-a8e0-5a61-51ff-9b47f29569a5@linaro.org>
Date:   Fri, 19 Aug 2022 15:45:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/6] dt-bindings: clk: document PolarFire SoC fabric
 clocks
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Daire McNamara <daire.mcnamara@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-3-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220819122259.183600-3-conor.dooley@microchip.com>
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

On 19/08/2022 15:22, Conor Dooley wrote:
> On PolarFire SoC there are 4 PLL/DLL blocks, located in each of the
> ordinal corners of the chip, which our documentation refers to as
> "Clock Conditioning Circuitry". PolarFire SoC is an FPGA, these are
> highly configurable & many of the input clocks are optional.
> 

Thank you for your patch. There is something to discuss/improve.

> +  '#clock-cells':
> +    const: 1
> +    description: |
> +      The clock consumer should specify the desired clock by having the clock
> +      ID in its "clocks" phandle cell.
> +      See include/dt-bindings/clock/microchip,mpfs-clock.h for the full list of
> +      PolarFire clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ccc_nw: cccnwclk@38100000 {

Node names should be generic: clock-controller

https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof
