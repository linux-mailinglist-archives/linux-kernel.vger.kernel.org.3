Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E8248BCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348248AbiALCI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:08:59 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36527 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiALCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:08:57 -0500
Received: by mail-ot1-f42.google.com with SMTP id s21-20020a05683004d500b0058f585672efso954660otd.3;
        Tue, 11 Jan 2022 18:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qv9s6j6RhpBxf9d3C4bU6cUX2QC6sqzpiw6XcMn6uWs=;
        b=YCCWnxthMmVlPjmLE787rtbbQf7IAjyjIPrAqDvQdtWAhqqYkBEdEracW+r/t3fpgS
         rXDyD5yJ6bAW6q+dlTq777yoPO7A3VOGlSVAefu4DynPYR3VPBnCzlGMli22jS5DnK0f
         opvdac3nmAitTnNWtCzkn7H2SbkXRT9dSQznvX0czRxVH/ROTqgoYIg6rXrGEOLddgIA
         G/ud8rvFW+qkDlQGUyXOKhbLRFE9I7wgzdd8K6+Gmu24b5hjSqAi2wJCJJgHFqgZZ4yk
         hBk3fXNMwJADPJtlK7q4dPIjToCnyNr6IU0BGQU2OUPU5QMa+YC3U/aMY3M4Lkfq+ywS
         EIeQ==
X-Gm-Message-State: AOAM533DPb5Nj+YAm0OVj7g8vT5FujXPYdSMNjw3BguqMCGBEFeIRp0s
        CQ6ZBUOMfDfqyi/3AnNAng==
X-Google-Smtp-Source: ABdhPJxfv0f51SXHqiaN8up+LH1wKKQXWgiNH9sgJV6XwJhYYOsdxuIDMthbn17PAW5R5z5TV6yVGQ==
X-Received: by 2002:a05:6830:13d5:: with SMTP id e21mr5234752otq.168.1641953336418;
        Tue, 11 Jan 2022 18:08:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e69sm113007ote.1.2022.01.11.18.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:08:55 -0800 (PST)
Received: (nullmailer pid 3925789 invoked by uid 1000);
        Wed, 12 Jan 2022 02:08:54 -0000
Date:   Tue, 11 Jan 2022 20:08:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ~okias/devicetree@lists.sr.ht, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Message-ID: <Yd44NhcBWh1c4vuV@robh.at.kernel.org>
References: <20220108184143.69479-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108184143.69479-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 07:41:42PM +0100, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - fix wrong path in binding $id
>  - comment qcom,mdp4 node example (we don't want to validate it yet)
> 
> v3:
>  - I kept the name as -v0, since we have other binding -v1 and it look
>    good, I can change thou in v4 if requested.

The preference is to use compatible strings for filenames. There's 
little reason not to do that here.

>  - dropped non-existent smmu_clk part (and adjusted example, which was
>    using it)
>  - dropped iommu description
>  - moved iommu-cells description to the property #iommu-cells
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
>  .../bindings/iommu/qcom,iommu-v0.yaml         | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 64 deletions(-)
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
> index 000000000000..a506e8ad8902
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> @@ -0,0 +1,91 @@
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
> +    items:
> +      - const: smmu_pclk
> +      - const: iommu_clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Specifiers for the MMU fault interrupts.
> +    minItems: 1
> +    items:
> +      - description: non-secure mode interrupt
> +      - description: secure mode interrupt (for instances which supports it)
> +
> +  "#iommu-cells":
> +    const: 1
> +    description: |
> +      The first cell is a phandle to the IOMMU and
> +      the second cell is the stream id.
> +      A single master device can be connected to more than one iommu
> +      and multiple contexts in each of the iommu.
> +      So multiple entries are required to list all the iommus and
> +      the stream ids that the master is connected to.
> +
> +  qcom,ncb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The total number of context banks in the IOMMU.
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
> +                "iommu_clk";
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
