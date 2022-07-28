Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CEE583DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbiG1Lmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbiG1Lmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:42:51 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCDA274
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:42:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d17so2403478lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZdeLo/HEqDcBsBJZCtTsZcIieSbE3G0c5YaVE49SxhM=;
        b=D/2g/QjrEK8fnbPdip0C4HLBdUCVf1+o0vuESGDzjqER7MbdY0B/Po3zAuvNBt1e10
         WO9vbtKX1sn1Mu/grWuVAdCAk9DappVyhyBvldWRSQNsVYhYtRdhOIM0YQEwBPmKCuff
         Y7cSyaTCaGporSRlv5/Sy4MK8wgwiR8GV//hfP0+8em4n8ySU+AcxdUxUEj0ZheyLkhe
         nV5yFu32FsGqrNXaykZNMJMwAFl1ZmYVP1mVXadkm5gLrqL4OS4uskymswtd9GIMhzLP
         2FtQcW0QmnwVl8wd6enixv3vQek9QkAlT1kBOIFtDdVX35ki7EJ8FCeT19d9rWUdid4K
         ZA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZdeLo/HEqDcBsBJZCtTsZcIieSbE3G0c5YaVE49SxhM=;
        b=xkh1UY9bQgH1yhNhBuDQlMvRnzHEa+CoTF1V3RbLTDnhU3i/tm5CL2knuXwmTUwPzI
         nbDfit4X9EjG0Iqw1WGOnbTGKEiPZMT/40kmjw3BQPMeY/HiIyeGbnag7dx+AHTVnQkI
         vW/nElQ5FdyqSfQu38Qv9md0aafapP5LjCCxZ72rfJmroKBSylYlCo3JukvvqOjxUN0o
         jcyoDiQIKbsd3gHgqppxtnv2hKg4N/9pAB4h26IKzj5nm+O66pYhkmzLdYdgKNQIsJXp
         6FmLDyv1S2jDD21zAGXt+nkMdn6GWLsN78DI1fHRDExj/BSfQ3S1SvbyzdB+IvUXSjev
         vIpA==
X-Gm-Message-State: AJIora9Xk2PFMUk5SZdaVIKeU3cce3kd+OvYHpqEI6yN1tQw8GLlwnkS
        DbrRu7QHpPnDeMzWUoDL5I9d+Q==
X-Google-Smtp-Source: AGRyM1vj/7RBruIhGdOeZdiOwv0g82Q6nua4rpfJQIzPlJvLjQrz3CgmbPncXFOcdWxaf2eze6H8Lg==
X-Received: by 2002:ac2:5b1d:0:b0:48a:718b:d21d with SMTP id v29-20020ac25b1d000000b0048a718bd21dmr10235584lfn.488.1659008569059;
        Thu, 28 Jul 2022 04:42:49 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id t11-20020a056512208b00b0048a78c1fc1dsm162825lfr.111.2022.07.28.04.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 04:42:48 -0700 (PDT)
Message-ID: <a810ec42-825c-1a85-568f-b70f04b58280@linaro.org>
Date:   Thu, 28 Jul 2022 13:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: spmi: add compatible for mt8188
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sen Chu <sen.chu@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Hui Liu <hui.liu@mediatek.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220726103729.24525-1-sen.chu@mediatek.com>
 <d0d24ba1-e870-2ba0-8259-c405cb029d2f@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d0d24ba1-e870-2ba0-8259-c405cb029d2f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 13:29, AngeloGioacchino Del Regno wrote:
> Il 26/07/22 12:37, Sen Chu ha scritto:
>> Add dt-binding documentation of spmi for Mediatek MT8188 SoC platform.
>>
>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
>> index 2445c5e0b0ef..05801e0199f9 100644
>> --- a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
>> +++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
>> @@ -20,6 +20,7 @@ properties:
>>     compatible:
>>       enum:
>>         - mediatek,mt6873-spmi
>> +      - mediatek,mt8188-spmi
> 
> I think that you'll be adding a SPMI node that will have:
> 
> compatible = "mediatek,mt8188-spmi", "mediatek,mt8195-spmi";
> 
> Which means that this is actually wrong, so, please fix it by
> adding items...

I wished bindings were not coming along but with DTS so we can check if
submitter understands what he/she/they are coding...

I also wished bindings in schema were used for testing their own DTBS
without sending.

Ehh.... :(
Best regards,
Krzysztof
