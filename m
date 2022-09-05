Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D155AD7D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiIEQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiIEQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:47:40 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0348D61D5A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:47:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j14so13857284lfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MRtxshIY33MrmaP4gwUku88eHsV85/eQJrthZbd/ll8=;
        b=Q9btPcyLPZQwVyFkE8H1mnDuwqX7UfR3Wv9Xi5BIVqPqe4JYK3A9KlhV9d2kDgDxuu
         UxwH/XKMJ/FzTHZcM4bGrzDnyAqNVDbRJmjYWOuDrR7xuYvw6VnUrFP24F8mMDaGQ3Lk
         cpw3W4dgSkp6+rmqMKzPsMbjLEZ+d9GoAKccS8x8ef+T1EcjW+MqBHvRZzk4IXs6hfDo
         I01X/ubz9XOwqthd39IvkVBmGU6dKW4s06Wh+kFQ6A6dFu+FVIwc9NyyjlZYIEqu8dl4
         jiZ30rHmvdLV8/h9q0/CDkRu5hJoKHu5tqGIobjgenGdgplwfkZ00vhrtCNbiKfHMZN0
         DmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MRtxshIY33MrmaP4gwUku88eHsV85/eQJrthZbd/ll8=;
        b=34xi1k0YYyVW4qAFpqFyaLv3Cts/tW3hBQD1KBjqWV0dAZnWsqsFdTbCl2BLbMZ0v3
         2q9WOJ43ZK1TYhk93nuSYeK7n+jZzbILp4LGYa2VbrrFbNaiWmll7exxpom42Qj8egI+
         vbGf01mx/JgKkAxTre+ItGBB3bDZd6bde8V6brrsoGjI1rX3l1R4p51SJEfc1WUvsR0W
         gMaFeA7PaY2AQAtZ86XqGMsrlrWQygHwRKav5klPnRit16SDj62jb+LikaefVAXBWCsY
         Hb0wh6qf/VU21fwnmxGcP5oVm8LaIUAP80PN7BVLPRLQXEqcif490q6P/aLFyn6xLnsx
         XU7g==
X-Gm-Message-State: ACgBeo2UVyq48Sf1ahgcqkNF5A1GQPqPvKgS4/FY7pzP2NIcWU5tpOUg
        eRQVjm9R7t3qLgOPn8pfrUwvWQ==
X-Google-Smtp-Source: AA6agR53M9zdoa3lzE+TzOTpcWG16+H2aovFcD0X3mZCa81+DFQjWYtK7Wf8IF05YJvc5n3FxVxHYw==
X-Received: by 2002:a05:6512:39d1:b0:494:7698:8ae2 with SMTP id k17-20020a05651239d100b0049476988ae2mr9855265lfu.407.1662396457395;
        Mon, 05 Sep 2022 09:47:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s19-20020a056512315300b0049465db4be5sm1243496lfi.34.2022.09.05.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:47:36 -0700 (PDT)
Message-ID: <a49fad1a-f7fb-921e-d0f5-e1edb3f86f7c@linaro.org>
Date:   Mon, 5 Sep 2022 18:47:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] regulator: dt-bindings: qcom,rpmh: Specify supply
 property
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dianders@chromium.org, johan@kernel.org
References: <20220902185148.635292-1-ahalaney@redhat.com>
 <20220902185148.635292-3-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220902185148.635292-3-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 20:51, Andrew Halaney wrote:
> The top level RPMh nodes have a supply property, make sure to specify it
> so the patternProperties later that are keyed off of the PMIC version
> are properly honored. Without this, and the dt-binding containing
> additionalProperties: false, you will see the following when running
> make dt_binding_check:
> 
>       DTEX    Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dts
>       DTC     Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb
>       CHECK   Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb
>     /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.example.dtb: pm8998-rpmh-regulators: 'vdd-l7-l12-l14-l15-supply' does not match any of the regexes: '^(smps|ldo|lvs)[0-9]+$', 'pinctrl-[0-9]+'
>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
> 
> That supply pattern is intended to be considered correct for the
> qcom,pm8998-rpmh-regulators compatible, and is no longer complained
> about with the supply property described.

Which supply pattern?

> 
> Unfortunately this pattern is wide enough that it no longer complains
> when you bork the expected supply for a compatible. I.e. for
> qcom,pm8998-rpmh-regulators, if I change the example usage in the
> binding to:
> 
>         vdd-l0-l12-l14-l15-supply = <&pm8998_s5>;
> 
> I get no warning, when really it should be of the pattern:
> 
>         vdd-l7-l12-l14-l15-supply = <&pm8998_s5>;
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

No, you basically reverse the change I did, without actually addressing
my intentions in that commit. If you want to revert it, please make a
proper revert and explain why such revert is needed.

Best regards,
Krzysztof
