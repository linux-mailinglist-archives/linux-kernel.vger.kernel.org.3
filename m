Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC0576A06
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiGOWmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiGOWmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:42:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792A832EDF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:42:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so4113113wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2X8jC778a1bD8tgrUWuX1UVZgnWt1gIMDS+KShdSfBc=;
        b=jbTDGvlbbzs1z5HnP6/mapGZm7MZhRKQoJdleovVTDakEJlHvZYWh2EiETPybsKXzo
         /VzB18mZVy47k2XIwgMvLCGqHPCjdPRQrn/U53gJ6DeAPV9hfNoAfPEFLWb/KCjrE0gU
         OWn2J6fDaUJEIBjfUVqt4CEy3Jf02rNs1YOyHfbkbCT7IfrBZ1MucKQTC4Z4G+96Uoyw
         yY2JvulPnCRcg0lZPyXifOFkhnaSnx20tE2GYw+zVQJycbPHF7aPExnEGs4SGJMc7EKs
         c2Kmh35fY+dgaZnAY+bVZezFmtKt0xOYhQ2junox4EtLBShs5p5sa9ih32mFg6V/qR4A
         xhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2X8jC778a1bD8tgrUWuX1UVZgnWt1gIMDS+KShdSfBc=;
        b=t8qY4nqURLIqqwubImI6tKC3oQCpnT4Cd5YzKhl+ORdmEktFXiG7gtb4lZwhzgV9gS
         pH6YbA/RHkX4RT2gU4l/IKwIPoTPT1PnjeCpPlHgNm+OknSg5aHdK5N086sFPn2d3a5n
         F7/H3TcEGSJBaOQqbtJStw+B26c9Y2GkS+JlhS/45G865B06PowrBkC6sTIj6E3wxEqn
         tQncfKWaT2+SDygEGyzQEWLBm+GgP2eTeyjZGq61V0mJ20M2kZSN0eQnP3nzjFNsZL4U
         JFnfkZrLW3W1RSTzMLRHCr/wBhsG3q0UIPF6zS/Xzk/zgIld/abQZpr1rLlRr24rnQ26
         lqCg==
X-Gm-Message-State: AJIora9zZF8NzZJFuvf4HAVee51DhY3NDesgUrj6rUN9khua49HD+4am
        Wpe8aWkMd4ofz1z2kEiwg2wF9w==
X-Google-Smtp-Source: AGRyM1slAuNUi2kVMR00o7FcgsJHvB9Ke/0OFXq7b+nWaaLRGPPkZevi0l6tGHJYVdskcIY7XQkawQ==
X-Received: by 2002:adf:e18a:0:b0:21d:93ac:bd55 with SMTP id az10-20020adfe18a000000b0021d93acbd55mr13486799wrb.100.1657924937976;
        Fri, 15 Jul 2022 15:42:17 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:a223:f4b3:40c9:43fa? ([2a05:6e02:1041:c10:a223:f4b3:40c9:43fa])
        by smtp.googlemail.com with ESMTPSA id c6-20020a5d5286000000b0021d6e49e4ebsm4616406wrv.10.2022.07.15.15.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:42:17 -0700 (PDT)
Message-ID: <4f89bdc5-3047-7619-f518-3ef328a027a8@linaro.org>
Date:   Sat, 16 Jul 2022 00:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 0/2] MediaTek SoC ARM/ARM64 System Timer
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org
References: <20220613133819.35318-1-angelogioacchino.delregno@collabora.com>
 <217695f5-55d3-e347-ea04-d30aaee6e712@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <217695f5-55d3-e347-ea04-d30aaee6e712@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2022 10:45, AngeloGioacchino Del Regno wrote:
> Il 13/06/22 15:38, AngeloGioacchino Del Regno ha scritto:
>> In an effort to give some love to the apparently forgotten MT6795 SoC,
>> I am upstreaming more components that are necessary to support platforms
>> powered by this one apart from a simple boot to serial console.
>>
>> This series introduces support to start the System Timer for the CPU
>> cores found in various MediaTek SoCs including, but not limited to the
>> MT6795 Helio X10 - and will most probably unblock many developers for
>> the upstreaming of various platforms.
>>
>> For a broad overview of why/what/when, please look at the description
>> of patch [2/2] in this series.
>>
>> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
>>
>> Changes in v4:
>>   - Changed statement in documentation, now saying:
>>     "MediaTek SoCs have different timers on different platforms"
>>
>> Changes in v3:
>>   - Merged mtk_cpux_{enable,disable}_irq() as one mtk_cpux_set_irq() 
>> function
>>     as suggested by Matthias
>>
>> Changes in v2:
>>   - Added back a lost line in commit 2/2 (sorry, commit didn't get 
>> amended...!)
>>   - Tested again for safety
>>
>> AngeloGioacchino Del Regno (2):
>>    dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795
>>      compatible
>>    clocksource/drivers/timer-mediatek: Implement CPUXGPT timers
>>
>>   .../bindings/timer/mediatek,mtk-timer.txt     |   6 +-
>>   drivers/clocksource/timer-mediatek.c          | 114 ++++++++++++++++++
>>   2 files changed, 119 insertions(+), 1 deletion(-)
>>
> 
> 
> Gentle ping for this one - I need it to start upstreaming devicetrees for
> that MT6795 Xperia M5 smartphone, or it won't be able to boot.


Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
