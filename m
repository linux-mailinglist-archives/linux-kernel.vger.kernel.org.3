Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642B85017CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiDNPuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356849AbiDNPlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:41:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73838E41EE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so6182142wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEU2HxQ6q/LFN3ZcXhOTdeHa0hw0kyeWBrXOIp9eUGM=;
        b=NMk3CfiAMS09PEAvwrluaQ4Ekhlfv9LaF/cPsOMSNgNv+474kYj46kcC/+HxW/Cptl
         DDIw2F9JqKzNCtMF2KdFlIE5xiFmfzMirnlYvx6BjEwGExVbNxPLNE0luDV9IZLC8whs
         3JpkHfYpaq9y3zRZqZufgnlEZ2rLooSAI2UoxS0jgeETfzdknDHM8kKTa8msYZcd/86S
         7Z+l98H6L+O2yrqlgVhgZeDSjrjudZ5LaoLlPNgx3mQ+Y37dcHI9mbbfFaMYfnd1D3mJ
         393JEAl0a+eYZGHK3/2Hcwj/YBp80JAcQMSeAylxv17FfUVoA1GBj/glsNQrLApvuyKU
         Yz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEU2HxQ6q/LFN3ZcXhOTdeHa0hw0kyeWBrXOIp9eUGM=;
        b=P75/qqTl6GCW1uEl/s8jbATrzk/z/HGhiU6AOAEK6N+AxaWRiUXMi1pO52dRF6RN/X
         0/6NL1y1H98ZR6oGDi/StSGIz/gNqNHgDjdxUdS2yFbrnOPLxt+h+SqQCI1yXtPGW0/v
         M3lLQpG7kIWArHjksplcEv75Q+VCHz0XlprfF7sbCciy1OQd5nkbSXdYTPHQrpvIYRBm
         ZCHsvCMv6TWUJTTippjXiGj67Fxu6i3XEVMDtQXIDT+/7WdtJRW4XSzOMqXRlYMkbp7w
         5XTYIOTXCy0flwY4D5HZsGFdDGosnT3cZCin+xMLElKeOWmjrAGUQ5ANsYMf5wob6d2U
         iW6A==
X-Gm-Message-State: AOAM533pstbBAZKSrtemA+ucdHNRq+D9gp94ucmhVRMbOznGefeTKkdi
        BDQ4hVsOl/kQP69qKwx9JCbCA0Nluq4KvKqb7yy3xA==
X-Google-Smtp-Source: ABdhPJy6xm6KJi//HmwmP4ZEusqNKx8viG5+S3vy3AfQakUeMqUKaBh+y9LoselJr9TqWewNfW7g6AL5rePjTMLtwLY=
X-Received: by 2002:a05:600c:1f17:b0:38f:f14d:82fa with SMTP id
 bd23-20020a05600c1f1700b0038ff14d82famr3620079wmb.149.1649949785942; Thu, 14
 Apr 2022 08:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-4-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-4-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 14 Apr 2022 16:22:54 +0100
Message-ID: <CAJ9a7VjZiYN6g+gPZRgc4fJQCJYcSXrdzRfT+kAiK0cwRfm+iA@mail.gmail.com>
Subject: Re: [PATCH v5 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware definitions
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++
>  .../devicetree/bindings/arm/coresight.txt     |  7 ++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> new file mode 100644
> index 000000000000..05210e0fc262
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
> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> +

These should be e-mail addresses of maintainers for this binding, not
the coresight sub-system.
See writing-schema.rst

> +properties:
> +  $nodename:
> +    pattern: "^tpdm(@[0-9a-f]+)$"
> +  compatible:
> +    items:
> +      - const: qcom,coresight-tpdm
> +      - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +   items:
> +     - const: apb_pclk
> +
> +  out-ports:
> +    description: |
> +      Output connections from the TPDM to coresight funnle/tpda.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port:
> +        description: Output connection from the TPDM to coresight
> +            funnel/tpda.
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
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index c68d93a35b6c..f7ce8af48574 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -52,6 +52,10 @@ its hardware characteristcs.
>                         "arm,coresight-cti", "arm,primecell";
>                         See coresight-cti.yaml for full CTI definitions.
>
> +               - Trace, Profiling and Diagnostics Monitor (TPDM):
> +                       "qcom,coresight-tpdm", "arm,primecell";
> +                       See coresight-tpdm.yaml for full TPDM definitions.
> +
>         * reg: physical base address and length of the register
>           set(s) of the component.
>
> @@ -82,6 +86,9 @@ its hardware characteristcs.
>  * Required properties for Coresight Cross Trigger Interface (CTI)
>         See coresight-cti.yaml for full CTI definitions.
>
> +* Required properties for Trace, Profiling and Diagnostics Monitor (TPDM)
> +       See coresight-tpdm.yaml for full TPDM definitions.
> +
>  * Required properties for devices that don't show up on the AMBA bus, such as
>    non-configurable replicators and non-configurable funnels:
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..0d39bb37935d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1977,6 +1977,7 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>  F:     Documentation/ABI/testing/sysfs-bus-coresight-devices-*
>  F:     Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
>  F:     Documentation/devicetree/bindings/arm/coresight-cti.yaml
> +F:     Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>  F:     Documentation/devicetree/bindings/arm/coresight.txt
>  F:     Documentation/devicetree/bindings/arm/ete.yaml
>  F:     Documentation/devicetree/bindings/arm/trbe.yaml
> --
> 2.17.1
>

With the above:
Reviewed by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
