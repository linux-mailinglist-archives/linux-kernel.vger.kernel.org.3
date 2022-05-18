Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596E352B3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiERHpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiERHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:45:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F53119906
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:45:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id w14so2088891lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l74h/9CSiIDFDguTV3SM7WBot9s5H63otpdl0O2qedY=;
        b=hSNow+0C8TVnZfavy5d09sBUSkgiBsgb18B7328vv3QwqfbSjN9XysU6AWY+W//nvW
         jNFlzo+OtIb0KAbTtFcw3qNACx2EeKwAM5kBvZZARfWUds5uOgqLIgiWSriVzvw6LMCy
         Rp7LBrSrWL2o5F8J6SJxp3VOkipzKQW1JDk1y+BiN3GD9/Qj8XO3/54PnMypEFsB9fcv
         a/Jdy9WiciUN4rFiJ0oIbMDeCubfbdKIBf2FU5qqlF8xRcnW3T3YtnY8bh/WvS/Ayb/J
         UxHxg0TxKznUAvIdXiTbX/ISolHwQHdtR9T8/w2LYArmmcxqBKTWtmwfUXRZTB6qpJef
         2SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l74h/9CSiIDFDguTV3SM7WBot9s5H63otpdl0O2qedY=;
        b=nXVuLQiH0Gvij5v6miQulr1A2Z8My4FvoWNCtnYnmgd9NGpUuSdblQ9EUOb00XjkaC
         sW1F54c59zS5fDdeYfSd3Gz9gyICxlu020Y2/J4hg5SMCfZe19+mhPXQfDfsR1iJEbX2
         q24TTXxGj7wFYz9wbcYjhTmiFDFbTnfAfytvlQZUSN3wYvJistcjPuTaRG2LtlgznyxM
         9o5K+PzjD7N/cz5N0/cTcCeFye0V8KBm4S2VenNxQ9m0lJDHbSZsGTLQdKupCgJxlq9z
         WBfTZo/ZkosJ99TvDTzBZ0PtFv/KGPcjJwhtbTKKovPBfGWi3PUKgkM86cBrfihF3EJN
         DP/w==
X-Gm-Message-State: AOAM531SjTXD2X8738cWGpUgupRVIrKjM4/u9EBwRZ3doe+YMkxpTq8T
        B6ZeinF513OXORhETYkMhl5M+w==
X-Google-Smtp-Source: ABdhPJxC7DaRfGoMH6mGwh5VEtuC+9o0de1TBsaxiwBhEaf0Q3qzSEaH4Xy9KVTb46fMKsddaSrUog==
X-Received: by 2002:a05:6512:66:b0:477:a1e0:8a4 with SMTP id i6-20020a056512006600b00477a1e008a4mr5090208lfo.590.1652859940619;
        Wed, 18 May 2022 00:45:40 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u15-20020ac24c2f000000b00477b223ab3fsm126459lfq.167.2022.05.18.00.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 00:45:40 -0700 (PDT)
Message-ID: <92258b87-824c-79cc-c775-972018c45c87@linaro.org>
Date:   Wed, 18 May 2022 09:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/6] dt-bindings: regulator: qcom,spmi-regulator:
 Convert to dtschema
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
References: <20220517120000.71048-1-robimarko@gmail.com>
 <12093e84-49b0-d36d-cfde-08ab8af3801c@linaro.org>
 <CAOX2RU4PpTQJUNkDremkhfdPG-=1NbG5xLmu22zFSOrqKMce5g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAOX2RU4PpTQJUNkDremkhfdPG-=1NbG5xLmu22zFSOrqKMce5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 22:58, Robert Marko wrote:
> On Tue, 17 May 2022 at 16:47, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/05/2022 13:59, Robert Marko wrote:
>>> Convert the bindings of Qualcomm SPMI regulators to DT schema.
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>> I am aware that syscon alone is not really acceptable, its converted
>>> directly from the old text bindings.
>>>
>>> There is also the issue of some MSM8994, MSM8996 and APQ8096 devices using
>>> '#address-cells', '#size-cells', some even defining reg property for
>>> regulators.
>>>
>>> Any advice on how to solve these issues is appreciated.
>>>
>>> Changes in v2:
>>
>> Changelog goes after ---
> 
> Ok, will fix up in v3.
> 
> While we are here,
> any ideas about the DTS-s that use reg and #address/size-cells for
> regulator subnodes and syscon?

Ideas for what exactly? It looks like a more of a subsystem convention,
whether to use unit addresses for children which are not real devices
(LEDs use unit addresses, regulators do not).

Best regards,
Krzysztof
