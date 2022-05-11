Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86613522F11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiEKJOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiEKJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:14:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2977682D05
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:14:20 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z2so2758065ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=bHmJ4JQM0ahp4y4UqiuvyOdC9DhyYS0199lrFCEzmUw=;
        b=A+fkhlX3WrnIJwoPrBo2HZxSYfi4zPTUMo2UXnzO4F2uAiRkc6YPp+X8Iy5f8aiJOc
         1zFYgKlp3cq/2uTrX3xiUwlIOQquQGa+z6BLya8KxkdEoz7Znujtl8Daai+EGoPZZbja
         SDeRb9ZH7Ar3GBSTwKGZE7aIdi670ysp339ZyDTENJH2KFbO7VTNPd2Ssix5WRiJndNh
         XwQw51D1nlGgRJxnrSRnABUxgr21MPLCIMTMb+Jh377tSdVtIJ+mwG/b5w8EhqqrxAg0
         Z43L30PP3u8+Q6h3Qp05ZOlpxdDQ5weozC9dZIIkUNvp341vNKOQpYuvz5z3JxRpFv5f
         uOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=bHmJ4JQM0ahp4y4UqiuvyOdC9DhyYS0199lrFCEzmUw=;
        b=a5ng29XDm86IXd/zZ6fn068MR6ifMFuiyrnMwBW5gPgnwBAMxAmYMSuZbQDhhx/ifE
         fPr18f0j7OinJGaJFvcRvM8w1+9kDgaKU3q/kReUgWTTf0MyU5MOoMfuZlvOL7oa4nFV
         q7mXr/ouZY6MT86YgNdNFDpRUfndaX+dvId+127wL9tzAU7hMoxF1dF6gtrVMQUI93T4
         54ZTmDthRmO90VfLLZKpqdyVMDa2EEiWEfJ6YgixlDG0CMmg1xhnbktefiDuBtRXWQqo
         kuKevdVJbbSY4iQiSWXsmSUcjjrki/k7ROZEfq/gUHiXM0DQC78FdIaLaD0dn510ouL1
         iAxA==
X-Gm-Message-State: AOAM532jzBcmqS0vZRbDzF3JuiXNJilS3tXvCmf3IUmaalv2K9C+QO3C
        fpUv/puPXCrzFWy5ahJ4gC9CVA==
X-Google-Smtp-Source: ABdhPJxDrbjJVt79t2h9FiSlpJoNszdUyEQni7whfaHreR3sdC7CxegUPLZyiivDrf/5AS2/zp+N7g==
X-Received: by 2002:a17:907:8a21:b0:6f4:d2e5:4d17 with SMTP id sc33-20020a1709078a2100b006f4d2e54d17mr24229498ejc.196.1652260458589;
        Wed, 11 May 2022 02:14:18 -0700 (PDT)
Received: from [192.168.0.152] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id au18-20020a170907093200b006f3ef214df9sm733996ejc.95.2022.05.11.02.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 02:14:17 -0700 (PDT)
Message-ID: <5c0bc870-2514-57b6-1ff3-c393b57fc5f0@linaro.org>
Date:   Wed, 11 May 2022 11:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220506213226.257859-1-nfraprado@collabora.com>
 <20220506213226.257859-2-nfraprado@collabora.com>
 <d3e027ca-9ccf-cf91-2414-85d2b9b680f0@linaro.org>
 <20220510165016.r7nyck2abt5m4djp@notapiano>
 <66796853-efe7-f661-9637-ac6cfefc68e5@linaro.org>
In-Reply-To: <66796853-efe7-f661-9637-ac6cfefc68e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 11:12, Krzysztof Kozlowski wrote:
> On 10/05/2022 18:50, Nícolas F. R. A. Prado wrote:
>>>> Also I had to add a description to the global reg-names, since it
>>>> couldn't be neither missing nor empty.
>>>
>>> It is possible:
>>> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91
>>>
>>> Keep constraints and list of names in properties. Then in allOf:if:then
>>> raise minItems or lower maxItems, depending on the variant.
>>
>> Hi Krzysztof,
>>
>> that example only shows setting minItems to override the default value, but the
>> issue here is that it's not possible to override minItems/maxItems (after
>> they're already set, even if implicitly) with a different value in the if.
> 
> No, this example shows exactly what you need in first step - make one
> item on the list optional.
> 
> There are several other examples for the entire picture or different
> aproach:
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91

Wait, this is the same link... because it exactly matches your case.

Best regards,
Krzysztof
