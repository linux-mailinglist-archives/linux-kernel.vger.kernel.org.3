Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ACB563893
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiGAR0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGAR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:26:47 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064934B86;
        Fri,  1 Jul 2022 10:26:46 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id y2so2871391ior.12;
        Fri, 01 Jul 2022 10:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tNDBOPW04ACWjZ1RmSaGHvRH0YNKgzkEiDOcMmz1kTM=;
        b=EOPAH0bqVQ0LpKx4yA9LP2q7wiKQSUqMGITAtw1cicZvRYFaVirPiBBAkY+aVjmRPz
         7taFY3RKPidYhLUW3XsI2ixvrWdpRo6+nTydRh3SYmhaaP1aeqmd3H8hoCDBft/N+zIw
         joiER2KE6YwVcZUQbPRO9+bBgwfG3a4KN7glXQmKLv4b5nfjPh4deX72FjMp1dG7D+U9
         DC9ltMtRSmbVnDozmTdVtQoZmdtLlCGkz06ln/Ye8Ko41uhVI3eR3C8i3AO7uuzvrUPd
         BLZaBRMHJZ3fj42xxqX6tu7NfPJeZ5PWh+Ps4XVcBlGfzt+mVz7nqnz/zcYiL6JFA6eb
         b51A==
X-Gm-Message-State: AJIora+BfdzL9dnSAM66BZffpJ86xLrYFr3xL8XVzCM5nAw1+LWY3qFa
        Px2LNGmcll3Fq23su5NtIA==
X-Google-Smtp-Source: AGRyM1s5YOKYKPpMyMLPlv7bpieOeXCM9X1M6uBU3vBT6xcL2vVhAJuG+3VAMTcmOEDmFw4yZUowRw==
X-Received: by 2002:a05:6638:2b7:b0:33c:d250:12b9 with SMTP id d23-20020a05663802b700b0033cd25012b9mr8636531jaq.220.1656696405810;
        Fri, 01 Jul 2022 10:26:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u71-20020a02234a000000b0033074471f78sm9990232jau.101.2022.07.01.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 10:26:45 -0700 (PDT)
Received: (nullmailer pid 1175627 invoked by uid 1000);
        Fri, 01 Jul 2022 17:26:43 -0000
Date:   Fri, 1 Jul 2022 11:26:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/5] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
Message-ID: <20220701172643.GA1164683-robh@kernel.org>
References: <20220629121441.6552-1-ansuelsmth@gmail.com>
 <20220629121441.6552-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629121441.6552-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 02:14:38PM +0200, Christian Marangi wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, limit all the additional
> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> v1 and also flag that these bindings should NOT be used for v2.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 93 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> deleted file mode 100644
> index 7f696362a4a1..000000000000
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> -
> -The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> -There is one ACC register region per CPU within the KPSS remapped region as
> -well as an alias register region that remaps accesses to the ACC associated
> -with the CPU accessing the region.
> -
> -PROPERTIES
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: should be one of:
> -			"qcom,kpss-acc-v1"
> -			"qcom,kpss-acc-v2"
> -
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: the first element specifies the base address and size of
> -		    the register region. An optional second element specifies
> -		    the base address and size of the alias register region.
> -
> -- clocks:
> -        Usage: required
> -        Value type: <prop-encoded-array>
> -        Definition: reference to the pll parents.
> -
> -- clock-names:
> -        Usage: required
> -        Value type: <stringlist>
> -        Definition: must be "pll8_vote", "pxo".
> -
> -- clock-output-names:
> -	Usage: optional
> -	Value type: <string>
> -	Definition: Name of the output clock. Typically acpuX_aux where X is a
> -		    CPU number starting at 0.
> -
> -Example:
> -
> -	clock-controller@2088000 {
> -		compatible = "qcom,kpss-acc-v2";
> -		reg = <0x02088000 0x1000>,
> -		      <0x02008000 0x1000>;
> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> -		clock-names = "pll8_vote", "pxo";
> -		clock-output-names = "acpu0_aux";
> -	};
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> new file mode 100644
> index 000000000000..5e16121d9f0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/msm/qcom,kpss-acc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> +  There is one ACC register region per CPU within the KPSS remapped region as
> +  well as an alias register region that remaps accesses to the ACC associated
> +  with the CPU accessing the region.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,kpss-acc-v1
> +      - qcom,kpss-acc-v2
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region
> +      - description: Optional base address and size of the alias register region

Optional? Need 'minItems: 1' then.

> +
> +  clocks:
> +    items:
> +      - description: phandle to pll8_vote
> +      - description: phandle to pxo_board

Not necessarily just a phandle... Needs a better description in terms of 
the function of the clock within the KPSS ACC block, not the source.

> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  clock-output-names:
> +    description: Name of the aux clock. Krait can have at most 4 cpu.

s/cpu/CPUs/

> +    enum:
> +      - acpu0_aux
> +      - acpu1_aux
> +      - acpu2_aux
> +      - acpu3_aux
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: qcom,kpss-acc-v1
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +    - clock-output-names
> +    - '#clock-cells'
> +else:
> +  properties:
> +    clocks: false
> +    clock-names: false
> +    clock-output-names: false
> +    '#clock-cells': false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +
> +    clock-controller@2088000 {
> +      compatible = "qcom,kpss-acc-v1";
> +      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +      clock-names = "pll8_vote", "pxo";
> +      clock-output-names = "acpu0_aux";
> +      #clock-cells = <0>;
> +    };
> +
> +  - |
> +    clock-controller@f9088000 {
> +      compatible = "qcom,kpss-acc-v2";
> +      reg = <0xf9088000 0x1000>,
> +            <0xf9008000 0x1000>;
> +    };
> +...
> -- 
> 2.36.1
> 
> 
