Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53055D00C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiF0Qyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiF0Qyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:54:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F2A18B19;
        Mon, 27 Jun 2022 09:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656348882; x=1687884882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wOOCX+SVxBwY59HG8AlckopFe1xskYhOAeIAW3yTJZQ=;
  b=nzMpYMT3fYki9DfgAeuOV06Aq1RMy5NgXpzC5yvn7TdcsvSedVub9t+L
   ztMUJW8iNgQ4LDEYu3/GmyrS4seyuQvJ47+aWVZHV6x7nKYrboPqUQYUK
   WL+6oxX+6bW3Ng5GqFZJ95sFzpbAU1WFAPGUPaAzWiYF3BqbQJpjqPlO7
   8=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Jun 2022 09:54:41 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 09:54:41 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 27 Jun
 2022 09:54:41 -0700
Date:   Mon, 27 Jun 2022 09:54:39 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     David Heidelberg <david@ixit.cz>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        <~okias/devicetree@lists.sr.ht>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] dt-bindings: firmware: convert Qualcomm SCM
 binding to the yaml
Message-ID: <20220627165439.GB6690@quicinc.com>
References: <20220626183247.142776-1-david@ixit.cz>
 <20220626183247.142776-3-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220626183247.142776-3-david@ixit.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 26 2022 20:32, David Heidelberg wrote:
> Convert Qualcomm SCM firmware binding to the yaml format.
> 
> This commit also:
>  - adds qcom,scm-mdm9607 into list which has only core clock
>  - adds qcom,scm-sm6125, qcom,scm-ipq6018
>  - #reset-cells, because the property is already used
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> --
> v4:
>  - added clocks minItems and maxItems
>  - removed quotes from $id and $schema
>  - adjusted description of TCSR HW block
> v3:
>  - add preceding patches for ARM and arm64 adding missing compatible strings
>  - extended with missing compatible strings
>  - added two additional maintainers, see https://lkml.org/lkml/2022/6/23/1969
> v2:
>  - changed maintainer to Bjorn
>  - document #reset-cells
> ---
>  .../devicetree/bindings/firmware/qcom,scm.txt |  57 -------
>  .../bindings/firmware/qcom,scm.yaml           | 140 ++++++++++++++++++
>  2 files changed, 140 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> deleted file mode 100644
> index 0f4e5ab26477..000000000000
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> +++ /dev/null
> @@ -1,57 +0,0 @@
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
> - * "qcom,scm-msm8976"
> - * "qcom,scm-msm8994"
> - * "qcom,scm-msm8996"
> - * "qcom,scm-msm8998"
> - * "qcom,scm-sc7180"
> - * "qcom,scm-sc7280"
> - * "qcom,scm-sdm845"
> - * "qcom,scm-sdx55"
> - * "qcom,scm-sm6350"
> - * "qcom,scm-sm8150"
> - * "qcom,scm-sm8250"
> - * "qcom,scm-sm8350"
> - * "qcom,scm-sm8450"
> - and:
> - * "qcom,scm"
> -- clocks: Specifies clocks needed by the SCM interface, if any:
> - * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
> -   "qcom,scm-msm8960"
> - * core, iface and bus clocks required for "qcom,scm-apq8084",
> -   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
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
> index 000000000000..b01acbd1e408
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/qcom,scm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: QCOM Secure Channel Manager (SCM)
> +
> +description: |
> +  Qualcomm processors include an interface to communicate to the secure firmware.
> +  This interface allows for clients to request different types of actions.
> +  These can include CPU power up/down, HDCP requests, loading of firmware,
> +  and other assorted actions.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Robert Marko <robimarko@gmail.com>
> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,scm-apq8064
> +          - qcom,scm-apq8084
> +          - qcom,scm-ipq4019
> +          - qcom,scm-ipq6018
> +          - qcom,scm-ipq806x
> +          - qcom,scm-ipq8074
> +          - qcom,scm-mdm9607
> +          - qcom,scm-msm8226
> +          - qcom,scm-msm8660
> +          - qcom,scm-msm8916
> +          - qcom,scm-msm8953
> +          - qcom,scm-msm8960
> +          - qcom,scm-msm8974
> +          - qcom,scm-msm8976
> +          - qcom,scm-msm8994
> +          - qcom,scm-msm8996
> +          - qcom,scm-msm8998
> +          - qcom,scm-sc7180
> +          - qcom,scm-sc7280
> +          - qcom,scm-sdm845
> +          - qcom,scm-sdx55
> +          - qcom,scm-sm6125
> +          - qcom,scm-sm6350
> +          - qcom,scm-sm8150
> +          - qcom,scm-sm8250
> +          - qcom,scm-sm8350
> +          - qcom,scm-sm8450
> +          - qcom,scm-qcs404
> +      - const: qcom,scm
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  qcom,dload-mode:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to TCSR hardware block
> +          - description: offset of the download mode control register
> +    description: TCSR hardware block
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,scm-apq8064

scm-apq8064 doesn't have the clock specified in the driver (there's a FIXME
comment to specify it), so even though the DT node specifies the clock, it
currently has no effect. We would need to check if the conditions for
re-enabling the clock are satisfied, and update the driver for this to take
effect.

> +              - qcom,scm-mdm9607

scm-mdm9607 has three clocks listed in the driver, not one. Please move this to
the "three-clocks" list below.

> +              - qcom,scm-msm8660
> +              - qcom,scm-msm8960

These two are good - they are listed as having a single clock each in the
driver.

> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +
> +        clocks:
> +          maxItems: 1
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
> +              - qcom,scm-msm8976

Verified that the above five nodes are all listed as supporting three clocks
each in the driver.

> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: iface
> +
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +
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
> +    include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +
> +    firmware {
> +        scm {
> +            compatible = "qcom,msm8916", "qcom,scm";
> +            clocks = <&gcc GCC_CRYPTO_CLK>,
> +                     <&gcc GCC_CRYPTO_AXI_CLK>,
> +                     <&gcc GCC_CRYPTO_AHB_CLK>;
> +            clock-names = "core", "bus", "iface";
> +        };
> +    };
> -- 
> 2.35.1
> 
