Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0344808FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 13:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhL1MIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 07:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhL1MID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 07:08:03 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69162C061574;
        Tue, 28 Dec 2021 04:08:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o6so73008589edc.4;
        Tue, 28 Dec 2021 04:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=shBrQLOvlvGM8s87Is6erSp89kAhjElOM3ByEm8H9Sw=;
        b=GatQEtLEWzlVYpRap1EdimbXE4NmVhdDJilB6yXhm4+rhoqwuJVfK1lNarv0BLo4TT
         4Tx5N9/fR8DOF8LH8YX9Tl7h3nmj4l0NM7ORHOyGC+78hIY+TVRjKokXoj3WGbLoNotB
         7NRCHoad5DrNhkgpmuk9cPQJ0bPmntiGIVdx6J9UJIZeT9u80qUu/PfcQ6NHSW/MvDvm
         FpRsIwO1XzAGm4OOghWi7oFxWUOCMLdD9Uxfzg9gim+8c5LMinOXOtFMXh1B4ZX9eHR8
         C79JszSQ/+wdKA/NLl/V0L04/BxqFXjc1ZjaBGJz9EURaDyUp1tj16RJeGPu1V+aDomt
         9b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shBrQLOvlvGM8s87Is6erSp89kAhjElOM3ByEm8H9Sw=;
        b=G7uzUkoJp4CEVIDOmM1dknW69wrMIniBBYS1tXHoTA1rPbaemjz1jgu3VuYiS4b3fs
         G5zZqkyOI2TQNhql9ynCkyMdy5tCbRIb6yO+mbquYIAaAExL8bSyWZf8g91gaJY7FKHg
         vmb/Tm4KO36HIFd0oexDLBsw5vzcNWooc4i5zgLvep5y4HP1ps0NE3J7aBhmbi29IcUU
         gUqGaSUgjysBid4PbGr3BRTU49Zj2/+SLV7fJUZQk04jv8kfrokwHF7g5D7s1/KNsNwo
         /qPa3wr2gu0DMWiZNDxODB8caLVsOXbNe5OqsHoObliBT6FGqJqmMOF3PdPbPp1RmZ+N
         DWSA==
X-Gm-Message-State: AOAM530g/lGkglbr9IVdyC38KpN+gJsRE4rS7H1e8RiPOhP9JVFSJbVw
        9wAnEQ4QScye9B7dbDxjdMZcQQ86dRSIzA==
X-Google-Smtp-Source: ABdhPJyRsGWIlw4+PkSGRchYiWx5CIhsqycvCoWYUKkfIwWrrUJ2z/BGz72NUiT0cZFa9nwJ7d6FtA==
X-Received: by 2002:a05:6402:254e:: with SMTP id l14mr20520394edb.241.1640693281897;
        Tue, 28 Dec 2021 04:08:01 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h13sm1807814edt.61.2021.12.28.04.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 04:08:01 -0800 (PST)
Subject: Re: [RFC PATCH v6 1/4] dt-bindings: mfd: syscon: add naneng multi phy
 register compatible
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, lee.jones@linaro.org,
        yifeng.zhao@rock-chips.com, kever.yang@rock-chips.com,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211222213032.7678-1-jbx6244@gmail.com>
 <20211222213032.7678-2-jbx6244@gmail.com>
Message-ID: <50f49afa-6042-03f2-a8ed-cfffd317aa15@gmail.com>
Date:   Tue, 28 Dec 2021 13:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222213032.7678-2-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

The file grf.yaml is already pretty full with legacy stuff.
Now rockchip,rk3568-usb2phy-grf is added, would you like these two
compatible strings also there?
Could you give advice to Yifeng?

Kind regards,

Johan Jonker


On 12/22/21 10:30 PM, Johan Jonker wrote:
> Add Naneng multi phy register compatible.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 5de16388a..9f0c8aa81 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -52,6 +52,8 @@ properties:
>                - rockchip,rk3288-qos
>                - rockchip,rk3368-qos
>                - rockchip,rk3399-qos
> +              - rockchip,rk3568-pipe-grf
> +              - rockchip,rk3568-pipe-phy-grf
>                - rockchip,rk3568-qos
>                - samsung,exynos3-sysreg
>                - samsung,exynos4-sysreg
> 
