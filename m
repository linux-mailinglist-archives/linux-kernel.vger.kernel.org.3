Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25823515639
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381122AbiD2VBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381117AbiD2VBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:01:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C0DD39A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:58:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id be20so10355288edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WdMZLLyeFXH4DfRi+UZF/9Px71nbw4EKe4mxmAdQ3XE=;
        b=aiwWjzigxT1KNBITjxe/E7mSEtUUrDcle5KjVvOFmddNHyAD4aMRzA7TfmPHRzetfv
         BmYusvLYKzkBonGFUmPto6rulyiCkLIeiF+7inhSj6sEIaIVP66AbxBS+mX7qEEfwd6Q
         cuDpkJ4LfEiCqVPnSkd4DXo/pygJ3+SQF89PF9wyr36F4Qj9EXiQUs8oQ/YstGQgvQFq
         HKZM+i/EmcELGgB+h+S5QIsEMxLA3rKpi/XIY5TZblTbEDEE2Owa/hembdAvo8j9EAc1
         60pl4mV8l6d4DRbpkekjaalv3keKuDKXiO8HrnH6dssi67YoG46CqB/OOYVMtXEq3Ubg
         dYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WdMZLLyeFXH4DfRi+UZF/9Px71nbw4EKe4mxmAdQ3XE=;
        b=k93mtE9cNJbXTRQ0ee81iVlhKBmcImvbiaIjyaVYZKuUWvxPQC0gqs203ifIOsnD03
         SLVJWUBj0GwPp7G5BVYGPu0e8IuXeQLjue9MFGhcfkXEZ8vNtbFusxN5cZ9yqJ7nkJ/R
         ZK7oQkh43Fl+XcXgKzuTAXndprj4bzviBcxWQaEE5hRok7pfeSuN3v0daFJs90JM5AOX
         oN9BNeeQP+veIwMdu7MzucwYCeo8jZfu4Sk5ZpXrFOGt1z6GrEPUZ1N5INb1pxIZZTn1
         pyx/I3kv/ya74zUYJ6QBrrcKTLOTrCuq4V+VKfRQ3WVtKRU7yGROgRf6AkR3A7Z9skMq
         C8AA==
X-Gm-Message-State: AOAM531L/7aeUHfDrOfw288TdN6+V2R1ilVsqBkBKa6oBY4bqvQOj3rm
        QjMcPNswsxzetdbXqaRFw+Wc7w==
X-Google-Smtp-Source: ABdhPJyL87eFc+6S28m7X+Br7uTwfCfUX3HCGnFdomWPJcEwY16SQ7u+cZALCnMnkw77uXqxOmKAQw==
X-Received: by 2002:aa7:c318:0:b0:426:4aae:de6d with SMTP id l24-20020aa7c318000000b004264aaede6dmr1169671edq.208.1651265910467;
        Fri, 29 Apr 2022 13:58:30 -0700 (PDT)
Received: from [192.168.0.176] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id en22-20020a17090728d600b006f3ef214ddesm978670ejc.68.2022.04.29.13.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:58:30 -0700 (PDT)
Message-ID: <63ed8d74-4e84-4486-25ca-58885d343215@linaro.org>
Date:   Fri, 29 Apr 2022 22:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: refine power and gce
 properties
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220428012715.2619-1-jason-jh.lin@mediatek.com>
 <b7bb228f-751c-e7ad-a695-3dc40d889a72@linaro.org>
 <60338c26047f47c77fdc7d4eff6a7dee43853e1b.camel@mediatek.com>
 <9779588a-5bda-ea82-64a0-c13d48d89eff@linaro.org>
 <0a43e9787c8e4886b361268a58e755afbf81be1d.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0a43e9787c8e4886b361268a58e755afbf81be1d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 09:54, Jason-JH Lin wrote:
> Hi Krzysztof,
> 
> Thanks for the reviews.
> 
> On Fri, 2022-04-29 at 07:55 +0200, Krzysztof Kozlowski wrote:
>> On 29/04/2022 06:10, Jason-JH Lin wrote:
>>> Yes, we cannot have infinite number for this, but we can use not
>>> only
>>> one mbox channel for one mmsys.
>>>
>>> Its maximum number is equal to GCE HW thread number.
>>> The maximum number in mt8195 is 24 and mt8173 is 16.
>>>
>>> But we currently using 1.
>>> So I'm not sure if I need to set the maxItems for this?
>>
>> Yes. 24 for mt8195 and 16 for mt8173.
>>
> OK, I'll add maxItems: 24.

and 16 for mt8173....

Best regards,
Krzysztof
