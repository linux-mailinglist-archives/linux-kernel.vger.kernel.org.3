Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB634F04D2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbiDBQXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357968AbiDBQW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:22:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CC6A023
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:21:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bq8so11699796ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mnGt6W+Yxzjo9+/+HIyfnhtyS1WFSMtagQnoizbL1R0=;
        b=GJwZFGWMfHIBnC1wfxgc9r7rpLndt29L5PyMvPW1IFf+DRW2csbfA1olTD5scsM+SR
         dR20QG4DtEqIoAKSZfVB4YCPysxcGzrePbMs9EpqU5RRbYmg2hVdja0oIjKH7Q8YA18B
         Ah0LQQJJP56KZFtnNdO0nkaND7gz4n3Mrn3XDBRcfjc6LgMtUZpv/rrn7xdnr6upoqWK
         G9QU/IDTJ3hwr48aPieGhLZ5ynK6xU/mXHC7pPFzx/3dhQEriL12ADhztEptk8Aaf7iP
         0DeOfCQPgiZCPa29SoIWawVINwv3wuyypuV7fOLFHGwxOoLf4teOF0IXwcxqANHymCg8
         nkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mnGt6W+Yxzjo9+/+HIyfnhtyS1WFSMtagQnoizbL1R0=;
        b=stUSCCfm/l9HSAc3Q9Q6H/nGNRX/vgBUyR76W0KT31xs5JTKLhji/FvIcfH+IuMrja
         P31oR9iKqhFpwWmonLcHc9UN9bc1SaEkCMqnbvQWOvKpb1Svcyc0vGj2q4m30Cm5/4Kd
         xOfwisjIQJhYYcipfO5YDjWI4HRb8TEOMawou56bCNNYR8RBEpmF8Ti0lBxdsOmnxkad
         UwrDKe69DqQKoAqo6JdhmPBVYCZ3FLwfSEHg6Jzc8UwaWTs+HM4Tw+2Qjbu971heDfOG
         /5sQZ7UkcaxiNP+Xi9jcj2V/Up02P7bSJsD8CofDa2SvAr2gbMuetg+zx5VRsDNyZ1Vt
         perA==
X-Gm-Message-State: AOAM532lPAmTv03HmLG0vuRRFHrVMlokU04tpshWAj/Yxmf6qpCgxD2M
        tMO5wF6euFLY3Q7yRJXhFdXIUA==
X-Google-Smtp-Source: ABdhPJwr6iufJ5ANsNQoEWLNc+tMOFQ/Hxw54wk/gFKN6u6OnQXSWTkJJ9vsUMAaFPtBFxpnVzSNBw==
X-Received: by 2002:a17:907:9718:b0:6e0:6faa:3aa with SMTP id jg24-20020a170907971800b006e06faa03aamr4338206ejc.307.1648916464849;
        Sat, 02 Apr 2022 09:21:04 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm2709359edk.50.2022.04.02.09.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:21:04 -0700 (PDT)
Message-ID: <7d66c6ce-80d9-3a09-b34c-7ae5a7763465@linaro.org>
Date:   Sat, 2 Apr 2022 18:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v13 1/2] dt-bindings: mmc: mtk-sd: increase reg items
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, wenst@chromium.org, chunfeng.yun@mediatek.com
References: <20220330094532.21721-1-tinghan.shen@mediatek.com>
 <20220330094532.21721-2-tinghan.shen@mediatek.com>
 <aebbb5c8-1d27-5e66-e18a-e2b647bc8cb4@gmail.com>
 <53cb53b8614aa39e0785b99f46b708ad201c3dd8.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <53cb53b8614aa39e0785b99f46b708ad201c3dd8.camel@mediatek.com>
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

On 01/04/2022 04:18, Tinghan Shen wrote:
> Hi Matthias,
> 
> On Thu, 2022-03-31 at 12:54 +0200, Matthias Brugger wrote:
>>
>> On 30/03/2022 11:45, Tinghan Shen wrote:
>>> MediaTek has a new version of mmc IP since mt8183. Some IO registers
>>> are moved to top to improve hardware design and named as "host top
>>> registers".
>>>
>>> Add host top register in the reg binding description for mt8183 and
>>> successors.
>>>
>>> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>> ---
>>>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 ++++++++++++++-
>>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index 297ada03e3de..2a2e9fa8c188 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -40,7 +40,10 @@ properties:
>>>             - const: mediatek,mt8183-mmc
>>>   
>>>     reg:
>>> -    maxItems: 1
>>> +    minItems: 1
>>
>>  From my understanding adding minItems is correct, but you need to add also 
>> maxItems: 2 as there can't be more then two register entries.
>>
>> Regards,
>> Matthias
>>
> 
> After add "maxItems: 2", I get following message when doing dt_binding_check.
> from this message, it looks like that maxItems is not necessary.


That's correct, you don't need them because "items" defines it.


Best regards,
Krzysztof
