Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7F5A7E11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiHaMzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHaMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:54:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D137646
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:54:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id br21so14060504lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=V6XUFfKw/mcf35DuShi6/x/3ymScjwY/+2rsQ4Prf54=;
        b=g7zivDNFTvaNclQwX3j1LH1SHYCr4wqcC8y5fe/dBAYykEKVembblo+KqTFT5bQPlC
         eEPEZK1vu91aO0KFca1bDuq4yYzLv7K+rEtn9ClvNh7s9DZs/G3SAhGUCJFfqr6Lxv73
         QfuZnaBIEf1XvTxguE2FMO7/dUNR5FzrLLScrOP0pdSHypugDH82CbB2cQ0QDgMTSoUG
         +Kwbldg4eXjL735BMqh79DanVIUHLdE8+kIMwhqDq9PlOlt/Ji7YyKKN2k2hGy8WGNJ6
         cd2J/Gtyc/mu/YB7CPbEfIJjk0unZesnFscVmp6obD4+zHIczKfrabYPXMwAZnz+JVBf
         rH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=V6XUFfKw/mcf35DuShi6/x/3ymScjwY/+2rsQ4Prf54=;
        b=rVc3cxdFFpR3HYHBTQtgMHgsjzzjaJ8U9mLoqdPA53KsDYQhOOH2oF68IxcjZr5O9C
         1W5sDuCKL89g5hPRwYh0cnOaVxyPQZA42Au2dqKHq6fyHsXX4ewWFe99kRZT+DZIqaEG
         zCwc/DYikBQ6HQ6m3hpnBccCLx4kwbxZJcuBcuPDZUXAt0uSLlupS3ahMvKWQ22AU78e
         J4IlFD1RLG3vW9Zeaa24ErWv3zNiV0gvxuy0a9CVRM+9QX3Kd0UmnKBajdNgAeh3MQeB
         k/7Z2m+lcTQaI50jtwGtxcyqEEoQ0bL0e73Giiol/qLEAqNghy6k3Wfd0fwzDLBYGCqw
         lc5Q==
X-Gm-Message-State: ACgBeo0QVGkA/SG9R/M3kM3B4eE3VRVTkRoiIOsHZ12urSuLEntmhrKG
        2SEMUSjErGa2LMIwnkZqgZC1ig==
X-Google-Smtp-Source: AA6agR5xyQHInsiAmVlULA23am/aIuyUWINMG0q1CPHSOdnoZ5UvmzllUhOyOstaX6BcJx52TIzcew==
X-Received: by 2002:a05:6512:3e0b:b0:494:735c:c7ec with SMTP id i11-20020a0565123e0b00b00494735cc7ecmr3803651lfv.373.1661950494688;
        Wed, 31 Aug 2022 05:54:54 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512214b00b0049461118819sm1482243lfr.77.2022.08.31.05.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 05:54:54 -0700 (PDT)
Message-ID: <7f8a4f33-4bde-384f-f541-f383c8e0b27d@linaro.org>
Date:   Wed, 31 Aug 2022 15:54:53 +0300
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9c7854a2-bc9c-f4e6-3b37-f740e05768c5@oss.nxp.com>
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

On 31/08/2022 13:08, Peng Fan wrote:
> 
> 
> On 8/31/2022 5:15 PM, Krzysztof Kozlowski wrote:
>> On 31/08/2022 10:49, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> Add binding doc for i.MX9 blk_ctrl_ns_aonmix and blk_ctrl_wakeupmix
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>   .../bindings/soc/imx/fsl,imx9-syscon.yaml     | 37 +++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>> new file mode 100644
>>> index 000000000000..90c5e354f86c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx9-syscon.yaml
>>> @@ -0,0 +1,37 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/soc/imx/fsl,imx9-syscon.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>
>> One more - drop the quotes both lines above.
> 
> There will be dtbs_check error. I updated schema with:
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@main
> 
> So it is ok the drop the two quotes above? Is there
> any new update in dt-schema that not landed in repo?

This is something new to me, can you paste the error?

Best regards,
Krzysztof
