Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207AF568B9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiGFOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiGFOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:46:20 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7525594
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:46:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n15so18728932ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IhSxVhqpX3UwoPfQmBLHBbn1hjY46iGBhEtwBN0p8yU=;
        b=UXf4Y0Lbqeww5heIfP2QQosKVF2kE1LMgupiMapeiJIjdiSfXdzp+t3tVxAL3ggZjj
         ohonlX7DlRVWaFTfQu5KiaCLKMSukIxnL3l35+omSaUtZG19gfqIKg5Al/3MjWw8Jw0O
         tLEDMwDp7wEk9nF7dHHQmPCiFymJGOOvmHeydYKirWIEaczi51lX0xOputWjTGMImDcG
         5T4bGw9m520uLHfhb9AZo35z5874afh2vbZf8/InaiLvFJWxZNePLnESewgen2XXUFuO
         K4/xYVN8JI0bF9+h7efLY5CTnG74dhNjyvq6qNw38vGIPwT6P0UNzSFV/1MvAkpPIoFk
         XHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IhSxVhqpX3UwoPfQmBLHBbn1hjY46iGBhEtwBN0p8yU=;
        b=JtHcKVn4bd++9J2FwjYJanhDym/maI6HAjxxd+INHr4unWa0v/mZRqRscfEDteCSaC
         eBwZUgk8nMik2v4jCL7WK/Q9ZWMvvhlvsMz6cTrqxuwtSvKf+c1/HcV7Iq5b8xg9IE4X
         yZ82JOAkE/fQ/sS71IPGP1I8RFkobAuOHDNtjaCzCblxUuSeQ1sS9OqhTAtBQT97PT50
         1ncbTqyFZ4f9XBeAg0EzlJpdvPxuVfZ3rfNZzfoQsLIKVXy+OJrJimWI2yQxFRlSJiHY
         rFUayO8nEtYPNVIDa/JEA/VBmCFY2jnD1qY/umX/8i2vDct6biTm+75iJCQ6Iwh3uY8b
         p3dA==
X-Gm-Message-State: AJIora+jAixPlHAVM/7yv/pLcJBCMWSb1Q+wNYz3bN4xriJMfZCwkDvC
        olNsLND2lM+oFsqXgtWeu8DSZg==
X-Google-Smtp-Source: AGRyM1ucQO0LFc0I0mVG4sFN1EGeDHBo4bM4yN1D4I0bXjHzBjss7dTvUNvmRvoRbxGs0nsqdVaF5Q==
X-Received: by 2002:a2e:805a:0:b0:25d:3f51:3cac with SMTP id p26-20020a2e805a000000b0025d3f513cacmr3466789ljg.30.1657118777634;
        Wed, 06 Jul 2022 07:46:17 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s16-20020a05651c201000b0025d41c09dcdsm610300ljo.96.2022.07.06.07.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:46:17 -0700 (PDT)
Message-ID: <6b61116a-0465-9687-33bf-9b36f0ef90cb@linaro.org>
Date:   Wed, 6 Jul 2022 16:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/13] ARM: dts: qcom: add smem node for ipq8064
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
 <20220705133917.8405-10-ansuelsmth@gmail.com>
 <c5bf6246-a350-8a87-71bc-bc13d502a8af@linaro.org>
 <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <62c56477.1c69fb81.8ec4c.f1ac@mx.google.com>
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

On 06/07/2022 12:14, Christian Marangi wrote:
> On Wed, Jul 06, 2022 at 10:39:16AM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 15:39, Christian Marangi wrote:
>>> Add missing smem node for ipq8064.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Tested-by: Jonathan McDowell <noodles@earth.li>
>>> ---
>>>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> index b5aede3d7ccf..98527a7d885e 100644
>>> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
>>> @@ -908,6 +908,11 @@ lcc: clock-controller@28000000 {
>>>  			#reset-cells = <1>;
>>>  		};
>>>  
>>> +		sfpb_mutex_block: syscon@1200600 {
>>> +			compatible = "syscon";
>>
>> syscon alone is not allowed.
>>
> 
> Mh... This is problematic. How this should be handled?

As usual - add specific compatible.

Maybe I was not specific enough, but my commit was under compatible, not
under device node, so it seems obvious. Just in case it is not obvious -
you cannot have "syscon" compatible alone.


Best regards,
Krzysztof
