Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1130475DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbhLOQlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:41:08 -0500
Received: from foss.arm.com ([217.140.110.172]:57404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244903AbhLOQlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:41:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28FDA6D;
        Wed, 15 Dec 2021 08:41:06 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4D5E3F5A1;
        Wed, 15 Dec 2021 08:41:04 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:41:02 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Heidelberg <david@ixit.cz>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: add #size-cells 2 for ARM
Message-ID: <Yboanu5YK38/A514@FVFF77S0Q05N>
References: <20211215144500.64284-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215144500.64284-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:45:00PM +0100, David Heidelberg wrote:
> It's already widely used by dt-schemas, so I blindly assume it's correct.
> 
> Fixes warnings as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: timer@17c90000: #size-cells:0:0: 1 was expected
>         From schema: Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

FWIW, that makes sense to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume Rob will pick this (or otherwise correct me).

Thanks,
Mark.

> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> index cd2176cad53a..c061bb90b8e7 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> @@ -30,7 +30,7 @@ properties:
>      enum: [1, 2]
>  
>    '#size-cells':
> -    const: 1
> +    enum: [1, 2]
>  
>    ranges: true
>  
> -- 
> 2.34.1
> 
