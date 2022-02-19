Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43E74BCA20
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbiBSSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:44:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiBSSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:44:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF04350E21;
        Sat, 19 Feb 2022 10:43:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31B42CE0AC0;
        Sat, 19 Feb 2022 18:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B110AC340ED;
        Sat, 19 Feb 2022 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645296227;
        bh=NTP0TpFvOtfTOvjqKjBMOO0Y1TPdpq2v2eaLgNU5lVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bAwhDrXKO7kf28Zw46evDEL+6gdTGX1425IYH5b4ioDlEfduyBR9Z7AHWyPGAHkYN
         a+pdR/4A+3nOgukF/0jAksfVh+PEZOm/3vQMD0JTbZSPmLQPK/IzrEP5orYfv9UnPz
         T3ZaeEIC5Z0JYtpFHndiPZ0eVIK86yUWfke+30LGl+pgXaUlu8NH3c8GAGgo+tt3+p
         2nxuNMN7gQ28jgaFNPQ3HxuQb2lRmIUSOSw/yAGCKbWteiyCsI4PsaGuOX0lMSBg0W
         6rYCg4rgT25pe0FZWLigLmJRXu39Y8H9noc05wjHnHWohsYGKBG+agcgLPP1RTPNz4
         11BrUbsx+1XFQ==
Date:   Sat, 19 Feb 2022 18:50:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings:iio:amplifiers: add ada4250 doc
Message-ID: <20220219185035.21e1ae9b@jic23-huawei>
In-Reply-To: <20220214094115.48548-2-antoniu.miclaus@analog.com>
References: <20220214094115.48548-1-antoniu.miclaus@analog.com>
        <20220214094115.48548-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 11:41:14 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add device tree bindings for the ADA4250 driver.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,ada4250.yaml  | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> new file mode 100644
> index 000000000000..22283ab48903
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,ada4250.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADA4250 Programmable Gain Instrumentation Amplifier
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Precision Low Power, 110kHz, 26uA, Programmable Gain Instrumentation Amplifier.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ada4250
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  adi,refbuf-enable:
> +    description:
> +      Enable internal buffer to drive the reference pin.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false

Given it's an spi driver, probably want to add
spi-max-frequency: true to the allowed properties

Otherwise, lgtm
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      ada4250@0{
> +        compatible = "adi,ada4250";
> +        reg = <0>;
> +        avdd-supply = <&avdd>;
> +      };
> +    };
> +...

