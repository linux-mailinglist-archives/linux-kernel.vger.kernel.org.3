Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36040488A1C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiAIPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:10:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56608 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiAIPKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:10:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FDD9B802C8;
        Sun,  9 Jan 2022 15:09:59 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 8400FC36AEB;
        Sun,  9 Jan 2022 15:09:56 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:15:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/adc: ti,palmas-gpadc: Split interrupt
 fields in example
Message-ID: <20220109151553.1c14810d@jic23-huawei>
In-Reply-To: <20220106182518.1435497-3-robh@kernel.org>
References: <20220106182518.1435497-3-robh@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jan 2022 12:25:11 -0600
Rob Herring <robh@kernel.org> wrote:

> Best practice for multi-cell property values is to bracket each multi-cell
> value.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git.

I'm assuming there is no rush on this as it's best practice rather than a bug.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml        | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> index 7b895784e008..57a31356082e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
> @@ -74,9 +74,9 @@ examples:
>          compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
>          adc {
>              compatible = "ti,palmas-gpadc";
> -            interrupts = <18 0
> -                          16 0
> -                          17 0>;
> +            interrupts = <18 0>,
> +                         <16 0>,
> +                         <17 0>;
>              #io-channel-cells = <1>;
>              ti,channel0-current-microamp = <5>;
>              ti,channel3-current-microamp = <10>;

