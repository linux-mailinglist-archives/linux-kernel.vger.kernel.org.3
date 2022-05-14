Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91495273C9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 21:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbiENTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiENTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 15:41:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD01CB36
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:41:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bu29so19846900lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=t6bJEDO0j/dRfFq4rPjW4+ykP3n6Msmi35RTgOoZ07M=;
        b=Kl7f6ZAzoxQ4Jd8/+V19vqhkpkPjmEHVoVrK51Kv1LDfYNnBINfKrX6YUx+89iVSjx
         0Kcyr9hxefFJxiH9uBIlQ+2ta82hisNj12PIGV3cHbR1/w26ovilmYOUt8ypxwv3NlnK
         7rgtbKaHc9Pg8u9Vb1vJPocjJuzp1fyfnx9QauxFkXLwNYdyTQOgSUUnUt6CgB87i3D+
         2vqb8TR/qrrGbGRYgNPH3tRTl7crlEA7gLHGfXCI/kF4yCAIZlgT0iSnALmSmbAiZCQi
         o/wXQ6rT542gdyMTiHD8Cyg3DrMI+wT2KBj30BenDrZW3ofC6Vq4qwJIBXRYI6MTCX5I
         oIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t6bJEDO0j/dRfFq4rPjW4+ykP3n6Msmi35RTgOoZ07M=;
        b=j2JF5Ex6Zs2/b5PLEwx347wBX/0KbFVTwa5ldlRGI6x7OT8cKgLf4UAzx9KT006jbq
         E9gyxGcJgZ08GveR9ecX92Cu3Fv4WEHJhfTyrVR63Ob7iRc5b5zWUmO/OQ8VStas4Jgg
         EtWaurpx+nVCcsVDNGEx97jd4dbXiPb3VxdLnvEtlrHvFyrthDroDTVHLYYyL7Ftmacf
         1SGX+Qhz9P/jT3ZMIWcIGOb1z9pa+czWe0CeJiBdStBwDz6cs4zgKcsjfjZTSIk6u/7R
         99kNLZlUYGGQ/KGNTFY/zlcHPFErO6ltTCg08Yjz69JnVH89jslcSOwCUjAr/Oyatehm
         Nysw==
X-Gm-Message-State: AOAM533jNiTlkW3Aoxna3gaXHjg5xyXuiG0UGDdg90KR1Q8zmaP5a610
        FFmeTB5KCe86ysAhmQBBhfAiJw==
X-Google-Smtp-Source: ABdhPJxHu3S+WGwVzKJZUxwzhTiHR4uLT/Zh8n+qQPda4WwCCELQ3QGV2iDBNb6lJiozLzyiQW2ksA==
X-Received: by 2002:a05:6512:12c9:b0:473:c33e:a65b with SMTP id p9-20020a05651212c900b00473c33ea65bmr7771309lfg.285.1652557304862;
        Sat, 14 May 2022 12:41:44 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c2-20020ac25302000000b004778d417c49sm78333lfh.290.2022.05.14.12.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 12:41:44 -0700 (PDT)
Message-ID: <f8d8be37-3e2f-c1fc-37d6-b1e0bfa875ce@linaro.org>
Date:   Sat, 14 May 2022 21:41:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [v4 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy
 override params bindings
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_vpulyala@quicinc.com
References: <1652282793-5580-1-git-send-email-quic_kriskura@quicinc.com>
 <1652282793-5580-2-git-send-email-quic_kriskura@quicinc.com>
 <d296720d-ccbe-27f0-8ba1-9653af25dd52@linaro.org>
 <9644d608-4ab9-ed0d-50fb-0016e4331361@quicinc.com>
 <5b32cecf-873a-6367-df87-1b8d45e63cec@linaro.org>
 <972ac516-efac-54d6-febc-1b180ec36d4b@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <972ac516-efac-54d6-febc-1b180ec36d4b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2022 08:24, Krishna Kurapati PSSNV wrote:
> 
> On 5/12/2022 4:00 PM, Krzysztof Kozlowski wrote:
>> On 12/05/2022 07:57, Krishna Kurapati PSSNV wrote:
>>> On 5/11/2022 11:49 PM, Krzysztof Kozlowski wrote:
>>>> On 11/05/2022 17:26, Krishna Kurapati wrote:
>>>>> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>>
>>>>> Add device tree bindings for SNPS phy tuning parameters.
>>>>>
>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
>>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>>> ---
>>>>>    .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 87 ++++++++++++++++++++++
>>>>>    1 file changed, 87 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>>> index 1ce251d..70efffe 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
>>>>> @@ -53,6 +53,93 @@ properties:
>>>>>      vdda33-supply:
>>>>>        description: phandle to the regulator 3.3V supply node.
>>>>>    
>>>>> +  qcom,hs-disconnect-bps:
>>>>> +    $ref: /schemas/types.yaml#/definitions/int32
>>>>> +    description:
>>>>> +      This adjusts the voltage level for the threshold used to
>>>>> +      detect a disconnect event at the host. Possible values are.
>>>>> +      The values defined are in multiples of basis points (1bp = 0.01%).
>>>> This means there is some minimum and maximum (100%)?
>>> Hi Krzystof,
>>>
>>> Yes there are max and min for each parameter (not necessarily 0%/100%)
>>>
>>> As an example if we take squelch detector threshold, the register value
>>> vs actual percentage changer as per data book is as follows :
>>>
>>> % change in voltage    |     corresponding reg value
>>>
>>>    -20.90%                        |    7
>>>    -15.60%                        |    6
>>> -10.30%                         |    5
>>> -5.30%                           |    4
>>> 0%                                  |    3
>>> 5.30%                            |    2
>>> 10.60%                          |    1
>>> 15.90%                          |    0
>>>
>>> Here the min and max are 15.9% to -20.9%
>>>
>>> The min and max differ for each parameter and might not be necessarily
>>> 0% and 100%
>> Then it seems possible to define minimum and maximum values - please add
>> them ("minimum: xxxx").
>>
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> 
>   Sorry for the late reply, missed this mail.
> 
> Currently, these values have a fixed maximum and minimum. But if these 
> limits change in the
> 
> future (say on a per target basis) , would it be appropriate to add them 
> here in bindings file ?

Per "target" you mean compatible? Then yes, the same as customizing
number of interrupts, clocks etc.

> 
> Also in the driver file for sc7280 target, we have added parameter 
> mapping : (map b/w register value
> 
> and bps passed from device tree). For squelch detector, it is as follows:
> 
> +static struct override_param squelch_det_threshold_sc7280[] = {
> +	OVERRIDE_PARAM(-2090, 7),
> +	OVERRIDE_PARAM(-1560, 6),
> +	OVERRIDE_PARAM(-1030, 5),
> +	OVERRIDE_PARAM(-530, 4),
> +	OVERRIDE_PARAM(0, 3),
> +	OVERRIDE_PARAM(530, 2),
> +	OVERRIDE_PARAM(1060, 1),
> +	OVERRIDE_PARAM(1590, 0),
> +};
> 
> And the code is written such that if we give a bps value in dt greater than max value in
> table, we would automatically choose max value. And if we provide bps value lesser than
> minimum value, we would choose the min value.
> 
> So, would it be appropriate to add the min and max in dt-bindings when there is a
> slight chance of them changing in the future ?

The kernel behavior should not matter here, because the bindings are
about the hardware. Therefore if hardware comes with maximum/minimum
values, it would be better to document them here.


Best regards,
Krzysztof
