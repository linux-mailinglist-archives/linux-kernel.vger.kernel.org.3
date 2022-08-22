Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE35359BFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiHVMkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiHVMkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:40:01 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E933343;
        Mon, 22 Aug 2022 05:40:00 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so833766otk.0;
        Mon, 22 Aug 2022 05:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PhEPEud72j5kQVxW8NO2vqL1FVdaHjnTMbrh083xpV0=;
        b=jrz9kdF7p21Lt8PU3ZNe+cpNELdxDnXQDshiwQTw+X7bKhKTLAk/YsEs+rKBKfY2VL
         ZP3Z/5pWIqIkta1hEarQvAUb8ICgb78yjxpLubIaSx6VmCSMioYkb+/XQb+5rjaemb/2
         TF6YjGjscHW4GT+wbukauvovDAy3Hg/GtQSrKj4Y6vN5ofHwdrdPPo2qL47eVYaQaO29
         GiErwHy8QnSSUpQ57Jvaq/s3XqeXyyzebZlCp6nQZGquo6OsCz3Dt1k5+g/bphiqqeC+
         zDO+rhTnbRGR7sz2jfsO8Ag+vfGqRw3xQ+1kfSE+s6wKNcEz072hC4v/3InnMg6xUUmQ
         o4JA==
X-Gm-Message-State: ACgBeo1SjvyOduC+B0S/jNAiRPfuMt0KXdacpFxrpByh6049YswSKxv9
        yMUULxhF/ZOb4cHlqA1sMx+ovJ5mIg==
X-Google-Smtp-Source: AA6agR5g64WBRUlwSWnDCd9sVKwnExbQiowIvsS13bvXxfGDvcK7A+9xBDQH0t3l/Jgnraq3we4Kzw==
X-Received: by 2002:a05:6830:6188:b0:61c:568b:1001 with SMTP id cb8-20020a056830618800b0061c568b1001mr7614005otb.98.1661171999453;
        Mon, 22 Aug 2022 05:39:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a13-20020a4ad5cd000000b00435954f91ddsm2497869oot.28.2022.08.22.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 05:39:58 -0700 (PDT)
Received: (nullmailer pid 3640781 invoked by uid 1000);
        Mon, 22 Aug 2022 12:39:57 -0000
Date:   Mon, 22 Aug 2022 07:39:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: qcom: Introduce PMIC GLINK binding
Message-ID: <20220822123957.GA3628946-robh@kernel.org>
References: <20220818031512.319310-1-bjorn.andersson@linaro.org>
 <20220818031512.319310-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818031512.319310-2-bjorn.andersson@linaro.org>
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

On Wed, Aug 17, 2022 at 08:15:09PM -0700, Bjorn Andersson wrote:
> The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
> platforms and implement USB Type-C handling and battery management.
> This binding describes the component in the OS used to communicate with
> the firmware and connect it's resources to those described in the
> Devicetree, particularly the USB Type-C controllers relationship with
> USB and DisplayPort components.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,pmic-glink.yaml    | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> new file mode 100644
> index 000000000000..3261f9d27a47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PMIC GLINK firmware interface for battery management, USB
> +  Type-C and other things.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description:
> +  The PMIC GLINK service, running on a coprocessor on some modern Qualcomm
> +  platforms and implement USB Type-C handling and battery management. This
> +  binding describes the component in the OS used to communicate with the
> +  firmware and connect it's resources to those described in the Devicetree,
> +  particularly the USB Type-C controllers relationship with USB and DisplayPort
> +  components.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sc8180x-pmic-glink
> +          - qcom,sc8280xp-pmic-glink
> +          - qcom,sm8350-pmic-glink
> +      - const: qcom,pmic-glink
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^connector@\d$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    pmic-glink {
> +        compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        connector@0 {
> +            compatible = "usb-c-connector";
> +            reg = <0>;

'reg' causes a warning:

Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.example.dtb: pmic-glink: connector@0: Unevaluated properties are not allowed ('reg' was unexpected)

> +            power-role = "dual";
> +            data-role = "dual";
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    endpoint {
> +                        remote-endpoint = <&usb_role>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    endpoint@0 {
> +                        reg = <0>;
> +                        remote-endpoint = <&qmp_out>;
> +                    };
> +
> +                    endpoint@1 {
> +                        reg = <1>;
> +                        remote-endpoint = <&displayport_hpd>;
> +                    };
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    endpoint {
> +                        remote-endpoint = <&sbu_mux>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> +
> -- 
> 2.35.1
> 
> 
