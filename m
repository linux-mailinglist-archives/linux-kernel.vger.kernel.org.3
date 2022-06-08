Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C337543EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiFHWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiFHWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:01:55 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D2B8BC5;
        Wed,  8 Jun 2022 15:01:54 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id p128so924292iof.1;
        Wed, 08 Jun 2022 15:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NN7GcotegH3FFfcqHSDcYe6YeJ9nxGa2AwyTelBXKr8=;
        b=gPw85fgrG6aLwnLxi2yRHtV8srawtwgsyYS2yO+OJMMdU950BOekt49MY9Ez1evs0a
         ICqBbwaZZx8JTRt4xm2yMP/DA0UFu2+eLMcekQEKribLx056ZnlqjtNcN6sw9EIbr1Eu
         pRNRMlRkBxao8amiyS3C8BG+FUhi8LVB7RftfEM4pTWsWq9EHU/+7JEq7eGWgHHXly1W
         f0gaO1lcs1uO/NOEYHsH24sU6cg4AfeJprs2bX/gXcbJzFoS3ffAeFOTho473ezBg+1N
         nUSZMf9Pp0djrwjkYXmGbPjtozajwPYegqabY2upmOeju5ARXEwj1bTLTMttdfKlPnmE
         GcnA==
X-Gm-Message-State: AOAM533FEr214/iuV+qjxAQMArdI8R0eH3Y4V+nUBpspyY4G3EE+886u
        sSGbkJs6pwdW1/Cpcfj8og==
X-Google-Smtp-Source: ABdhPJwYJUic/1ZyEOvAqw740GgvsE+qnzhkTfmFrKTOJpNUOscNySpwIX4S+PyzbpZVs1iVy1344A==
X-Received: by 2002:a05:6638:3383:b0:331:b268:261 with SMTP id h3-20020a056638338300b00331b2680261mr9101899jav.55.1654725713770;
        Wed, 08 Jun 2022 15:01:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b12-20020a5edc0c000000b00669a3f60e99sm727337iok.31.2022.06.08.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 15:01:53 -0700 (PDT)
Received: (nullmailer pid 2156157 invoked by uid 1000);
        Wed, 08 Jun 2022 22:01:50 -0000
Date:   Wed, 8 Jun 2022 16:01:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v8 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware
 definitions
Message-ID: <20220608220150.GA2137312-robh@kernel.org>
References: <20220608154705.40322-1-quic_jinlmao@quicinc.com>
 <20220608154705.40322-4-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608154705.40322-4-quic_jinlmao@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 11:46:58PM +0800, Mao Jinlong wrote:
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++

qcom,coresight-tpdm.yaml

>  .../devicetree/bindings/arm/coresight.txt     |  7 ++

This file is going away[1]. I'd just drop the changes to it.

>  MAINTAINERS                                   |  1 +
>  3 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> new file mode 100644
> index 000000000000..14bef4ce4274
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/coresight-tpdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trace, Profiling and Diagnostics Monitor - TPDM
> +
> +description: |
> +  The TPDM or Monitor serves as data collection component for various dataset
> +  types specified in the QPMDA spec. It covers Implementation defined ((ImplDef),
> +  Basic Counts (BC), Tenure Counts (TC), Continuous Multi-Bit (CMB), and Discrete
> +  Single Bit (DSB). It performs data collection in the data producing clock
> +  domain and transfers it to the data collection time domain, generally ATB
> +  clock domain.
> +
> +  The primary use case of the TPDM is to collect data from different data
> +  sources and send it to a TPDA for packetization, timestamping, and funneling.
> +
> +maintainers:
> +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^tpdm(@[0-9a-f]+)$"

blank line

> +  compatible:
> +    items:
> +      - const: qcom,coresight-tpdm
> +      - const: arm,primecell

You need a 'select' to fix the errors reported. See other primecell 
bindings.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  out-ports:
> +    description: |
> +      Output connections from the TPDM to coresight funnle/tpda.

typo

> +    $ref: /schemas/graph.yaml#/properties/ports

blank line here.

> +    properties:
> +      port:
> +        description: Output connection from the TPDM to coresight
> +            funnel/tpda.

s/tpda/TPDA/

> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum TPDM definition. TPDM connect to coresight funnel.
> +  - |
> +    tpdm@6980000 {
> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x6980000 0x1000>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_turing_out_funnel_turing: endpoint {
> +            remote-endpoint =
> +              <&funnel_turing_in_tpdm_turing>;
> +          };
> +        };
> +      };
> +    };
> +  # minimum TPDM definition. TPDM connect to coresight TPDA.
> +  - |

The only difference in the 2 examples is some external phandle. 1 
example is sufficient.

> +    tpdm@684c000 {
> +      compatible = "qcom,coresight-tpdm", "arm,primecell";
> +      reg = <0x684c000 0x1000>;
> +
> +      clocks = <&aoss_qmp>;
> +      clock-names = "apb_pclk";
> +
> +      out-ports {
> +        port {
> +          tpdm_prng_out_tpda_qdss: endpoint {
> +            remote-endpoint =
> +              <&tpda_qdss_in_tpdm_prng>;
> +          };
> +        };
> +      };
> +    };
> +
> +...

Rob

[1] https://lore.kernel.org/all/20220603011933.3277315-1-robh@kernel.org/
