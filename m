Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523A65312F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiEWOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiEWOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:25:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C185A582;
        Mon, 23 May 2022 07:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17E7AB81100;
        Mon, 23 May 2022 14:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC4DC385A9;
        Mon, 23 May 2022 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653315912;
        bh=4vLh4ue1tMMosFDoK6263Dar2yYqNCg/G7FWJAgLPp8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r/qpw7GGCIz7a5LLJurI22VqpnfZPjCvUilv1WtvGhte7xO3Zl4zmE0M9g7GC3NGG
         rGKDBc6/bHSkH6bE3mKH9G1LtslYjnqyyeptjtibGprZDPkKLueriLMdselH4vnA44
         LPPPZHvmWc3AsbVqQ+gJNDiGFZYcrF4FJdbdJWrz9UBGg8ML7flJhJAYF7Gm2MCGjb
         0ng2XYOQ6E4h+M91DkR5eoUZ+Y7dcnO4E0Cz7wEbwAT5sMXOSpRJxBKKhC2Xu1cfYT
         SKH/4XHglOuFn16JEX3bNahmLeW37KB6Yu8BE2dTtsutcMO/YsOZNrd2p0LAzqiyGu
         pR5o/ewDnTIMw==
Received: by mail-ed1-f49.google.com with SMTP id g12so19369632edq.4;
        Mon, 23 May 2022 07:25:12 -0700 (PDT)
X-Gm-Message-State: AOAM530XevtgSa9wN2p6npVkyjHN21bseyPwEwAK96QFaZYSIN/AYgaH
        W23PYC14X9A3+Ze/b8W1mEw0b6oJxgvGLiLT4g==
X-Google-Smtp-Source: ABdhPJwoOeWMZ55frHI3XEH4l/rWGlWP0SKbPSv8LWz5GQV6XKBYerjQpqXQjeWUQavlCQXH9Ze9HnGb4cM8NySG3R4=
X-Received: by 2002:a05:6402:1e93:b0:42b:5134:6bf6 with SMTP id
 f19-20020a0564021e9300b0042b51346bf6mr9903039edf.40.1653315911050; Mon, 23
 May 2022 07:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-9-quic_jinlmao@quicinc.com> <beba5968-3115-3c09-cda6-67095ca55226@arm.com>
In-Reply-To: <beba5968-3115-3c09-cda6-67095ca55226@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 May 2022 09:24:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK8Z_J2xaOsBM-U4hhHPgQCudd=SGmPqwdipArWmTXJYw@mail.gmail.com>
Message-ID: <CAL_JsqK8Z_J2xaOsBM-U4hhHPgQCudd=SGmPqwdipArWmTXJYw@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 4:44 AM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Cc: Rob Herring
>

Will or will not have any effect...

Please use get_maintainers.pl and send your patches to the right
lists/maintainers. DT patches only get reviewed if sent to DT list. So
please resend to the DT list. But before you do, I can tell this
binding hasn't been tested so fix all the warnings first.

Rob

>
>
> On 09/05/2022 14:39, Mao Jinlong wrote:
> > Adds new coresight-tpda.yaml file describing the bindings required
> > to define tpda in the device trees.
> >
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> > Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> > ---
> >   .../bindings/arm/coresight-tpda.yaml          | 119 ++++++++++++++++++
> >   MAINTAINERS                                   |   1 +
> >   2 files changed, 120 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/coresight-tpda.yaml b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> > new file mode 100644
> > index 000000000000..4948ac13e7f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> > @@ -0,0 +1,119 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +# Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/coresight-tpda.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Trace, Profiling and Diagnostics Aggregator - TPDA
> > +
> > +description: |
> > +  TPDAs are responsible for packetization and timestamping of data sets
> > +  utilizing the MIPI STPv2 packet protocol. Pulling data sets from one or
> > +  more attached TPDM and pushing the resultant (packetized) data out a
> > +  master ATB interface. Performing an arbitrated ATB interleaving (funneling)
> > +  task for free-flowing data from TPDM (i.e. CMB and DSB data set flows).
> > +
> > +maintainers:
> > +  - Mao Jinlong <quic_jinlmao@quicinc.com>
> > +  - Tao Zhang <quic_taozha@quicinc.com>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^tpda(@[0-9a-f]+)$"
> > +  compatible:
> > +    items:
> > +      - const: qcom,coresight-tpda
> > +      - const: arm,primecell
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb_pclk
> > +
> > +  in-ports:
> > +    type: object
> > +    description: |
> > +      Input connections from TPDM to TPDA
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
>
> --->8---
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^port@[0-9a-f]+$":
> > +        type: object
> > +        required:
> > +          - reg
> > +
> > +    required:
> > +      - '#size-cells'
> > +      - '#address-cells'
>
> ---8<---
>
> I believe the above snippet is not needed and is covered by the generic
> ports.
>
>
> > +
> > +  out-ports:
> > +    type: object
> > +    description: |
> > +      Output connections from the TPDA to legacy CoreSight trace bus.
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +     port:
> > +       description:
> > +         Output connection from the TPDA to legacy CoreSight Trace bus.
> > +       $ref: /schemas/graph.yaml#/properties/port
> > +
> > +required:
> > +    - compatible
> > +    - reg
> > +    - clocks
> > +    - clock-names
> > +    - in-ports
> > +    - out-ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # minimum tpda definition.
> > +  - |
> > +    tpda@6004000 {
> > +       compatible = "qcom,coresight-tpda", "arm,primecell";
> > +       reg = <0x6004000 0x1000>;
> > +
> > +       qcom,tpda-atid = <65>;
> > +
> > +       clocks = <&aoss_qmp>;
> > +       clock-names = "apb_pclk";
> > +
> > +       in-ports {
> > +         #address-cells = <1>;
> > +         #size-cells = <0>;
> > +
> > +        port@0 {
> > +          reg = <0>;
> > +          tpda_qdss_0_in_tpdm_dcc: endpoint {
> > +            remote-endpoint =
> > +              <&tpdm_dcc_out_tpda_qdss_0>;
> > +            };
> > +        };
> > +      };
> > +
> > +       out-ports {
> > +         port {
> > +                 tpda_qdss_out_funnel_in0: endpoint {
> > +                    remote-endpoint =
> > +                    <&funnel_in0_in_tpda_qdss>;
> > +                  };
> > +          };
> > +       };
> > +    };
> > +
> > +...
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 28d32b3f3f5c..5d2d8c0ee340 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1978,6 +1978,7 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
> >   F:  Documentation/ABI/testing/sysfs-bus-coresight-devices-*
> >   F:  Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> >   F:  Documentation/devicetree/bindings/arm/coresight-cti.yaml
> > +F:   Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> >   F:  Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> >   F:  Documentation/devicetree/bindings/arm/coresight.txt
> >   F:  Documentation/devicetree/bindings/arm/ete.yaml
>
> Otherwise looks good to me.
>
> Suzuki
