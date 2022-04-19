Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE25066FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350036AbiDSIf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350031AbiDSIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:35:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FD20F60
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:32:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so995937wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHvs75OIdBcW18yBO72Em+wYmTcQRlmIYGoMfGShO9k=;
        b=e8aQaurBWDlSp7s0M5kfav7M7rW8d1x5lxD7JtvOOy55WVtz56crt8Oudr7I+Zp/AM
         X7WvU2brUonFdV3xHXtlSE6Twe9EnbX2q/p1YPArL+VDrTs+0/sJPYAuJRZug07jBU5U
         dRGnIu6Xrq7v7J1O/Rku506iKJbcXD07p1k25KF9hItPzS9AGk+HDhLB3ELsOjflHnyJ
         uDLpD3Lp5FyTGXpPUPjTTbG5rl+hEwxQTV4kTOoLsuRfln8VMAlNjoIVwar4zyViPhH3
         XCOQRl7IM2CEl8iTmKUl0+BkH49WkYZ60gYLXQImQ1jcWz+j7yTmQbO63d9mJCGpN9k7
         1OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHvs75OIdBcW18yBO72Em+wYmTcQRlmIYGoMfGShO9k=;
        b=fA3aECWGJD8oPykLDYBQaYkiYqiQRNcrezl9dkRmPgU39QGlDxSR6WpcOq2pKJXaos
         r9Kv/eQztJBsDvJlbd74e6SHc79XWSHv3tq+beCrBHchMe0pxDhao9dHK/4eNgfQuWNg
         h/vhRL2z7n0SaEgm7AWiHW/v1Md+6UBsNnEeu7qOoPoG5rJvW2+yD4ZcuGRgsCmFqt95
         0NyjNptlNYiTfJ9j4HQ4m0XjoMEiIeJdDEwgjSW3ipAJ6wyb7CpDsP0bF/a/caARHemJ
         Iz44Y+5mC/wXh1npRoLBFz21CeeyGd2X2yR9C6BF7w9lRbndtnjVBz9Ia+6+Dm5V5cUR
         an2g==
X-Gm-Message-State: AOAM530UjbIJ6iRD5ASS4v9fM5WiXjAWzD2qOstIHlSScEqrDCB5mxhn
        gKb5XAP/lS5lN9JmQCZXHeH/l05U6qQIPzF9ZkBSmg==
X-Google-Smtp-Source: ABdhPJzQhWxnwUMFOcpQPCWc/3KSDPEv7os9QOAeC3syMn4xsJmdbG24HL6lPci1vlSXnS5HChzrZVbdum1QfhR1nXU=
X-Received: by 2002:a7b:cc13:0:b0:38e:67e3:db47 with SMTP id
 f19-20020a7bcc13000000b0038e67e3db47mr19059920wmh.133.1650357158957; Tue, 19
 Apr 2022 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-9-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-9-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 19 Apr 2022 09:32:37 +0100
Message-ID: <CAJ9a7VjgHwPcLFZdApPcLdsOZ_s=nkRXar5hqrFtDscrc0CqBw@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
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

Hi

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Adds new coresight-tpda.yaml file describing the bindings required
> to define tpda in the device trees.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/coresight-tpda.yaml          | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> new file mode 100644
> index 000000000000..2c79de0a7928
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> @@ -0,0 +1,119 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/coresight-tpda.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Trace, Profiling and Diagnostics Aggregator - TPDA
> +
> +description: |
> +  TPDAs are responsible for packetization and timestamping of data sets
> +  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
> +  more attached TPDM and pushing the resultant (packetized) data out a
> +  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
> +  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
> +
> +maintainers:
> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> +

as mentioned in patch 03 - these should be bindings maintainers.

with the above change

Reviewed by: Mike Leach <mike.leach@linaro.org>




> +properties:
> +  $nodename:
> +    pattern: "^tpda(@[0-9a-f]+)$"
> +  compatible:
> +    items:
> +      - const: qcom,coresight-tpda
> +      - const: arm,primecell
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
> +  in-ports:
> +    type: object
> +    description: |
> +      Input connections from TPDM to TPDA
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-9a-f]+$":
> +        type: object
> +        required:
> +          - reg
> +
> +    required:
> +      - '#size-cells'
> +      - '#address-cells'
> +
> +  out-ports:
> +    type: object
> +    description: |
> +      Output connections from the TPDA to legacy CoreSight trace bus.
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +     port:
> +       description:
> +         Output connection from the TPDA to legacy CoreSight Trace bus.
> +       $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +    - compatible
> +    - reg
> +    - clocks
> +    - clock-names
> +    - in-ports
> +    - out-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  # minimum tpda definition.
> +  - |
> +    tpda@6004000 {
> +       compatible = "qcom,coresight-tpda", "arm,primecell";
> +       reg = <0x6004000 0x1000>;
> +
> +       qcom,tpda-atid = <65>;
> +
> +       clocks = <&aoss_qmp>;
> +       clock-names = "apb_pclk";
> +
> +       in-ports {
> +         #address-cells = <1>;
> +         #size-cells = <0>;
> +
> +        port@0 {
> +          reg = <0>;
> +          tpda_qdss_0_in_tpdm_dcc: endpoint {
> +            remote-endpoint =
> +              <&tpdm_dcc_out_tpda_qdss_0>;
> +            };
> +        };
> +      };
> +
> +       out-ports {
> +         port {
> +                 tpda_qdss_out_funnel_in0: endpoint {
> +                    remote-endpoint =
> +                    <&funnel_in0_in_tpda_qdss>;
> +                  };
> +          };
> +       };
> +    };
> +
> +...
> --
> 2.17.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
