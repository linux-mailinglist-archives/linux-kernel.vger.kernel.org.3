Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A86D4F0AA6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353036AbiDCPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiDCPcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:32:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210F393DD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:30:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id d29so4872876wra.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=g/pOdUoD+aSLxOxunI/HD3X3dn118+KcjklCC+A61c0=;
        b=KiRNvDwwTy7V/nXZ51s+7PKUgpf7mFtIMQ1I7yvBHvWorPgiupKGZgboDKlU0bycRG
         zhCmA9IuNbrJbX5Ziyy0JodN4D6xJeZE1AxUpGEQyRd3sZEZyH0hC0WMIiFkMoNd1dm8
         mxR3odG/lCPYWhk4Ncixk/5MXMBub4wCE/jytzG//QrD+ggjRmNUtaLfPQhJXwKmHpCN
         hgllZLArzcs3h+mseXpNju2E9sMzdo3DxVj3YqZFSREbpQSkhLWXcEakjevm8YmH7Wts
         vyw7p+Ft4793ob07zsV91d7ja40sQ0LxxnySXcGcy4YdqGeeE4XIsv8vtMKMviw4ik9E
         9C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=g/pOdUoD+aSLxOxunI/HD3X3dn118+KcjklCC+A61c0=;
        b=vqsO3Oy/fNqI86QDZzcqthgM+Tmeqvt7brEzxLlbRNWUxyZQO5d9A6XPOrx4C0e10X
         1epAVeqLkrsWhdC/2MU6pFbpDv2xwZYzOeGQfAMx1KG+n+6vB/HnfWrFJyF/Ils0T+ED
         lM2NndMljCnutUq90uZak2N2Zqkt0TEqLOcgMlWrkBcPiOuuVJZ/bbvH9+xlQ1irYqIB
         4fHzseG0gxjFgzD9w8cRALNWjkxJfQegS83NBxy2m+2e2OelLkbTYu/tMFUq7798Ho8n
         /uRPgsyyGJLN1GOOTp62PUgkvFXz9c33E2jdth1pvnBGTnG17RsupTSA6xoc1VkPx13o
         4OFw==
X-Gm-Message-State: AOAM532i34eyCXCAw13xRiaCgfFi/2RidMbXN1CIuXCK7WX/h2hSySAv
        +S70R3cXmu3VAFIPdkiW2WWIUw==
X-Google-Smtp-Source: ABdhPJwwB+OVtGxMkpj7zQX5eTLsSBfBcwUVIx+fSag8zqpUp3Pma2boS8iBSUv1j9j0vft+N7t+Lw==
X-Received: by 2002:adf:e0ce:0:b0:1ef:706d:d6b9 with SMTP id m14-20020adfe0ce000000b001ef706dd6b9mr14723279wri.71.1648999808830;
        Sun, 03 Apr 2022 08:30:08 -0700 (PDT)
Received: from [192.168.0.172] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r14-20020a0560001b8e00b00205918bd86esm7025492wru.78.2022.04.03.08.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 08:30:08 -0700 (PDT)
Message-ID: <99f1181b-fde2-43a5-9b6a-c0c3a8b3933f@linaro.org>
Date:   Sun, 3 Apr 2022 17:30:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,smb2: add bindings
 for smb2 driver
Content-Language: en-US
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220401202643.877609-1-caleb.connolly@linaro.org>
 <20220401202643.877609-7-caleb.connolly@linaro.org>
 <20220403071426.GA49153@9a2d8922b8f1>
 <798f0244-95dd-cf2d-7bc5-02c72c7fa327@linaro.org>
 <20220403133122.GA49428@9a2d8922b8f1>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220403133122.GA49428@9a2d8922b8f1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2022 15:31, Kuldeep Singh wrote:
> On Sun, Apr 03, 2022 at 09:56:25AM +0200, Krzysztof Kozlowski wrote:
>> On 03/04/2022 09:14, Kuldeep Singh wrote:
>>> On Fri, Apr 01, 2022 at 09:26:43PM +0100, Caleb Connolly wrote:
>>>> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
>>>> drivers.
>>>>
>>
>> (...)
>>
>>>
>>>> +    pmic {
>>>> +      #address-cells = <1>;
>>>> +      #size-cells = <0>;
>>>> +      #interrupt-cells = <4>;
>>>> +
>>>> +      smb2@1000 {
>>>> +        compatible = "qcom,pmi8998-smb2";
>>>> +        reg = <0x1000>;
>>>> +
>>>> +        interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>;
>>>> +        interrupt-names = "usb-plugin";
>>>> +
>>>
>>> In-between new lines may not be required.
>>> And DTs use tabs instead of 2 spaces, we can follow that here also.
>>
>> The DT examples in bindings use spaces. Either two (like YAML) or four
>> (for easier reading).
> 
> ok, since example snippet is taken from DT that's why I said four
> spaces(tab) as it will be closest to actual env.

You said "use tabs", which is 8 spaces in Linux. So to clarify - we do
not use tabs here, so do not use tabs.

>>>> +        io-channels = <&pmi8998_rradc 3>,
>>>> +                      <&pmi8998_rradc 4>;
>>>> +        io-channel-names = "usbin_i",
>>>> +                           "usbin_v";
>>>
>>> Channel-names can be written in one line.
>>
>> They match the format of io-channels, so this is quite readable.
> 
> io-channels doesn't exceed max characters in line(i.e 75) even after
> being clubbed. Won't be better if kept in one line?
> This might be personal perspective but I thought it's worth mentioning.

I find current code readable. The other option would be fine as well,
kind of does not matter to me much.

Best regards,
Krzysztof
