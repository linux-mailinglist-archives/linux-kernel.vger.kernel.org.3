Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C352E9EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348122AbiETKcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiETKcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:32:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC98BD39
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:32:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v8so11639546lfd.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jLoKShXnvK18g/hpxDcb3w46Wn4GpvoKRXUZYRWFidQ=;
        b=YVHFkRD0MqPNxaUsIcx9HwSiCoSSee9T33zSd9hqf9PotLf1FcnGR0Pws1wO1JLgE4
         e/6KIHa32HILZ5k73we7TDs6M4/NRbs2yA9gqSyxYYzGtVOKNjs+WeJBPV/vYcm1R9Gg
         JD9oOUG3n0ADg9Ax4OdqLzX/nhE4s+rtOJOjQ/+5Q6dASz+i3MBSNb658knV0FUq00wC
         1I2ahV40H9IJZ91kOQS8kmHsa5ClU10iVATVVwg73lqphQ1vOGCBiESQpMwntUhdu6iV
         pkTlg7/QlybhBJSrM+wCNQOc9+Q+J7rKZ7CEH/WE0ZS3hi30FIC93l5syWL9aNoAkMRo
         hC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jLoKShXnvK18g/hpxDcb3w46Wn4GpvoKRXUZYRWFidQ=;
        b=D8DNYaaObvkjRXT/ucGqTeuGTzvJQlKBcENJBKoJpCmrCmLjjaw4O525J+WKXQLfWC
         7toGuJKv/Aizp5KJ7+mbukMN+oUT3zqG5HAxSXZEVru+dZL3wG3JdJYVRQc8ZAZEATAC
         Yzr0wca85d8ssbi0C7IhixnAvvtcSGTXYj9IAhqMMH+bGLV9VSU7bglen0JMP4WCZkK2
         oVXWcLmuzzcyLTCn00b6aFnyDL4+HZKoSaPsnBuYFxsLA4H+C9D29jhb/Iwn9VqJozrd
         oQSi51VLz2/as+Pnz90k42PwheFsI/YhFzo9EjqxPQ3IGFhw3bO+y/cLB2X8gsHFNr5V
         QOCw==
X-Gm-Message-State: AOAM5303yAF3SSmIv7BqGXPVWxyAmKnSnMytReTni1LRjnOy5ZjKdcTU
        VDJphTyDzyBagk/3x59D5Ac5wQ==
X-Google-Smtp-Source: ABdhPJwBIkQUvVaiMkEgWaWOZv0PfIymapoTpMeWHBZ0HTws3HEolBrTMYZvdVTLI6OZbthBhCE1kA==
X-Received: by 2002:a05:6512:3d89:b0:473:9e0e:8c4c with SMTP id k9-20020a0565123d8900b004739e0e8c4cmr6566185lfv.160.1653042720823;
        Fri, 20 May 2022 03:32:00 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h4-20020ac250c4000000b00477be45fb23sm563728lfm.56.2022.05.20.03.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 03:32:00 -0700 (PDT)
Message-ID: <7b451dfb-8353-4a4e-1834-a01feaa267d2@linaro.org>
Date:   Fri, 20 May 2022 12:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/5] dt-bindings: interconnect: Add Qualcomm SM6350 NoC
 support
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
 <20220520070318.48521-3-luca.weiss@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220520070318.48521-3-luca.weiss@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 09:03, Luca Weiss wrote:
> Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices.
> 
> As SM6350 has two pairs of NoCs sharing the same reg, allow this in the
> binding documentation, as was done for qcm2290.
> 
> Because the main qcom,rpmh.yaml file is getting too complicated for our
> use cases, create a new qcom,rpmh-common.yaml and a separate
> qcom,sm6350-rpmh.yaml that defines our new bindings.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Changes since v1:
> * Split sm6350 into separate yaml with new rpmh-common.yaml
> 
>  .../interconnect/qcom,rpmh-common.yaml        |  41 +++++
>  .../interconnect/qcom,sm6350-rpmh.yaml        |  82 ++++++++++
>  .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++++
>  3 files changed, 271 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
> new file mode 100644
> index 000000000000..6121eea3e87d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm RPMh Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Georgi Djakov <georgi.djakov@linaro.org>
> +  - Odelu Kukatla <okukatla@codeaurora.org>

Is this valid email address?

> +
> +description: |
> +   RPMh interconnect providers support system bandwidth requirements through
> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
> +   associated with each execution environment. Provider nodes must point to at
> +   least one RPMh device child node pertaining to their RSC and each provider
> +   can map to multiple RPMh resources.
> +
> +properties:
> +  '#interconnect-cells':
> +    enum: [ 1, 2 ]

Why this is an enum?

> +
> +  qcom,bcm-voters:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:

Please implement my previous comments.

> +      maxItems: 1
> +    description: |

No need for |

> +      List of phandles to qcom,bcm-voter nodes that are required by
> +      this interconnect to send RPMh commands.
> +
> +  qcom,bcm-voter-names:

What names do you expect here?

> +    description: |

Ditto.

> +      Names for each of the qcom,bcm-voters specified.
> +
> +required:
> +  - '#interconnect-cells'
> +  - qcom,bcm-voters
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
> new file mode 100644
> index 000000000000..89fe17c31b8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm6350-rpmh.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6350 RPMh Network-On-Chip Interconnect
> +
> +maintainers:
> +  - Luca Weiss <luca.weiss@fairphone.com>
> +
> +description: |
> +  Qualcomm RPMh-based interconnect provider on SM6350.
> +
> +allOf:
> +  - $ref: qcom,rpmh-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm6350-aggre1-noc
> +      - qcom,sm6350-aggre2-noc
> +      - qcom,sm6350-config-noc
> +      - qcom,sm6350-dc-noc
> +      - qcom,sm6350-gem-noc
> +      - qcom,sm6350-mmss-noc
> +      - qcom,sm6350-npu-noc
> +      - qcom,sm6350-system-noc
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#interconnect-cells': true

Since you defined it as enum in rpmh-common, you really expect here
different values?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +patternProperties:

This goes after "properties".

> +  '^interconnect-[a-z0-9\-]+$':
> +    type: object
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.
> +    $ref: qcom,rpmh-common.yaml#
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,sm6350-clk-virt
> +          - qcom,sm6350-compute-noc
> +
> +      '#interconnect-cells': true

Same problem.

> +
> +    required:
> +      - compatible
> +
> +    unevaluatedProperties: false
> +


Best regards,
Krzysztof
