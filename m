Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38A046C3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhLGTqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:46:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLGTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:46:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C697B81E22;
        Tue,  7 Dec 2021 19:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AA7C341C3;
        Tue,  7 Dec 2021 19:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638906150;
        bh=XVX9o3VWrtvyVxiDPrxlrr7aFHBobyjCRBFZ0nPdMxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DYv9u6HVviK0Smafd1q+EzWY9bH9ejahYC7E05S2eATigMcvoxljcEVfx7Ab4eo5q
         fvctc8Qq9KphJ3AubOca5WhDu5emB/gB3hzSvy2v85qhDMOlGc3pXkYCAGPMOLFiEx
         lARO9om7j1QKkkMl1Xe7PTWxvupKcTFN+EEj9unffQ+obZyLNcC6TvMPSLJHpExlRl
         B2TaBSOxKdY4Szym0GIbcBl29q8VQcky3CoRb+3MJxHoLv3fUN9T0pkbvXN2gHCDNy
         c+m+hq6CkW+2kZlcrqzWt9xpTDjs4WKcA3JGgDJM361IVZMjaAZv8kUyN+veD3+VAN
         6t+ZNB9vXPTSw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mugM7-00AarY-Tn; Tue, 07 Dec 2021 19:42:28 +0000
MIME-Version: 1.0
Date:   Tue, 07 Dec 2021 19:42:27 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
In-Reply-To: <20211206153124.427102-8-virag.david003@gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-8-virag.david003@gmail.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <b0f95b77e335596ee567ae83c1cbe549@misterjones.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: virag.david003@gmail.com, semen.protsenko@linaro.org, krzysztof.kozlowski@canonical.com, robh+dt@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-06 15:31, David Virag wrote:
> Add initial Exynos7885 device tree nodes with dts for the Samsung 
> Galaxy
> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> Currently this includes some clock support, UART support, and I2C 
> nodes.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>

[...]

> +	psci {
> +		compatible = "arm,psci";
> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;

Aren't these the standard PSCI 0.2 function numbers? Can't you
make the compatible "arm,psci-0.2" instead?

> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		/* Hypervisor Virtual Timer interrupt is not wired to GIC */

I don't understand this comment. You seem to have a bunch of
ARMv8.0 cores, for which there is no such thing as a hypervisor
virtual timer (this is an ARMv8.1 addition).

> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | 
> IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
