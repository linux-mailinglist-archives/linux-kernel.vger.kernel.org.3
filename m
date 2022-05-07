Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5451E6D2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350203AbiEGMNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446345AbiEGMN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:13:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694894A3FE
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 05:09:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bq30so16580147lfb.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dwPQGwYOX78/2Wl83+8z+fnO4MGJ5mQqUGO35CgVNpY=;
        b=IVKPqEQb2InKCXHTHFRvsgnShsBhmaehU5E+ny4szQY410SM3vPzgCiwwUf+zepS15
         TdpxN4ZYPqUfxi9q0R4t5Rw16taZ/LsuYSHe9RwbFxFijjO2SnwvMzLh3xjRXORZLq24
         rXhVWQ0IKkKD39LSOYkmF8ldJZOAQOFnlJ3PNZs6KyY5dIjQ4O9PJ/DiJs9k/oS4j+qB
         jP6HZVpyGbLJGqVLaXKAvYZ0zSHbyXjtBEagIoRravsJFnR/jL/8dt0tzq4Yv8otfp5X
         nTdlbHR71rGM86C+TCV3MgmXZRJ6/txyyAz4XPpYdighnZL5RZ0oM4e0IswG0Lq22+7U
         BMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dwPQGwYOX78/2Wl83+8z+fnO4MGJ5mQqUGO35CgVNpY=;
        b=qXE4oM2XDv2kLDwvgZb4ZRgMzQiIbbbHnU8nOjfbRAbc7EGLjKWe0TWe81So+wuOfk
         sG72G47EoSKHBmHEb3liu8YRs1b56F1QAc/czNl5qXdmJshYPCQ46Gj5skLPxJ0Sc7Od
         vy8SJHzcX5UA/3id1L0jHM/Y6g5eE2+mSviot1WeHYH1/msjI0LflYFWjJG1t9tOtPE1
         Za5PkbkB6XlpS1J/p/fuO8rf2FPz5uGkEoSTPedAWwJid7TdgVdkj4IbSCyN+ecp+uwM
         OoMZKbUiKupnj01HJzJO0ZHdDQRxaGZaoc+kz9YS65l6D8AmSMVRvpzXZbahD8k6a21L
         /RlQ==
X-Gm-Message-State: AOAM532cqpKV/2FnNYfP+i9jz4qruO/+DAfPJ9WLsdK2NURWzBfmRAJt
        FXEXaffNOrn4LiSTAnN3S/GnGA==
X-Google-Smtp-Source: ABdhPJzzbkDhvl8bNtspXcuzOi4bRZ3x37FxH3e90OFZxBBQIyh2Iz6ka1k7KoYniuM1SUbAtRDEeg==
X-Received: by 2002:a19:5f51:0:b0:471:f43a:d830 with SMTP id a17-20020a195f51000000b00471f43ad830mr6273070lfj.348.1651925374751;
        Sat, 07 May 2022 05:09:34 -0700 (PDT)
Received: from [192.168.43.7] ([94.25.229.149])
        by smtp.gmail.com with ESMTPSA id 14-20020ac24d4e000000b0047255d21117sm1086527lfp.70.2022.05.07.05.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 05:09:34 -0700 (PDT)
Message-ID: <c2a9f0c4-1d77-acca-c319-c74ef51d9ed3@linaro.org>
Date:   Sat, 7 May 2022 15:09:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: (subset) [PATCH v2] dt-bindings: clock: qcom,gcc-apq8064: Fix
 typo in compatible and split apq8084
Content-Language: en-GB
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ansuel Smith <ansuelsmth@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>
Cc:     Rob Herring <robh@kernel.org>
References: <20220426064241.6379-1-krzysztof.kozlowski@linaro.org>
 <165184936433.73465.8918776302755169232.b4-ty@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <165184936433.73465.8918776302755169232.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 18:03, Bjorn Andersson wrote:
> On Tue, 26 Apr 2022 08:42:41 +0200, Krzysztof Kozlowski wrote:
>> The qcom,gcc-apq8064.yaml was meant to describe only APQ8064 and APQ8084
>> should have slightly different bindings (without Qualcomm thermal sensor
>> device).  Add new bindings for APQ8084.
>>
>>
> 
> Applied, thanks!
> 
> [1/1] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in compatible and split apq8084
>        commit: 4ac7e878c15781286c043cff19ec88d82b8e2014

I supposed that 
https://lore.kernel.org/linux-arm-msm/20220426093608.2957210-1-dmitry.baryshkov@linaro.org/ 
is a slightly better version.


-- 
With best wishes
Dmitry
