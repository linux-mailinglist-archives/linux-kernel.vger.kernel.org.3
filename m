Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E72554C42
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357986AbiFVOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357952AbiFVOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:10:07 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C138BF1;
        Wed, 22 Jun 2022 07:10:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so871888wml.2;
        Wed, 22 Jun 2022 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IUleCzU0ATDf0+p/HH1nF2nu10ebP7qKQKRtIfRnmbY=;
        b=KSzdoo/36ZIvRIu6QQ/klecmGghfPbtDd0BgkYWOUelHQex0jNYUA7/brCB4t7Goa0
         wqZaR9dyx7ZrEaYLsamF+5HABOou1GXhsY6EqGEAiawpQSVq7F8hPWG24JxjKFmn1kkk
         oq8Xl5dGXPIjkB4dgmj1c9UaAARXM7u2RPzUSoii1caVxeSnNoI8IC1V/aAswsvcNvJF
         XVWzcSGINqPTG8W9JMYHTka77G1kl29PsxNV7A1TmXkPKWT/qIhR+3QPN+8rZoYY7SEx
         dYj8seOmtusTwH/0iHUUTxEi6p987CqzCQXu0IhsrN1o/9Arf55c37K9OXkOyiyE4Tb/
         lokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IUleCzU0ATDf0+p/HH1nF2nu10ebP7qKQKRtIfRnmbY=;
        b=kaEHQl5gzkdP/tXnk2PrTZJAwZbk3jgYMQDNI4t9Bv6rsQUE3SwHXSRebBGgYyqq57
         RXjswEcU6ex7x3nnxAtMWttZMHmHkceDKlRBZ4Uck6mvkneHMDkL1sUyjd3ZyuRFWDSo
         9WMS+LgXGFuQVtzBw6kJfsZjfQtiaqBmqtJ0XgtuFLg6Hc09xJyPwagY17VNJmfdPjrh
         qUXxUTLIyoIEiu+nuEjYQ3CSxXbi56IWqoyNdibvJfqwKK8+wKYlT8Bc/eM25oQSl6N4
         qROJW20d/v0LkgdUEXv/kF290ERV2wOnFF+nfvNICx/6sQZFAF1DggA1S9WmH9GNVO0B
         NxsQ==
X-Gm-Message-State: AJIora8IMDZLKGRpo7/WfnZRDzcfd14X8F1Z4ab8t0Eq/YOxuYVQOr5b
        W3p0c44MmRWyAuPpiiV9hLQ=
X-Google-Smtp-Source: AGRyM1sMtk0NJfyawl0SBTLR/ENEJAyULujRd4IYFKCRrJUK56lDt+eTATyCgING1Ci7/CWWeEzNMg==
X-Received: by 2002:a05:600c:3543:b0:3a0:2a72:e4d2 with SMTP id i3-20020a05600c354300b003a02a72e4d2mr3559358wmq.58.1655907002466;
        Wed, 22 Jun 2022 07:10:02 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b0039db500714fsm23452759wmq.6.2022.06.22.07.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:10:01 -0700 (PDT)
Message-ID: <56b940e7-849a-6d90-52cd-b8db90e5ed62@gmail.com>
Date:   Wed, 22 Jun 2022 16:10:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/4] dt-bindings: nvmem: convert mtk-efuse.txt to YAML
 schema
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20220617093132.22578-1-chunfeng.yun@mediatek.com>
 <46ec62eb-00da-defb-219f-92121fd35d7e@linaro.org>
 <0050627cdd64c02bb84f4694fc8994a5cb27d0f2.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <0050627cdd64c02bb84f4694fc8994a5cb27d0f2.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/06/2022 09:11, Chunfeng Yun wrote:
> Hi Matthias,
> 
> On Fri, 2022-06-17 at 12:41 -0700, Srinivas Kandagatla wrote:
>>
>> On 17/06/2022 02:31, Chunfeng Yun wrote:
>>> Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> ---
>>
>> Applied 1/4 and 2/4, dts patches need to go via SoC maintainer.
> Could you please help to pick up 3/4, 4/4?

Applied, thanks!

> 
> thanks
> 
>>
>>
>> thanks,
>> -srini
>>
>>
>>> v6: no changes, based on kernel 5.19-rc1
>>>
>>> v5:
>>> sync with the series:
>>>
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=640196
>>>      1. change title suggested by Krzysztof;
>>>      2. No need drop 'reviewed-by Rob' suggested by Krzysztof
>>>      3. add maintainer Lala who maintain efuse driver now;
>>>
>>> v4: fix duplicated unit-address in example;
>>>       drop reviewed-by Rob, due to changes;
>>>
>>> v3: add reviewed-by Rob
>>>
>>> v2:
>>>      1. remove description of subnodes which is covered by
>>> nvmem.yaml
>>> suggested by Rob
>>>      2. change the example which is commoner than mt8173's
>>> ---
>>>    .../bindings/nvmem/mediatek,efuse.yaml        | 87
>>> +++++++++++++++++++
>>>    .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ---------
>>>    2 files changed, 87 insertions(+), 43 deletions(-)
>>>    create mode 100644
>>> Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>>    delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-
>>> efuse.txt
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> new file mode 100644
>>> index 000000000000..f6e01ddb7499
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>>> @@ -0,0 +1,87 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek efuse
>>> +
>>> +description: |
>>> +  MediaTek's efuse is used for storing calibration data, it can be
>>> accessed
>>> +  on ARM devices usiong I/O mapped memory.
>>> +
>>> +maintainers:
>>> +  - Andrew-CT Chen <andrew-ct.chen@mediatek.com>
>>> +  - Lala Lin <lala.lin@mediatek.com>
>>> +
>>> +allOf:
>>> +  - $ref: "nvmem.yaml#"
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    pattern: "^efuse@[0-9a-f]+$"
>>> +
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - mediatek,mt7622-efuse
>>> +              - mediatek,mt7623-efuse
>>> +              - mediatek,mt8173-efuse
>>> +              - mediatek,mt8192-efuse
>>> +              - mediatek,mt8195-efuse
>>> +              - mediatek,mt8516-efuse
>>> +          - const: mediatek,efuse
>>> +      - const: mediatek,mt8173-efuse
>>> +        deprecated: true
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    efuse@11c10000 {
>>> +        compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
>>> +        reg = <0x11c10000 0x1000>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +
>>> +        u3_tx_imp_p0: usb3-tx-imp@184,1 {
>>> +            reg = <0x184 0x1>;
>>> +            bits = <0 5>;
>>> +        };
>>> +        u3_rx_imp_p0: usb3-rx-imp@184,2 {
>>> +            reg = <0x184 0x2>;
>>> +            bits = <5 5>;
>>> +        };
>>> +        u3_intr_p0: usb3-intr@185 {
>>> +            reg = <0x185 0x1>;
>>> +            bits = <2 6>;
>>> +        };
>>> +        comb_tx_imp_p1: usb3-tx-imp@186,1 {
>>> +            reg = <0x186 0x1>;
>>> +            bits = <0 5>;
>>> +        };
>>> +        comb_rx_imp_p1: usb3-rx-imp@186,2 {
>>> +            reg = <0x186 0x2>;
>>> +            bits = <5 5>;
>>> +        };
>>> +        comb_intr_p1: usb3-intr@187 {
>>> +            reg = <0x187 0x1>;
>>> +            bits = <2 6>;
>>> +        };
>>> +        u2_intr_p0: usb2-intr-p0@188,1 {
>>> +            reg = <0x188 0x1>;
>>> +            bits = <0 5>;
>>> +        };
>>> +        u2_intr_p1: usb2-intr-p1@188,2 {
>>> +            reg = <0x188 0x2>;
>>> +            bits = <5 5>;
>>> +        };
>>> +    };
>>> diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>>> b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>>> deleted file mode 100644
>>> index 39d529599444..000000000000
>>> --- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
>>> +++ /dev/null
>>> @@ -1,43 +0,0 @@
>>> -= Mediatek MTK-EFUSE device tree bindings =
>>> -
>>> -This binding is intended to represent MTK-EFUSE which is found in
>>> most Mediatek SOCs.
>>> -
>>> -Required properties:
>>> -- compatible: should be
>>> -	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
>>> -	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
>>> -	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
>>> -	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
>>> -	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
>>> -	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
>>> -- reg: Should contain registers location and length
>>> -- bits: contain the bits range by offset and size
>>> -
>>> -= Data cells =
>>> -Are child nodes of MTK-EFUSE, bindings of which as described in
>>> -bindings/nvmem/nvmem.txt
>>> -
>>> -Example:
>>> -
>>> -	efuse: efuse@10206000 {
>>> -		compatible = "mediatek,mt8173-efuse";
>>> -		reg	   = <0 0x10206000 0 0x1000>;
>>> -		#address-cells = <1>;
>>> -		#size-cells = <1>;
>>> -
>>> -		/* Data cells */
>>> -		thermal_calibration: calib@528 {
>>> -			reg = <0x528 0xc>;
>>> -		};
>>> -	};
>>> -
>>> -= Data consumers =
>>> -Are device nodes which consume nvmem data cells.
>>> -
>>> -For example:
>>> -
>>> -	thermal {
>>> -		...
>>> -		nvmem-cells = <&thermal_calibration>;
>>> -		nvmem-cell-names = "calibration";
>>> -	};
> 
