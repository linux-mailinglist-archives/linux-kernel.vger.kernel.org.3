Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E13495818
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 03:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378398AbiAUCEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 21:04:08 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:41901 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244655AbiAUCEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 21:04:06 -0500
Received: by mail-ot1-f44.google.com with SMTP id a12-20020a0568301dcc00b005919e149b4cso9984477otj.8;
        Thu, 20 Jan 2022 18:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cc9spV2rl91I9rwf82cjdmxiDdvU2PQSZIfY9wtAWls=;
        b=U6DoSu80jhgFNVuQVuz7DGAKLf9ODcCP/W99pL+ugMijtg270QDZlbkds5CaBcYLyB
         tEANdX3OrlhaUnBzOkSsVKStbQyicd0ZpAibmYWZb1k9gIaEGljNn06cOeVpBOGSv9jM
         GA9B3br5FIdlceOf7UiQuxgDq6vgNGhq85yL/r5wN4xpuvgNF7FtW3NiZ/EHjTlgnhfb
         l+KTc+YvQ8DVVz0LBeSwSZD0440ubu58P6D69DQNaunNjJ6KjKjkv4iQ8A+O1e+Yf/zW
         O4cu9KAjqUYxzwbPyg34PfAJ5p2RZWv+xOuWcHbsNKTberHp/h8LByiDSzrSfxTowcIm
         d4aA==
X-Gm-Message-State: AOAM531z3QKr7dRvjEhXDYwwI7AnfzMGQkKnny2H7KPt0/m0DNwPqNY6
        yWZeypd1Hx4ON+9CBiWQFA==
X-Google-Smtp-Source: ABdhPJyXsWWXP3WL+rZIhDhbXXvKSwhl2JYfvg4bHVYzTOylDX0xUyIJnLUnJktOahWMVf4xcy9iAQ==
X-Received: by 2002:a9d:5c04:: with SMTP id o4mr1265326otk.339.1642730645739;
        Thu, 20 Jan 2022 18:04:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h65sm511679oia.56.2022.01.20.18.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 18:04:04 -0800 (PST)
Received: (nullmailer pid 2351938 invoked by uid 1000);
        Fri, 21 Jan 2022 02:04:03 -0000
Date:   Thu, 20 Jan 2022 20:04:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: clock: Document qcom,gcc-ipq8064
 binding
Message-ID: <YeoUk3t2iVbQwj5s@robh.at.kernel.org>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
 <20220120232028.6738-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120232028.6738-4-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 12:20:16AM +0100, Ansuel Smith wrote:
> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already documented,
> to get the calib nvmem cells and the base reg from gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> new file mode 100644
> index 000000000000..abc76a46b2ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on IPQ8064.
> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-ipq806x.h
> +  - dt-bindings/reset/qcom,gcc-ipq806x.h
> +
> +properties:

This schema will never be applied because there is not a compatible 
property to use for matching. The base/common schema is the one that 
shouldn't have a compatible and then the specific schemas like this 
one do.

> +  clocks:
> +    items:
> +      - description: PXO source
> +      - description: CXO source
> +
> +  clock-names:
> +    items:
> +      - const: pxo
> +      - const: cxo
> +
> +  thermal-sensor:
> +    type: object
> +
> +    allOf:
> +      - $ref: /schemas/thermal/qcom-tsens.yaml#
> +
> +required:
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    gcc: clock-controller@900000 {
> +      compatible = "qcom,gcc-ipq8064", "syscon";
> +      reg = <0x00900000 0x4000>;
> +      clocks = <&pxo_board>, <&cxo_board>;
> +      clock-names = "pxo", "cxo";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +
> +      tsens: thermal-sensor {
> +        compatible = "qcom,ipq8064-tsens";
> +
> +        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
> +        nvmem-cell-names = "calib", "calib_backup";
> +        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "uplow";
> +
> +        #qcom,sensors = <11>;
> +        #thermal-sensor-cells = <1>;
> +      };
> +    };
> -- 
> 2.33.1
> 
> 
