Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAE50F32F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiDZH64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiDZH6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:58:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D5E15A03
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:55:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l18so7723731ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=U1WIMsibwKAIR96y0nfN1dWqQ9y7DvH5uIdNqetGlS8=;
        b=FyZ/TA1R0QE9jseCnsTKYHivHbJbdV3nJ2NWiZVIhMzQOaldbwN8vuAtrdZD/wP6hA
         89cSdgErVumgQOt1bPWr1jgCFjfDYqE1mbAiDg6qb/D8DdimLrdY3TAGjiK+sqdO39Dx
         P1ZSzHXILr9emGF2u8Y2vYQPe2rCIgTHDlhzXsl1p4ZquHvKW9KTCFHeH1cZOqYkJhNQ
         TnfENNrCmpZu10KT0YcRGPaPzHg76g5U5T7tx7iYUfEnrgCBquNxNS+pahzCw9Jg2lgM
         ULXAjZ79f8mRQMFXU1DDuCcqcugSK+6CTQCEm+9BEMLHOCiJQQ/XzvbZH3eYZX3dsudZ
         M87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=U1WIMsibwKAIR96y0nfN1dWqQ9y7DvH5uIdNqetGlS8=;
        b=QlHS8ZIycaDWxhGTRMHc0d87KQv11KpTAeUph13skJIJC6lrPhwk/vUUoI6/ExBhG5
         BR7+fYosde286v3dbRuNAhJdVM9cvY2/YI9hTA4lKxzsVI49HhF7PDbFRCHUUNAI5uox
         J37bJLW33bctYiQfdRHZ4xtxmBcYAStiTkvdN81MIzjK6tEaQvBckFWGtPCOb1fLMD8Y
         qXbE8q0Sz2Y0gnZ/qODu/i5EQL7jh1u/cb/+gM2MJawlA8Sudo32bFVNn8HqIUTcHQlp
         Y1sa+WqrlDZ1UR3QmJRp6FOWd9wEnzEFzw901/U5EvJqmKWy4hmyrgTqSgLKl1ouH21e
         x1iw==
X-Gm-Message-State: AOAM531jAKeaHAdp8AElXbc/3NWYkFUG0FdzHnJhaMuiktKVScJmxpal
        pTx4xL5BfwfBn2HnXwwX2hVcSw==
X-Google-Smtp-Source: ABdhPJyl6PyJGE7Jjc6hic8TZ5AB9cjeYf4nSNHBpwP4vGGeYWVVrFn2tuH6oToWF4vr+xPevOz/qQ==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr20831011ejo.523.1650959737278;
        Tue, 26 Apr 2022 00:55:37 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709064f9200b006e7f229b332sm4428329eju.36.2022.04.26.00.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 00:55:36 -0700 (PDT)
Message-ID: <2ac59e59-2516-2bca-9db6-e2cfec671cef@linaro.org>
Date:   Tue, 26 Apr 2022 09:55:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] riscv: dts: fu540-c000: fix duplicated dma compatible
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bmeng.cn@gmail.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220421065401.9303-1-krzysztof.kozlowski@linaro.org>
 <f822fc7a-7c47-d8f9-8ef9-fda2c7832926@linaro.org>
In-Reply-To: <f822fc7a-7c47-d8f9-8ef9-fda2c7832926@linaro.org>
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

On 26/04/2022 09:53, Krzysztof Kozlowski wrote:
> On 21/04/2022 08:54, Krzysztof Kozlowski wrote:
>> Remove duplicated compatible to fix error:
>>
>>   u540-c000.dtsi:171.4-42: ERROR (duplicate_property_names): /soc/dma@3000000:compatible: Duplicate property name
>>
>> Fixes: 7eba954a8de8 ("riscv: dts: Add dma-channels property and modify compatible")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi everyone,
> 
> This is an error which causes compilation to fail. Such patches should
> be picked up faster than later, because it breaks various builds.
> 
> I'll take it via my tree.

Ah, it seems Palmer rebased his tree after it got accepted to next, so
patch can be dropped.


Best regards,
Krzysztof
