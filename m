Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB652876D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbiEPOsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiEPOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:48:36 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBA2EA39
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:48:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j6so29115878ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pFiYrDI2KIk/lu+aID8s/T/vZWJ+Pf0jeglf1Qmti9o=;
        b=VZeFthn0/+Mkzq95FEWhHGeRBLt9ztigE/j/mkGPyMCgjj2hS3+s0bPTWUhaUMSowz
         +Y4SA+s45rp/kkwNngSt5sE+MtI48OukedYMYYlS5THImNtpFopQ/pw7es4dNn8zT+fy
         +ElPBay/aVvcfgCjyEX3cuTM5A8Lik1hLDyzUTmOTDGUN+ir1qyXB69T9psUqx7Ahx+M
         YOUEbuLttrp3s7fVSgeT1wrO2lKZ9llsuaGi1beg4ZEfAs71W72ow4W2l5jtLHPAcBRP
         Jx7IMw+CSsHfQjd4fhsHYYjMFqQ998LB1sKM2jcO43xcVnddEWmHxTMm09WtRnUgECzy
         2d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pFiYrDI2KIk/lu+aID8s/T/vZWJ+Pf0jeglf1Qmti9o=;
        b=IKYnn9g8rH1e+SziNqMgJl9crYTOmguH/jRWrWPr6ydnuHpzD7gmlhx2CQWyMFGx+J
         Dqz3FJKR9Yo2OwsTUgLMwLjMZkSFhVNZ7SmC0zGRlFJsaMxWM86eM0/kBHgFdxw11HHp
         c4OF8d89GkfXDUoqw2dx3ruuoP3MWq9g4R9vDsa5klrUbvt0hRT4KkpcQS5WmOQT66ty
         dj32jnjDAsFWjfWhiMsi0sHboIunX9UPJbpWYN0olBXnWtb3xWHbiO3Wb9yGF0lvhAbX
         tNILjeiYF1g2SDax+evUSpPklsLqAZf7WolAMW73uuTQj0xLz1mNzl+rWsX8VJYtNLK0
         Rdew==
X-Gm-Message-State: AOAM53107ko/rPlcyReHu4CBEYNzH3IOUAIyyDV0YVHge0ID0GErbXbO
        XDeQSI251GxCyDk32CRSyif0iw==
X-Google-Smtp-Source: ABdhPJw+z3a4IS51Rh/2SPddsW0nZC5uDNxcK5FVTvU3AbHCQxPKbc9PunOYp96fOKe4UpFZaSKAnA==
X-Received: by 2002:a17:907:e90:b0:6f4:cbc8:41bc with SMTP id ho16-20020a1709070e9000b006f4cbc841bcmr16005231ejc.536.1652712512721;
        Mon, 16 May 2022 07:48:32 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id en8-20020a17090728c800b006f3ef214e0bsm3787988ejc.113.2022.05.16.07.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 07:48:32 -0700 (PDT)
Message-ID: <4b58f725-3bc6-d537-ca02-cb2a753227c0@linaro.org>
Date:   Mon, 16 May 2022 16:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20220511195452.871897-1-nfraprado@collabora.com>
 <20220511195452.871897-2-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220511195452.871897-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 21:54, Nícolas F. R. A. Prado wrote:
> Commit ca23ecfdbd44 ("remoteproc/mediatek: support L1TCM") added support
> for the l1tcm memory region on the MT8192 SCP, adding a new da_to_va
> callback that handles l1tcm while keeping the old one for
> back-compatibility with MT8183. However, since the mt8192 compatible was
> missing from the dt-binding, the accompanying dt-binding commit
> 503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
> mistakenly added this reg as if it were for mt8183. And later
> it became common to all platforms as their compatibles were added.
> 
> Fix the dt-binding so that the l1tcm reg can be present only on the
> supported platforms: mt8192 and mt8195.
> 
> Fixes: 503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v5:
> - Made l1tcm optional for mt8192/mt8195
> - Greatly simplified the constraints override in the if:then:
> - Updated commit message
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
