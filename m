Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D44C4EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiBYT04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiBYT0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:26:54 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D61C1EF36A;
        Fri, 25 Feb 2022 11:26:21 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so7545226oos.10;
        Fri, 25 Feb 2022 11:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8/RhmmvOE3ZBDv39xXLcWsX9wxG1z+5j6Nqh+tUlI0Q=;
        b=ssD0SgsREbYVn5l3Iijp/6MHcAToGAlsbJ4Jy/yGogrufZuqTLRoqkuRJpxtur4oKl
         Qgbi4Z7Y88sHNpJLTkepjUt3XGuvodHrF+MhqiXc7jy4p8pTt8hRUPyTXmH0PWk+RFhr
         TFfPk4fuBAjDKoLtNXB08JgTAU2chmTGKeXs7+O220LoaVZ2LjODgjBFMFtJf6a+vkfj
         29GBwtXOpgeO/2C+wx9567gMVc9sYmDX3AZwYDIyauHsoAJFnQfDV123OI3gT21sTC/z
         eZ1iBAoZ212zCVfnEXnPFDgRXpRUeIumLy6kDS+U4tZFcWoub1CPmb5kdp3VuVTeG+QH
         y3Xw==
X-Gm-Message-State: AOAM531jwe2rUZRVGKu9Pdf9xbmrnyqjcRKgY0KKAeIwNrPciMSNYsDj
        SHf/RpejmwD8SNEXmKkcFQ==
X-Google-Smtp-Source: ABdhPJzWJ5ARcz3klRmenrwFTt1pjcga9WbD7rJl5U41JbD2tVK2JK2Wkw4Lcb5MV4ZtE1fRD8p44Q==
X-Received: by 2002:a05:6870:d917:b0:ce:c0c9:650 with SMTP id gq23-20020a056870d91700b000cec0c90650mr2073603oab.162.1645817180555;
        Fri, 25 Feb 2022 11:26:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x7-20020a4a8687000000b003191a2edc67sm1586401ooh.7.2022.02.25.11.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:26:19 -0800 (PST)
Received: (nullmailer pid 1288039 invoked by uid 1000);
        Fri, 25 Feb 2022 19:26:18 -0000
Date:   Fri, 25 Feb 2022 13:26:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 01/15] dt-bindings: ufs: add common platform bindings
Message-ID: <YhktWpoJekR2Lj0D@robh.at.kernel.org>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
 <20220222145854.358646-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222145854.358646-2-krzysztof.kozlowski@canonical.com>
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

On Tue, Feb 22, 2022 at 03:58:40PM +0100, Krzysztof Kozlowski wrote:
> Add bindings for common parts (platform) of Universal Flash Storage
> (UFS) Host Controllers in dtschema format.
> 
> The 'freq-table-hz' is not correct in dtschema, because '-hz' suffix
> defines uint32 type, not an array.  Therefore deprecate 'freq-table-hz'
> and use 'freq-table' instead.

-hz is an array type. We can extend it to matrix if needed.

I do think this property is a bit questionable. Do we really need a 
minimum in DT and if not, wouldn't assigned-clocks-rate work? Or an OPP 
table.

> Include also the bindings directory in UFS maintainers entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/ufs/ti,j721e-ufs.yaml |  2 +-
>  .../devicetree/bindings/ufs/ufs-common.yaml   | 88 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> index 4d13e6bc1c50..dc93fe2d3458 100644
> --- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
> @@ -80,7 +80,7 @@ examples:
>                  compatible = "cdns,ufshc-m31-16nm", "jedec,ufs-2.0";
>                  reg = <0x0 0x4000 0x0 0x10000>;
>                  interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> -                freq-table-hz = <19200000 19200000>;
> +                freq-table = <19200000 19200000>;
>                  power-domains = <&k3_pds 277>;
>                  clocks = <&k3_clks 277 1>;
>                  assigned-clocks = <&k3_clks 277 1>;
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> new file mode 100644
> index 000000000000..85c73d2853e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ufs/ufs-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common properties for Universal Flash Storage (UFS) Host Controllers
> +
> +maintainers:
> +  - Alim Akhtar <alim.akhtar@samsung.com>
> +  - Avri Altman <avri.altman@wdc.com>
> +
> +properties:
> +  clocks: true
> +
> +  clock-names: true
> +
> +  freq-table-hz:
> +    deprecated: true
> +    description:
> +      Use freq-table.
> +
> +  freq-table:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: Minimum frequency for given clock
> +        - description: Maximum frequency for given clock
> +    description: |
> +      Array of <min max> operating frequencies in Hz stored in the same order
> +      as the clocks property. If this property is not defined or a value in the
> +      array is "0" then it is assumed that the frequency is set by the parent
> +      clock or a fixed rate clock source.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  lanes-per-direction:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]
> +    default: 2
> +    description:
> +      Number of lanes available per direction.  Note that it is assume same
> +      number of lanes is used both directions at once.
> +
> +  vdd-hba-supply:
> +    description:
> +      Phandle to UFS host controller supply regulator node.
> +
> +  vcc-supply:
> +    description:
> +      Phandle to VCC supply regulator node.
> +
> +  vccq-supply:
> +    description:
> +      Phandle to VCCQ supply regulator node.
> +
> +  vccq2-supply:
> +    description:
> +      Phandle to VCCQ2 supply regulator node.
> +
> +  vcc-supply-1p8:
> +    type: boolean
> +    description:
> +      For embedded UFS devices, valid VCC range is 1.7-1.95V or 2.7-3.6V. This
> +      boolean property when set, specifies to use low voltage range of
> +      1.7-1.95V. Note for external UFS cards this property is invalid and valid
> +      VCC range is always 2.7-3.6V.
> +
> +  vcc-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from VCC supply.
> +
> +  vccq-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from VCCQ supply.
> +
> +  vccq2-max-microamp:
> +    description:
> +      Specifies max. load that can be drawn from VCCQ2 supply.
> +
> +dependencies:
> +  freq-table: [ 'clocks' ]
> +
> +required:
> +  - interrupts
> +
> +additionalProperties: true
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa0f6cbb634e..c2cff57d32f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20015,6 +20015,7 @@ R:	Alim Akhtar <alim.akhtar@samsung.com>
>  R:	Avri Altman <avri.altman@wdc.com>
>  L:	linux-scsi@vger.kernel.org
>  S:	Supported
> +F:	Documentation/devicetree/bindings/ufs/
>  F:	Documentation/scsi/ufs.rst
>  F:	drivers/scsi/ufs/
>  
> -- 
> 2.32.0
> 
> 
