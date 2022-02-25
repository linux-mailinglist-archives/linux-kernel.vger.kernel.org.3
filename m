Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619E24C517C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 23:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbiBYW0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 17:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiBYWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:25:58 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172531CDDC6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:25:25 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d28so6467570wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pMdKTxslGmzlgz5T0AhXDhZ58tmlruUYBH99ctt7vgY=;
        b=YggS9A2f9j35MkWy7WvKMd7lWxnLAduoYGfA3tPaKwu+R1W1AIxdkQU0lKAo8wNVF+
         2j0V+AYntUGgtv71u9A4PjNO0/73QDmW0BKCM7+lngwz/VKkaTgb3DXmrLNZ+7od5YSQ
         cD6JiuSulRFv8+sOdRQgfiDj0/swOdL9QkcSxZep2tJjuLSHMyZ6Fh6KsivpTvNT/Ulb
         qL1wvs25wL5Nv/VjWppzXCazPfyH75ulJrKar5+BpLsxgqe3ABqJN8jZ170HUtTz/NAL
         GUwdSlG5XEvZDgxmvYu0pyZBvmgZdz1CE6jaFZBK2Cjcn6y1PDeXHXtgSsQ+kiW8Mink
         6gZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pMdKTxslGmzlgz5T0AhXDhZ58tmlruUYBH99ctt7vgY=;
        b=3rM00HN6sNZaxGcbGUk6a+qAvxJnmqyuwgfZ2sbkEcsB43Ksxm1XihvO4bFENRjBpc
         a1fNjvjX64TIyP9UFjg0saGfq7vNg2rPe9t0paAlI3VxHIH3AtzonOw/hADgPd+1MiTk
         IL0e8xIOs4nA2zvOBlTehvjxwEW9MDWVT99b6SgYni/VbsCTJSlvGOqm0Yxd/WnI0Rxq
         3Zssu7iChbFo3GGnZ9QvArLgk1CSsm71ihLQ6imCLnm/Ly4N+4Kws6E8rhPszbD/hpKS
         J9ntUqlkfy2oMajp+ENy98/2i2DTeGoa1zo68eo3+PQgLLt5GhAtc4NgbAYPpa9TIVBn
         FEPQ==
X-Gm-Message-State: AOAM533g8XeErwLtK9ae09KgDL/zY4x95AiJ+WbzvqmPSrhulvxtwMtS
        Tw+Njf8cRg6U4wbltvibLOUdNA==
X-Google-Smtp-Source: ABdhPJyKBQ224ynEkmOrK/gm7F/M+eTJTaHhxmCo8UJFmtf4IOUMnBwK95SpxSLGz9rfGQMbkrXTvQ==
X-Received: by 2002:adf:ea4a:0:b0:1ef:7a85:d772 with SMTP id j10-20020adfea4a000000b001ef7a85d772mr2219282wrn.101.1645827923534;
        Fri, 25 Feb 2022 14:25:23 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:e11c:33b1:8704:339f? ([2a01:e34:ed2f:f020:e11c:33b1:8704:339f])
        by smtp.googlemail.com with ESMTPSA id h5-20020adffd45000000b001b36cba20adsm3278743wrs.42.2022.02.25.14.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:25:22 -0800 (PST)
Message-ID: <7856aa45-d8fc-ca2c-0b95-302f94378c7a@linaro.org>
Date:   Fri, 25 Feb 2022 23:25:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] clocksource/drivers/timer-ti-dm: fix regression from
 errata i940 fix
Content-Language: en-US
To:     Suman Anna <s-anna@ti.com>, Drew Fustini <dfustini@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, khilman@baylibre.com
References: <20220204053503.1409162-1-dfustini@baylibre.com>
 <9d56bc51-2539-fe14-7968-c172acb8b4c9@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9d56bc51-2539-fe14-7968-c172acb8b4c9@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2022 01:03, Suman Anna wrote:
> Hi Tony,
> 
> On 2/3/22 23:35, Drew Fustini wrote:
>> The existing fix for errata i940 causes a conflict for IPU2 which is
>> using timer 3 and 4. From arch/arm/boot/dts/dra7-ipu-dsp-common.dtsi:
>>
>>    &ipu2 {
>>            mboxes = <&mailbox6 &mbox_ipu2_ipc3x>;
>>            ti,timers = <&timer3>;
>>            ti,watchdog-timers = <&timer4>, <&timer9>;
>>    };
>>
>> The conflict was noticed when booting mainline on the BeagleBoard X15
>> which has a TI AM5728 SoC:
>>
>>    remoteproc remoteproc1: 55020000.ipu is available
>>    remoteproc remoteproc1: powering up 55020000.ipu
>>    remoteproc remoteproc1: Booting fw image dra7-ipu2-fw.xem4
>>    omap-rproc 55020000.ipu: could not get timer platform device
>>    omap-rproc 55020000.ipu: omap_rproc_enable_timers failed: -19
>>    remoteproc remoteproc1: can't start rproc 55020000.ipu: -19
>>
>> This change modifies the errata fix to instead use timer 15 and 16 which
>> resolves the timer conflict.
>>
>> It does not appear to introduce any latency regression. Results from
>> cyclictest with original errata fix using dmtimer 3 and 4:
>>
>>    # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0
>>    policy: fifo: loadavg: 0.02 0.03 0.05
>>
>>    T: 0 ( 1449) P:80 I:200 C: 800368 Min:   0 Act:   32 Avg:   22 Max:  128
>>    T: 1 ( 1450) P:80 I:200 C: 800301 Min:   0 Act:   12 Avg:   23 Max:   70
>>
>> The results after the change to dmtimer 15 and 16:
>>
>>    # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0
>>    policy: fifo: loadavg: 0.36 0.19 0.07
>>
>>    T: 0 ( 1711) P:80 I:200 C: 759599 Min:   0 Act:    6 Avg:   22 Max:  108
>>    T: 1 ( 1712) P:80 I:200 C: 759539 Min:   0 Act:   19 Avg:   23 Max:   79
>>
> 
> Gentle reminder, I don't see this in linux-next yet, was kinda expecting this
> would be included in the fixes for 5.17.
> 
> Just want to make sure that the patch did not get lost in your mbox.

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
