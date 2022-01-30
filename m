Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9E04A3623
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 13:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354750AbiA3MLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 07:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiA3MLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 07:11:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D97C061714;
        Sun, 30 Jan 2022 04:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AAE9BCE0E8B;
        Sun, 30 Jan 2022 12:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F16C340E4;
        Sun, 30 Jan 2022 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643544658;
        bh=3OyJ49EmCju1DvvhXIuA6J36rxsK/GREk9R0i8V2Shg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZOxLAYGXPMZMP0uzaw/EOhD4xLah0MQv4rd+PJQY2p78iszb/D9LtyGAX9JqQzCw1
         XWWbr/6WBulW6/BOeK5VrG+AtJPZ45kEFjUBX1C6LbqGkbceq4dSF3vIGxEotBzJer
         +tI7u3O/tfDGtebC+M9dzX1PVlAUnXdbqcc6fU5VHbKXst5sXSmrIMTF0PepdoxSVq
         RbvADtoxukgJnncQTqw6W58K+OuqL62P0bPLWg01+x2Qiguv3PkNYzHIpqCrVP6Vor
         cOUN7Wx9sU8Zu9a0cJaDaNTbZ3zXMiHjKb4Rw0F8EyKU7FaWodGvmdnmMicRNQ2ABR
         0nicgkmVl0omA==
Date:   Sun, 30 Jan 2022 12:17:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/adc: qcom,spmi-iadc: Fix 'reg'
 property in example
Message-ID: <20220130121721.62cc90db@jic23-huawei>
In-Reply-To: <20220126231217.1633935-1-robh@kernel.org>
References: <20220126231217.1633935-1-robh@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 17:12:17 -0600
Rob Herring <robh@kernel.org> wrote:

> The QCom SPMI PMIC child nodes are defined to have a single address cell,
> but the example has an erroneous size cell. Remove it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Probably should have a fixes tag...
Fixes: a4e6bf69418c ("dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.")

Given it's been there a long time I'm guessing no great rush on this so I'll
queue it up for then next merge window.

Shout if you want to pick it up sooner.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
> index 27e3108661c0..2a94db688830 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
> @@ -51,7 +51,7 @@ examples:
>          #size-cells = <0>;
>          pmic_iadc: adc@3600 {
>              compatible = "qcom,spmi-iadc";
> -            reg = <0x3600 0x100>;
> +            reg = <0x3600>;
>              interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
>              qcom,external-resistor-micro-ohms = <10000>;
>              #io-channel-cells  = <1>;

