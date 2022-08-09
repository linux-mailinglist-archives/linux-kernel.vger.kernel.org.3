Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E6558D840
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242577AbiHILft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242827AbiHILfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:35:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609A248E2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:34:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id e15so16667008lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kY0VW7WRH6OusbkpplS07Fdtd4JYKcNiADl2/iZxNM4=;
        b=KJK0csbJ8X8iQUolwDewaQzJioe6tf+1Sc3oMKJRyphO8GNc5fAs8O9MdaLYQySOaa
         zwbXKjGxRnY5fGqIecaQHibZTxQOXUuzaI98Tv9mzYJcpPUAWa2fU+IzLuWzsI19Zs1u
         +P5+btFkh6Sy0kqfHmpN00+r2IgJL2ddRUJh6Tkb0A7/3nBIIcWbCgrPALKXIX9U0RL9
         Yg8yk8k5Zs87kPRl7UmCbOk2wsNG8S9wJQmvyHmQC1DuHCYKzQWYnt+LnU3lqTr8599m
         hOaI4yd2d+Rh2Ds4mClFiZzeT9l6I7KSVMJ3X5Hcn937rJsXvzpgabeGjlcxfC9Rzn/S
         i8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kY0VW7WRH6OusbkpplS07Fdtd4JYKcNiADl2/iZxNM4=;
        b=DcuRi8FzN9tkqtThTaWoxkAXkW6h6GJYNZ2Z7rq5mayvrBEwN+BW/sZncBcujdEgTT
         0lEyydRFMACln53FOxCufkmTIkavc8zVZv1BCc4Jh4qEeuT2eMAW2Pyvtgz/rN0hp9mB
         +v5Z2Ehp5BbuyhIcuOmJ2LQd8pfB8RW1KnkZS2OjQtZTWlwBvX257WnldhEazEbXDznT
         0+bKLW5vzlRo3pfeGRL0S/PLVdF4wyaUaehU81Jg9XO5LOkQuGx8Bg30q0TDcUW+Ce08
         aAxYT45Ndhe19i7F3md7s/+RCFxaRsCegaWVaS1HnZuJlQ7xes5V4XvCZmdRzNW+nIHD
         EL2w==
X-Gm-Message-State: ACgBeo2uOX/zXMlp1RVS9Y3B2INKUYsbLxUGSOjGZZiKAjSUsuJweq4P
        Jtd2hJDBe7bWthJEPPZBwpeKrw==
X-Google-Smtp-Source: AA6agR646I5X0CTuqa55/u440pAF2eLYRijfxQzVMpjwQVklzq7IlNiFuXKLdtPE9t5FEybrYt56ig==
X-Received: by 2002:a05:6512:6c8:b0:48a:f375:9ecc with SMTP id u8-20020a05651206c800b0048af3759eccmr7515767lff.206.1660044893124;
        Tue, 09 Aug 2022 04:34:53 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eb7c8000000b0025e42f8e771sm1670846ljo.34.2022.08.09.04.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 04:34:52 -0700 (PDT)
Message-ID: <3a9c6f63-64c7-d95d-496a-79516cce3939@linaro.org>
Date:   Tue, 9 Aug 2022 14:34:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v5 02/20] dt-bindings: memory: mediatek: Update condition
 for mt8195 smi node
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
 <20220804021553.14867-3-tinghan.shen@mediatek.com>
 <96e66425-ff2a-4640-8b96-48fa39943bf9@linaro.org>
 <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6a1977971317059fcfad685869b6ccf233edcb68.camel@mediatek.com>
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

On 09/08/2022 14:01, Tinghan Shen wrote:
> Hi Krzysztof,
> 
> On Thu, 2022-08-04 at 17:12 +0200, Krzysztof Kozlowski wrote:
>> On 04/08/2022 04:15, Tinghan Shen wrote:
>>>
>>> It's because the 'mediatek,mt8195-smi-sub-common' compatible incorrectly
>>> matches the 'else' conditions for gen2 HW without gals.
>>>
>>> Rewrite the 'else' condition to specifically identify the compatibles
>>> that utilizing gen2 HW without gals.
>>>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> Reviewed-by: AngeloGioacchino Del Regno
>>>  <angelogioacchino.delregno@collabora.com>
>>
>> Unfortunately, your patches got corrupted.
>>
>>
>> Best regards,
>> Krzysztof
> 
> Do you mean rebase to the latest linux-next?
> I'll rebase in the next version, thanks!
> 

No, I mean look at the line above. And many other lines. That's not a
proper patch file.

It's not my email client. Lore reports the same.


Best regards,
Krzysztof
