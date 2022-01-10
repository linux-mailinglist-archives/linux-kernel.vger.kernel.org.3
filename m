Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851E848A12B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiAJUxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbiAJUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:53:37 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A35C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:53:37 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so16454782otg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlNkfjPl8bJ5V8M/bxJmWndgQif9YSbLDO09vemRv3M=;
        b=Teluis0uizho9gwqRGOWQdDpfU6/sbEJFjCpWVFDEhnQbjulh1wKPyqYjEA0U0YIHP
         les+MmdNr1b1CQa6cgd6a6z9Wy/K0GcCmxyzgGdqsaj+PJDv0idl6fPTqsclyh5iInda
         Pag+YAlaVZWEWBzewDE+8C6317jpB6cssSHkmLVKzmJGe3PCr5Rg9Hbm9X7VghMQqzVm
         6r2Z9lyMAIn9ANv/thuBN3WmTRrOlXL2ol19rmRDy6Y/E5z66Ig86QPoxjEm14xaf6g0
         K5sHa9TzAMmQVdmN9KBePNbZdZzRvwjXH59YOffrYFVeRKt4kGjVmApCz0QmWrn87sl1
         sr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SlNkfjPl8bJ5V8M/bxJmWndgQif9YSbLDO09vemRv3M=;
        b=P3yRWHjp58pAhewmh0XysOI7Wvwy9pVykQSgXFstX69Jj/5kn2Kwue4C5rkp72zNcG
         ATz1fi4D1N/NpI4Mu+uoO9BSi8m9/vCXIM05mypGrlyI8ZjYikj1uhEbyKBCnDWtNVKy
         JIIGxv4SRchIuAHskJPG4KaB/4Yf5vY6legTi6DaoxWTTC7uzW31CUgwNUzgMY1nO/2b
         GpB1HrleLoDCsjfduGtRyJ2lQyRm1b86q8kRxYZDbQbvlHr3Sm5RAYG/NmcmfGecHZEO
         76CCVHe62NhZXnGir4z/W7fu/hMEHawTHcK4PHOuKPc+emoXPItnc6sJ7KzcG3wwbDvJ
         AGEQ==
X-Gm-Message-State: AOAM530ZsHyKFbNGQCeyLEkPgDghckoyh2dPGhaxFK8a416BywGo3VJc
        xv9r6JGJVga9Eo+rcNFO79vaiA==
X-Google-Smtp-Source: ABdhPJyzRdF2hLe7MG4+OZzcjpZxsWbk3LYYXPkoN4uMWf+x4IFXdxA/DSyYGcgBa3FFA6QpStBrfw==
X-Received: by 2002:a9d:6013:: with SMTP id h19mr1224781otj.270.1641848016323;
        Mon, 10 Jan 2022 12:53:36 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b26sm1523623oob.10.2022.01.10.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:53:35 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:54:21 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: phy: convert Qualcomm USB HS phy to yaml
Message-ID: <Ydyc/TJiVUHXRDVw@ripper>
References: <20211230000740.103869-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230000740.103869-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Dec 16:07 PST 2021, David Heidelberg wrote:

> Conversion of Qualcomm USB HS phy documentation to yaml.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v2:
>  - changed uint8 array to matrix
>  - improved clock-names check
>  - move reset-names items, adjust DTS files later
>  - added clocks and resets min and maxItems
>  - if'ed resets, since apq8064 doesn't have phy reset
> ---
>  .../bindings/phy/qcom,usb-hs-phy.txt          |  84 --------------
>  .../bindings/phy/qcom,usb-hs-phy.yaml         | 108 ++++++++++++++++++
>  2 files changed, 108 insertions(+), 84 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> deleted file mode 100644
> index b3b75c1e6285..000000000000
> --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -Qualcomm's USB HS PHY
> -
> -PROPERTIES
> -
> -- compatible:
> -    Usage: required
> -    Value type: <string>
> -    Definition: Should contain "qcom,usb-hs-phy" and more specifically one of the
> -                following:
> -
> -                        "qcom,usb-hs-phy-apq8064"
> -                        "qcom,usb-hs-phy-msm8916"
> -                        "qcom,usb-hs-phy-msm8974"
> -
> -- #phy-cells:
> -    Usage: required
> -    Value type: <u32>
> -    Definition: Should contain 0
> -
> -- clocks:
> -    Usage: required
> -    Value type: <prop-encoded-array>
> -    Definition: Should contain clock specifier for the reference and sleep
> -                clocks
> -
> -- clock-names:
> -    Usage: required
> -    Value type: <stringlist>
> -    Definition: Should contain "ref" and "sleep" for the reference and sleep
> -                clocks respectively
> -
> -- resets:
> -    Usage: required
> -    Value type: <prop-encoded-array>
> -    Definition: Should contain the phy and POR resets
> -
> -- reset-names:
> -    Usage: required
> -    Value type: <stringlist>
> -    Definition: Should contain "phy" and "por" for the phy and POR resets
> -                respectively
> -
> -- v3p3-supply:
> -    Usage: required
> -    Value type: <phandle>
> -    Definition: Should contain a reference to the 3.3V supply
> -
> -- v1p8-supply:
> -    Usage: required
> -    Value type: <phandle>
> -    Definition: Should contain a reference to the 1.8V supply
> -
> -- extcon:
> -    Usage: optional
> -    Value type: <prop-encoded-array>
> -    Definition: Should contain the vbus extcon
> -
> -- qcom,init-seq:
> -    Usage: optional
> -    Value type: <u8 array>
> -    Definition: Should contain a sequence of ULPI address and value pairs to
> -                program into the ULPI_EXT_VENDOR_SPECIFIC area. This is related
> -                to Device Mode Eye Diagram test. The addresses are offsets
> -                from the ULPI_EXT_VENDOR_SPECIFIC address, for example,
> -                <0x1 0x53> would mean "write the value 0x53 to address 0x81".
> -
> -EXAMPLE
> -
> -otg: usb-controller {
> -	ulpi {
> -		phy {
> -			compatible = "qcom,usb-hs-phy-msm8974", "qcom,usb-hs-phy";
> -			#phy-cells = <0>;
> -			clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
> -			clock-names = "ref", "sleep";
> -			resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
> -			reset-names = "phy", "por";
> -			v3p3-supply = <&pm8941_l24>;
> -			v1p8-supply = <&pm8941_l6>;
> -			extcon = <&smbb>;
> -			qcom,init-seq = /bits/ 8 <0x1 0x63>;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> new file mode 100644
> index 000000000000..a60386bd19b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,usb-hs-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm's USB HS PHY binding description
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: qcom,usb-hs-phy-apq8064
> +  then:
> +    properties:
> +      resets:
> +        maxItems: 1
> +
> +      reset-names:
> +        const: por
> +
> +  else:
> +    properties:
> +      resets:
> +        minItems: 2
> +        maxItems: 2
> +
> +      reset-names:
> +        items:
> +          - const: phy
> +          - const: por
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,usb-hs-phy-apq8064
> +          - qcom,usb-hs-phy-msm8916
> +          - qcom,usb-hs-phy-msm8974
> +      - const: qcom,usb-hs-phy
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    maxItems: 2
> +    contains:
> +      items:
> +        - const: ref
> +        - const: sleep
> +
> +  resets: true
> +
> +  reset-names: true
> +
> +  v1p8-supply: true
> +
> +  v3p3-supply: true
> +
> +  extcon: true
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  qcom,init-seq:
> +    $ref: /schemas/types.yaml#/definitions/uint8-matrix
> +    description: >
> +      Sequence of ULPI address and value pairs to
> +      program into the ULPI_EXT_VENDOR_SPECIFIC area.
> +      This is related to Device Mode Eye Diagram test.
> +    maxItems: 32 # no hard limit
> +    items:
> +      items:
> +        - description: >
> +            the address is offset from the ULPI_EXT_VENDOR_SPECIFIC address
> +        - description: value
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    otg: usb-controller {
> +      ulpi {
> +        phy {
> +          compatible = "qcom,usb-hs-phy-msm8974", "qcom,usb-hs-phy";
> +          #phy-cells = <0>;
> +          clocks = <&clk 0>, <&clk 258>;
> +          clock-names = "ref", "sleep";
> +          resets = <&gcc 10>, <&otg 0>;
> +          reset-names = "phy", "por";
> +          v3p3-supply = <&pm8941_l24>;
> +          v1p8-supply = <&pm8941_l6>;
> +          extcon = <&smbb>;
> +          qcom,init-seq = /bits/ 8 <0x1 0x63>;
> +        };
> +      };
> +    };
> -- 
> 2.34.1
> 
