Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09924FFF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiDMT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiDMT0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:26:02 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842B66C94;
        Wed, 13 Apr 2022 12:23:40 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-deb9295679so3036305fac.6;
        Wed, 13 Apr 2022 12:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nw71/WQRUhg0t6rL1I9s4rl1al7MOSJ4hA/po68c59c=;
        b=Hi9NgTHV+W9qd1x2p122OKMVrkDAePSIymyNt+TFv7lXxtUzUsQ4/xB0bECDR3P/fc
         kmqNCUs1IhtmxbOz1o9i4orRfKdJPfn06KnMDQyZIWcyrz1YDf7QwP1QdXtOrFTeeAZY
         zepxO+JbgdPB9g6SFSAWfPXpI4hYxBg+xfF7+9RiVpRWAHzSbau+5YVEdvarEMwn6bEv
         VDM3n3gvWqJp5ztkR6ODk2xkdujplTRVetCf3mCoXD7H6S0TzrZlGULoWkUR504F0LCo
         Jb8lnnD6PPn1xtrDML6rexLKYqUMl/kFkkLgsHL/3a+JSJiJKU50Xki/FwrKsJO05fYJ
         lQcQ==
X-Gm-Message-State: AOAM531W2XscTsccCI0bF8PAPNe6t2ui6aVK73054WRP3bcVcXy+0/1y
        w3Wmd9kO8VyXnnzd1A70FQ==
X-Google-Smtp-Source: ABdhPJxP64aD70NQFPYD4OZ1flPgBgyxec0fISdcdAOFAJz1bEO3+F98ejSye1fVUWMJpuCrR0ZnZg==
X-Received: by 2002:a05:6870:208:b0:e2:a000:d65f with SMTP id j8-20020a056870020800b000e2a000d65fmr100270oad.265.1649877819991;
        Wed, 13 Apr 2022 12:23:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d63c8000000b005b235a56831sm15240880otl.49.2022.04.13.12.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:23:39 -0700 (PDT)
Received: (nullmailer pid 3681503 invoked by uid 1000);
        Wed, 13 Apr 2022 19:23:38 -0000
Date:   Wed, 13 Apr 2022 14:23:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: add bindings for ums512
 clock controller
Message-ID: <YlcjOmDAx6OAl+s0@robh.at.kernel.org>
References: <20220408104520.1896568-1-gengcixi@gmail.com>
 <20220408104520.1896568-2-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408104520.1896568-2-gengcixi@gmail.com>
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

On Fri, Apr 08, 2022 at 06:45:18PM +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> add a new bindings to describe ums512 clock compatible string.

s/add a/Add/

> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> new file mode 100644
> index 000000000000..a80bd6ca4a7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: UMS512 Clock Control Unit Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  "#clock-cells":
> +    const: 1
> +
> +  compatible:
> +    enum:
> +      - sprd,ums512-aon-gate
> +      - sprd,ums512-apahb-gate
> +      - sprd,ums512-apapb-gate
> +      - sprd,ums512-audcpahb-gate
> +      - sprd,ums512-audcpapb-gate
> +      - sprd,ums512-g0-pll
> +      - sprd,ums512-g2-pll
> +      - sprd,ums512-g3-pll
> +      - sprd,ums512-gc-pll
> +      - sprd,ums512-gpu-clk
> +      - sprd,ums512-mm-clk
> +      - sprd,ums512-mm-gate-clk
> +      - sprd,ums512-pmu-gate
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +    description: |
> +      The input parent clock(s) phandle for this clock, only list fixed
> +      clocks which are declared in devicetree.
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: ext-26m
> +      - const: ext-32k
> +      - const: ext-4m
> +      - const: rco-100m
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - sprd,ums512-ap-clk
> +        - sprd,ums512-aonapb-clk
> +then:
> +  required:
> +    - reg
> +
> +else:
> +  description: |
> +    Other UMS512 clock nodes should be the child of a syscon node in
> +    which compatible string should be:
> +            "sprd,ums512-glbregs", "syscon", "simple-mfd"

This doesn't match your example.

> +
> +    The 'reg' property for the clock node is also required if there is a sub
> +    range of registers for the clocks.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        ap_clk: clock-controller@20200000 {
> +                compatible = "sprd,ums512-ap-clk";
> +                reg = <0 0x20200000 0 0x1000>;
> +                clocks = <&ext_26m>;
> +                clock-names = "ext-26m";
> +                #clock-cells = <1>;
> +        };
> +
> +        syscon@20100000{
> +               compatible = "sprd,ums512-glbregs", "syscon","simple-mfd";
> +               reg = <0 0x20100000 0 0x4000>;
> +               clocks = <&ext_32k>, <&ext_26m>;
> +               clock-names = "ext-32k", "ext-26m";
> +               #clock-cells = <1>;
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
