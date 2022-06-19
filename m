Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42515550A98
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiFSMZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFSMZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:25:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C7BC80;
        Sun, 19 Jun 2022 05:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B236EB80BA0;
        Sun, 19 Jun 2022 12:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA1DC34114;
        Sun, 19 Jun 2022 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655641499;
        bh=d2hzVNI9CHhwrX4ZalJ07kLK722DFdhax7bWmTW0wWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EOPICYTrUU+8viPQIoVbfXPDdit26tyqz2JqFHp5k4hodzeE9SCn6xSaAL2TJ5TqD
         UIcrQglb1LAKB5acU1tDByyNeRH9B5yt0LrnUibxwcXcPj60Oqy6RC+LTzaGiV5Tyf
         yC150H7OfJdVGFk3vsso5IDRChLqdkUVZxiR3Ya681ihVozimss76x7bkwbrX0Iuor
         bWVrHNjkO8B5UmHu/dO+Y1i+Aqoe38qP7iCXRAwA8IfF27NTTEeBR8pfOw6aFv5Epp
         AptRHTPoz1T3t8RjU9vKMOZys/X20yjRppW1WDG/lMkqs5Q/u4HNRWg8UHrM2mDyzG
         2hmn0pYIVFYBQ==
Date:   Sun, 19 Jun 2022 13:34:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com,
        andy.shevchenko@gmail.com, digetx@gmail.com
Subject: Re: [PATCH v6 1/2] dt-bindings: Document ltrf216a light sensor
 bindings
Message-ID: <20220619133415.5b3762d3@jic23-huawei>
In-Reply-To: <20220615135130.227236-2-shreeya.patel@collabora.com>
References: <20220615135130.227236-1-shreeya.patel@collabora.com>
        <20220615135130.227236-2-shreeya.patel@collabora.com>
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

On Wed, 15 Jun 2022 19:21:29 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Add devicetree bindings for ltrf216a ambient light sensor.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v5
>   - Remove deprecated string 'ltr' from the bindings.
> 
> Changes in v3
>   - Fix indentation in the example section
> 
> Changes in v2
>   - Take over the maintainership for the bindings
>   - Add interrupt and power supply property in DT bindings
> 
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> new file mode 100644
> index 000000000000..f256ff2e744c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTRF216A Ambient Light Sensor
> +
> +maintainers:
> +  - Shreeya Patel <shreeya.patel@collabora.com>
> +
> +description:
> +  Ambient light sensing with an i2c interface.
> +
> +properties:
> +  compatible:
> +    const:
> +      - liteon,ltrf216a
I assume you figured this out from the build bot error.

	const: liteon,ltrf216a

Please make sure to do what that message from Rob's bot says and test your bindings
before sending v7.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@53 {
> +            compatible = "liteon,ltrf216a";
> +            reg = <0x53>;
> +            vdd-supply = <&vdd_regulator>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };

