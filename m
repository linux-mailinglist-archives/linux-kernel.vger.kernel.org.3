Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A418B4AE767
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 04:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiBIDC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 22:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345475AbiBIDBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:01:39 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E83C0612C1;
        Tue,  8 Feb 2022 19:01:38 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id v17-20020a4ac911000000b002eac41bb3f4so944298ooq.10;
        Tue, 08 Feb 2022 19:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZyXH2t51WHYfAIKNwqd9VzvZrJFEb+1EMaGREtcsO1o=;
        b=smdHsLRvDLStsbRob5cMjjvKYoipTFRsYTwpT14xBhsjm+rAGPaWSeF9X1fdgOjMIc
         6UweVH9vqUNy5E6nS12aUMfzDpyLVK9Sj+6DSWeQOE9pZQESPzslVFRGlyUL4+NCR/Ea
         yh8JxcdTzGItZI9QJWP1KbbQ7sPBvgYwpiQlgkMfYBai7GQMphObAPBXidrDcUL4HXMl
         m+yk19XOEp9US49bR4P36tgV8RoVXP+GsKI5TmJBJeVGXSdbBHcWzv+TI/2Q2EaoUWw8
         7vRPWC3HHbsdM2Q/BPlmdx58JmMm39desuDwk3LTibUSjGNO88YBDtCMlCEvUlOur/FT
         1K0w==
X-Gm-Message-State: AOAM533NRjxPYoECqoaAe7w40w1QDYDkUDpPsxAO5KWIsIWHlJGOd+jq
        vmFpGKseGh8ATov66CR+AQ==
X-Google-Smtp-Source: ABdhPJwB8fyB9yz4PnmcGcrhM/oLIBzX1Hvz7Bc0G6d9wAsUrxiAKXe7N9gm9p3leyg8OG5KYjjkzw==
X-Received: by 2002:a05:6870:d450:: with SMTP id j16mr302591oag.268.1644375697493;
        Tue, 08 Feb 2022 19:01:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a15sm6324251oil.13.2022.02.08.19.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:01:36 -0800 (PST)
Received: (nullmailer pid 3538364 invoked by uid 1000);
        Wed, 09 Feb 2022 03:01:35 -0000
Date:   Tue, 8 Feb 2022 21:01:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
Message-ID: <YgMuj1yyk6DnNzlw@robh.at.kernel.org>
References: <20220122001609.15904-1-ansuelsmth@gmail.com>
 <20220122001609.15904-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122001609.15904-2-ansuelsmth@gmail.com>
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

On Sat, Jan 22, 2022 at 01:16:08AM +0100, Ansuel Smith wrote:
> Add qcom,tcsr-ipq8064 and qcom,tcsr-ipq4019 Documentation for the
> tcsr present in ipq8064 and ipa4019 required to configure and
> set various peripherals present in the SoC.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/soc/qcom/qcom,tcsr-ipq4019.yaml  | 93 +++++++++++++++++++
>  .../bindings/soc/qcom/qcom,tcsr-ipq8064.yaml  | 47 ++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> new file mode 100644
> index 000000000000..3a82ccbb6588
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq4019.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Top Control and Status Registers binding for IPQ4019
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  This binding describes the Qualcomm Top Control and Status Registers, used
> +  for accessing configuration and mux settings for a variety of peripherals
> +  for ipq4019.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,tcsr-ipq4019

Normal order is qcom,ipq4019-tcsr

> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,usb-hsphy-mode-select:
> +    description: Select usb hsphy mode for ipq4019
> +    enum:
> +      - 'host'
> +      - 'device'

Don't need quotes.

> +
> +  qcom,ess-interface-select:
> +    description: Select ess interface mode for ipq4019
> +    enum:
> +      - 'psgmii'
> +      - 'rgmii5'
> +      - 'rmii0'
> +      - 'rmii1'
> +      - 'rmii0_rmii1'
> +      - 'rgmii4'
> +
> +  qcom,wifi-glb-cfg-enable-axid:
> +    description: Enable AXI master bus Axid translating
> +                  to confirm all txn submitted by order for ipq4019

Wrap at ~80 and indent 2 more spaces (than 'description').

> +    type: boolean
> +
> +  qcom,wifi-glb-cfg-socslv-mode:
> +    description: Select wifi socslv mode for ipq4019
> +                  snoc use SNOC socslv_wxi_bvalid.
> +                  local use locally generate socslv_wxi_bvalid for performance.
> +    enum:
> +      - 'snoc'
> +      - 'local'
> +
> +  qcom,wifi_noc_memtype_m0_m2:

s/_/-/

> +    description: Configure special wifi memory type needed for
> +                  some IPQ40xx devicesfor ipq4019
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
> +    tcsr@194b000 {
> +      compatible = "qcom,tcsr-ipq4019", "syscon";
> +      reg = <0x194b000 0x100>;
> +      qcom,usb-hsphy-mode-select = "host";
> +    };
> +
> +    tcsr@1949000 {
> +      compatible = "qcom,tcsr-ipq4019", "syscon";
> +      reg = <0x1949000 0x100>;
> +      qcom,wifi-glb-cfg-enable-axid;
> +      qcom,wifi-glb-cfg-socslv-mode = "local";
> +    };
> +
> +    ess_tcsr@1953000 {
> +      compatible = "qcom,tcsr-ipq4019", "syscon";
> +      reg = <0x1953000 0x1000>;
> +      qcom,ess-interface-select = "psgmii";
> +    };
> +
> +    tcsr@1957000 {
> +      compatible = "qcom,tcsr-ipq4019", "syscon";
> +      reg = <0x1957000 0x100>;
> +      qcom,wifi_noc_memtype_m0_m2;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> new file mode 100644
> index 000000000000..4ccc0bfccec5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq8064.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Top Control and Status Registers binding for IPQ8064
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  This binding describes the Qualcomm Top Control and Status Registers, used
> +  for accessing configuration and mux settings for a variety of peripherals
> +  for ipq8064.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,tcsr-ipq8064

qcom,ipq8064-tcsr

> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,usb-ctrl-select:
> +    description: Select usb3 ctrl type for ipq8064
> +    enum:
> +      - 'p0'
> +      - 'p1'
> +      - 'dual'
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tcsr: syscon@1a400000 {
> +      compatible = "qcom,tcsr-ipq8064", "syscon";
> +      reg = <0x1a400000 0x100>;
> +      qcom,usb-ctrl-select = "dual";
> +    };
> +
> +...
> -- 
> 2.33.1
> 
> 
