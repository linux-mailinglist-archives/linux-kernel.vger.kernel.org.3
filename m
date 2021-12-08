Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68046D7E3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhLHQT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236680AbhLHQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:19:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6315AC0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:16:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t9so4965081wrx.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3S6Qu67tEui0DUsR7g/4/F35A73+SPBA+zRxkUhaG8=;
        b=MOtB1a6nj3/eQ3UtTDyQj1j+VVPdxYy6CedR8STiP6JvFUMlapTFPLi4UqGLNvsarp
         LBJcZFgfWEfjBSAAsypXx6MZtRZIkpUiNnsuhfbv/v8ov6rSYP/ZvOMQGqIat3nqxTUE
         sZT4IGJtCEQtYlnhi+uHHCl8gv/wD/2me2DEVJy3eYtdc4A+xHBTdxA1EjO3til/UDMm
         H/1edaw3ZvxzNZs7S/nWmnPAoIfTzxFkuQvzRY5Zg2TIP1/22hviuBUTchcYCqzkEiCs
         YLG2lwVRBbHfl0Z0TO8HEmsEIUF8y/l4xfS0BqKLlBXZ8DuHBBHsxnhYUoXSD5M9ohK7
         erVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3S6Qu67tEui0DUsR7g/4/F35A73+SPBA+zRxkUhaG8=;
        b=YUyrGvn72+9XFCWLTHeR+sdaCmHbI9nshY5KN/sX5gjKUGgir2ykysNwhiDVuiruTv
         mMpb+rHOTV/VZK7w5IIc2uP30+9ZN9aP/rN3Ist+PWK0sfkFsmcRg/u6ecnaO0CdMiX7
         ILuyzk230MQpa5zyqymmsM0FU6Z0+1agLVnfY7hgHXIp83K5jFQCACm0g1yty1GfQ34q
         oPX1p+cuZ+xx4/CXuyvVJheTmD26NspvJObnPxFCsQJe0wJGbf6H9EaiGNqxKivSaWhx
         uxjbTKdaGsBRmOodHJKmSQJw1SJ8P4II7SWXGWK4RblUsaZE/dpnxs6xY82bGNTuprya
         fu/w==
X-Gm-Message-State: AOAM530VqS6IY1gNtct9C/4/ypOkJW+Ai0Hcu1By9DpSUO2GAG+0e7iJ
        cf4SEyy2TjzS86IiLDSBkNy3/g==
X-Google-Smtp-Source: ABdhPJyCcP3HTyvqGn8Z6fbCxuZdPjgKKEAI4N4Ibrf6Rk4KMeup+vzySvXG4xrGLqlNMeEqm37nlA==
X-Received: by 2002:a5d:48cf:: with SMTP id p15mr60128362wrs.277.1638980181213;
        Wed, 08 Dec 2021 08:16:21 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d? ([2a01:e34:ed2f:f020:8ae8:ca1f:ff1a:a23d])
        by smtp.googlemail.com with ESMTPSA id r83sm6322557wma.22.2021.12.08.08.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 08:16:20 -0800 (PST)
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add powerzones definition
 for rock960
To:     Rob Herring <robh@kernel.org>
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
 <20211126181500.3404129-2-daniel.lezcano@linaro.org>
 <CAL_JsqK1tsOqUYrLkZCo95BC=AXwZxai947x41zYpeHbodvwFg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <82ac88d2-5419-4c1f-e81a-154c65b39c1b@linaro.org>
Date:   Wed, 8 Dec 2021 17:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK1tsOqUYrLkZCo95BC=AXwZxai947x41zYpeHbodvwFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

On 07/12/2021 19:41, Rob Herring wrote:

[ ... ]

>>         thermal_zones: thermal-zones {
>>                 cpu_thermal: cpu-thermal {
>>                         polling-delay-passive = <100>;
>> @@ -2027,6 +2050,8 @@ gpu: gpu@ff9a0000 {
>>                 clocks = <&cru ACLK_GPU>;
>>                 #cooling-cells = <2>;
>>                 power-domains = <&power RK3399_PD_GPU>;
>> +               #powerzone-cells = <0>;
>> +               powerzone = <&PKG_PZ>;
> 
> Every CPU and the GPU are in the same powerzone. What is the point? Do
> you really have to be told that CPUs and GPU are a source of heat and
> might need to be limited?

A powerzone ==> can read power && set power limit

Every CPU is a powerzone as well as the GPU.

They are all grouped under PKG_PZ.

That means we have:

 pkg
  |-- cpu0-3
  |
  |-- cpu4-7
  |
  `-- gpu

We can read the power consumption of cpu0-3, cpu4-7 or gpu and set their
power limit.

We can read the power consumption of pkg (which is the sum of the power
consumption of cpu0-3, cpu4-7 and gpu) and I can set the power limit
which will ensure powerof(cpu0-3 + cpu4-7 + gpu) <= powerof(pkg).



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
