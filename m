Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFCE5A5D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiH3Hmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbiH3Hmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:42:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC2A1D06
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:42:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z6so14351066lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=c+BAz5TKARnaA7ePcUOXjPEFWuKXdNXQbdrTJXQiOA8=;
        b=cE6M+jIIm2JY5p5Gd+AJwb7gJD4EP8fNwBY5jsaBGDhUk5F47Jt1yWBILhG6/v01t9
         iPmhdwwrzBtw2x8aWbrqV+HzC2xg+2gh7HYHRgdMVVFmwVlzQ99Fm0baz8MI1lUb8qt3
         feihot3Aru7Q+6iAzlZo6vbOUk9At8lVccORWCmbwDzrqW4edMA5kmWyevdx4RhwEOse
         j2nkWQmsH5mFYVGNVninKWpd4zF8bX0AyOFpUcJTQkCpRidRU+wHEw2YrkiKp1EOy7/N
         MYYSS+KwJvlA2Z1fJAWGwWJKMEVN7VMuU3IXuwWy8k5VHpFEg0Mt4Bpdx+zIrmUUjzNd
         k8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=c+BAz5TKARnaA7ePcUOXjPEFWuKXdNXQbdrTJXQiOA8=;
        b=OVV+y5D2SqV2j2wPFUwzxexcpHw2i4+N4wO1u0hM38KPuo7ghAxvIDw7nunrC2fDWO
         M6XC9S1Abs76vdbNC7HKyBj0ui1lk3tlNxtyOsqSEJwQusGJQgJU3syOYUFFL+4lSOUi
         RXBdscUDYNf6OBOrxCV2kms1Hwd2B1rvXw0bvLv+IEvVsmL7uLAuNVMqC9MpcW9qxA0p
         j6yroO+K0wUO709/9TJDfNoKV8VoWDsYMsEwA8fTkqiUwPgn/UOR+WVRQXHZ3xcCFORm
         zyCbEE/cv6nquIMLhH9yH/iffmKTn3JK30ysB5JsvadBW03YoJTbfYzq6AHzuDaqLMZX
         Pddw==
X-Gm-Message-State: ACgBeo2ikDxYEaB6uAhumcyKAg6tl+eki8fjHePBySS0OjC8O7y3koJi
        i8glB0y4L3da2eClg6PCkxN0MA==
X-Google-Smtp-Source: AA6agR5e7+jk6RNyxPoSGiPYTuNDPyAoTBhOV75Af0njmGE2v5/xj4Z02ryp1GDslTWJlAu/Y3EvVg==
X-Received: by 2002:a05:6512:1684:b0:47f:5f27:b006 with SMTP id bu4-20020a056512168400b0047f5f27b006mr7304537lfb.225.1661845352094;
        Tue, 30 Aug 2022 00:42:32 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b00492d270db5esm1520758lfr.242.2022.08.30.00.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:42:31 -0700 (PDT)
Message-ID: <52336b1e-f0b3-c828-48ef-b6977fd90547@linaro.org>
Date:   Tue, 30 Aug 2022 10:42:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4] regulator: dt-bindings: mediatek: add mt6366
Content-Language: en-US
To:     "zhiyong.tao" <zhiyong.tao@mediatek.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, eddie.huang@mediatek.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, fshao@chromium.org
Cc:     sen.chu@mediatek.com, hui.liu@mediatek.com,
        allen-kh.cheng@mediatek.com, hsin-hsiung.wang@mediatek.com,
        sean.wang@mediatek.com, macpaul.lin@mediatek.com,
        wen.su@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220823123745.14061-1-zhiyong.tao@mediatek.com>
 <57d259cd-613b-a608-5b67-01aa72c2babb@linaro.org>
 <93bb8a3f7f5567cfe427ed067f68d5c8b6db776d.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <93bb8a3f7f5567cfe427ed067f68d5c8b6db776d.camel@mediatek.com>
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

On 29/08/2022 06:25, zhiyong.tao wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: mediatek,mt6366-regulator
>>
>> This looks incomplete. How does it bind? Further pieces also suggest
>> you
>> send something incomplete.
> ==>
> 
> The project dts file(such as 8186-evb.dts) will add the compatible.
> The project dts file is examining.
> 

I don't understand this at all. I am not talking about DTS, but about
bindings which look incomplete. Although seeing entire DTS would
probably help understand the context.

(...)

>>
>>
>>> +        type: object
>>> +        $ref: regulator.yaml#
>>> +        unevaluatedProperties: false
>>> +
>>> +required:
>>> +  - compatible
>>> +  - regulators
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:

>>> +  - |
>>> +    pmic {
>>> +        compatible = "mediatek,mt6366-regulator";
>>> +
>>> +        regulators {
>>> +            mt6366_vdram1_reg: buck-vdram1 {
>>
>> Drop the labels here and further. Why you do not have here any
>> regular
>> constraints like min/max voltage?
> 
> we will add properties min/max voltag on project dts file.

Example should be complete. DTS does not matter here.

> 
>>
>>> +                regulator-ramp-delay = <12500>;
>>> +                regulator-enable-ramp-delay = <0>;
>>> +                regulator-allowed-modes = <0 1>;
>>
>> Where do you explain the meaning of modes?
> support pwm mode.

The question was "Where". Where did you explain them?

(...)

>>> +
>>> +            mt6366_vsim2_reg: ldo-vsim2 {
>>> +                regulator-enable-ramp-delay = <540>;
>>> +            };
>>> +
>>> +            mt6366_vcore_sshub_reg: buck-vcore-sshub {
>>
>> Empty node? What does it do?
> just define here, we will add properties on project dts file.

How is it related to bindings?

Best regards,
Krzysztof
