Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F15A5A936F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiIAJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiIAJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:42:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8890D1385A7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:42:19 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x10so17265407ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=cyGoLGFYlRzNkjYzyQzXdAYg9tduOqgaIixq4gRNrZI=;
        b=TJM+qgmP78WPN0RndE/VLYhAoBjYJOv6Rag8VK3jR+6uYbzVVFP7H4fE8lYtddG60v
         +FuxG9+2oHabfVV2pV0BUo4GYP1hjrkAHTazM9MblE1gyYGCP3WbXNxkucKTjecG5Xh/
         t8ppcXv6JkrVF8PdMAw6yp8BfQW9+eyYqh/SyuoVqGNNmvXDyEDdAXmceliP3aOs0Bbj
         Xom2MXL96es2KYOZLpX590vsc1P2VsZyuO1WYTu8YRIeqyaargB4vTtwu3rk0u9fQpub
         f484fVUj4Hj3x5AMjyEp89YJpKWY5H9Kxt5y+tOU4G9zgjdrlnUVOQ+ZsEFtN0enJL4x
         83ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=cyGoLGFYlRzNkjYzyQzXdAYg9tduOqgaIixq4gRNrZI=;
        b=LiWthHdP+gwSYDzxT4OkZ4Ww0AFjJmVjrd42QmqIupF0Mnl7sRT8bK0MO2pfjoV1HS
         Xy36xc4Tp9XAbeZc2iAWfyZX+jixm86OmUP2ubktfa4zk9519EP50MZIz3xlnGQej9iF
         5+1kDFRI0LdrT3fJncaZuIFhn/151rDJb4htmQg4141qJLQRtwrePwCVy8a1t6XclGaV
         ECGjzijiCJa5CO7dP722X5mV4oTqTJQqhiZ5tc9IZifOfL+ioVzTuzvocIH+jBxEUT2C
         8MsYZqTmDJcbxn0BC27XdmdEtSJVQGYP82nBhDfzfD7FoWNe/PZePeeSQpG4SyE5D5Km
         xwJA==
X-Gm-Message-State: ACgBeo0aD6Qc2X1DOmXYCRWNszGwt5tcWuQWI/mNZqj/JxxiorUcv09+
        sHRcVdklJOTerc9VB2/U/+Z+gQ==
X-Google-Smtp-Source: AA6agR41jeZpevY4b5EMQDTYDrqO8wPCUCqUani6cv6z6SYnfuyTde+XLqs0U9nLZQgJVkuXdjSAVA==
X-Received: by 2002:a2e:3317:0:b0:264:6516:93ce with SMTP id d23-20020a2e3317000000b00264651693cemr5716037ljc.212.1662025337680;
        Thu, 01 Sep 2022 02:42:17 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512221200b00492f294f06bsm993545lfu.110.2022.09.01.02.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:42:16 -0700 (PDT)
Message-ID: <38910de5-89ad-e7a1-261f-18b51c8e7877@linaro.org>
Date:   Thu, 1 Sep 2022 12:42:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
 <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
 <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1fae0c47-fff9-89e9-c849-536d167d741d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 11:04, AngeloGioacchino Del Regno wrote:
> Il 31/08/22 15:19, Krzysztof Kozlowski ha scritto:
>> On 31/08/2022 15:48, Johnson Wang wrote:
>>> Add the new binding documentation for MediaTek frequency hopping
>>> and spread spectrum clocking control.
>>>
>>> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
>>> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
>>> ---
>>>   .../bindings/arm/mediatek/mediatek,fhctl.yaml | 49 +++++++++++++++++++
>>>   1 file changed, 49 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>>> new file mode 100644
>>> index 000000000000..c5d76410538b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek frequency hopping and spread spectrum clocking control
>>> +
>>> +maintainers:
>>> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
>>> +
>>> +description: |
>>> +  Frequency hopping control (FHCTL) is a piece of hardware that control
>>> +  some PLLs to adopt "hopping" mechanism to adjust their frequency.
>>> +  Spread spectrum clocking (SSC) is another function provided by this hardware.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,fhctl
>>
>> You need SoC/device specific compatibles. Preferably only SoC specific,
>> without generic fallback, unless you can guarantee (while representing
>> MediaTek), that generic fallback will cover all of their SoCs?
>>
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  mediatek,hopping-ssc-percents:
>>> +    description: |
>>> +      Determine the enablement of frequency hopping feature and the percentage
>>> +      of spread spectrum clocking for PLLs.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>>> +    items:
>>> +      items:
>>> +        - description: PLL id that is expected to enable frequency hopping.
>>
>> So the clocks are indices from some specific, yet unnamed
>> clock-controller? This feels hacky. You should rather take here clock
>> phandles (1) or integrate it into specific clock controller (2). The
>> reason is that either your device does something on top of existing
>> clocks (option 1, thus it takes clock as inputs) or it modifies existing
>> clocks (option 2, thus it is integral part of clock-controller).
>>
> 
> FHCTL is a MCU that handles (some, or all, depending on what's supported on the
> SoC and what's needed by the board) PLL frequency setting, doing it in steps and
> avoiding overshooting and other issues.
> 
> We had a pretty big conversation about this a while ago and the indices instead
> of phandles is actually my fault, that happened because I initially proposed your
> option 2 but then for a number of reasons we went with this kind of solution.
> 
> I know it's going to be a long read, but the entire conversation is on the list [1]
> 

Sorry, but it's a hacky architecture where one device (which is a clock
provider) and second device have no relationship in hardware description
but both play with each other resources. That's simply not a proper
hardware description, so again:

1. If this is separate device (as you indicated), then it needs
expressing the dependencies and uses of other device resources.

2. If this is not a separate device, but integral part of clock
controller, then it would be fine but then probably should be child of
that device.

Best regards,
Krzysztof
