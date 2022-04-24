Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97D950D30A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbiDXQHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiDXQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:07:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558547B127;
        Sun, 24 Apr 2022 09:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11F0FB80DD4;
        Sun, 24 Apr 2022 16:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44783C385A9;
        Sun, 24 Apr 2022 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650816244;
        bh=g8dkPhiULK/SVyEdnpRLy5JR9O4qchMC2KRkj1DVmx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OdmrwaqhoK/HFNPQYlIIJDmZbLgVG9fZJG28WGp3SXEV1c6F3+qBQ5enRuBAykzWl
         x8fvbxJWOHCoM7QIeiUJPyDMI+W7GrN/1CYA5Xg030L5M0FZFhbvHCmwNnUQ5VZHjp
         Ayr40WNb7fI0t/4Zx+VbFHPYHN0Dg7oLnc+Nx6Loe1Ui3/g9c1FZmuH/9vf7LnadXW
         9OpZ+jq4hQ7oso3NQ6RjwoP75gRbG7hzZMlrC9a2+TstaCSsO+7Z/nvj7K89OAJ6Pp
         uANpriusle4YSoHmomU8kudET++FHffsJCWBMgIKEzX8RaAPuW2FB0ztulaYSofCkO
         kRZkhVSfBZckA==
Date:   Sun, 24 Apr 2022 17:12:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Fix incorrect compatible strings in
 examples
Message-ID: <20220424171212.6d247854@jic23-huawei>
In-Reply-To: <20220422192039.2590548-1-robh@kernel.org>
References: <20220422192039.2590548-1-robh@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 14:20:39 -0500
Rob Herring <robh@kernel.org> wrote:

> Fix a couple of examples using incorrect compatible strings.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

or I can pick these up through IIO if preferred.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml     | 2 +-
>  .../bindings/iio/potentiometer/microchip,mcp4131.yaml           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> index edf804d0aca2..b1eb77335d05 100644
> --- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> @@ -68,7 +68,7 @@ examples:
>        #size-cells = <0>;
>  
>        dac@0 {
> -        compatible = "lltc,ltc2632";
> +        compatible = "lltc,ltc2632-l12";
>          reg = <0>;    /* CS0 */
>          spi-max-frequency = <1000000>;
>          vref-supply = <&vref>;
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
> index 945a2d644ddc..32e92bced81f 100644
> --- a/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.yaml
> @@ -95,7 +95,7 @@ examples:
>          #size-cells = <0>;
>  
>          potentiometer@0 {
> -            compatible = "mcp4131-502";
> +            compatible = "microchip,mcp4131-502";
>              reg = <0>;
>              spi-max-frequency = <500000>;
>          };

