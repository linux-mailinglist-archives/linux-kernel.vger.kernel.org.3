Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904394E87EB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiC0NtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiC0NtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 09:49:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D62213E94;
        Sun, 27 Mar 2022 06:47:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7345B8013C;
        Sun, 27 Mar 2022 13:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D99C340EC;
        Sun, 27 Mar 2022 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648388859;
        bh=GcofGmQumimhl5OM4grJQX7kjo1GV6TWDaRRje8li8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DVQEy2ex/vXD/NWI7KoNA5kIgUAVdd5vGyP4CG3hIh7nfMTVyQeQO5Ir+jkYThHL5
         zRVVCumoQMVF0Tpd15Gfle0lul0LGBIsjhXbGvnwgf5bs5OxhnZQeOki8CGIN8tENg
         w0D0sobt4gRRJChRVfQeRccEX96obw2BK09zh1p2qPMuIVC+ysi+lK/KRQwPMDsQy2
         x+8TJRrjDmH6bRtbxsm2X1MIRQh6//az54g1CusTZSE6temv6JQMqXC6u0B+zDhwMo
         yViHnXdP8SQYrVlp+98noCPB6pP5ZdTMipSYahDM/dB6f/kCL8bgoTe1b5amVSSgPY
         BhJwuUjk8wmag==
Date:   Sun, 27 Mar 2022 14:55:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH 2/3] dt-bindings: Document ltrf216a light sensor
 bindings
Message-ID: <20220327145511.2d36dd10@jic23-huawei>
In-Reply-To: <20220325103014.6597-3-shreeya.patel@collabora.com>
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-3-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 16:00:13 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Add devicetree bindings for ltrf216a ambient light sensor
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Hi Shreeya,

As we are making this Zhigang Shi's problem to maintain, I'm 
looking for an ack.  Bit mean otherwise :)

Except for the deprecated part this could just have gone in
trivial-bindings.yaml.

I guess you don't need it for your existing board, but best
practice would probably include ensuring whatever supplies
the device needs are here so that platforms that don't enable
them by default can turn them on.

Also, there is an interrupt according to the datasheet linked
from patch 3 and that should definitely be in the binding
even if the driver isn't using it.

Jonathan


> ---
>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> new file mode 100644
> index 000000000000..275d86a0353a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LTRF216A Ambient Light Sensor
> +
> +maintainers:
> +  - Zhigang Shi <Zhigang.Shi@liteon.com>
> +
> +description: |
> +  Ambient sensing with an i2c interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - liteon,ltrf216a
> +      - ltr,ltrf216a
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@53 {
> +                compatible = "ltr,ltrf216a";
> +                reg = <0x53>;
> +        };
> +    };
> +...

