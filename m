Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C435A3E54
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiH1PUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiH1PUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:20:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F0BA1BC
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:20:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m2so4326940lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=vWIOQpau8zQvC+oLMoO5r2Km1y79obld+jCRMXEUpCM=;
        b=xT1o18rUcGpZ3RG16y1ykyDsE+uYyBezJ/Yhy2Pmt4LyzuVcJTQ2P+LFPyfrTkF2xh
         y/bgkHMP6OjtslrEWRI/ME7PAMkXHeRyVTm219hm/cU/3JrH9FQ8cmdJ+/MZe3N5etHX
         3tus2lT9cr2R/lraI2GbcDAIe/TyIFLa9gvkBEyv0uls207JxPDyVn0FZCwyMwG6ugPe
         /hL3TO9JZPlTVp+YAsPx4cndE8NqL4duxyWttnruKBBZ8S5cfgRDREqaMM50sSqFeXXK
         7sDTO6x1TKobNlAxz0fsM2SvD6HdshpqZz+qgpKehUxtU9sHf9yH85Iy078Tl3N8bOvE
         AKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vWIOQpau8zQvC+oLMoO5r2Km1y79obld+jCRMXEUpCM=;
        b=p8NdeDYMZRwGDpi95wmynJ4Szyib8b1JeRC9y2HAYbLmWI1yQu8JsjpMyiWuWn4STd
         vBCakKuQV+OKRWMDnx6MyHNBYKxbnjdt4/fCX12D7x+kP5XSNeV2PNt3YIk4tOi8FaJ2
         y5Rn6NxpxYobj5GmtLOan63zHcL8Fz82UQbaDCA8Exe67Msw7tr4ltD9lH1jx9DqITxf
         68wh6YxraaIahToRqgbf4RkYAfT6BUWYJ3ekjn0tRWGSOa4zuVgOMG1o4iUylluN3DXR
         G7SBykNK5yFvdJbWDGoHGjwoR61+KoG13M7xOKFWZU9pDI/XAkq2ro0QRPXkqSNxnPU+
         WZxg==
X-Gm-Message-State: ACgBeo36V4TaMHW8Go4Eli3t0M0pRwe36jMIgFw9nIxTvzbJQNJLIXgw
        i1K3lCkUM4BEYCkfr56et7bKLAYwT9eLN8Xa
X-Google-Smtp-Source: AA6agR7ao95Gd2XL1wwjOZr62Pf1iHe0P8rgzdfClnLgH62TbMoV2cQubN9/jy6g3IMS28JGptP+tg==
X-Received: by 2002:a05:6512:32b6:b0:494:6ab2:b997 with SMTP id q22-20020a05651232b600b004946ab2b997mr772250lfe.193.1661700026700;
        Sun, 28 Aug 2022 08:20:26 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id v28-20020ac25b1c000000b00492d09aed44sm971777lfn.195.2022.08.28.08.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 08:20:25 -0700 (PDT)
Message-ID: <b188b3fe-cc35-f902-b316-0c1632893e9d@linaro.org>
Date:   Sun, 28 Aug 2022 18:20:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/11] dt-bindings: PCI: qcom-ep: Define clocks per
 platform
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
 <20220826181923.251564-10-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826181923.251564-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2022 21:19, Manivannan Sadhasivam wrote:
> In preparation of adding the bindings for future SoCs, let's define the
> clocks per platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 46 +++++++++++--------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index b728ede3f09f..83a2cfc63bc1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm PCIe Endpoint Controller binding
>  maintainers:
>    - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  
> -allOf:
> -  - $ref: "pci-ep.yaml#"
> -
>  properties:
>    compatible:
>      const: qcom,sdx55-pcie-ep
> @@ -35,24 +32,12 @@ properties:
>        - const: mmio
>  
>    clocks:
> -    items:
> -      - description: PCIe Auxiliary clock
> -      - description: PCIe CFG AHB clock
> -      - description: PCIe Master AXI clock
> -      - description: PCIe Slave AXI clock
> -      - description: PCIe Slave Q2A AXI clock
> -      - description: PCIe Sleep clock
> -      - description: PCIe Reference clock
> +    minItems: 7
> +    maxItems: 7
>  
>    clock-names:
> -    items:
> -      - const: aux
> -      - const: cfg
> -      - const: bus_master
> -      - const: bus_slave
> -      - const: slave_q2a
> -      - const: sleep
> -      - const: ref
> +    minItems: 7
> +    maxItems: 7
>  
>    qcom,perst-regs:
>      description: Reference to a syscon representing TCSR followed by the two
> @@ -112,6 +97,29 @@ required:
>    - reset-names
>    - power-domains
>  
> +allOf:
> +  - $ref: "pci-ep.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdx55-pcie-ep
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +          maxItems: 7

One more thing - the previous way of describing items is more readable
instead of names followed by a comment, so I propose to keep it. This
applies also to patch 10.

Best regards,
Krzysztof
