Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4544E3626
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbiCVBrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiCVBrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:47:01 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2129E33E91;
        Mon, 21 Mar 2022 18:45:34 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9so10790300ilu.9;
        Mon, 21 Mar 2022 18:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zr0mWxQ50In1k50aI0C4tqPbw585vCp4j+PEvB7bkb8=;
        b=WPeQWzlV2V8L+K20EVJb+LMeyLxwsBHU8JgNhDMz2/4wk7Upkb0JOcwnXg8aFR+A+7
         pEg6qPQ6Eob5oE0M4bP3muGozT/dxeB/eAusirOX1ledQNzJ1k4xcA3J7Rr2q34NGp50
         3zwU8o43mM6yToZ5771Ww/E2I9vbLrXzC0q+kNaALhWkkKf5BDkpS+KdaKMTLPnuyxfE
         ux232B2Pl8yJmWhorpLFITU1hHTa1Mwl8tXoK+gBBayyBOffGncDPSPI2LTyoqH40Aa2
         40yEdRDRbW1tmENlHoVfU5G8yXHSA6agJM+Q/lGTtm6U8/kL91jFTbVThKbRKAIeDAC+
         4rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zr0mWxQ50In1k50aI0C4tqPbw585vCp4j+PEvB7bkb8=;
        b=Ygg+AecK7bVi/1ESvb6hDwHr/FOXaFYNM1bUtfhITcwX6c01tdnVDPHkHnpKlInYBE
         c/2Ufw4W3CEjDs2So4cC9A1pVBFRfNkT3cLboTLL/GYNaHNI5Oab1IXVEi7JuzvlVB8g
         mBcp8rUJlGxEAn9CB5cObofDY5EuaJDiIUyD3qMF+ia741WIxvNeP7r0SU/gFxlXAJuz
         QUvnYt7nNyHMmLLT0Lvn8ER3Xnz6guR/cN6Re9bKbj0V6rN9PRj86GKyK+LOKhaVrUAn
         /Ndz4FJBAP55cNNoe0bdjM/tLqmzAddkJFcmdfCu80nRChDehJJk+UjgzkB9PAfS5hDg
         t5ug==
X-Gm-Message-State: AOAM530bPUXT8eHXTPdBKvA6gJSyitQlYzZ6R7UDnqOq2vnVj/uiyfWt
        D5IJZbSPDLdiKyIOpBOuBCg=
X-Google-Smtp-Source: ABdhPJyO1XKSI7rN37fLL9+RWQm3FDgEEZEuiFvyfCvwgCm0b+qN5b2DQubr3ioFDqHp4GAM0w4Pzw==
X-Received: by 2002:a92:cbc3:0:b0:2c6:78fa:41e9 with SMTP id s3-20020a92cbc3000000b002c678fa41e9mr11160986ilq.112.1647913533439;
        Mon, 21 Mar 2022 18:45:33 -0700 (PDT)
Received: from [10.4.10.38] (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id m2-20020a056e021c2200b002c837530587sm1389456ilh.60.2022.03.21.18.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:45:32 -0700 (PDT)
Message-ID: <ca6c4fe5-93c5-9ad4-0c9f-86ec3213d44e@gmail.com>
Date:   Mon, 21 Mar 2022 21:45:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] dt-bindings: clock: drop useless consumer example
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Shiyan <shc_work@mail.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
 <20220316130858.93455-2-krzysztof.kozlowski@canonical.com>
 <YjjCpQ9vwFoEmFFi@robh.at.kernel.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <YjjCpQ9vwFoEmFFi@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 14:23, Rob Herring wrote:
> On Wed, Mar 16, 2022 at 02:08:58PM +0100, Krzysztof Kozlowski wrote:
>> Consumer examples in the bindings of resource providers are trivial,
>> useless and duplication of code.  Remove the example code for consumer
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>   .../bindings/clock/bitmain,bm1880-clk.yaml           | 12 ------------
>>   .../devicetree/bindings/clock/idt,versaclock5.yaml   |  7 -------
>>   .../devicetree/bindings/clock/imx1-clock.yaml        |  9 ---------
>>   .../devicetree/bindings/clock/imx21-clock.yaml       |  9 ---------
>>   .../devicetree/bindings/clock/imx23-clock.yaml       |  9 ---------
>>   .../devicetree/bindings/clock/imx25-clock.yaml       |  8 --------
>>   .../devicetree/bindings/clock/imx27-clock.yaml       |  9 ---------
>>   .../devicetree/bindings/clock/imx28-clock.yaml       |  9 ---------
>>   .../devicetree/bindings/clock/imx31-clock.yaml       |  8 --------
>>   .../devicetree/bindings/clock/imx35-clock.yaml       |  8 --------
>>   .../devicetree/bindings/clock/imx7ulp-pcc-clock.yaml | 11 -----------
>>   .../devicetree/bindings/clock/imx7ulp-scg-clock.yaml | 11 -----------
>>   .../devicetree/bindings/clock/imx8qxp-lpcg.yaml      | 11 -----------
>>   .../devicetree/bindings/clock/imxrt1050-clock.yaml   |  8 --------
>>   .../bindings/clock/nvidia,tegra124-car.yaml          |  7 -------
>>   .../bindings/clock/nvidia,tegra20-car.yaml           |  7 -------
>>   16 files changed, 143 deletions(-)
> 
> Doesn't apply to my tree (no imxrt1050-clock.yaml), so
merge against linux-next I can submit another patch if needed.
> Acked-by: Rob Herring <robh@kernel.org>

