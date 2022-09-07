Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0455AFFE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIGJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiIGJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:07:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84517CB5F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:07:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bj14so6038019wrb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IFfO8s24X4L6IiX71R+uIe6DXsqgosywnjWvsxtv3Ew=;
        b=TuG9vzaPdZNZybNQ1CIY26t6SbgnlgX+ISm0najnlfKQ215iQ26dI/QsM2o/sSljjQ
         1SMgIrAtBeagSRJ1ASNxQRmKfmi5J1IZekJU1zkb0ciLsWo6INl5EgpyGSPbinF55ZRJ
         jypbqx3648Aat5NjxTcCkUpwGrtjY4bTb+bgkp53A+YSaZBhBoTj0RYAqAqQBdYD+Fsv
         DvEonYMYL4i/9Sv71TA/KPNyutryRXrVuGBbS9tfOX4kXS1ASkk1W3TfgrFkOibddNaM
         P1VBbF4/u+/MhRORVNM3FThLrzsWq+IHM6g6hiOJyPEBGNYTzAT8oCKTrodLjU50VvAV
         Eg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IFfO8s24X4L6IiX71R+uIe6DXsqgosywnjWvsxtv3Ew=;
        b=xNrk4EDOyTvLy5FHhHEVJ2TmwZA7SFzCtzT6/1ARzgzRLZWkZ3oxuaLSXM2Fds2AtO
         XlYNqETP8bf1jJ+SezSqhEIpHfBMEsWoDRKx8+nlKHM5awQNt0I0SIKrTMb/Vs0qOJ9r
         LoH3l4e3ePJg1H5/ehp17hdmFbKUf/Maer8Y0+2sO9qfzpE2P1s9QXOPCadoebPhuZrw
         Pgb3UnN8W46erc1OJU+Gs9J6XvOz3KVG+USXiQnFcMPy0kAHXlhpOsf02qTRU4SPYPd9
         fqUokPLuoU/y528GMDGrrsKbz9Uya7edTScf/BwAAwklof63mTuGk7qqIA90+2mVWvUY
         R/Qg==
X-Gm-Message-State: ACgBeo2cGpnlUlYn3ptB97xtdjmfK5pOhFaSvihbf/YD15SRjuM/r55t
        NtLBOAPAtfVUtz+r71NJt7P6nw==
X-Google-Smtp-Source: AA6agR48lqIv2qlI6YDo9XWqTGC1l2K8ft12K29sufasxevueMiTov8EQXDNfyfvekSrIt/9hMpzdg==
X-Received: by 2002:adf:fbc7:0:b0:220:6004:18ca with SMTP id d7-20020adffbc7000000b00220600418camr1379849wrs.632.1662541635444;
        Wed, 07 Sep 2022 02:07:15 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f25-20020a1c6a19000000b003a840690609sm27982950wmc.36.2022.09.07.02.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 02:07:15 -0700 (PDT)
Message-ID: <cabade8b-256d-904d-bbf5-a4960fe75179@linaro.org>
Date:   Wed, 7 Sep 2022 11:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 3/4] clocksource/drivers/exynos_mct: Support
 local-timers property
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20220609112738.359385-1-vincent.whitchurch@axis.com>
 <20220609112738.359385-4-vincent.whitchurch@axis.com>
 <d0f3bab8-fadb-709c-7118-20e23fba1dc4@linaro.org> <YxhdYAmSIzUGN5od@axis.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <YxhdYAmSIzUGN5od@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 10:59, Vincent Whitchurch wrote:
> On Tue, Jun 21, 2022 at 03:11:15PM +0200, Krzysztof Kozlowski wrote:
>> On 09/06/2022 13:27, Vincent Whitchurch wrote:
>>> If the device tree indicates that the hardware requires that the
>>> processor only use certain local timers, respect that.
>>>
>>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Daniel,
>> All patches got my review. Do you need here anything more? It seems it's
>> only me who reviews such code, so I don't expect more Rb-tags. :)
> 
> It's been a couple of months, and unless I'm missing something, it looks
> like this series did not get merged, and nor did it receive any further
> comments.  Should I resend it with Krzysztof's Reviewed-by tags?

No, need to resend. I'll pick the series


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
