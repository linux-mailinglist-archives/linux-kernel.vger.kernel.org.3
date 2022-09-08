Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0359F5B209A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiIHO34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiIHO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:29:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41801658D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 07:29:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y29so7518323ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IQR375oRxnZf2kodfPY8b5WXgAl2frXO5MLWypEn38Q=;
        b=zmjpmg+WdRp6cHOOYjZTEaoAj2FUyqJHgttikmf01asdhjogxji6sWHb0YULI+WNm2
         hSdIqVMt7L8Q4L+vUeWq9Bum+lHWDBSIbO66+bR1mijNaxKFWoCBnDH9OZHWPugnnZAN
         /a1npjG/XLYLtrNq5IWm2tWZmmweLM8fHZFgE1DQyzjFyqxh+G0CerloEZymb/mLKM8C
         R1MyYQxusiTGcqcLkEvJZmcZ1jnql48iZnhBK2qd10uUbvX1tgFT4pVuD3B4eGwhsUzj
         AEFjH3B8ys85nV7kmPJdiPpt0/Qe9H41LC2JXxTgOvkSvs//BCsIOwsVdQoUlsoiNWTh
         G8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IQR375oRxnZf2kodfPY8b5WXgAl2frXO5MLWypEn38Q=;
        b=j3VhxwXv46r79wtUU2tFJSDpDRCdkfY9q8IF8jZUnUEkSh/DwG7SFByC8AiI1lp3s/
         o/PCqm2MMg6a3678821RtAPdoHKDvhgbbqdfGVGcLHwREQJHnQa+EPV6ES3YBGunhz/r
         AHdW9woQ4sFMOcIWjSgGzUy4dy4HiGd05IwVDSdHTnhUaUgAZhxei/4jHckUXtsAVKwh
         +6FYE7vXYgSPiufdz/nR8RmHggtiXpJK9vDPP1iab0pKQB0AXLUBA7YxpF3noHjaAEB8
         OvseDy4lYkliNgnITit/+S+aLzhwrsitLRlRy4zRewdu9lFKY3W7RAwQJ2k/DxTaL+zn
         PDmw==
X-Gm-Message-State: ACgBeo11q5o9PMmvnmkqC2apNY2uHVRhFBxpVso4QwnHBY5ht1uW5Jdb
        0Z+c1VdK5Nm6rs8131f3IUe7yw==
X-Google-Smtp-Source: AA6agR7F5bUfjQa21ulmnIH/kP8kg8ZCU7Mu/1M094w1XOHHK6s6cUshRJs/32QfxVTfQo6ZNSEKYQ==
X-Received: by 2002:a2e:7805:0:b0:26b:c19b:f08a with SMTP id t5-20020a2e7805000000b0026bc19bf08amr965567ljc.267.1662647371942;
        Thu, 08 Sep 2022 07:29:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b15-20020a19644f000000b00497adccecddsm561835lfj.170.2022.09.08.07.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 07:29:31 -0700 (PDT)
Message-ID: <168cde58-d061-97e7-54a5-5d3cccf3ce22@linaro.org>
Date:   Thu, 8 Sep 2022 16:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+kernel@kernel.org>
References: <20220907204924.173030-1-ahalaney@redhat.com>
 <abad381a-dfe7-9337-ff35-f657bf373d44@linaro.org>
 <CAD=FV=VmnKtx9smitqvNgmiCs-UCnLGFgbPnKd41QWeo1t3c9g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=VmnKtx9smitqvNgmiCs-UCnLGFgbPnKd41QWeo1t3c9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 16:23, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 8, 2022 at 3:25 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 07/09/2022 22:49, Andrew Halaney wrote:
>>> For RPMH regulators it doesn't make sense to indicate
>>> regulator-allow-set-load without saying what modes you can switch to,
>>> so be sure to indicate a dependency on regulator-allowed-modes.
>>>
>>> In general this is true for any regulators that are setting modes
>>> instead of setting a load directly, for example RPMH regulators. A
>>> counter example would be RPM based regulators, which set a load
>>> change directly instead of a mode change. In the RPM case
>>> regulator-allow-set-load alone is sufficient to describe the regulator
>>> (the regulator can change its output current, here's the new load),
>>> but in the RPMH case what valid operating modes exist must also be
>>> stated to properly describe the regulator (the new load is this, what
>>> is the optimum mode for this regulator with that load, let's change to
>>> that mode now).
>>>
>>> With this in place devicetree validation can catch issues like this:
>>>
>>>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>>>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>>>
>>> Where the RPMH regulator hardware is described as being settable, but
>>> there are no modes described to set it to!
>>>
>>> Suggested-by: Johan Hovold <johan+kernel@kernel.org>
>>> Reviewed-by: Johan Hovold <johan+kernel@kernel.org>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
>>> ---
>>>
>>> v2: https://lore.kernel.org/linux-arm-msm/20220906201959.69920-1-ahalaney@redhat.com/
>>> Changes since v2:
>>>   - Updated commit message to explain how this is a property of the
>>>     hardware, and why it only applies to certain regulators like RPMH
>>>     (Johan + Krzysztof recommendation)
>>>   - Added Johan + Douglas' R-B tags
>>
>> You posted before we finished discussion so let me paste it here:
>>
>> The bindings don't express it, but the regulator core explicitly asks
>> for set_mode with set_load callbacks in drms_uA_update(), which depends
>> on REGULATOR_CHANGE_DRMS (toggled with regulator-allow-set-load).
>>
>> drms_uA_update() later calls regulator_mode_constrain() which checks if
>> mode changing is allowed (REGULATOR_CHANGE_MODE).
>>
>> Therefore based on current implementation and meaning of
>> set-load/allowed-modes properties, I would say that this applies to all
>> regulators. I don't think that RPMh is special here.
> 
> RPMh is special compared to RPM because in RPMh the hardware exposes
> "modes" to the OS and in RPM the hardware doesn't. Specifically:
> 
> In RPM, the OS (Linux) has no idea what mode the regulator is running
> at and what modes are valid. The OS just tells the RPM hardware "I'm
> requesting a load of X uA. Thanks!" So "regulator-allow-set-mode"
> basically says "yeah, let the OS talk to RPM about loads for this
> regulator.

So how does set load works for this case? You mentioned
"allow-set-mode", but we talk about "allow-set-load".

> 
> In RPMh, the OS knows all about the modes. For each regulator it's the
> OS's job to know how much load the regulator can handle before it
> needs to change modes. So the OS adds up all the load requests from
> all the users of the regulator and then translates that to a mode. The
> OS knows all about the modes possible for the regulator and limiting
> them to a subset is a concept that is sensible.
> 
> This is why, for instance, there can be an "initial mode" specified
> for RPMh but not for RPM. The OS doesn't ever know what mode a RPM
> regulator is in but it does for RPMh.

Sorry, I don't find it related. Whether RPM has modes or not, does not
matter to this discussion unless it sets as well allow-set-load without
the mode... and then how does it work? In current implementation it
shouldn't...

Best regards,
Krzysztof
