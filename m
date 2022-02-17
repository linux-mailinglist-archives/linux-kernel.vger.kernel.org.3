Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B10A4BA76E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiBQRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:49:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiBQRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:49:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B9C291FB4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:48:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso4613139wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eA6IIhqYEfrRDuKOGshN1p14BWrOpnI8vaNPig+Er3U=;
        b=Z7Lvy/Lu0PgnLPUDuFPsdG49Zyk4N0fWd92pQXI2BU3ytXBKNzd+AoncQRZWkjzXbZ
         oxp4AAYZ1qPDAOmTUD4Ti47DXQMMtwT4+Qd767pUOA99nTaU6PHtqDb3tcKd0CcuVBrl
         5KGTiHLLJEjsVcJvTXRSy49WeEQ04aBzlIPZDYzvzssbiOJ6QHjoZTgr1/mw/YibIEFp
         PpyGXZABs9l0LsrBr4WR/YZl5zmsdVWuUGuhPDk3w4W4WWlXz+7CGL2svqs5EE5uQ+U8
         FYSNfFI79gOtkhewdBFZLQqcYqZeFdew3rJTLJ6tDdqvqP7slTd1dNFLv2M//KNbcWct
         X25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eA6IIhqYEfrRDuKOGshN1p14BWrOpnI8vaNPig+Er3U=;
        b=6zozfjYArh64E8Tz56FV0xtD7r3K5Mg2yr6oLrO9spS2H8qlV1Ms4nX7CzQUJXd1Ro
         naPgyBcJjhrADg4l0miC2Aqq790GAXQF8ehus1lXUg5txFoM5MpwtayOFfobOCFqX2TY
         iqUq/2mQt/CY14uhjaZ98gTCLbxa2vBsrPW8b8NmZAqXlCo0rD1aXrTXm6r17s0l1oTb
         UydCPZ02NQ4YmkqgPJvazdY454HdCeCbvXJVEz2c5ZKvFE8miyvqjCpTdrJ8iEm+Q4oL
         O6sSXeVhx7n7sigwTG+lD5s2XH/zXhYzR/Yj6Q7E0wA3mWNxoYYCFKFxH93/VYTbjB1p
         iqyQ==
X-Gm-Message-State: AOAM531p6Ux3o3dnxmB6o5dwd27U6/myG2ceNH+tfXRoCBQNSFWaWY62
        jG4dw9E+VAM65lppsnG0s8BpDRBXfBQJA8EjrXPJ1nM/IPE=
X-Google-Smtp-Source: ABdhPJwwa3LmENnFrJD5FLhvk02XJs/Qc9bfHqvayUmoxC5bFLZFN14JD0xFcO6PeEfXXckQgirXkhtlEZYLaYPTxoI=
X-Received: by 2002:a05:600c:1f05:b0:37b:d9aa:e210 with SMTP id
 bd5-20020a05600c1f0500b0037bd9aae210mr7242831wmb.63.1645120130134; Thu, 17
 Feb 2022 09:48:50 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com> <20220209105706.18852-5-quic_jinlmao@quicinc.com>
In-Reply-To: <20220209105706.18852-5-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 17 Feb 2022 17:48:39 +0000
Message-ID: <CAJ9a7ViO2S_sUCNaZ711SNDz-jmYiWxCBcBYOc-gVGkoCG-VDA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: arm: Adds CoreSight TPDM hardware definitions
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

On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/coresight-tpdm.yaml          | 81 +++++++++++++++++++
>  .../devicetree/bindings/arm/coresight.txt     |  7 ++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> new file mode 100644
> index 000000000000..7ebc1bf7abc2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> @@ -0,0 +1,81 @@
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
> +      Output connections from the TPDM to legacy CoreSight trace bus.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port:
> +        description: Output connection from the TPDM to legacy CoreSight
> +          Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +

As we discussed in patch 0/10 of this set - the TDPM actually sends
data to TDPA - not to coresight. These descriptions should match that.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum TPDM definition.
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
> +

example looks OK, but I would like to see something of a _tdpa in the
nameing as that is the funnel / link the tdpm sends data to.

Regards

Mike

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
> index ea3e6c914384..434bbe98d22b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1906,6 +1906,7 @@ T:        git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
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


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
