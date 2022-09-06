Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C15AE367
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiIFIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiIFIqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:46:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE578BCE;
        Tue,  6 Sep 2022 01:42:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b16so14186390edd.4;
        Tue, 06 Sep 2022 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tP5HePAM+ajxYSe0bk8z7pkG3VRLXsVkQqpZO2Z6iCs=;
        b=cg37L4Xf6MHEQ5UsGmC374ty8ZFu/cwYIOiE6D86wCjCJ5gXtGccpY3Zt2OsFeacBY
         +5j+mpIE7guBk5ukQLA3aVlTCHL06B4bNI6G9RG4s/fR3NvxUYtogVHFQTBdr8EDW3YJ
         XA29EJ/VDnWTYJ0MZp0ntC7Tpg8ipPbezaSXMzhrYKpNbfCMsxU0swVHNPN+aO/ADBg8
         LqR7FLsi1+Wee96hx8dKLIzTqNEAotlyc0c9LhoUlPGe6pTM/gRpPOghzmUkLZN5CNxw
         w/FekFeb21GTV0nI6/7UiXT/5ctdGMENQfXigX8vjm1nfGnB1D9b9q2jAyhxSDEPfpNv
         sFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tP5HePAM+ajxYSe0bk8z7pkG3VRLXsVkQqpZO2Z6iCs=;
        b=nov9pV9OX2FOp1zGigrgB15W7bpdWF0SkmlfLgiVf5sEYm83ehElPZNzJv3fICtUzG
         OTD7ojZDjOAh82YcBs9I3sAcllf0dcroeMJyOhL3jz1mFZ6fYz9KjgUOIWT/AkHuwflS
         TIH0GD0+KlK4avSdXrJhEdDo45gmVBfBmTsJOphC1tx3Qusz4HaJziIGsy+hVpirDsIr
         LT8wIHod9DmqRjPBK4WhbSQvxCjf+UHJH3HIMkxr5404WzPu38UMO2Mw1w3SY0pJwZv9
         ktyhZY15CJNVs4wqFhqTkCCja4J2gOrrQoofrOvbz5SU7tnKDKRrsH3x5mzcbjFxUAT8
         sLtg==
X-Gm-Message-State: ACgBeo18/gVMqdcSiYpnP6rQiJqUFgUprMjGZ/f5JjHn1WEnkdB2WQtN
        kLyV2w7SsBejOL8ITcO5jkA=
X-Google-Smtp-Source: AA6agR5bS+4j8YwEOyVkGGsIIAHnsSrC6HHryFZeb/Zdcirth3itz7A7cjQlXUl/gL6+JEFOkNzAHw==
X-Received: by 2002:a05:6402:294c:b0:446:fb0:723b with SMTP id ed12-20020a056402294c00b004460fb0723bmr47480266edb.258.1662453773901;
        Tue, 06 Sep 2022 01:42:53 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id ka15-20020a170907920f00b0073d68db09ecsm6197261ejb.23.2022.09.06.01.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 01:42:53 -0700 (PDT)
Message-ID: <da038cb1-bb4b-4e7c-f17d-99e179c61741@gmail.com>
Date:   Tue, 6 Sep 2022 11:42:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-10-iskren.chernev@gmail.com>
 <e655cddd-677b-f277-667f-48107671db2a@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <e655cddd-677b-f277-667f-48107671db2a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/22 11:33, Krzysztof Kozlowski wrote:
> On 03/09/2022 19:41, Iskren Chernev wrote:
>> Add initial support for OnePlus Nord N100, based on SM4250. Currently
>> working:
>> - boots
>> - usb
>> - buildin flash storage (UFS)
>> - SD card reader
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>> Remaining issues from make dtbs_check:
>> - rpm-requests: it doesn't like the pm6125-regulators subnode. Every other
>>   DTS I checked is written in this way.
>
> Yes, I sent patches for it, already merged, so please rebase on linux-next.
>
> https://lore.kernel.org/all/20220828084341.112146-1-krzysztof.kozlowski@linaro.org/

Great, thanks!

>> +
>> +	clocks {
>> +		xo-board {
>
> These should be overridden by label, not full node path.

Will do.

>> +&rpm_requests {
>> +	pm6125-regulators {
>
> Please rebase and test with
> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml

I will, I'm just waiting for Konrad to say what to do about the reserved-memory
nodes. For some reason mainline doesn't use alloc-ranges (dynamic) regions. On
the other hand all of the dynamic ranges are not used ATM, so I can just drop
them?

> Best regards,
> Krzysztof
