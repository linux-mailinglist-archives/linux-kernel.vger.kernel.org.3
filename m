Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D955AC68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 22:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiFYUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiFYUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 16:04:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A6C140B9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:04:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lw20so11259581ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=484IUMcow05iyV1q6ajSQK3ecgIAOqLkAvID94WbHbc=;
        b=xKKkluQB5W5jsjMGpvV4mWayJh3F87PZNANoAlbx1ANdQtwKrl0tFLSdSnt7PTz8q9
         pourHAfc7ZlH8/92enAJ3nxTsh1n/eQnOYpOgN7a+B+uqVo4MVMFzGgUo88QeKLcZikg
         /7V0Jjsyw9gB73faVN6mAwwOrTMscQKhKjbF5PCoKPJJwTPMl6gA/8ebrwwlMcuvHBWw
         fC4hmtaNENs0rNgrz1wmwij7uWQ8/mIYA2S0hU2j3VQcnTtdR1wh/A0W37igzjhy2yqd
         jq9jdDG4j+7o6CQmtNgBbiMV/kWkzu+PVjc+stDbYngDv5Laq9bjrlDDv2dgs9h4fHc2
         iAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=484IUMcow05iyV1q6ajSQK3ecgIAOqLkAvID94WbHbc=;
        b=khjWhneQMoIc0CidbAKpwAbYuHRfuBOL81QG0rwZ4PntJetI7EYM6XQm0DqbYhd41B
         /f6lbfm654fwjWgTfWo7+w7aPChUi+QR6F1jzyYGUAHXl9Pe2FhX88kFuJdzCfc+/eG1
         Vx8W0QB7KfjDJHYioDnu4vqVZjbNL2ce1fOsOwYM9+IY0LLBkpTMQ3wxHjm8lMk6AnuX
         zhW5PNBQdtAtuAJrY0DRkgwTOfF3ix7YXHfdDtScQiLbftgQfWJ6LC4mL4KqdPT6fn2A
         SIV4T/E9Ko0Wn1fXUNkFkTJTdcQb/KQf57pAyiJGNxqNWH9ASFiq6eQI9zBRUh68TMGq
         KdbQ==
X-Gm-Message-State: AJIora8bIEhKfdYFA679hoo6iBlw1g0VUkY/SjwFjCNJmWKs8okSjny8
        SHT59uGTr1dZgDeWtmDOLKi2aA==
X-Google-Smtp-Source: AGRyM1vAHJsB0fQVRjAcZCjkgpVQmm2apAqr3ltjCElkOyYJUzZB1QBiv4XLi9yN/SstZ0ELo/1w+w==
X-Received: by 2002:a17:907:7256:b0:722:e5a8:e3a3 with SMTP id ds22-20020a170907725600b00722e5a8e3a3mr5296645ejc.599.1656187458520;
        Sat, 25 Jun 2022 13:04:18 -0700 (PDT)
Received: from [192.168.0.239] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402150800b0043578cf97d0sm4579259edw.23.2022.06.25.13.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 13:04:18 -0700 (PDT)
Message-ID: <9116badb-32c2-3727-6037-fd87b45af4b8@linaro.org>
Date:   Sat, 25 Jun 2022 22:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 4/5] arm64: dts: qcom: sc7180: Add pazquel dts files
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220625022716.683664-1-joebar@chromium.org>
 <20220624192643.v13.4.I41e2c2dc12961fe000ebc4d4ef6f0bc5da1259ea@changeid>
 <CAD=FV=X+92d+PvrHENT3g5=hkJ_UaVWHgMHyuvn3erg10DpVAw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=X+92d+PvrHENT3g5=hkJ_UaVWHgMHyuvn3erg10DpVAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2022 16:45, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 24, 2022 at 7:28 PM Joseph S. Barrera III
> <joebar@chromium.org> wrote:
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> index e55dbaa6dc12..69cd4b3b911b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>> @@ -11,6 +11,12 @@
>>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include <dt-bindings/sound/sc7180-lpass.h>
>>
>> +#ifdef __SC7180_TROGDOR_DTSI__
>> +#error "Duplicate include"
>> +#else
>> +#define __SC7180_TROGDOR_DTSI__
>> +#endif
>> +
> 
> I'm not convinced about the need for this. That being said:

We have several DTSI files included by several different boards. Some
are describing board (in a common way), some only common subset of board
or SoC. In none of the cases we include such include guard, so why is
this one different?

Best regards,
Krzysztof
