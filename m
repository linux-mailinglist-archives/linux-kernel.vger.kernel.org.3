Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642644E6236
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349699AbiCXLPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbiCXLPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:15:40 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0A70071;
        Thu, 24 Mar 2022 04:14:06 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id t1so5204724edc.3;
        Thu, 24 Mar 2022 04:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LnBHIWTMwUxu5CxDggWjU5OVRGTaM8mL8G6XsxB1wRI=;
        b=wh2PoblV/v+pv0gEwbAddO84w/vfVumtRmFm/9Kl66Yid5rr++RoyqaMRfjRyK6875
         f7pr/woPao+SB0MhtKK9PHQG4SEnj3GhMVS5phWIQhW9S4gJO+/G4HKck980QrU+2Yxt
         2Ihu2SPLTBmUgv5QHSGzhjucSXOdqfSKvJnTiwNenVqWi4HIia9v3Dhbn62+hahuqAXR
         cfQvUI7ycg7VnIvj16W+ROQhAUayXcc4CsGRFuz4sPSlwetS5Qp3oYCq+p77oM0nom8i
         j8+XT6hO7K3yaWz/yZJdpGTXdIh3rG6GEcJwowGsusGiPzPExFC1ufs37fK+3lg8JcvP
         yhtQ==
X-Gm-Message-State: AOAM530LQf/Bt1RBAUPivdRZInlMVEqk6FtGtL8vrDm2+YgeEj3Ftcm5
        5/71ZrYNBLoqj+9Y5/Xilezn9yXYid2d7w==
X-Google-Smtp-Source: ABdhPJwwONi6y53eVNGRVDSTyVSgaZrT1JFMHVhb1HlojUu4EUk4lusp3clxvUhSpyT3gwBJLNHcmA==
X-Received: by 2002:a05:6402:1907:b0:418:d2a8:a7f3 with SMTP id e7-20020a056402190700b00418d2a8a7f3mr6028406edz.245.1648120445050;
        Thu, 24 Mar 2022 04:14:05 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id d23-20020aa7d5d7000000b00418f7b2f1dbsm1266017eds.71.2022.03.24.04.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:14:04 -0700 (PDT)
Message-ID: <327e5b31-5b9a-240f-26c1-98b8a29e2023@kernel.org>
Date:   Thu, 24 Mar 2022 12:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc
 dtbindings
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220311164628.378849-1-gengcixi@gmail.com>
 <20220311164628.378849-2-gengcixi@gmail.com>
 <6e4f64dc-bb3d-0e05-0380-7e6f3b1a823c@kernel.org>
 <CAF12kFuKnm2qenvpmKhCVD4T+d=0SyruzdpJ5FX1RS8gvqbyNA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAF12kFuKnm2qenvpmKhCVD4T+d=0SyruzdpJ5FX1RS8gvqbyNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 07:22, Cixi Geng wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 于2022年3月20日周日 22:50写道：
>>
>> On 11/03/2022 17:46, Cixi Geng wrote:
>>> From: Cixi Geng <cixi.geng1@unisoc.com>
>>>
>>> sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
>>> dtbindings.
>>>
>>> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>>> ---
>>>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 30 +++++++++++++++++--
>>>  1 file changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
>>> index caa3ee0b4b8c..331b08fb1761 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
>>> @@ -20,6 +20,7 @@ properties:
>>>        - sprd,sc2723-adc
>>>        - sprd,sc2730-adc
>>>        - sprd,sc2731-adc
>>> +      - sprd,ump9620-adc
>>>
>>>    reg:
>>>      maxItems: 1
>>> @@ -37,9 +38,32 @@ properties:
>>>      maxItems: 2
>>>
>>>    nvmem-cell-names:
>>> -    items:
>>> -      - const: big_scale_calib
>>> -      - const: small_scale_calib
>>
>> Please test your changes with dt_binding_check and dtbs_check. Your
>> change looks not complete - you have still nvmem-cells = 2.
>>
> Hi Krzysztof
> I test all is PASS on my local.  could you tell how did you test?
> my_logs:
> cixi.geng1@tj10039pcu:~/upsteatming/linux$ make DT_CHECKER_FLAGS=-m
> dt_binding_check &>dt_check.log
> cixi.geng1@tj10039pcu:~/upsteatming/linux$ cat dt_check.log |grep sprd,sc2720
>   DTEX    Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example.dts
>   DTC     Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example.dt.yaml
> cixi.geng1@tj10039pcu:~/upsteatming/linux$ tuxmake -C ${kernel_src} -b
> ${topdir}/obj/gcc -o ${topdir}/dist/gcc -a $ARCH -t gcc  -K
> CONFIG_ARCH_${PLAT}=y -K CONFIG_MFD_SC27XX_PMIC=y -K
> CONFIG_SC27XX_ADC=y
> 

The method is correct, just please test sprd,ump9620-adc (either in
example in the binding or your DTS with `make dtbs_check
DT_SCHEMA_FILES=sprd,sc2720-adc.yaml).

Best regards,
Krzysztof
