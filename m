Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579EE53CD27
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiFCQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbiFCQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:25:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FBD5131C;
        Fri,  3 Jun 2022 09:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB0896195F;
        Fri,  3 Jun 2022 16:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A239C385A9;
        Fri,  3 Jun 2022 16:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654273507;
        bh=4rw9dnXElz7aaMM5oeE5jfIs71mLFoPFuBfRRckUmRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jUrPgyXf8lp+ALxVFmsd5m8fqg6DzUeCDsk1uHrHqSxQ6Pfr951Vtu6O7upSVw845
         eRckR2c2q9tIwqsCPGmzUtDZ7EiJN7KkabGeLhDeRKZI8a/N4oiMOcgoW+ui+lkrPR
         wVyqnq3xUwMT3X9uVr3ST3n3jQfBa1/BiXw9pZ1iokMS2pLgJ5qH9vsTLdVyuP0Mmp
         E2gpPUi73jEDopcSXLhOYPWj6uQaWMbCFQ+hyEjHmta/WtCMT72BxRpmGzMKvgK1/L
         18ufwHNbk2pBaeJ9f7UCJRddmDreMuSJZOhppEeqL7DTbXTyZRJ88qbtMy0y97GWEh
         sflnWPW9nqrqg==
Date:   Fri, 3 Jun 2022 17:34:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: iio: adc: axp209: Add AXP192
 compatible
Message-ID: <20220603173404.4cb83647@jic23-huawei>
In-Reply-To: <20220603135714.12007-4-aidanmacdonald.0x0@gmail.com>
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
        <20220603135714.12007-4-aidanmacdonald.0x0@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jun 2022 14:57:07 +0100
Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:

> The AXP192 is identical to the AXP20x, except for two additional
> GPIO ADC channels.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

There is an argument that could be made here to say this should
have a fallback compatible to a suitable existing part as the driver
would work, we'd just be missing a couple of channels.

I don't feel strongly either way, but thought I'd raise the possibility.

I guess it's irrelevant if an updated kernel is needed anyway to have
it functional because of support needed for some other part of the chip
though.

Jonathan

> ---
>  .../bindings/iio/adc/x-powers,axp209-adc.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> index d6d3d8590171..1a68e650ac7d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
> @@ -14,6 +14,23 @@ description: |
>    Device is a child of an axp209 multifunction device
>    ADC channels and their indexes per variant:
>  
> +  AXP192
> +  ------
> +   0 | acin_v
> +   1 | acin_i
> +   2 | vbus_v
> +   3 | vbus_i
> +   4 | pmic_temp
> +   5 | gpio0_v
> +   6 | gpio1_v
> +   7 | gpio2_v
> +   8 | gpio3_v
> +   9 | ipsout_v
> +  10 | batt_v
> +  11 | batt_chrg_i
> +  12 | batt_dischrg_i
> +  13 | ts_v
> +
>    AXP209
>    ------
>     0 | acin_v
> @@ -50,6 +67,7 @@ description: |
>  properties:
>    compatible:
>      oneOf:
> +      - const: x-powers,axp192-adc
>        - const: x-powers,axp209-adc
>        - const: x-powers,axp221-adc
>        - const: x-powers,axp813-adc

