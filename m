Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330E755062F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiFRRA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbiFRRA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:00:27 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763EA12D03
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 10:00:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gl15so13954018ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qo+XVZATD7QvafJGYNsBnvzlaXlfHOgJMqIMb8gJ68I=;
        b=X2qWk44P4TSsmjCHzHruBJB3JXlcqcj+1A7VBhLQLmyWGJEYrzo6zSx/p3/xEsVQWG
         WbBKM9iHasQQrHEC+N5Se9AK72b0KMQDF/nOORGPr2GLq5F05iG3j9EMbPzqBXYjYFIN
         ttG17/+j2bTOL8G6Fpo7AyPSHFkD9X5jK+pt0ybo3an5HBbIf1mZV7VPZclOJHhfdH4g
         sS7YyhFiIcjCoiiaQo+gxkq1r5pX3p7v3P3rEMInsSrPtg+ghu1BOTlEud3m9VQle5FY
         kJI9znu9F4cO2R3YMEzgRBOuNP0U0a791jySrdInn6/olG5aXhhyDcJUC4gJ6a6n2CKi
         Pt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qo+XVZATD7QvafJGYNsBnvzlaXlfHOgJMqIMb8gJ68I=;
        b=w5EoIfN89IbVqbPXTS/hta4CfuORnugnyw9gBd3O6kQ2Cef6rPU8hDjdpqqdRKZWBq
         /oW+QEM2f1Cggdt2OdsVBdbJsSH8vVZXBs/68nFhTnYJ1oxR1JXmLlhHrxRESXY9JYGk
         4tE3qJospdt6hfSEk4qBYBFw3vUNPoE6TSGrGyR9xGjk17keUM5j+aMZqP1vl2nBkmF6
         NIDgwHUXYKVe7FbApx8I9p4wk6gb+mDSkILNJ5ApgHm3VVGV+Hpc3e0njHuDvl6qfyrF
         LuCmUP4vpaMCh7bzfpQk3Qw2/IC8nWWpeIU77w7RIkAF/AOzGA2NI4CnZxLdkHwnskPC
         XzNA==
X-Gm-Message-State: AJIora/Lst48HvxHHp3GW1MZNHxnT//+dBZjNr9oy/ourVRAIXJHTFaM
        0D2qGGhUKtqTBoE1hNRkyxtOPQ==
X-Google-Smtp-Source: AGRyM1u4CVew7K3LxjmXZseIbBAUDExxTq6WbzYmeYgVp/qnZPQHgFK1WAIuvASEueoknrZsutAr/Q==
X-Received: by 2002:a17:906:649b:b0:712:24cd:6102 with SMTP id e27-20020a170906649b00b0071224cd6102mr14417111ejm.664.1655571621875;
        Sat, 18 Jun 2022 10:00:21 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906825700b0070ad296e4b0sm3559455ejx.186.2022.06.18.10.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 10:00:21 -0700 (PDT)
Message-ID: <279cf4ef-8b41-5e92-73c3-416730038c56@linaro.org>
Date:   Sat, 18 Jun 2022 19:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1655458375-30478-1-git-send-email-u0084500@gmail.com>
 <1655458375-30478-2-git-send-email-u0084500@gmail.com>
 <7a9d3354-164b-e5e5-936b-95de4c4338f9@linaro.org>
 <CADiBU3_wyFLpoy3PU0a-EbGAKoQ9LZMprH5DWnzwo05-Gwa2=Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3_wyFLpoy3PU0a-EbGAKoQ9LZMprH5DWnzwo05-Gwa2=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2022 08:50, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年6月18日 週六 上午9:45寫道：
>>
>> On 17/06/2022 02:32, cy_huang wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> Add the documentation for Richtek RTQ6056.
>>>
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>>  .../bindings/iio/adc/richtek,rtq6056-adc.yaml      | 57 ++++++++++++++++++++++
>>>  1 file changed, 57 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
>>> new file mode 100644
>>> index 00000000..6b4e0e0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056-adc.yaml
>>> @@ -0,0 +1,57 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056-adc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
>>> +
>>> +maintainers:
>>> +  - ChiYuan Huang <cy_huang@richtek.com>
>>> +
>>> +description: |
>>> +  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
>>> +  interface, and the device provides full information for system by reading
>>> +  out the loading current and power.
>>> +
>>> +  The device monitors both of the drops across sense resistor and the BUS
>>> +  voltage, converts into the current in amperes, and power in watts through
>>> +  internal analog-to-digital converter ADC. The programmable calibration,
>>> +  adjustable conversion time, and averaging function are also built in for
>>> +  more design flexibility.
>>> +
>>> +  Datasheet is available at
>>> +  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: richtek,rtq6056
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#io-channel-cells":
>>> +    const: 1
>>> +
>>> +  richtek,shunt-resistor-uohm:
>>
>> Use standard properties, so "-micro-ohms". Drop the unit from
>> description and drop the ref.
>>
> Use richtek.shunt-resistor-micro-ohms?

Yes.

> Or the prefix 'richtek,' can be removed?

No, the vendor prefix must stay.

Best regards,
Krzysztof
