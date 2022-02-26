Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680584C58B4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 00:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiBZXjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 18:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBZXi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 18:38:59 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80923EC61
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 15:38:24 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v28so12330984ljv.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 15:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L77jjy3Pjb6haSmnZfnNmFgIofaBblWDltlBIh2LtP8=;
        b=ksCenEYJQP77iJl3VqiJjoJeFeq1I9QMUm9fBePnf75SO+2P4R5mUgZ2dv3tKUFnuu
         gar7ZtWVt828sugg+VnjuYXnlA7qzZVyxJ/2Fc+Wjuq4KHtxJ0pKzrAByvjmsM6JlnqZ
         o3WODvJDdShjW1l2b8nEOAU6Jfe/fzCXXKDuCF6N6sA1IHoRNmPLjt+RqDAg2H5bf3tY
         LCjY63dHcBz2Zl5OxOMr0PeQmKwW2ry49C2tXCnEXCRwy7A7FgqnlQ8YOxCxkHfhq120
         2UqBGKjlKA8KKmGeZBCTcW2qvmwr3Heq5LdFUYauq5193lbCmssb9S8fYYA5VgSjT+Lu
         bCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L77jjy3Pjb6haSmnZfnNmFgIofaBblWDltlBIh2LtP8=;
        b=snpnpZqbNzir9OtOyfvtX1iNYVQDQABssRMzpnOqVCM//pmKWXRrZsY5blVuepD4KZ
         5OCjvrvEFsPw6U+ZoUj8+Y35YnVBxj7ZGRSc2YcuLVKI24QaNnWCTCuXq/qm7FutZ/aQ
         0bSvITJ5WrpY82Kms54TKphyXTMMbcPYGmBCEjPkDIa96SKpjqwPaeZSED647neik/2v
         jcCzpF4ATeFMNO70Wz90/k6FkPO/vp0xmihLsRK4XioPM8adOGT0V6McySAhPPwugYT4
         UHH4QDuGdafqskzdUYlosoRGDKHPKOZD+B9cqZWG28+B/DuuY3AtnfV8Q9Z5uZ2fq56C
         7STg==
X-Gm-Message-State: AOAM532lrix/MFASQuV/Xk/6f8TUE0IhOlbRWeU71w0f0TPFWUWPgdP1
        l34ach0VRDaqvHTw1PIfCtxU0w==
X-Google-Smtp-Source: ABdhPJzI6jlwWxLLswkwolfMTDkejgzveyClOap+Ur9bxPwPT/5fOg85P4oWWg1y+wDGzOu5nl5a9A==
X-Received: by 2002:a2e:7007:0:b0:246:2b76:31a with SMTP id l7-20020a2e7007000000b002462b76031amr9992267ljc.397.1645918702617;
        Sat, 26 Feb 2022 15:38:22 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b3-20020ac25623000000b004435fb1f5basm550208lff.78.2022.02.26.15.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Feb 2022 15:38:22 -0800 (PST)
Message-ID: <a6d28a2e-69fc-9bdf-da0d-28be35d9bfc2@linaro.org>
Date:   Sun, 27 Feb 2022 02:38:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,qmp: Mark '#clock-cells' as a
 'optional' property
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        robh+dt@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20220224123248.67073-1-bhupesh.sharma@linaro.org>
 <CAA8EJprRgsZRSXBQumveAn029j+w6xO8K2kZUO4rzZaefuYe7Q@mail.gmail.com>
 <CAH=2NtxQBS=c0W0cpX5EdNi12PrqiKEuzyvEtF8WrVE6nsU_rg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAH=2NtxQBS=c0W0cpX5EdNi12PrqiKEuzyvEtF8WrVE6nsU_rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 25/02/2022 12:16, Bhupesh Sharma wrote:
> Hi Dmitry,
> 
> Thanks for your review comments.
> 
> On Thu, 24 Feb 2022 at 20:22, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Thu, 24 Feb 2022 at 15:33, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>>>
>>> Since '#clock-cells' is not a required property for several
>>> QCoM boards supporting qmp-phy(s) (for e.g. sm8150, sm8250 or sm8350 SoC
>>> based boards), mark it as an optional property instead.
>>
>> I believe the description is not correct. the clock-cells should not
>> be used at all, so it should be removed from the root node.
> 
> Hmm.. 'clock-cells' is still used for describing qmp phy pcie nodes for certain
> devices like 'msm8996.dtsi'. I am not sure if removing it would impact existing
> dts files. But let me try cleaning them up in v2.

Checked. Unless I'm mistaken, msm8996.dtsi doesn't use #clock-cells in 
root QMP PHY nodes.

> 
>> Also we should describe phy@ properties.
> 
> Sure, I will add them in v2.
> 
> Regards,
> Bhupesh
> 
>>>
>>> This fixes the following '$ make dtbs_check' warning(s):
>>>
>>> sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
>>>    '#clock-cells' is a required property
>>>
>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Cc: Vinod Koul <vkoul@kernel.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>   Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>>> index 9e0f60e682c4..746a929c63bb 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
>>> @@ -115,7 +115,6 @@ patternProperties:
>>>   required:
>>>     - compatible
>>>     - reg
>>> -  - "#clock-cells"
>>>     - "#address-cells"
>>>     - "#size-cells"
>>>     - ranges
>>> --
>>> 2.35.1
>>>
>>
>>
>> --
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry
