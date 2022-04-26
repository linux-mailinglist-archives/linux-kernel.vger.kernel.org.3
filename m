Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F136651026D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352736AbiDZQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352731AbiDZQCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:02:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257D816A5EE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:59:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l7so37057492ejn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IE5WdDoFR9vCBN7dCO3EiE00nBi4kE/GvRYTPFuengA=;
        b=uAJmI3Pj5Ngxs35JNs0qJ/cLsAm6ZoUCdy76uRTYT9+Z1/KhgAaieAS8CSZNRJdiGC
         4icruyLaS2b3j68ffd1FQii1CRcoKYiGEsi1WkjqyCQEST0CeCVJputyIDElvsb0MIvL
         ZZUFcuTf1rogLT79mSdLkCMMwfBd1LoMFDVRvduF9/wjNBPtaI5Ef/uK4PHTPU181ZxI
         JOT9lurbEVBv68bOo/IT+AKBxBBhQEktpdyCp/8MfkCZ8yhP39IUls/sfEKYogPU00+n
         RMi3N2n0pPksskrRF0l5AL0/Z8YSuaL9P2DmZsw3MvuYRexm3WsKL3bvIu3O4KinMIqL
         vhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IE5WdDoFR9vCBN7dCO3EiE00nBi4kE/GvRYTPFuengA=;
        b=5/iwoz993pK8jaoeQHlHzrgHyqExeG8mugeNY9lhvCnLhTTFwXLgrw6EzDDcnoEcDQ
         UsKaZMfXKK12aMTqLb5VRncxM0hAVdEAVrrDylc0zJTCMRzYRY5DBUIMPWaNGaC60XFS
         0Hz0ESjwJXHZ9jTs77PginaXrFZe9MEnmKL5WadgdRGSlLnL0NQXJJepjLUuu64LqGDP
         DJIvS9E3dQLep7C2INCsg71vv2oh831qO9ks7AwObcHoc3ZLFu3yvZM4MEL21AdCHqS1
         aiZWu3ckcs68mk8NbrpP7ylWAF9OFg7xgvz8AgHfaRg4BZ+Rig2JF/iUuV+Oy2i1ey2G
         Sapw==
X-Gm-Message-State: AOAM533fI34aGnHJv8SIN53NnnYbL4w/vEXki1bvYEJv1loLVaz/0rsC
        m4m6an4gRCbcEhw7kJXZoKZFOA==
X-Google-Smtp-Source: ABdhPJyD555vYRh8BhSe3kVw/JNEcQgwHjOkSDdSDmnLNaL5jq9Crlx6eOVDsZNck52443oEXklXCw==
X-Received: by 2002:a17:906:7c5:b0:6e8:7c6f:4f49 with SMTP id m5-20020a17090607c500b006e87c6f4f49mr22050294ejc.378.1650988777608;
        Tue, 26 Apr 2022 08:59:37 -0700 (PDT)
Received: from [192.168.0.252] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q16-20020a056402519000b00425f60d7109sm1294360edd.54.2022.04.26.08.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 08:59:36 -0700 (PDT)
Message-ID: <3171818a-82c2-3f29-03e4-fd2b7d8947fc@linaro.org>
Date:   Tue, 26 Apr 2022 17:59:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220425140214.32448-1-michael@walle.cc>
 <658851ed-33fd-8e2b-7db7-ef1ca9e31c33@linaro.org>
 <83b596d0570c779c61c3c37c6f512679@walle.cc>
 <c324eec7-79b1-33da-c38e-4a480fe23126@linaro.org>
 <6fec63c911c88a375fc024f6ca0e946d@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6fec63c911c88a375fc024f6ca0e946d@walle.cc>
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

On 26/04/2022 09:28, Michael Walle wrote:
> Am 2022-04-26 08:53, schrieb Krzysztof Kozlowski:
>> On 25/04/2022 23:58, Michael Walle wrote:
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +    description:
>>>>> +      Specifies the Interrupt Polarity Control Register (INTPCR) in
>>>>> the
>>>>> +      SCFG or the External Interrupt Control Register (IRQCR) in 
>>>>> the
>>>>> ISC.
>>>>> +
>>>>> +  interrupt-map:
>>>
>>> btw.
>>>
>>> minItems: 12
>>> maxItems: 12
>>>
>>> Isn't working here, is that expected? The validator seem to get the
>>> count
>>> of the elements of one tuple wrong.
>>>
>>> I.e.
>>> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb:
>>> interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1,
>>> 0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5,
>>> 0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 
>>> 8,
>>> 4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is 
>>> too
>>> short
>>
>>
>> Works for me (in different schema)... maybe update your dtschema?
> 
> Just updated to the latest one. But I'm still getting the same errors.
> 
> $ dt-validate -V
> 2022.4
> 
> /home/mwalle/repos/b-linux-arm64/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: 
> interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 
> 0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5, 
> 0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 8, 
> 4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is too 
> short
> 	From schema: 
> /home/mwalle/repos/linux-mw/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml
> 
> How is the length of one entry calculated?

If you add maxItems to your original v2 binding example, it works. If
you replace your example with ls1088a and use maxItems:12, it works.

So maybe something is wrong in your modified patch (which we do not have
so we cannot test it)?

Best regards,
Krzysztof
