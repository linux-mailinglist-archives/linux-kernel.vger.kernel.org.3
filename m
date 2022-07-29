Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3637F584FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiG2LdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiG2LdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:33:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB046DB9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:33:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y11so6896614lfs.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T3lyyxd0KP2STslbGMoYEWzFv8XZ5XnehzpgSY0LnyI=;
        b=P+CKl8Vclb7nppRLsuEQ4KbidbQV2Ruu443ArQM94iKZAkxacw3raTwYOEI0bzdcEA
         A9f7HiLkW4aSpW9eFi/C7uIOFaP3VViEKS0EVnkM2vvgeZp3oODP1pEwCYpsZtoO06gd
         OAmTY482BkwlvshK8K9khx5/OkUSSWEMwENv5IBoPZgwN/Td/ceiM+FcTx9g8/yFR7DJ
         RNwaN9vhx3888pB6AJyE7avLmiQT5NeldP5auJRl0+YVjl1kDVn6esYy1D+pRAGY7+j+
         7W+M8RuHHhz6iL27tvQnY0+GWGNlzt1n5Ul7XmIz9/Gsa6vQGwBzp6L0362zrqBKm2Wi
         WRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T3lyyxd0KP2STslbGMoYEWzFv8XZ5XnehzpgSY0LnyI=;
        b=sBDDt/UFBLh8g1qG4mW2QaU1/YOUvw2xPBShsfcWx/OSz9runv7J5UGUQg6F06Q3SK
         ZraNo+NJd8YtvsG6M1Vj95FShfVhidR2rc67+rC4TOryc9ee2RjaIM8qMQ6zFNlSSDbF
         OQRYt8FiYF7KTvQScsWz2dUB4soWB1FY0TT53JZiXF4q4wpHHvmcf0OKugryj3A48iYN
         t5d0rOvNgU4QwEc6PgKitA9ifdUx7quPPFqC6T/jfWNeehUKD6FLZ5ZY8EvEsJmorIBO
         1ASyh4j/JSKric+Qq6/aQO1gV5lN5/bV8xC9DIdCsO8KTpiwazRo0k7dq2ooCccNRuC4
         k3iw==
X-Gm-Message-State: ACgBeo2PSEwWf4xJeN1+ya080PKoUdJs8oJwBko3mlN/2BN1pQ+CXvK9
        thpvp+escfH6l6o5PEk3a49aXA==
X-Google-Smtp-Source: AA6agR6JOOke7r3XaAOM3ixhkIu9pO6CxBd+pt5kplHnHvvUAtmQNHvEfUPP/0ZIFYZt4+gi5HzCaA==
X-Received: by 2002:a05:6512:3b3:b0:48a:e4d5:e77a with SMTP id v19-20020a05651203b300b0048ae4d5e77amr371426lfp.247.1659094383912;
        Fri, 29 Jul 2022 04:33:03 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q19-20020a05651c055300b0025e15fe421bsm620540ljp.17.2022.07.29.04.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 04:33:03 -0700 (PDT)
Message-ID: <f932415d-3bee-0948-a016-a2e837dd7256@linaro.org>
Date:   Fri, 29 Jul 2022 14:33:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: msm8960: add reference to sleep_clk
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shinjo Park <peremen@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220728111603.30503-1-peremen@gmail.com>
 <66e15d42-96fd-5b02-b7c8-a284d3f8d21f@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <66e15d42-96fd-5b02-b7c8-a284d3f8d21f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2022 14:51, Krzysztof Kozlowski wrote:
> On 28/07/2022 13:16, Shinjo Park wrote:
>> Change the reference of sleep_clk to the same as qcom-apq8064.dtsi.
> 
> You add label, not change something.
> 
>>
>> Signed-off-by: Shinjo Park <peremen@gmail.com>
>> Reviewed-by: David Heidelberg <david@ixit.cz>
>> ---
>>   arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
>> index e8cd1c9c0..991eb1948 100644
>> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
>> @@ -71,7 +71,7 @@ pxo_board: pxo_board {
>>   			clock-output-names = "pxo_board";
>>   		};
>>   
>> -		sleep_clk {
>> +		sleep_clk: sleep_clk {
> 
> Since you touch the line, make the device node sleep-clk (device node
> names should not have underscores) and mention this in commit msg.


Then we are back to the compat issues, since the gcc expects the 
'sleep_clk' clock.


-- 
With best wishes
Dmitry
