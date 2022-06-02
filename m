Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF553B79C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiFBLKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiFBLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:09:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715A3AA72
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 04:09:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 25so5533489edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Uu7mpGh4jmD9NBJ1QMAG8IkLPN1ogSZKHJ+KYPHKm4=;
        b=Ud8gp2mWmdkKxDbbtJCpKZvK4z74qA5sMWMxI6jbnWTmPAamDMAMdJ+WOiTrSQuViJ
         9fTdm84o3zgeXCmvoNNVQH2o5i7j043Um5WxNH4i7aqXjSkdGB7xanfd26qVvtHz6qxT
         1184Ws5+UybPD33JyJew+aU96LHAxxkhZgyXwtM/LcCo5spJkLiBuPWJwjdC1TJ/drhj
         57PuGMQ1vfKlPvOdPiv1wNoVr9d6jPQYGnDpXI3zjjdgnoshBwPe6opRYOQlnG5GnLfv
         VF1RzgrJ6HjW4MEjrt6nmTs1DoGznKFHq7SqDue5BpVI715Ih/FBx+7K1MRzrZbyBqfQ
         fHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Uu7mpGh4jmD9NBJ1QMAG8IkLPN1ogSZKHJ+KYPHKm4=;
        b=1K1lEoV5fsfgYWAhnTVg+zrT3gYKzXrie/CKLl8APjXim1qX1DnLDtQ3CG2zj4IsoP
         9wHz/LKkzsH5gRxw9itE7JSGCyosGPmTc2o5YNbeHt2a6Emouoqc3zxZQfR2f/JiTA0O
         Rqg0dAWXjmbWG8v6PPfJOxURrdMAR3emOXo+aebFDR0wSnlU8fpA5ka6w/Un5Vp2c8Su
         FEMVY/RsdpiIkSGNh1cqN6vMfAEIjMXM8KMCj1/DZIeyRpU9ZgNDpRYafI3hoaAAC5q/
         SZI0rlModTLXw4yT0TNFDUcg/dDx391eulpJ6RNHepFRbrcmV6qrBAKjJMM1HEkJhRD/
         VpTQ==
X-Gm-Message-State: AOAM532LoJkoX00ku+wOBMtCiEv9r1/SLRzrIFh+fn9mcJ/BN5X9Jy+N
        f3kuK1+cLZv9NQaQMWySikE9xw==
X-Google-Smtp-Source: ABdhPJx2WktBi2SCnVLcXrgLBL1qmAN57dUdvcuNXys1R/3FFR1DY00WNEq+2vytkGdYSm3RK08ykQ==
X-Received: by 2002:a05:6402:14c1:b0:42d:d6f1:ac3d with SMTP id f1-20020a05640214c100b0042dd6f1ac3dmr4662958edx.223.1654168195507;
        Thu, 02 Jun 2022 04:09:55 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n24-20020a1709062bd800b006fee28d459csm1652894ejg.224.2022.06.02.04.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 04:09:55 -0700 (PDT)
Message-ID: <f7d62376-49b7-8929-7027-9c81703a5f7b@linaro.org>
Date:   Thu, 2 Jun 2022 13:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Update bindings for K3
 AM62x SoCs
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20220427072703.4898-1-kishon@ti.com>
 <20220427072703.4898-2-kishon@ti.com>
 <53212a3b-d02c-ab5e-6b5c-e19d359c7c2b@linaro.org>
 <dcce6737-5881-a703-67f0-59c5f55f1cd1@ti.com>
 <81d94ea8-9d0f-785b-07aa-fe9c9093ad73@linaro.org>
 <68381314-136b-776d-070a-e825506f2132@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <68381314-136b-776d-070a-e825506f2132@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2022 12:03, Kishon Vijay Abraham I wrote:
> Hi Krzysztof,
> 
> On 16/05/22 20:48, Krzysztof Kozlowski wrote:
>> On 16/05/2022 14:33, Kishon Vijay Abraham I wrote:
>>> Hi Krzysztof,
>>>
>>> On 28/04/22 11:48, Krzysztof Kozlowski wrote:
>>>> On 27/04/2022 09:27, Kishon Vijay Abraham I wrote:
>>>>> Update the PRUSS bindings for the PRUSSM instance present in
>>>>> AM625 SoC.
>>>>>
>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> index 64461d432004..cf13e5179657 100644
>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>>>>> @@ -69,6 +69,7 @@ properties:
>>>>>        - ti,am654-icssg   # for K3 AM65x SoC family
>>>>>        - ti,j721e-icssg   # for K3 J721E SoC family
>>>>>        - ti,am642-icssg   # for K3 AM64x SoC family
>>>>> +      - ti,am625-pruss   # for K3 AM62x SoC family
>>>>>  
>>>>
>>>> Looks like out of order (although for some reason before it was also
>>>> misordered...).
>>>
>>> These are really in the chronological order of the introduction of SoCs.
>>> Isn't that okay to have?
>>
>> You mean order of release on the market of order of adding files here?
>> The first is ok, the latter would mean there is no order at all.
> 
> I meant order of release to market. Anyways, I'll send a patch to change
> the order to alphabetic order.

It's okay to keep it then in such release-market order. Up to you:


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
