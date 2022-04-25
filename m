Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B550EA88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245335AbiDYUcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245438AbiDYUb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:31:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3C6308
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:28:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so14768269ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wvQYRS1pWv21ehmcnJxWSnYJsytlKQ2x5bcgfTp8r5E=;
        b=E0AIy0zXFuolgxRDb6PvDyvlBJBmvpqPHHcjwYTOkAWDEUeIUtIAo/PcJH+Sqz4TQw
         BygwGSFokKDLhRDupuKtC+Sx2WpgzowmMxZ1481MaNrRoA8VdiIpmYLpfulvqPM3Aaqd
         8W+Cs0N+RIrgubsLqEi7loNgGPcNvMbYEv5GIJu8deV/2nKJjwqS3Z8S8CwZx4WFtbHc
         jRKGWVem2UtxgqJkGzaRvc3vKAHN+hpuOipNzr/0icY8AJxL5zNRntxCyIBXmpe3JtB+
         +L9t1qxTai6pqXw/c7GTAMezs/b8j4yPrAJX25C3WratWnWYCHDYLgkv4LztKutixayI
         V3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wvQYRS1pWv21ehmcnJxWSnYJsytlKQ2x5bcgfTp8r5E=;
        b=dxAHxyNtXNum86bceBAXCD/EOfh3PeKrZnDOPTZZwes/rrC+mnggbOBsPNaUZSS4bE
         bZudbrOsh/cIbKNftDYUNfrZYfnU5v8QtgsrFntBSeoKJgDnBmMQCtGl0mvA5hk6Hy07
         47YrZ8hGR12aRwUTjYKr9LvDJ1tyPAj3SrFkhzp3atmbUD/wAyEDAYXyr1YyYEGmmnoz
         GmlQ2Gg9FtqUuBf64a5uNhpCv+C2DfBHIdbyFumyGBXAhJXdsjCQYarRY462XFgCY01O
         rc9MD2HyEW6BZEiAZp5IYdsU4+E92Vz12Qceii800IO67hUHLWF79jF1eIMjLHC/NTSU
         NtSA==
X-Gm-Message-State: AOAM531fpSc7nJoj5ICSe8XG8ZxZgixE2syhxVJSwIhTyJZ8iWwwU2ag
        f3Xoj8uCSOCi5UyCLvmGm1M1rw==
X-Google-Smtp-Source: ABdhPJxRiXQdrMEZ1bEiijQmU3oSqmhzoZsPoezAg48UIyxDJ1owz8UIf9lbzN8JjioalA7frYn1kA==
X-Received: by 2002:a05:6402:26c5:b0:425:f7f0:fb6c with SMTP id x5-20020a05640226c500b00425f7f0fb6cmr1385802edd.133.1650918530508;
        Mon, 25 Apr 2022 13:28:50 -0700 (PDT)
Received: from [192.168.0.244] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm3893124ejn.130.2022.04.25.13.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 13:28:50 -0700 (PDT)
Message-ID: <8db5f7cc-dbad-3636-0fd2-7d6dc29ee409@linaro.org>
Date:   Mon, 25 Apr 2022 22:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: clock: qcom,gcc-apq8064: Fix typo in
 compatible string
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>, Taniya Das <tdas@codeaurora.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220425133527.3723233-1-robh@kernel.org>
 <20220425193253.06828C385A4@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220425193253.06828C385A4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 21:32, Stephen Boyd wrote:
> Quoting Rob Herring (2022-04-25 06:35:27)
>> The compatible string should be 'qcom,gcc-apq8064', not
>> 'qcom,gcc-apq8084'. Found by enabling undocumented compatible checks.
>>
>> Cc: Ansuel Smith <ansuelsmth@gmail.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
>> index 97936411b6b4..9910a3e033bb 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
>> @@ -25,7 +25,7 @@ description: |
>>  
>>  properties:
>>    compatible:
>> -    const: qcom,gcc-apq8084
>> +    const: qcom,gcc-apq8064
> 
> This file has dt-bindings/clock/qcom,gcc-apq8084.h referenced. Should
> that be removed? It looks like commit a469bf89a009 ("dt-bindings: clock:
> simplify qcom,gcc-apq8064 Documentation") took the more than just the
> compatible for apq8084 from qcom,gcc-other.yaml and put it in here while
> removing gcc-apq8064. Probably the apq8084 part needs to be a copy of
> the apq8064 file with the single compatible changed.

Good point, Rob's commit removes entirely qcom,gcc-apq8084 compatible,
which is and was used.

Probably the intention of that commit was to merge apq8064 and apq8084.
The first uses dt-bindings/clock/qcom,gcc-msm8960.h header for IDs. The
second has its own headers, added in mentioned commit.

I am not sure it is worth splitting this into two files. Adding here
enum for 8064 and 8084 should work fine.

Best regards,
Krzysztof
