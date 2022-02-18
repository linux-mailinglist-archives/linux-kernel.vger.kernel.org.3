Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A94BB8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiBRL5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:57:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiBRL5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:57:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B6253BE5;
        Fri, 18 Feb 2022 03:57:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0097061F58;
        Fri, 18 Feb 2022 11:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE1DC340E9;
        Fri, 18 Feb 2022 11:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645185426;
        bh=kUbpTt/StXluIZwwl2qBkxYOiqUkjNO4FOl6aWmkKgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GxwBfGr8ZW19lDxtJvWqMkKDLHE29ewva9Z5w5wTqgsRIc/oWypmSBMOGez3bUB77
         wOUrA4reZxkn5hagfLnGvI/b2eh58WVZ9qJRvRZ4bhGAN+Uv0sKqOhgIp2RMiQcPr/
         6fQai/yh6H2DAhtsOItLpCKoz7i+oTZIgqxq/Q2Kq1c8FhwNbGlfRpdj8kYOMBlc5b
         4t8ByMv94NaewMe8SPseAAGO3Y1Qh1HT9Tuf9oDDllMIjwlo9zv3zSrC2HZ0e59EI1
         loyUFvDZwia2cqIjejXlj3lSw0sqtLsNdl44jOWs3Afa8XsLPP+lEKyCKgJTLZQW8s
         xJVvGgOPbe9pg==
Date:   Fri, 18 Feb 2022 12:03:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v4 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Message-ID: <20220218120355.4b7c33e1@jic23-huawei>
In-Reply-To: <20220218095048.86826-1-cristian.pop@analog.com>
References: <20220218095048.86826-1-cristian.pop@analog.com>
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

On Fri, 18 Feb 2022 11:50:47 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---

Change log?  Also, looks like this crossed with a question from
Rob on v3.

Thanks,

Jonathan


>  .../bindings/iio/frequency/adi,admv4420.yaml  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> new file mode 100644
> index 000000000000..35a3fb3fd339
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv4420.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV4420 K Band Downconverter
> +
> +maintainers:
> +  - Cristian Pop <cristian.pop@analog.com>
> +
> +description:
> +  The ADMV4420 is a highly integrated, double balanced, active
> +  mixer with an integrated fractional-N synthesizer, ideally suited
> +  for next generation K band satellite communications
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admv4420
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  adi,lo-freq-khz:
> +    description: LO Frequency
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  adi,ref-ext-single-ended-en:
> +    description: External reference selected.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv4420@0 {
> +        compatible = "adi,admv4420";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        adi,lo-freq-khz = <16750000>;
> +        adi,ref-ext-single-ended-en;
> +      };
> +    };
> +...

