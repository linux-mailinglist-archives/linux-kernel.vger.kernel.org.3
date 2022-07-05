Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078A566C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiGEMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiGEMH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:07:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C019028
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:06:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j21so20231452lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gvtOfLV3w59vkjhPXB0CKmZQUz8ZCCnh+m5pi29Tltw=;
        b=yFdGK76H7d4g5yVTH1z9XzJSMKrOBP5Ci49MiYAH0TuB7cE+gPlNguzCfd3wJ0pKLl
         1K6PftX9gDQJIlSINsgzlhjDcgpaVukKG3BK62aU62hpfbCYDXxPekbgz6+Jv9YwnQmK
         l8X9EVsPxj5hdCcjO1uHVz+Fohe1PopxxxDDhVIBQFlqaTNoMG8SW2EKYPp/vbe/ovqo
         zYsJmRKbfH1+ktLNjiKQc12nvv/YzQigrSLWoF3NwsPV6u5NSEVz06YXhnmIjW4cOkCa
         iRh3SYBE+FINTDQIHDYzN/sSC40SeXmLLy1ieg/joupZJsIPvmaZfMaEbn1ix66A8XO9
         Km0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gvtOfLV3w59vkjhPXB0CKmZQUz8ZCCnh+m5pi29Tltw=;
        b=dwUQrRW6fKeqmz1M2Ng4fNozbXZYm3R2BQWpFKDt/6GoCPC8OuCVC470xAZ9rwVWYg
         6kS7T32i8MrZPOT/lwGeGkaNWeN4gfkyJzJXSrXLG6lCYUiIUErd+jjYP6ythsZ6QCzj
         n9Z53yFm5LXFwCGMn16rbn631qZG6oLo0Dve6o4+WFmY3FQzOOwmo7q43GDVKWuNSDDQ
         yi4ZeLAOGYEXQZY5YeGvCvqUOGJq8UpAN/agnF989HSlM1BGHSHME1bQ4tXj9CYO8bsT
         fVA9Mwh7mB7Lh+ipp39EDtYMq/oOsfFWnXpFezzBgFwPiJWmwfBSgWN+9ZRBaDJ2zq6l
         8huQ==
X-Gm-Message-State: AJIora/4l6x92Ph8gAW+dGxI8+1Q3pUjziLPMcfTZvpRX/4X6RYir5ie
        7LkFszCAVN2OqvDCzMAs9B1Dog==
X-Google-Smtp-Source: AGRyM1tFtOB9fCIFQFFawJmwGngdoWCCZhwVtxeWNIqGg2x+SUbrZ0W7sfdj4st5IB40TYuKaFpRAA==
X-Received: by 2002:a05:6512:21d2:b0:47f:9f53:f729 with SMTP id d18-20020a05651221d200b0047f9f53f729mr22789851lft.378.1657022780340;
        Tue, 05 Jul 2022 05:06:20 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id r25-20020ac25a59000000b0048355942defsm389424lfn.249.2022.07.05.05.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 05:06:18 -0700 (PDT)
Message-ID: <6907ac7d-4970-b287-1ac6-1e47dae52949@linaro.org>
Date:   Tue, 5 Jul 2022 14:06:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 38/43] phy: qcom-qmp-pcie: drop pipe clock lane suffix
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-39-johan+linaro@kernel.org>
 <dcff330c-92ec-2302-8e2a-4ac124e72942@linaro.org>
 <76508b56-6733-b65c-d81c-31ac173780c0@linaro.org>
 <YsQnW2o4eCU8PlWl@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsQnW2o4eCU8PlWl@hovoldconsulting.com>
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

On 05/07/2022 13:58, Johan Hovold wrote:
> On Tue, Jul 05, 2022 at 02:13:04PM +0300, Dmitry Baryshkov wrote:
>> On 05/07/2022 13:20, Krzysztof Kozlowski wrote:
>>> On 05/07/2022 11:42, Johan Hovold wrote:
>>>> The pipe clock is defined in the "lane" node so there's no need to keep
>>>> adding a redundant lane-number suffix to the clock name.
>>>>
>>>> Drop the lane suffix from the pipe clock name, but continue supporting
>>>> the legacy name as a fall back.
>>>>
>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>> ---
>>>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>> index 385ea3d8de08..254ad25591b9 100644
>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>> @@ -2210,8 +2210,12 @@ int qcom_qmp_phy_pcie_create(struct device *dev, struct device_node *np, int id,
>>>>   	if (!qphy->pcs_misc)
>>>>   		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
>>>>   
>>>> -	snprintf(prop_name, sizeof(prop_name), "pipe%d", id);
>>>> -	qphy->pipe_clk = devm_get_clk_from_child(dev, np, prop_name);
>>>> +	qphy->pipe_clk = devm_get_clk_from_child(dev, np, "pipe");
>>>
>>> Just get first clock and no need for handling any deprecation.
> 
> I still want to deprecate the current name as it makes no sense and
> risks introducing inconsistencies when adding new resources (e.g. should
> they also get a bogus suffix).

And it was suggested to you to deprecate entire property... There is no
need to handle anything in the driver.

> 
>> If I got it correctly, passing NULL instead of the name would do the trick.
> 
> Ah, thanks for spotting that. I feared this would require adding a host
> of new devres wrappers otherwise.
> 
> Would still be needed for the upcoming second pipediv2 clock though...


Best regards,
Krzysztof
