Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3574A516E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381030AbiAaV0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381018AbiAaV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:26:25 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEEDC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:26:25 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q186so29337410oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rjcQnxZph82Xd5iXuMJliZu5pKs4JinKFWoJ3CAGamw=;
        b=MBodaNvwAzrufxpfW7g7ruVRDbHknoBi50bPAsc8NVyJCQIwJGh7+j9HlJjATrvBv0
         pghuyqHZoxaczI2HebSbily7ypYGnFFLQFIbkdgG3aXCu6fFu8sKVsC6XlPt2xwFgkGr
         uA0xkjpoY1jZ6LX2LIF9Kbi0Ds06n6lbTXFlwgVforbve94CCJspPNOpPsxco70SBqQg
         cBZwEQWmEFW8ZfPvJ5qmvZN2Um5iBdij7OvJEpAEoehXs38tnsoGBESAU1EJLZWeqakM
         ryhAZbkZyq2g4W1Jar8Zhqus2lqr/DgvJm7EgFZlgwYd62WMpVqyi5kud8iYtArRIWbR
         nXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjcQnxZph82Xd5iXuMJliZu5pKs4JinKFWoJ3CAGamw=;
        b=J+ePTz2rvDr5Wdyi6RYEDtXr8HSqTdYU5qJunAwoXqqNaohkcRZN6prqbRQpXi5nuk
         bWK4pcOMZr4LIbYJdEl1qtAh15MX2jDlOJMiq6lR8TcwZEw6BysiyC2wM0re4ZI8GM42
         Q9l9nNb1u+1kamoeYYfFpinuTlfe5hLRvkWjAERMoDYDrsPFBzFliZ7xeHC6och1y7pj
         n/a+vfmD0HcmB1DBPBhcgo+7d0dgu3pF4enZyCk4INCmS/3GRTuSQkuLzn+Waz0Ajw6C
         uvEGm4V9VUeDwmognzSyUqBs4uqlD6rx6dyPlq3aI5dzIfdNC3tovFZuUm3TKp5OloGY
         eVzw==
X-Gm-Message-State: AOAM531zYC7mOJ4881lSJ1qW3dWOyfFQ1GMiBxGo7Wmvd6POklBbG2Kd
        4OwGNqyJM4ql8MjOZimtkkqzeNMPEEZDYw==
X-Google-Smtp-Source: ABdhPJzOt8SX9PLroEDwwrhXnj2Kvv/nQgztBJQs7uOiIqk+wA/7eKKAp8g9KFDNMk4uUMc0N15w9g==
X-Received: by 2002:aca:dac2:: with SMTP id r185mr18558922oig.152.1643664384877;
        Mon, 31 Jan 2022 13:26:24 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id q9sm10040747oif.9.2022.01.31.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:26:24 -0800 (PST)
Date:   Mon, 31 Jan 2022 15:26:22 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: convert Qualcomm SCM binding to
 the yaml
Message-ID: <YfhT/ltPDhQZV0Bo@builder.lan>
References: <20211218194038.26913-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218194038.26913-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18 Dec 13:40 CST 2021, David Heidelberg wrote:

> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> This patch comes with followup question -> since not all definitions
> follow `"qcom,scm-*chipset*", "qcom,scm"`, should I change them or adjust this
> binding to cover all cases?
> 

I don't remember why some platforms has the generic "fallback" and
others doesn't. I don't have any objections to defining the binding as
you've done.

>  .../devicetree/bindings/firmware/qcom,scm.txt |  54 ---------
>  .../bindings/firmware/qcom,scm.yaml           | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> deleted file mode 100644
> index d7e3cda8924e..000000000000
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -QCOM Secure Channel Manager (SCM)
> -
> -Qualcomm processors include an interface to communicate to the secure firmware.
> -This interface allows for clients to request different types of actions.  These
> -can include CPU power up/down, HDCP requests, loading of firmware, and other
> -assorted actions.
> -
> -Required properties:
> -- compatible: must contain one of the following:
> - * "qcom,scm-apq8064"
> - * "qcom,scm-apq8084"
> - * "qcom,scm-ipq4019"
> - * "qcom,scm-ipq806x"
> - * "qcom,scm-ipq8074"
> - * "qcom,scm-mdm9607"
> - * "qcom,scm-msm8226"
> - * "qcom,scm-msm8660"
> - * "qcom,scm-msm8916"
> - * "qcom,scm-msm8953"
> - * "qcom,scm-msm8960"
> - * "qcom,scm-msm8974"
> - * "qcom,scm-msm8994"
> - * "qcom,scm-msm8996"
> - * "qcom,scm-msm8998"
> - * "qcom,scm-sc7180"
> - * "qcom,scm-sc7280"
> - * "qcom,scm-sdm845"
> - * "qcom,scm-sdx55"
> - * "qcom,scm-sm8150"
> - * "qcom,scm-sm8250"
> - * "qcom,scm-sm8350"
> - and:
> - * "qcom,scm"
> -- clocks: Specifies clocks needed by the SCM interface, if any:
> - * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
> -   "qcom,scm-msm8960"
> - * core, iface and bus clocks required for "qcom,scm-apq8084",
> -   "qcom,scm-msm8916", "qcom,scm-msm8953" and "qcom,scm-msm8974"
> -- clock-names: Must contain "core" for the core clock, "iface" for the interface
> -  clock and "bus" for the bus clock per the requirements of the compatible.
> -- qcom,dload-mode: phandle to the TCSR hardware block and offset of the
> -		   download mode control register (optional)
> -
> -Example for MSM8916:
> -
> -	firmware {
> -		scm {
> -			compatible = "qcom,msm8916", "qcom,scm";
> -			clocks = <&gcc GCC_CRYPTO_CLK> ,
> -				 <&gcc GCC_CRYPTO_AXI_CLK>,
> -				 <&gcc GCC_CRYPTO_AHB_CLK>;
> -			clock-names = "core", "bus", "iface";
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> new file mode 100644
> index 000000000000..3a7261734fad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/firmware/qcom,scm.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: QCOM Secure Channel Manager (SCM)
> +
> +description: |

I don't think there's value in the formatting, so perhaps omitting the
pipe?

> +  Qualcomm processors include an interface to communicate to the secure firmware.
> +  This interface allows for clients to request different types of actions.  These
> +  can include CPU power up/down, HDCP requests, loading of firmware, and other
> +  assorted actions.
> +
> +maintainers:
> +  - Andy Gross <andy.gross@linaro.org>

It's been a while since Andy left that address behind. Please put mine
instead.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,scm-apq8064
> +          - qcom,scm-apq8084
> +          - qcom,scm-ipq4019
> +          - qcom,scm-ipq806x
> +          - qcom,scm-ipq8074
> +          - qcom,scm-mdm9607
> +          - qcom,scm-msm8226
> +          - qcom,scm-msm8660
> +          - qcom,scm-msm8916
> +          - qcom,scm-msm8953
> +          - qcom,scm-msm8960
> +          - qcom,scm-msm8974
> +          - qcom,scm-msm8994
> +          - qcom,scm-msm8996
> +          - qcom,scm-msm8998
> +          - qcom,scm-sc7180
> +          - qcom,scm-sc7280
> +          - qcom,scm-sdm845
> +          - qcom,scm-sdx55
> +          - qcom,scm-sm8150
> +          - qcom,scm-sm8250
> +          - qcom,scm-sm8350
> +      - const: qcom,scm
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names: true
> +
> +  qcom,dload-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: >
> +      TCSR hardware block and offset of the download mode control register
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8064
> +              - qcom,scm-msm8660
> +              - qcom,scm-msm8960
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8084
> +              - qcom,scm-msm8916
> +              - qcom,scm-msm8953
> +              - qcom,scm-msm8974
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: iface
> +            - const: bus
> +
> +      required:
> +        - clocks
> +        - clock-names
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +        scm {
> +            compatible = "qcom,msm8916", "qcom,scm";
> +            clocks = <&gcc 104>,
> +                     <&gcc 77>,
> +                     <&gcc 86>;

Can we include dt-bindings/clock/qcom,gcc-msm8916.h and continue to use
the constants in the example?

Regards,
Bjorn

> +            clock-names = "core", "bus", "iface";
> +        };
> +    };
> -- 
> 2.34.1
> 
