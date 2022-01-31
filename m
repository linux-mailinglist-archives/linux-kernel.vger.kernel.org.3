Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C576F4A5369
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiAaXle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiAaXld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:41:33 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDD2C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:41:33 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id i16-20020a056830011000b005a3cc8d20fbso8157514otp.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=77+HksFUsOVcQq4vStx69pmlR18iG3QVLa69zKDYps4=;
        b=uQdQSAwL1YeEVGJSOPaPCVEG/3wmqggEuVKUbB9OFFsPRRHhVz8JZKHZjc07pIVpOi
         Ek1u9DV2dUy7xC/UzDn1QK7jC6YgCEkHeTEvOVRUdYCRuMjBjcnJFGlKC8Rrx+gubFxF
         Eqy5cSB4Su6os7S0hrIr/tBUVy8BWLbgTlf1GrY2lbybA/e38QT1/rkOE5jQySKeh9XT
         3tN0bv0VhEsNdcVvUVqQay38rKc1W71owR0dHmFo0v+ZSHZbiJBG9Hv9NczqX/vdY+f2
         9KgT4dlI0/sXFcLFM+ugaNckp53N9uteAaQP8CvO25EMa8iqsS+JMRrONSuHi+l6LkDN
         jbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77+HksFUsOVcQq4vStx69pmlR18iG3QVLa69zKDYps4=;
        b=45g5nBEzRfTBnpZ50Y4z+oSv5kYDAoGvjTfXs/Qhe1bwHqVe+o6+8ox56OFYen78/6
         iHOsn3tK5Fq8l9+HbVUV7nUAHc3SL/TREgRNy0OmOSyB9NHnR8GOPpoqD4dv4t3E9/+I
         mPE5rTXT7IhkKL/aykOay4ajyd9BEIuysuWPuk44bzAuj4LpDdssA2rfrJWIMl6oAmLI
         Q4nItgTb4MbLVJq+a3MAjGWVmcMRRs3RyU5Y0FlpvfPm5NHlXBsTvoUbCLF3HDTeBs3G
         pohkLMWkci5TtdFf6AWTo34oXYEbXSKJpnTD4YNwSy1bqzhUhc07HuTcUSUd/dRQlaf2
         WItQ==
X-Gm-Message-State: AOAM531t7F06cVJPC+l3cLRQXsqXrr/fo6sEcj5mt0AANue2FDqNEKkP
        QUhM1MLcviQ0kxp9xvdOJHnAyg==
X-Google-Smtp-Source: ABdhPJyXXdx4oXfebwfsRRFl5sKct5LDYu4LmbFA/XD8KJAw54e2YBKoUrfdgSQv2xXJwBCLXLqiMg==
X-Received: by 2002:a9d:4794:: with SMTP id b20mr12766231otf.361.1643672492848;
        Mon, 31 Jan 2022 15:41:32 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id y19sm3630574oti.49.2022.01.31.15.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 15:41:32 -0800 (PST)
Date:   Mon, 31 Jan 2022 17:41:30 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
Message-ID: <Yfhzqvrj6bIPmV2S@builder.lan>
References: <20220122001609.15904-1-ansuelsmth@gmail.com>
 <20220122001609.15904-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122001609.15904-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Jan 18:16 CST 2022, Ansuel Smith wrote:

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
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,usb-hsphy-mode-select:
> +    description: Select usb hsphy mode for ipq4019

Why isn't this driven by the USB node, where I presume you otherwise
need to duplicate this decision?

Is this platform not capable of OTG?

> +    enum:
> +      - 'host'
> +      - 'device'
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

There's a single "tcsr" register block at 0x1937000 of size 0x21000.
The binding should describe that entire block, not convenient pieces of
it.

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

Again, it seems reasonable to get this form the dwc3 node, rather than
duplicating the configuration.

Regards,
Bjorn

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
