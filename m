Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C95AFF01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiIGIbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiIGIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:30:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB3BA2A9D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:30:57 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id p5so2047159ljc.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HoBu5pVRP0QlH9IyjF/UfBIe/8xVli1mPMeUsv8Z2sM=;
        b=wHxxXgOaPb0hNl/IJP0P+lOmntLkVF5Yp02OoLnxprSjola21wH2Sl47pU32q2dEho
         v3+4xYTvBKFcabjwfshFDu0V4rOeDzT3vKP9BSN8wBi2n9N6o3VUuZfJk/9aOwCYHmYS
         5eRenIKcxScpXLtxpeCdsc/9q4pQJpl15dd9hAKleqeKpx4MORzmNLoMRNLVAhNC1QwY
         qZicXyBsxF0+0bya/Y9S+aegK5DaKN8X4Qdys0tu7Xhud+l8RuNJUr6xbMxR2ORhwojl
         mHh8GyIqGcK2PxlP+L3WZR89c+Ov+L4rmZVitja4c5prSHhoLVBW/wi40zB+JmsxLgFd
         155Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HoBu5pVRP0QlH9IyjF/UfBIe/8xVli1mPMeUsv8Z2sM=;
        b=07StQ3uy81doWq6xrlUEIXtfk9WvN4CKhhzmhLH+3F29gh+LVSK2HqTsmHLV0OdHU+
         jv4m0DNE5pnL/YiyguF/ii8O+uUNcbzxIXtDsAo72T7GvKjkOQfhYsUl7DpJW9kIsFGD
         I/oHrKJHmdHLjffUt1iyCAtUpsmud8q216yykYhhdgJYHUCtU1jdEJ9KXHkTAqFE1u59
         vUYU2d/38LSYE6KvOCsGDW9+ST97X778zrywHMULs4gMjmyuDAZmpoLbLnxFFg7q4RDJ
         auf8q084RIsZhSOcww1TnkV4kXlqcf27F5Ul/7N5NUH03COoqVwglSD9WUwApLDBVaEu
         zYPQ==
X-Gm-Message-State: ACgBeo00JxjBpkcoBMRJn+E/hP7xBn14dtu2obk//+ZBpNg5rEIv7xES
        ioQYDF7IP0pusAKKDszFlQaCmg==
X-Google-Smtp-Source: AA6agR7IEanWZYdcRnIeSyrGPg0ZoBPFDp/3VMgyRg9nCW7WCbetSuOiEUA1I1IqmDBXvZBOXapokw==
X-Received: by 2002:a05:651c:12cb:b0:25b:fa3f:c3f with SMTP id 11-20020a05651c12cb00b0025bfa3f0c3fmr681462lje.364.1662539455364;
        Wed, 07 Sep 2022 01:30:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p15-20020a2eb98f000000b00268d84f8db1sm2467364ljp.92.2022.09.07.01.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 01:30:54 -0700 (PDT)
Message-ID: <7f91afa5-b5bf-4f26-c540-a04e52825248@linaro.org>
Date:   Wed, 7 Sep 2022 10:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/12] dt-bindings: soc: qcom: apr: correct service
 children
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
 <20220906121655.303693-10-krzysztof.kozlowski@linaro.org>
 <1662486402.667876.780014.nullmailer@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1662486402.667876.780014.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2022 19:46, Rob Herring wrote:
> On Tue, 06 Sep 2022 14:16:52 +0200, Krzysztof Kozlowski wrote:
>> The APR bindings were not describing properly children nodes for DAIs.
>> None of the DTSes use unit addresses for the children, so correct the
>> nodes and reference their schema: clock-controller, dais and routing.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/soc/qcom/qcom,apr.yaml           | 38 +++++++++++++------
>>  .../sound/qcom,q6dsp-lpass-clocks.yaml        | 16 ++------
>>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 16 ++------
>>  3 files changed, 35 insertions(+), 35 deletions(-)
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.example.dtb: gpr: service@1: '#address-cells', '#size-cells', 'apm-dai@1' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml

I missed one more place with example to fix.

Best regards,
Krzysztof
