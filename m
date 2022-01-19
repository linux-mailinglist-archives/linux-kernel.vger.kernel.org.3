Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D38493B61
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354906AbiASNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:47:20 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41914 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiASNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:47:19 -0500
Received: by mail-ot1-f53.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso3123881otj.8;
        Wed, 19 Jan 2022 05:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lbHUREH8Nb6sbGTV6EknyNbmczeBBVZ9XP6lLLWfQc=;
        b=Z3qU7/4pctLM/E6bmTgv2WO71gzFLGTPQ4llPYiQD/ca2zFHdKCgE6c9kNNnyOHwAu
         wSiWuKTGRU3nhdswJK+LLdUdp8yBpmGWD2jYUklaQSHXVCc7Bc8bDkW93ofF5q1MwaxU
         N6Ug+5a7tiZSjZe94wjD4phDtmEgts4pJwwzISVU66xSJT8m11efIAiVWez67ehGAzqb
         GvadkGjyv0FoOSe9EvsYyBIJVfUJGQ7dm48vw78Y30zFId8c1hUNPaCoKsmmtcDVLpWb
         oLc86eFQCQmrgqKXTIrKGd1VdU1gpokcgHiqGBckjFnVJ/V9lA1B6rcW+Us6kfveGubF
         pCUw==
X-Gm-Message-State: AOAM532/hF98Z9h3VQIjTE+4tv5+lZB1rYfj+97EYCiaTm1nVC/Z1Mvg
        MWi4C5RgjWE38runSKXQgw==
X-Google-Smtp-Source: ABdhPJwDjr7szNDp5zhXx+HBPJmqwidp4YYQnLFH2R2fwaY8oZO7dmYKINnpSjcsZJOGLNt21ZIjjw==
X-Received: by 2002:a05:6830:2645:: with SMTP id f5mr3688318otu.20.1642600039207;
        Wed, 19 Jan 2022 05:47:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s9sm5284320oov.4.2022.01.19.05.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:47:18 -0800 (PST)
Received: (nullmailer pid 3452035 invoked by uid 1000);
        Wed, 19 Jan 2022 13:47:17 -0000
Date:   Wed, 19 Jan 2022 07:47:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Message-ID: <YegWZe4lSok84gyW@robh.at.kernel.org>
References: <20220117165247.15718-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117165247.15718-1-cristian.pop@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 06:52:46PM +0200, Cristian Pop wrote:
> Add device tree bindings for the ADMV4420 K band downconverter.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  .../bindings/iio/frequency/adi,admv4420.yaml  | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> new file mode 100644
> index 000000000000..f26af2718f23
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admv4420.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMV4420 K Band Downconverter
> +
> +maintainers:
> +- Cristian Pop <cristian.pop@analog.com>
> +
> +description: |

Don't need '|' when there is no formatting to preserve.

> +    The ADMV4420 is a highly integrated, double balanced, active
> +    mixer with an integrated fractional-N synthesizer, ideally suited
> +    for next generation K band satellite communications

Blank line.

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
> +  adi,lo_freq_hz:

s/_/-/

> +    description: LO Frequency
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +
> +  adi,ref_ext_single_ended_en:

s/_/-/

> +    description: External reference selected.
> +    type: boolean
> +
> +required:
> +- compatible
> +- reg
> +
> +additionalProperties: false
> +
> +examples:
> +- |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      admv4420@0 {
> +        compatible = "adi,admv4420";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        adi,lo_freq_hz = /bits/ 64 <16743700000>;
> +        adi,ref_ext_single_ended_en;
> +      };
> +    };
> +...
> -- 
> 2.17.1
> 
> 
