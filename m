Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25214596EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiHQMky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbiHQMki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:40:38 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BF8A6C4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:40:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r17so18827172lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=PNAKEEujSpper4OLN5pxdxOYzdQxS561gWpyJ1Oic7w=;
        b=IcZ49Qs7N3kOAdpQ6wrGPV9y3u7tp+Rs32w7KgDojPKBtdrL4WVhJeJQJWcunc0VH+
         7myktMEiCebo+/jcrQEPAxp83AzcFm/F/6f4oVd6BBSBZwUJpdncQlwrf96f4enUi/2f
         k9rO5aoalJgGjMsjs0ShAOxgBPHIMZG/VTpJvepl8t1AdwV0/jiHs/kQqcgPFY/h+KyB
         dtxruz4PjlB8Iun86mPba0s2Kr53iyh1FFDL9bk5OxFIvbpwNOnqG2CMimZlSJcVbpQk
         sGaAi/FzrFn/pGWBVt0OooNPW3QU5Z0BOjODZIR7v9XN+5oQKZdkesv8EMrmYU9ccw7A
         i0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=PNAKEEujSpper4OLN5pxdxOYzdQxS561gWpyJ1Oic7w=;
        b=z6JYiRE5SyA/xf1vmUXhrKfRJmSpwUSvkrkaxyLo7Lo3s7JCrVXEjAeI6A80moPf3j
         KvH+JflYW5Mjmga9z6st1wBqv9z+GjX7NjgHrOIL0YRkqfOpDRSMdX3FFYmaD+oPv5xj
         HSFIno2iVDR2bVR3drTKXC8PsuNlwmEbi94Jf8tZhAoSjQtmtidT86VMOnaX8dRCs3DZ
         Hl52amOUVYGD+FucP/x00cV7aseVjQVRD+KJWBXQ3jVApbfyrgGwAbs13yk880Db8lb7
         +cSLY8zTxR3A/BS1EtDQFnPaGZkweEmWPmbCbwxEDa/VwXr3m/BhJM5zN7c6mAt1rZIG
         C37Q==
X-Gm-Message-State: ACgBeo2/Q5tg8foeqsdynG3jym6Nn7XAvw6MSi2nAeKQ3yUNduAL2UXW
        xwIgBGEEDrm84v9DBu/+kKyMCw==
X-Google-Smtp-Source: AA6agR4pQ9T3xa2Nfv2boQQM8tnKnXpy4/G9WORRecm6pRcIpnj3bINxdlldATmPFdSnJ1YsyME39A==
X-Received: by 2002:ac2:484e:0:b0:48b:1d04:e37c with SMTP id 14-20020ac2484e000000b0048b1d04e37cmr8965756lfy.320.1660740033547;
        Wed, 17 Aug 2022 05:40:33 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ae:539c:1b1c:14b7:109b:ed76? (d15l54h48cw7vbh-qr4-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1b1c:14b7:109b:ed76])
        by smtp.gmail.com with ESMTPSA id q12-20020ac2528c000000b0048b9a0c2b99sm1674486lfm.97.2022.08.17.05.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 05:40:33 -0700 (PDT)
Message-ID: <f65be4ff-9dd6-55b0-45c2-5788102f281d@linaro.org>
Date:   Wed, 17 Aug 2022 15:40:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFT PATCH 06/14] arm64: dts: qcom: sc7180: add missing TCSR
 syscon compatible
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817120403.458000-1-krzysztof.kozlowski@linaro.org>
 <20220817120403.458000-8-krzysztof.kozlowski@linaro.org>
 <e7c29e37-3ff8-775f-292f-a87e419ac3ee@linaro.org>
In-Reply-To: <e7c29e37-3ff8-775f-292f-a87e419ac3ee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 15:38, Krzysztof Kozlowski wrote:
> On 17/08/2022 15:03, Krzysztof Kozlowski wrote:
>> TCSR syscon node should come with dedicated compatible.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index b82c335c25af..49f28cb531f6 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -1468,7 +1468,7 @@ tcsr_mutex_regs: syscon@1f40000 {
>>  		};
>>  
>>  		tcsr_regs: syscon@1fc0000 {
>> -			compatible = "syscon";
>> +			compatible = "qcom,sc7180-tcsr", "syscon";
> 

This one is good, it's my other patch with an issue.


Best regards,
Krzysztof
