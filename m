Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6C57933F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiGSG3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiGSG3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:29:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4732A958
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:29:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y11so23120920lfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=nSjyDxj6i5dF81wArrDQxqLYzLC5767xBBEXb93UcLU=;
        b=On5OdScSHC8+y4IywSQ0PFC0mneZPHUqUD6lB278w4kSg5tTey8c0tie3ziwEs5SdW
         qpm1W7C+Zj0iXDfpZJ4DD3eLoDoeh7w8vneSrH9xu0FEHPTszti8q8PBCnmca9URJIEH
         OExT69La3eS+xOxXch3Y/zgO9Eh+sE7yq+umPUgIpHGNezMAnlW/VUhSzzVmVHD9MEQQ
         +hvClpXRy/GBJzTYrgm1v9peOylCjmxH9eLNmIu7/+jCPz76AJuwYI5bcj0BEUGQi5to
         q9jFSwxqj5ygx47dI70Wb79dpAliin7jNFpYhooLyHK6Av9tFyXC23uIUkMmNZEMT/gu
         jQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nSjyDxj6i5dF81wArrDQxqLYzLC5767xBBEXb93UcLU=;
        b=LCA4a+l/WAunBT+THgUik8p8DzFIZ39RzcHFQ6R2EiF9vHxvquH0YgFL4wYfpOgZV1
         XtePkJvUfLPJpl7G1hFR8PpeaEpqgg51Yo08IumiunaqqGg4Ia6tQFslLYpzbxya+hNK
         c2/1RR5k1ao81HnPbnDqDfMcZBjbds5CpV2asLsH8WQCshMO1hARRvr+nhrnqGVYloQu
         hxUhOajRJVxRFxczs5/HmZ+3igVWVB/y99xPXnPJIc9v8W+lgRCK7mOvL53pVp4EYDs7
         dVSJSbD8sBV+4/ZAC/oRTQ14IunUs30/nL1RDCsPSVyGPt/eZ5l4fz9GyoYSO/Jdgs1+
         8fPg==
X-Gm-Message-State: AJIora9qlqwXYgbPF1l5mTlk93iUPSpwwkGkhLebmOFJG/B1Z5UTtT6y
        x8On+58AUD/EUDT62iXgis6Wqg==
X-Google-Smtp-Source: AGRyM1vM/WjC2sRJl9xwLLN4clwPL6yEYjiQfm8ay95D2P4JoNvZM1csxXaLZqA5Sjf8PaQoeHdl9A==
X-Received: by 2002:ac2:4e07:0:b0:48a:18f3:e5fe with SMTP id e7-20020ac24e07000000b0048a18f3e5femr14198113lfr.357.1658212179235;
        Mon, 18 Jul 2022 23:29:39 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b0047f987cc158sm3050688lfo.45.2022.07.18.23.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 23:29:38 -0700 (PDT)
Message-ID: <152cee25-9a36-a948-98e7-847d9ee36c1f@linaro.org>
Date:   Tue, 19 Jul 2022 08:29:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] clk: meson: s4: add s4 SoC clock controller driver
Content-Language: en-US
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
 <20220708062757.3662-4-yu.tu@amlogic.com>
 <7fe9aab5-73a2-6209-ae65-d955c426f745@linaro.org>
 <f5bf2abd-4d60-523a-3f84-879da2f1c78a@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f5bf2abd-4d60-523a-3f84-879da2f1c78a@amlogic.com>
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

On 19/07/2022 08:02, Yu Tu wrote:
> Hi Krzysztof,
> 	Thank you for your advice.
> 
> On 2022/7/12 17:44, Krzysztof Kozlowski wrote:
>> [ EXTERNAL EMAIL ]
>>
>> On 08/07/2022 08:27, Yu Tu wrote:
>>> Add the peripheral clock controller found in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   MAINTAINERS                |    2 +-
>>>   drivers/clk/meson/Kconfig  |   17 +
>>>   drivers/clk/meson/Makefile |    1 +
>>>   drivers/clk/meson/s4.c     | 4678 ++++++++++++++++++++++++++++++++++++
>>>   drivers/clk/meson/s4.h     |  156 ++
>>>   5 files changed, 4853 insertions(+), 1 deletion(-)
>>>   create mode 100644 drivers/clk/meson/s4.c
>>>   create mode 100644 drivers/clk/meson/s4.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e4ca46c5c8a1..f116ec0642f2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1772,7 +1772,7 @@ M:	Jerome Brunet <jbrunet@baylibre.com>
>>>   L:	linux-amlogic@lists.infradead.org
>>>   S:	Maintained
>>>   F:	Documentation/devicetree/bindings/clock/amlogic*
>>> -F:	drivers/clk/meson/
>>> +F:	drivers/clk/meson/*
>>
>> Why?
> Warning is displayed when using checkpatch. I will correct it.

What warning?

Best regards,
Krzysztof
