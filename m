Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA265B2269
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIHPfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIHPfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:35:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1C66BCD7
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:35:08 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so6970484ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=8OzZ5Qs/lq21s5oBO2au1T9ozqLApEhv1uI4lX4d/8Y=;
        b=ftozKavWAs025mUeUmoP4qVbN/G+5+94RV5cmOqszL8ZKl4bKVuc+ZBCpmvwz9SjVZ
         VcKK8LwgJJD2Fa8Yn4lij10yek+JTEBHuhC+6YYTb08TSWvRGH7aquE36sylSguDiq30
         gD8GVKVgOjyQGfyt0jEzRi257E7/8PJlSIuNjSNNqZbKq3SO+u5sJNoSq209Q1Aek5J9
         2JioNdMukgRUJIzc7lbxnJvKbHQezJlBXG3/l1xegEXpglBrGdd+MpEjybDI2sNFij1W
         WHYO3n+7bHUZ2gVBluwS0tms35S2pa1Hso6nIkmfQdrPpbsztglxtDeSkcxFhftwH2Po
         73jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=8OzZ5Qs/lq21s5oBO2au1T9ozqLApEhv1uI4lX4d/8Y=;
        b=SRN1zVVBBrDdRh7YrArTuwS915/fmT8ihRpWyBGt2prjJb4uFyv2tILt9m9IogbWNN
         ptns52/haG/xckTN/lbXeo7qoM21qdQN8gBArU4NHJe69Z0oITpqSlL3sJ8m4S1uaan0
         jAuh+YQ8MWPUQdtnRU91ZM8YZGfF0V6Jl4WGG1S/evTEClh8HV70hcWRk7eAhz/UpPYP
         Z2mzS2Ruta+UV9gKVyJcKArWMRIjmKH7qyDDmYL7Nu9IucTvi6yDdPoUGa7hcy2CEYWV
         QRfpmdO0zloySk0NdPuh8NDfk4mueK55l9whwMBbzxlGP9/zIxvgWXMjjkb1Z6LcGhN3
         R4bg==
X-Gm-Message-State: ACgBeo2AUNi6QXuQ0B4SdHoD3ECI6Ko9xIPj2KOO8T+iD3HrhNYXMbxj
        u35Y/YhYUQ5ExXBhAq4x43S+0g==
X-Google-Smtp-Source: AA6agR4ghr1ypXn2wb8f2Ux4j27NXPtCXRt7D4eCpNLaE4gxTa/3rNmpCKFnlb2c1ixMLtT4uDnsQQ==
X-Received: by 2002:a2e:8749:0:b0:25e:4357:8ef7 with SMTP id q9-20020a2e8749000000b0025e43578ef7mr2811610ljj.319.1662651306929;
        Thu, 08 Sep 2022 08:35:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e4811000000b0026ad316375esm566887lja.38.2022.09.08.08.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:35:06 -0700 (PDT)
Message-ID: <e4337c1d-e579-a200-35c3-7ca9d0a0ba12@linaro.org>
Date:   Thu, 8 Sep 2022 17:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFT PATCH v2 02/17] dt-bindings: mfd: qcom,tcsr: add QCS404
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
 <20220817145901.865977-3-krzysztof.kozlowski@linaro.org>
 <YxmetuNRIgDhutKv@google.com>
 <9abc956f-17c7-60c9-4672-d62fe581f516@linaro.org>
In-Reply-To: <9abc956f-17c7-60c9-4672-d62fe581f516@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 10:15, Krzysztof Kozlowski wrote:
> On 08/09/2022 09:50, Lee Jones wrote:
>> On Wed, 17 Aug 2022, Krzysztof Kozlowski wrote:
>>
>>> Document new QCS404 TCSR compatible.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Merge conflict.  Please rebase.
> 
> I will rebase. Can you check if you pushed your tree? I see updates 3
> weeks ago here:
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/

It seems latest next also has your old tree from Aug 15, so on what
exactly I should rebase?

Best regards,
Krzysztof
