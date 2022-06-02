Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADF953BA03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiFBNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiFBNn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:43:57 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8BB22DFA9;
        Thu,  2 Jun 2022 06:43:56 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f2bb84f9edso6752595fac.10;
        Thu, 02 Jun 2022 06:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQGK49GF9DeJULgey4jAcL7Oa6D8j/sPMETA1NkIOJc=;
        b=Cu7LV+csCy+r8W+x49zmlFAorzLEeBJnp4ckf64UcOVT9xd8+9/V3mCUqkXMdCHUIq
         OhGxxHBn8bq2XMxeRL84Gp5D14TLkepVBIXvh9/M8KS3lwxX3bJveVIVGFt1qDJDwClG
         1tt+L7jZ9VmAIhUiw77ZvRNyzYlatfpa8hfCzHuS7rvM650juCp9z+Jc8V1T5/Wpu5gy
         NwuyQNnejLk9V6lrdZ1vE5JymcWHb251sQFohWtU5x2gO8DJ3pKKasyERFHOJTAxcBZg
         o/90Sl0+khp82U/5/M31QbPZGyOqPQdnFX+ujbJ1xs3i0vObBaXNdAURApDn806OHRfP
         1Zbw==
X-Gm-Message-State: AOAM532xQs5+MWK4jpcrSO55GFTuqJr0wPXeLkSPRZ1yw+YiXIkDKHbT
        npMj65/NkYOj/7/CPScvi090wP380g==
X-Google-Smtp-Source: ABdhPJzL70GYPEawMMZyFEupbpoldLQk6350MsIEKUwqginMohKYrSm6Ju3LfMU8fTraG27RUbk8xA==
X-Received: by 2002:a05:6871:b0f:b0:f3:3687:524b with SMTP id fq15-20020a0568710b0f00b000f33687524bmr2642992oab.131.1654177435454;
        Thu, 02 Jun 2022 06:43:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a4adbd2000000b0040eb1d3f43dsm2330707oou.2.2022.06.02.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:43:55 -0700 (PDT)
Received: (nullmailer pid 2175981 invoked by uid 1000);
        Thu, 02 Jun 2022 13:43:54 -0000
Date:   Thu, 2 Jun 2022 08:43:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        yuji2.ishikawa@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu: bindings: Add binding documentation for
 Toshiba Visconti5 IOMMU device
Message-ID: <20220602134354.GA2170842-robh@kernel.org>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525013147.2215355-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 10:31:46AM +0900, Nobuhiro Iwamatsu wrote:
> Add documentation for the binding of Toshiba Visconti5 SoC's IOMMU.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/iommu/toshiba,visconti-atu.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
> new file mode 100644
> index 000000000000..af8d6688fa70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license: GPL-2.0-only OR BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/toshiba,visconti-atu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba ARM SoC Visconti5 IOMMU (ATU)
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description: |+
> +  IOMMU (ATU) driver can bse used for Visconti5's multimedia IPs, such as

Bindings are for hardware, not drivers.

> +  DCNN (Deep Convolutional Neural Network), VIIF(Video Input), VOIF(Video
> +  output), and others.
> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-atu
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#iommu-cells":
> +    const: 0
> +
> +  toshiba,max-entry:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The size of entry for address
> +    enum:
> +      - 16
> +      - 32
> +
> +  toshiba,reserved-entry:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The reserve number of entry address.
> +    default: 0
> +    minimum: 0
> +    maximum: 32

These 2 need a better description of what they are for.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#iommu-cells"
> +  - toshiba,max-entry
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        atu_affine0: iommu@1400f000 {

Drop unused labels.

> +            compatible = "toshiba,visconti-atu";
> +            reg = <0 0x1400F000 0 0x1000>;
> +            toshiba,max-entry = <16>;
> +            toshiba,reserved-entry = <1>;
> +            #iommu-cells = <0>;
> +        };
> +    };
> -- 
> 2.36.0
> 
> 
> 
