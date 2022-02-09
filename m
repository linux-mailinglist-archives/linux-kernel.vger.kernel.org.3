Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA24AEA8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiBIGpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiBIGpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:45:17 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3449C03544F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 22:45:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t9so1375585plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PVC8kg0m66z8nLsg7hxOAh4ZCaPmayhqQ5QiMYyZWlY=;
        b=hjkkB+DreNhYS/KptENJnaOeZzsf3zoLA17g1PzKwanvPvmLRz1rw2vIXm7TxU7Wls
         vmIPPMUYaLfI32C6XPq8PayQJN2jHoZTxlY2sA+WhqLxpB+WrlLJVb8+xuT5u3MeKJLu
         KT2rsVd5+bTcEY3UkL6L4/cD8Sdl0REnZW61J6IjgpohUtEYNdebpBTsf6tc81kEwJ91
         5jab9fomYIxnmIO56L7GOmg3B50apOtkutQKT/q/DLSktmso+CzWODSvgSIqnGW0kvgO
         Wccps8E7E9MnGF0zeqqNIY2gqkba3d3OBIbxyVg68G3xIeBzv0LNvqc8+1NhQcphvsSW
         +6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PVC8kg0m66z8nLsg7hxOAh4ZCaPmayhqQ5QiMYyZWlY=;
        b=vt/EhMJnmqQnz8jqz1LYLWV/plRERysxiCf2Sx7d+vhVm9/hX2fcrvfOlQMWYs1SnM
         WTCDtC4VOksWtydJ+jLv2ma01FhmGdtya5SLrggWPfQBRFKm7g5LmhjVkZ9fZngxBjY7
         gSyAXsGzJWcmzcsNb0ZKOWWq1vPJFFgWcKNzhlEUBoLzitq6wpN+Jw5zwL37g7I5lvIE
         86K6a/cBiCUm9fCfzNmg0taYFYCyY32t7F6zilz5L2JG+PQozNfcJJqGaLgq3mlxWqZ5
         s6XSb0gy9DQ7FrZe9OvtEz3Tj/ndKLMPuPO00oYQqy4FFFvPhiWr3MewIPe3KMqH0lU6
         OsOA==
X-Gm-Message-State: AOAM531N2/Bn352XH+h5pOP64DYp0wHcHbBa94SDlz4hdMAwO5zSXIH4
        gMJWF10fTyobe8nN28rtuKTQHw==
X-Google-Smtp-Source: ABdhPJyTnEiwKB7qSkQcVoYjamO3CNRQCXq2vkRCtMNivvsSE2h44qEyShyFtpctl+7fuDFYlQgCrA==
X-Received: by 2002:a17:902:b90a:: with SMTP id bf10mr847320plb.36.1644389119024;
        Tue, 08 Feb 2022 22:45:19 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id g5sm13345929pgc.51.2022.02.08.22.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:45:18 -0800 (PST)
Date:   Wed, 9 Feb 2022 12:15:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: spear320: Drop unused and undocumented
 'irq-over-gpio' property
Message-ID: <20220209064516.qxj7yd7r7dvz5zbz@vireshk-i7>
References: <20220204004117.1232902-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204004117.1232902-1-robh@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-02-22, 18:41, Rob Herring wrote:
> The property 'irq-over-gpio' is both unused and undocumented. It also
> happens to collide with standard *-gpio properties. As it is not needed,
> drop it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/spear320-hmi.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/spear320-hmi.dts b/arch/arm/boot/dts/spear320-hmi.dts
> index 367ba48aac3e..b587e4ec11e5 100644
> --- a/arch/arm/boot/dts/spear320-hmi.dts
> +++ b/arch/arm/boot/dts/spear320-hmi.dts
> @@ -235,7 +235,6 @@ stmpe811@41 {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <0x41>;
> -					irq-over-gpio;
>  					irq-gpios = <&gpiopinctrl 29 0x4>;
>  					id = <0>;
>  					blocks = <0x5>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
