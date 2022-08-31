Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20855A7F30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiHaNq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiHaNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:46:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DEBC6CFC
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:45:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so10974428lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=N0G7rOG3vdgdo9X3yTQ1g7olIE+/mQZT1vQ9cV8hobE=;
        b=vIlL6EEy5zR+EeKbEVppwnHesRNyW/+X8hhuVTnuepDv8Fe9ArBBhOaCkNdQz+VDZG
         YwaJo5Ljkux5YjRMW39XFC+898QQaejwvGl/IU9QzI65OxOI6Gzm46BEEOWQpvQAg3D/
         rfuYmASqsSmgoHM2uOgSBdlMbWbpgTAHok5jY1uH5S7DXkPfCnPdzK3DTu74YuJukCLu
         hD7vYdXDXtE+TpEKeNDlWRF5w8/7UfcUKVK6XX3FdBKQnnXBMxkxELVPxPGkI56Wv6Sn
         4UID62ophjX7P/H7uNxNGagxg+xaM/XjT7yXRkc1chd4bLYxTuke189c7py83kPAl0RO
         4/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=N0G7rOG3vdgdo9X3yTQ1g7olIE+/mQZT1vQ9cV8hobE=;
        b=DZh5NhHZWBjT5Y9XFUSSavM0gWk38KdgPvVBBMbOizv5NvhQgYuv9qLtFPrK5zLC9s
         vSrk4paGBCxAHkM7ZzGad89cdaXRdTtFcy5ZSTazRhKJUgMFzn1zIchxCIaURDvmGdLH
         A0q9ihwUUJoNwrCyKgbVg3zXZUSDF7iDIQlcfpzTfuoGr53fA2uLkXYl6FSuy2951JOe
         3xjSs/2t6As7Jx5MEIf3TuDphunm02KBVMIkVUPPS5FDE3/naHPtRe25k5zZsI5MAbBM
         naRFL1XLc7nNsPOsW1rbi4mdAcCOccUTO85yNvsq+w95ViJrjby7ijF70UFKkzWnjOFT
         fzUw==
X-Gm-Message-State: ACgBeo2uIjv3q1C//q8OxnKZaruh+2zNdX1K2kQKcgIaz++YoMBPlOlW
        ZiR7kU/5ovrReKKnwICwXBlDkWSL9Y4MjFqm
X-Google-Smtp-Source: AA6agR5Av5JpT5aqRZS2VQX6SDr45WRpUsUGJWUwhhOSsOH0e1j8tW1B0daJxjKtvCYVSZkhrg/Bvg==
X-Received: by 2002:a05:6512:c06:b0:48d:1d99:2a1a with SMTP id z6-20020a0565120c0600b0048d1d992a1amr10491615lfu.396.1661953544504;
        Wed, 31 Aug 2022 06:45:44 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id t22-20020a199116000000b00491734dcb89sm966719lfd.196.2022.08.31.06.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:45:43 -0700 (PDT)
Message-ID: <8d1328bb-9484-9c32-b059-bdebfc18663d@linaro.org>
Date:   Wed, 31 Aug 2022 16:45:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V2 1/8] dt-bindings: soc: imx: add binding for i.MX9
 syscon
Content-Language: en-US
To:     Peng Fan <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
 <20220831074923.3085937-2-peng.fan@oss.nxp.com>
 <cb3870bc-451a-ff62-e671-f2045eecc781@linaro.org>
 <9c7854a2-bc9c-f4e6-3b37-f740e05768c5@oss.nxp.com>
 <7f8a4f33-4bde-384f-f541-f383c8e0b27d@linaro.org>
 <0cacdfc0-b62d-ddd4-825e-3118071fe365@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0cacdfc0-b62d-ddd4-825e-3118071fe365@oss.nxp.com>
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

On 31/08/2022 16:41, Peng Fan wrote:
> 
> 
> On 8/31/2022 8:54 PM, Krzysztof Kozlowski wrote:
>> On 31/08/2022 13:08, Peng Fan wrote:
>>>
>>>
>>> On 8/31/2022 5:15 PM, Krzysztof Kozlowski wrote:
>>>> On 31/08/2022 10:49, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
>>>>>
>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>>>> ---
>>>>>    .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
>>>>>    1 file changed, 37 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..90c5e354f86c
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>>> @@ -0,0 +1,37 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
>>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>>
>>>> One more - drop the quotes both lines above.
>>>
>>> There will be dtbs_check error. I updated schema with:
>>> pip3 install git+https://github.com/devicetree-org/dt-schema.git@main
>>>
>>> So it is ok the drop the two quotes above? Is there
>>> any new update in dt-schema that not landed in repo?
>>
>> This is something new to me, can you paste the error?
> 
> I have renamed the file to "fsl,imx93-syscon.yaml"
> 
> $DT_SCHEMA_FILES=Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml 
> make ARCH=arm64 DT_CHECKER_FLAGS=-m dtbs_check
> 
>    LINT    Documentation/devicetree/bindings
>    CHKDT   Documentation/devicetree/bindings/processed-schema.json
> ./Documentation/devicetree/bindings/soc/imx/fsl,imx93-syscon.yaml: error 
> checking schema file
>    SCHEMA  Documentation/devicetree/bindings/processed-schema.json

Hm, not much of an actual message. Most - or almost all - bindings do
not have quotes, you know...

This is something with your setup because above error is not reproducible.

Best regards,
Krzysztof
