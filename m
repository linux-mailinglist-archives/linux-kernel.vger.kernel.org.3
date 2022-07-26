Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E123658141F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiGZN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiGZN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:26:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF7DBC92
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:26:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p11so17800475lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7LFFMwiJHSgt40VzNgnK+p0FFAjdjoeGyTH4E8FwT0E=;
        b=Aiij4gjIIX693LP3uECqDjhaNEduUYkTznUdozN6Z1X40PUPTHN+vv8FbbmpNUqhrh
         u2m/nMkW5fh9k5qQ/m5dalcbJSVBVF4lQebPHd1LnVZt5zmiLl9sABtM/Nu+mNud+1Vg
         b4rBDftjLJu8c52FxG197+ZtQ+wYjpvPhQ32KlQVSTpOQmJso+Z+GluiUqli8oFn6lY/
         7GGUGe4dLSAXcnncncROK7clRlT4q6+bxv7ffFDN8wTJec+Ngx11lCo8e4Rff2oV+umo
         CFMFzez31oIvcU/N8+b9gPCbipF/Eb7q55vbQrKAfQBeOjsCijMeKvYwviwS3395i/Tn
         cQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7LFFMwiJHSgt40VzNgnK+p0FFAjdjoeGyTH4E8FwT0E=;
        b=kdHXbecw4yKjhyRqKL4AGDmUTh8ZXDE61YmlqK4s4dIgOdecMIno4IIJW0ziPxJp6Z
         6O4zKQFZ+0tB0bsB6dRx8ek4d7MTbFQzGb8xx5vwQZkr2gQPMz3aiWC5BhqQk1+E/2Cl
         k6hp2yG+VkymBS6Tz2gKRmVbI6HByWrC1lMdKGTgwaELmr9tx9sn4NUl9G7v44Xn/0dI
         N3IITd7ZOoCowcmNzN1+DIaDW/cX28AgclolzFF0ULII9eBsuU1n/nPyDR4SCWOdlmta
         ZR4PS3hSTJvlv0MrFq33y7V+zdMDefME+ia3zP10vHjPUKBpsTIb3NW52VaycmNigkaD
         UQYw==
X-Gm-Message-State: AJIora965Pjvjnh47zm6TIX2HRg6mTqf0SY3lihNF0o5UxfX55I7BKBN
        NhQsd9tAzGRQzsrr11KAYmmQbg==
X-Google-Smtp-Source: AGRyM1uBaVRREf8/ovTyKCewffls63KLbGfV6IuqcxFgSfDg/bqFevMeoWqywHu+/bDCIz+1i8Cefw==
X-Received: by 2002:a05:6512:1301:b0:488:c42:5c02 with SMTP id x1-20020a056512130100b004880c425c02mr6106016lfu.61.1658841961437;
        Tue, 26 Jul 2022 06:26:01 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id p18-20020ac24ed2000000b00489c54859a5sm328145lfr.287.2022.07.26.06.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:26:00 -0700 (PDT)
Message-ID: <11e5c369-c0da-7756-b9e2-ac375dc78e9d@linaro.org>
Date:   Tue, 26 Jul 2022 15:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] dt-bindings: firmware: Add Qualcomm UEFI Secure
 Application client
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20220723224949.1089973-1-luzmaximilian@gmail.com>
 <20220723224949.1089973-5-luzmaximilian@gmail.com>
 <e88d1036-dc58-3fc8-c388-edba9b2d62a7@linaro.org>
 <87c19c5a-d7f4-7183-1322-f62267e01b3b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87c19c5a-d7f4-7183-1322-f62267e01b3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 13:15, Maximilian Luz wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,tee-uefisecapp
>>
>> Isn't this SoC-specific device? Generic compatibles are usually not
>> expected.
> 
> This is essentially software (kernel driver) talking to software (in the
> TrustZone), so I don't expect there to be anything SoC specific about it.

You are documenting here firmware in TZ (not kernel driver). Isn't this
a specific piece which might vary from device to device?

IOW, do you expect the same compatible to work for all possible Qualcomm
boards (past and future like in 10 years from now)?

> 
>>> +
>>> +required:
>>> +  - compatible
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    firmware {
>>> +        scm {
>>> +            compatible = "qcom,scm-sc8180x", "qcom,scm";
>>> +        };
>>> +        tee-uefisecapp {
>>> +            compatible = "qcom,tee-uefisecapp";
>>
>> You did not model here any dependency on SCM. This is not full
>> description of the firmware/hardware
> 
> How would I do that? A lot of other stuff also depends on SCM being
> present (e.g. qcom_q6v5_pas for loading mdt files) and I don't see them
> declare this in the device tree. As far as I can tell, SCM is pretty
> much expected to be there at all times (i.e. can't be unloaded) and
> drivers check for it when probing via qcom_scm_is_available(),
> deferring probe if not.

It seems this will be opening a can of worms...

The problem with existing approach is:
1. Lack of any probe ordering or probe deferral support.
2. Lack of any other dependencies, e.g. for PM.

Unloading is "solved" only by disallowing the unload, not by proper
device links and module get/put.

I understand that SCM must be there, but the same for several other
components and for these others we have ways to pass reference around
(e.g. syscon regmap, PHYs handles).

> 
> Don't take this as an excuse as in "I want to leave that out", it's just
> that I don't know how one would declare such a dependency explicitly. If
> you can tell me how to fix it, I'll include that for v2.

I think there are no dedicated subsystem helpers for this (like for
provider/consumer of resets/power domains/clocks etc), so one way would
be something like nvidia,bpmp is doing.

meson_sm_get is a bit similar - looking by compatible. This is less
portable and I would prefer the bpmp way (just like syscon phandles).

The qcom_q6v5_pas could be converted later to use similar approach and
eventually the "tatic struct qcom_scm *__scm;" can be entirely removed.

Any comments on this approach from Konrad, Bjorn, Dmitry, Vinod and
anyone else?


Best regards,
Krzysztof
