Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3C568B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGFOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiGFOme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:42:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454624BC8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:42:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l7so17987704ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6Xe30gHq1/bKVOvvpUolv/zq7ZNGoEVUN1+qrlGNB7M=;
        b=dJUCvaARPZnU/5Wz/bruRjeC5zre5Fkd+rHtbW9xlKXjHpxRqKtrRhJcWNIWfV5fzh
         pg3javD/nGaSKyy0wWmt2m/46hnr7UXcRv6EDjftRg8+jSKVhzttwvOhs+hJrLXa+Zy4
         orylxwG+eTdCwvOUj7V0UGvV6BOw7ZcFnOjIxY7/zGkI8PL7c7S+ZxwymH7w5dKU4m6M
         x7uiNd6N5FxbDzKlX3m3MY7tJEsOEPZHOvWZeAnPQ8xtWQcRjk83ZCareMtKaVvKAO8f
         d9LjUF34CJAHo0ejzxdwalSneiYiZVkXttsijm4HUh/lrIGUPSHKgDW3jflNv1PPQO41
         hWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Xe30gHq1/bKVOvvpUolv/zq7ZNGoEVUN1+qrlGNB7M=;
        b=OQJCIFuF0DjMQPJsuIWb6H1jqK4uLfZP+OEN6TOCk8SQDAJoV9Aw/FG08j2flCy3+k
         BrsCQnKSixS5RLXj2mN9mi4SwmkKvwXnc2q3qx6HEB/h2e5a0Ej+Eiv3xHkyE3pK2WVO
         2JE/7ojBCJhtR7WUI8ltLIp/Q0Mxa9euocR0fHaQfq1WybELWq8B93Qa45FE+yqi9svg
         nCIUQRxuNs5aSo7ab6I7REcl3Guw9ZZo/Hc5Zo6TaBjRaOFzurHlz19uok9bWoGQxUlr
         CqfMgqP10PrIBkp2S0Xl+YALy5jZ0o2DHzs9f13E7DPdl++nXE6b5mjGjk6rG/7KwmIE
         Zg9A==
X-Gm-Message-State: AJIora80nernhuS13mVPDQAdf+1r9IwhyH0xM3bwNReeYaAiAxZ3X4r/
        1tDeVNlMJG/PiR9toBoRIUfwwQ==
X-Google-Smtp-Source: AGRyM1u9DKYFBoJu0fPNHXOP5UXld700MJ8EcMFqpYaPedDBT5bVOHjcVoKn+YYrzqaUozSqcd4nBg==
X-Received: by 2002:a2e:99d0:0:b0:25d:33e7:2b01 with SMTP id l16-20020a2e99d0000000b0025d33e72b01mr5207636ljj.146.1657118551635;
        Wed, 06 Jul 2022 07:42:31 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a056512202800b0047f750ecd8csm6319194lfs.67.2022.07.06.07.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:42:31 -0700 (PDT)
Message-ID: <0cbf9425-7fa3-56fa-286e-f9d87424a6f3@linaro.org>
Date:   Wed, 6 Jul 2022 16:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/13] ARM: dts: qcom: add missing rpm regulators and
 cells for ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-4-ansuelsmth@gmail.com>
 <e81344f6-7da5-a209-2785-d540e41f3958@linaro.org>
 <62c56348.1c69fb81.d2cad.2584@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62c56348.1c69fb81.d2cad.2584@mx.google.com>
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

On 06/07/2022 12:09, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 10:34:16AM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 15:39, Christian Marangi wrote:
>>> Add cells definition for rpm node and add missing regulators for the 4
>>> regulator present on ipq8064. There regulators are controlled by rpm and
>>> to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
>>> reject any regulator change request.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Tested-by: Jonathan McDowell <noodles@earth.li>
>>> ---
>>>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 36 +++++++++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> index 1b4b72723ead..c0b05d2a2d6d 100644
>>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> @@ -844,10 +844,46 @@ rpm: rpm@108000 {
>>>  			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
>>>  			clock-names = "ram";
>>>  
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>
>> Why adding these?
>>
> 
> Fix dt warning, will split and put it in a separate commit.
> 
>>> +
>>>  			rpmcc: clock-controller {
>>>  				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
>>>  				#clock-cells = <1>;
>>>  			};
>>> +
>>> +			smb208_regulators: regulators {
>>> +				compatible = "qcom,rpm-smb208-regulators";
>>> +				status = "okay";
>>
>> Was the node disabled?
>>
> 
> smb208 is the normal and advised way to handle regulators on this
> platform. Some device may want to not follow that and implement their
> own regulator bypassing rpm so we add a status and on the current device
> present upstream we set it disabled as it does use different regulators
> implementation.

You just added a new node and say we set it as disabled... so the code
is not correct, because you enabled it. So again my question is valid -
was the node already existing and was it disabled?

> 


Best regards,
Krzysztof
