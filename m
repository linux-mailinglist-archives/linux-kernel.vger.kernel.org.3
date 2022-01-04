Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBFD484A98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiADWVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:21:49 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:34798 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiADWVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:21:48 -0500
Received: by mail-ot1-f54.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso46804938oti.1;
        Tue, 04 Jan 2022 14:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIRIjVAxLAvaKX3Gc+RLn9a30jBouaD7oSrdlD+iXfE=;
        b=OhS/+ttRrIh2UuX7K685lWSnpzM9YwKrRwDVh+gFGYcRgfUeRdifbw2TH+GRv8oibC
         TWfEQ9wCjIOHvbMptJ3WUrcM8KSFHa0YjpqHAT/vDZFGlfEPRDJsh5puk2U11P6IU8q/
         iJrP0zj6iWHD4wlYq5a9btiwsbF+Fcj2PPfLXN32r43pdwm5ZVjIsKM3gawQ1ojJUF74
         Fd+XRbnBzKeWHtBHpttqTeSJukNf5Q59xUfmA44gPgiBhjMxeyBEe9NS3JbdiFYN1qOv
         kfJN2mUTL/Vt95DwF9GIiDgtYYFle2ReKkMdr4ge/j6cQ/5qFP3rpYZarIhNznx9aPRi
         THtw==
X-Gm-Message-State: AOAM533QXKV36ZX0hi/I28oi1Mprb0bkY5G2RljQSpTKj1VtZs07xsNq
        alrjEwER64IxF89PTqTfYQ==
X-Google-Smtp-Source: ABdhPJw8C1rfqCqeEc1yJ6y1fz2F7Ico3ryaw4i0Lv3vcZ/SE0/FYv4dcM2+FX1/udDTK4lTMH9bqA==
X-Received: by 2002:a9d:744f:: with SMTP id p15mr37327564otk.314.1641334907595;
        Tue, 04 Jan 2022 14:21:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q26sm7263643ooc.17.2022.01.04.14.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 14:21:46 -0800 (PST)
Received: (nullmailer pid 1549908 invoked by uid 1000);
        Tue, 04 Jan 2022 22:21:45 -0000
Date:   Tue, 4 Jan 2022 16:21:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Message-ID: <YdTIeRjM5PkJbpbO@robh.at.kernel.org>
References: <20211225193556.66804-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211225193556.66804-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 08:35:55PM +0100, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - fix wrong path in binding $id
>  - comment qcom,mdp4 node example (we don't want to validate it yet)
> 
>  .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
>   .../bindings/iommu/qcom,iommu-v0.yaml         | 96 +++++++++++++++++++

qcom,apq8064-iommu.yaml

At this point, I don't think we'll get a 2nd user.

>  2 files changed, 96 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> deleted file mode 100644
> index 20236385f26e..000000000000
> --- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -* QCOM IOMMU
> -
> -The MSM IOMMU is an implementation compatible with the ARM VMSA short
> -descriptor page tables. It provides address translation for bus masters outside
> -of the CPU, each connected to the IOMMU through a port called micro-TLB.
> -
> -Required Properties:
> -
> -  - compatible: Must contain "qcom,apq8064-iommu".
> -  - reg: Base address and size of the IOMMU registers.
> -  - interrupts: Specifiers for the MMU fault interrupts. For instances that
> -    support secure mode two interrupts must be specified, for non-secure and
> -    secure mode, in that order. For instances that don't support secure mode a
> -    single interrupt must be specified.
> -  - #iommu-cells: The number of cells needed to specify the stream id. This
> -		  is always 1.
> -  - qcom,ncb:	  The total number of context banks in the IOMMU.
> -  - clocks	: List of clocks to be used during SMMU register access. See
> -		  Documentation/devicetree/bindings/clock/clock-bindings.txt
> -		  for information about the format. For each clock specified
> -		  here, there must be a corresponding entry in clock-names
> -		  (see below).
> -
> -  - clock-names	: List of clock names corresponding to the clocks specified in
> -		  the "clocks" property (above).
> -		  Should be "smmu_pclk" for specifying the interface clock
> -		  required for iommu's register accesses.
> -		  Should be "smmu_clk" for specifying the functional clock
> -		  required by iommu for bus accesses.
> -
> -Each bus master connected to an IOMMU must reference the IOMMU in its device
> -node with the following property:
> -
> -  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
> -	    phandle to the IOMMU and the second cell is the stream id.
> -	    A single master device can be connected to more than one iommu
> -	    and multiple contexts in each of the iommu. So multiple entries
> -	    are required to list all the iommus and the stream ids that the
> -	    master is connected to.
> -
> -Example: mdp iommu and its bus master
> -
> -                mdp_port0: iommu@7500000 {
> -			compatible = "qcom,apq8064-iommu";
> -			#iommu-cells = <1>;
> -			clock-names =
> -			    "smmu_pclk",
> -			    "smmu_clk";
> -			clocks =
> -			    <&mmcc SMMU_AHB_CLK>,
> -			    <&mmcc MDP_AXI_CLK>;
> -			reg = <0x07500000 0x100000>;
> -			interrupts =
> -			    <GIC_SPI 63 0>,
> -			    <GIC_SPI 64 0>;
> -			qcom,ncb = <2>;
> -		};
> -
> -		mdp: qcom,mdp@5100000 {
> -			compatible = "qcom,mdp";
> -			...
> -			iommus = <&mdp_port0 0
> -				  &mdp_port0 2>;
> -		};
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> new file mode 100644
> index 000000000000..6f166c30b9ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: "http://devicetree.org/schemas/iommu/qcom,iommu-v0.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm IOMMU for APQ8064
> +
> +maintainers:
> +  - Will Deacon <will@kernel.org>
> +
> +description: >
> +  The MSM IOMMU is an implementation compatible with the ARM VMSA short
> +  descriptor page tables. It provides address translation for bus masters
> +  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +properties:
> +  compatible:
> +    const: qcom,apq8064-iommu
> +
> +  clocks:
> +    items:
> +      - description: interface clock for register accesses
> +      - description: functional clock for bus accesses
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: smmu_pclk
> +          - const: smmu_clk
> +      - items:
> +          - const: smmu_pclk
> +          - const: iommu_clk

Where did this come from? It wasn't documented before.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: >
> +      Specifiers for the MMU fault interrupts. For instances that
> +      support secure mode two interrupts must be specified, for non-secure and
> +      secure mode, in that order. For instances that don't support secure mode a
> +      single interrupt must be specified.

minItems: 1
items:
  - description: non-secure irq...
  - description: ...


> +
> +  "#iommu-cells":
> +    const: 1
> +
> +  qcom,ncb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The total number of context banks in the IOMMU.
> +
> +# Each bus master connected to an IOMMU must reference the IOMMU
> +# in its device node with the following property:

What property? No need to describe how the iommu binding works.

> +#   A reference to the IOMMU in multiple cells. The first cell is a
> +#   phandle to the IOMMU and the second cell is the stream id.
> +#   A single master device can be connected to more than one iommu
> +#   and multiple contexts in each of the iommu. So multiple entries
> +#   are required to list all the iommus and the stream ids that the
> +#   master is connected to.

Put the cells description under #iommu-cells.

> +
> +required:
> +  - clocks
> +  - clock-names
> +  - reg
> +  - interrupts
> +  - qcom,ncb
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
> +
> +    mdp_port0: iommu@7500000 {
> +            compatible = "qcom,apq8064-iommu";
> +            #iommu-cells = <1>;
> +            clock-names =
> +                "smmu_pclk",
> +                "smmu_clk";
> +            clocks =
> +                <&clk SMMU_AHB_CLK>,
> +                <&clk MDP_AXI_CLK>;
> +            reg = <0x07500000 0x100000>;
> +            interrupts =
> +                <0 63 0>,
> +                <0 64 0>;
> +            qcom,ncb = <2>;
> +    };
> +
> +    /* mdp: mdp@5100000 {
> +            compatible = "qcom,mdp4";
> +            ...
> +
> +            iommus = <&mdp_port0 0
> +                      &mdp_port0 2>;
> +    };*/
> -- 
> 2.34.1
> 
> 
