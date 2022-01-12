Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E31048BC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347504AbiALBIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:08:34 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46841 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiALBId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:08:33 -0500
Received: by mail-ot1-f51.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so778785otc.13;
        Tue, 11 Jan 2022 17:08:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zfEgwfjg4A+hQfaxalCTAC80xYPvuxHf7IAsxkp6P4Q=;
        b=3Q1KEcXsETucKilRS1YxRkPxH0goy18yLMfVIvKXc3kBV9RSot4qIdB5Xn0fkHbM4T
         ZgeBjhommTOtLiQtn8yWp5wg4gC6t9fYR6PIFwI2m523ReumwQp2OybP6jKCBd34uc1+
         STQBplCAqaOUjgvPkyJ3YWNgiKJw+Uxb2Qkxdqb0bvovH/GMosEyT+Gtn9vPg2SJ1wvy
         hbg3tgKCRmV7p9Ui3yFm+NrOwE2XPRohww9DEVBNUyvSGtxcc8dxyFkLtXHNElCHPsz2
         0ctBloYDsuzv+A3ifQMOnZKagi7cP5soJqtgFmob4MYqO+4zMnSfOkFb9YE5i36WAdZs
         AnLg==
X-Gm-Message-State: AOAM532HpqGzodyTqPMyoZcj90KiXqbs7mhXF03Gus2xWWUGzT+KKUHI
        CaUSZe/KO6w8A4mFEintMA==
X-Google-Smtp-Source: ABdhPJxo6mmB/YuYHBD36Q4pjpucnKCeErxTN2wbLicZk28f4P4EcSrfWOESBczlwWIQ+J9EdK4XlA==
X-Received: by 2002:a05:6830:612:: with SMTP id w18mr2576295oti.155.1641949712964;
        Tue, 11 Jan 2022 17:08:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p23sm2385120otf.37.2022.01.11.17.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:08:32 -0800 (PST)
Received: (nullmailer pid 3838457 invoked by uid 1000);
        Wed, 12 Jan 2022 01:08:31 -0000
Date:   Tue, 11 Jan 2022 19:08:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, pure.logic@nexus-software.ie,
        bjorn.andersson@linaro.org, greg@kroah.com,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org, rnayak@codeaurora.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH V3 1/7] dt-bindings: Add the yaml bindings for EUD
Message-ID: <Yd4qD7ziPNgAQNHG@robh.at.kernel.org>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
 <5d9491693870b5dde757959f4491296503d22f70.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d9491693870b5dde757959f4491296503d22f70.1641288286.git.quic_schowdhu@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:28:14PM +0530, Souradeep Chowdhury wrote:
> Documentation for Embedded USB Debugger(EUD) device tree
> bindings in yaml format.

I agree with Bjorn's comments.

> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,eud.yaml     | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> new file mode 100644
> index 0000000..3523932
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,eud.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,eud.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Embedded USB Debugger
> +
> +maintainers:
> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +
> +description:
> +  This binding is used to describe the Qualcomm Embedded USB Debugger, which is
> +  mini USB-hub implemented on chip to support USB-based debug capabilities.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,sc7280-eud
> +      - const: qcom,eud
> +
> +  reg:
> +    items:
> +      - description: EUD Base Register Region
> +      - description: EUD Mode Manager Register
> +
> +  interrupts:
> +    description:
> +      EUD interrupt

Just 'maxItems: 1' is sufficient here.

> +
> +  port:

Based on Bjorn's comment, you will need 2 port nodes.

> +    description:
> +      This port is to be attached to the endpoint of the connector child of
> +      DWC3 controller node. The controller has the "usb-role-switch" property.
> +    $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    eud@88e0000 {
> +           compatible = "qcom,sc7280-eud","qcom,eud";
> +           reg = <0x88e0000 0x2000>,
> +                 <0x88e2000 0x1000>;

Are the ports really optional?

> +    };
> -- 
> 2.7.4
> 
> 
