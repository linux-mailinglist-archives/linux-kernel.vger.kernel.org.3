Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4350B552B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbiFUHO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUHOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:14:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09EE167F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:14:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cf14so8306124edb.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BU3K6SinExvEocmmVPaQvW019Wdd8765AUfADvWsjq8=;
        b=xY9S8gGdlJGQCO07Q+2Nif+7F+wUWZSqeaYzI+/xN6CmLvdv63g6mOmni/9E1yYxsH
         uI17z96Mml3ciYVyMDtRAlm37PSTXF1ZXBMWwVC/H3aNKs/PqaMNj5s+Oq+4xwRSZkAL
         hyuy0YvZNQpHxLeZeekbD9Fyam83qoBdOx+oBcmiY9pJgEO9ihqbzw6r2Cgpbrw88YP+
         UWNYbY2jtasa9G0901v8zzrDRzj4gxPBd2l4G2bx86qq9KrEjL2+dV7PtHXNeX/ZBmpI
         FaUR68G7DhK+GMBVKiSV9moScQmiMhX1rXykJOSd47zhVMR9x7OX23a0VbJse16ZIdod
         XskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BU3K6SinExvEocmmVPaQvW019Wdd8765AUfADvWsjq8=;
        b=CHZSg4Xad4oT/Wwt8FHCsFqQP/cWYPr+UHWUGNDcjCMiu/BPWsf5qXtogr7KjNkJnJ
         CpDXyRDcxAIVUYFal+E2mg897XElk6Yo07uXUrwDlwDO77vWeQCDvXL4pCEtROGh7LGU
         wRe66QCshh/y68XdLJn/ruktHBRGlu0ySCpMaJ5Bno7ViEDjNpqox8W0ujxPy1Dlb3fr
         mXGcxC2iNa7D4GFPuhN2BaW0mqZNcAf8/UBpLzy4+IVBaJXJUKQzqAW5fkawUV54THjV
         DxHy6PX9gQPAKFXrPAKbimdM6U5/LkgasOr66a8LNeVAZU3N5MTGRoAiX8wbwRkYj2g1
         7x3A==
X-Gm-Message-State: AJIora/xrj+0imMd2CtLXDi7trqMaFk2Asku04L1NEqxbbyUIXOykSSl
        81zMONo9eGL6C5r+sIANmkA5rA==
X-Google-Smtp-Source: AGRyM1tBku4dOhxRZ+tsBWaShFdZdDXQbIGVuRg++IW5L6zuGtkFMc1YBVszGNTf/5dmlH8pwRuK4w==
X-Received: by 2002:a05:6402:2554:b0:42d:ee79:559d with SMTP id l20-20020a056402255400b0042dee79559dmr33858014edb.175.1655795692479;
        Tue, 21 Jun 2022 00:14:52 -0700 (PDT)
Received: from [192.168.0.216] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q12-20020a5085cc000000b0042ab87ea713sm11952447edh.22.2022.06.21.00.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 00:14:52 -0700 (PDT)
Message-ID: <afae6179-3681-f5c6-4615-3228f16f1271@linaro.org>
Date:   Tue, 21 Jun 2022 09:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] dt-bindings: usb: mtk-xhci: Allow middle optional
 clocks to be missing
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
References: <20220617222916.2435618-1-nfraprado@collabora.com>
 <20220617222916.2435618-3-nfraprado@collabora.com>
 <8639e64d-c659-7090-2d0a-078fd96cfbd4@linaro.org>
 <bb460aa483cc888ffa36709d9e9c1f2e3be0e000.camel@mediatek.com>
 <bc5458fe-083c-d679-9fcb-95810a290da8@linaro.org>
 <af50210b95d0cd8b2e3103b3d4a9702aeeba9452.camel@mediatek.com>
 <a24c24e6-fdee-df79-fd2f-6a71540bd9b3@linaro.org>
 <20220620155057.a6qilnhm7snzhapa@notapiano>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220620155057.a6qilnhm7snzhapa@notapiano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 17:50, Nícolas F. R. A. Prado wrote:
> On Mon, Jun 20, 2022 at 10:50:57AM +0200, Krzysztof Kozlowski wrote:
>> On 20/06/2022 08:59, Chunfeng Yun wrote:
>>> On Sun, 2022-06-19 at 14:05 +0200, Krzysztof Kozlowski wrote:
>>>> On 19/06/2022 09:46, Chunfeng Yun wrote:
>>>>> On Fri, 2022-06-17 at 18:25 -0700, Krzysztof Kozlowski wrote:
>>>>>> On 17/06/2022 15:29, Nícolas F. R. A. Prado wrote:
>>>>>>> The current clock list in the binding doesn't allow for one of
>>>>>>> the
>>>>>>> optional clocks to be missing and a subsequent clock to be
>>>>>>> present.
>>>>>>> An
>>>>>>> example where this is an issue is in mt8192.dtsi, which has
>>>>>>> "sys_ck",
>>>>>>> "ref_ck", "xhci_ck" and would cause dtbs_check warnings.
>>>>>>>
>>>>>>> Change the clock list in a way that allows the middle optional
>>>>>>> clocks to
>>>>>>> be missing, while still guaranteeing a fixed order. The
>>>>>>> "ref_ck" is
>>>>>>> kept
>>>>>>> as a const even though it is optional for simplicity, since it
>>>>>>> is
>>>>>>> present in all current dts files.
>>>>>>>
>>>>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>>>> ---
>>>>>>>
>>>>>>>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml       | 9
>>>>>>> +++++++--
>>>>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/usb/mediatek,mtk-
>>>>>>> xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-
>>>>>>> xhci.yaml
>>>>>>> index 63cbc2b62d18..99a1b233ec90 100644
>>>>>>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-
>>>>>>> xhci.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-
>>>>>>> xhci.yaml
>>>>>>> @@ -80,8 +80,13 @@ properties:
>>>>>>>      items:
>>>>>>>        - const: sys_ck  # required, the following ones are
>>>>>>> optional
>>>>>>>        - const: ref_ck
>>>>>>> -      - const: mcu_ck
>>>>>>> -      - const: dma_ck
>>>>>>> +      - enum:
>>>>>>> +          - mcu_ck
>>>>>>> +          - dma_ck
>>>>>>> +          - xhci_ck
>>>>>>> +      - enum:
>>>>>>> +          - dma_ck
>>>>>>> +          - xhci_ck
>>>>>>>        - const: xhci_ck
>>>>>>
>>>>>> You allow now almost any order here, including incorrect like
>>>>>> sys,ref,xhci,xhci,xhci.
>>>>>>
>>>>>> The order of clocks has to be fixed and we cannot allow
>>>>>> flexibility.
>>>>>> Are
>>>>>> you sure that these clocks are actually optional (not wired to
>>>>>> the
>>>>>> device)?
>>>>>
>>>>> In fact, these optional clocks are fixed, due to no gates are
>>>>> provided,
>>>>> SW can't control them by CCF;
>>>>> In this case, I usually use a fixed clock, or ignore it.
>>>>
>>>> But in some versions these clocks are controllable or not?
>>> Some SoCs are controllable, some ones are not (fixed clock).
>>
>> Thanks for confirming. Then I would prefer to make these clocks required
>> (not optional) and always provide them - via common clock framework or
>> fixed-clock.
> 
> Hi Krzysztof and Chunfeng,
> 
> thank you both for the feedback.
> 
> Since the solution I proposed in this patch is not acceptable I see two options:
> 1. Split the clocks in several if blocks matched by compatibles
> 2. Make the clocks required and use fixed-clock nodes for the missing clocks in
>    the DT
> 
> My understanding is that 1 is the desirable solution if the clock is really
> missing in some hardware variants, while 2 is desirable if all hardware variants
> really receive all the clocks, only that on some variants they're fixed and not
> controlable by SW.
> 
> From what I'm reading of this discussion it seems that the latter is the case
> here and thus we should go for 2. Is this correct?

This is how I understood it as well, so correct from my side.

> 
> Also Chunfeng, do you have information on whether the same is true for the MMC
> HW block? I recently submitted some changes to that binding [1] but I followed
> approach 1 there instead. However if all the clocks are present in the HW level
> there as well it would make more sense for me to change it to follow approach 2.
> 
> Thanks,
> Nícolas
> 
> [1] https://lore.kernel.org/all/20220617230114.2438875-1-nfraprado@collabora.com


Best regards,
Krzysztof
