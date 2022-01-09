Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F5A488A19
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiAIPId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:08:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59500 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiAIPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:08:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A0E60A55;
        Sun,  9 Jan 2022 15:08:31 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 05899C36AEB;
        Sun,  9 Jan 2022 15:08:28 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:14:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/magnetometer: yamaha,yas530: Fix
 invalid 'interrupts' in example
Message-ID: <20220109151424.15346254@jic23-huawei>
In-Reply-To: <20220106182518.1435497-4-robh@kernel.org>
References: <20220106182518.1435497-4-robh@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Jan 2022 12:25:12 -0600
Rob Herring <robh@kernel.org> wrote:

> 'interrupts' does not take a phandle, so remove it in the example.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
I can pick this up, but if you want to take it.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
> index 4b0ef1ef5445..9438fffaf0ba 100644
> --- a/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/yamaha,yas530.yaml
> @@ -96,7 +96,7 @@ examples:
>            vdd-supply = <&ldo1_reg>;
>            iovdd-supply = <&ldo2_reg>;
>            reset-gpios = <&gpio6 12 GPIO_ACTIVE_LOW>;
> -          interrupts = <&gpio6 13 IRQ_TYPE_EDGE_RISING>;
> +          interrupts = <13 IRQ_TYPE_EDGE_RISING>;
>          };
>      };
>  

