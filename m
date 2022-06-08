Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB04543ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiFHVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiFHVsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:48:18 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001ACE06;
        Wed,  8 Jun 2022 14:48:15 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id y17so17551275ilj.11;
        Wed, 08 Jun 2022 14:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=hDl4d8kyN6O/buzOAzDmtfIHRZEP2zNZ77tF3N/rJgw=;
        b=rUaBKONjamzxloxsnwdi67eRRJXthvxsSf1slz5Qz+WxJc6GoLbPEURLuu1IAZW4eD
         lurU7PNQmcNcxgBxmGGVXCIXOqgPBTX7zk5qIcPkepEdqz0VbEtiIdApOhkdN3eRzwk8
         cKMAItK0APAC2i4bmu0kM5u/gQrvGiIpFMesSsRC2MyRJwbRHOSfyl2cXNY7+S55nOMZ
         rSNAbVp9QRq3TA+6X3Z7gJ01DJU+dd3laLlPvKYvDqUVdAo3UwLx6ap4jGSTsYOIzhvC
         9UEk58vd8k5u2ESfqcW2Ze6+9atEyw5Qff4m4Rl4jf80WQAE/I8JBNBQP1iY2huItot7
         b8WQ==
X-Gm-Message-State: AOAM5313/JW5U9QqMl/Y7tmq4WKoGy8vjJWdKhZ7VfBpOmlmkiNNDO2a
        sQ3YliF4dUB+SWYgk6RTzA==
X-Google-Smtp-Source: ABdhPJxyCvvZG5TdsCVwlzB9XL7g4Mf1RDjHqbouXdJo0fvWq7zbKnL/byxdiQI9J7ERfE5rjcuUeg==
X-Received: by 2002:a05:6e02:1bef:b0:2d3:c3d5:823d with SMTP id y15-20020a056e021bef00b002d3c3d5823dmr19392539ilv.2.1654724894360;
        Wed, 08 Jun 2022 14:48:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id u2-20020a022e42000000b00331b6dcfa07sm3670097jae.61.2022.06.08.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:48:13 -0700 (PDT)
Received: (nullmailer pid 2134379 invoked by uid 1000);
        Wed, 08 Jun 2022 21:48:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        devicetree@vger.kernel.org, coresight@lists.linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
In-Reply-To: <20220608154705.40322-9-quic_jinlmao@quicinc.com>
References: <20220608154705.40322-1-quic_jinlmao@quicinc.com> <20220608154705.40322-9-quic_jinlmao@quicinc.com>
Subject: Re: [PATCH v8 08/10] dt-bindings: arm: Adds CoreSight TPDA hardware definitions
Date:   Wed, 08 Jun 2022 15:48:06 -0600
Message-Id: <1654724886.791955.2134378.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 23:47:03 +0800, Mao Jinlong wrote:
> Adds new coresight-tpda.yaml file describing the bindings required
> to define tpda in the device trees.
> 
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/coresight-tpda.yaml          | 100 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpda.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: $nodename:0: 'memory-controller@e000e000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: clocks: [[4294967295, 11], [4294967295, 44]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: clock-names: ['memclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: '#address-cells', '#size-cells', 'nand-controller@0,0', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: $nodename:0: 'spi@e0100000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: '#address-cells', '#size-cells', 'dma-names', 'dmas', 'flash@1', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: $nodename:0: 'dma-controller@12680000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: '#dma-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: $nodename:0: 'dma-controller@10130000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: '#dma-cells', 'interrupts', 'lli-bus-interface-ahb1', 'lli-bus-interface-ahb2', 'mem-bus-interface-ahb2', 'memcpy-burst-size', 'memcpy-bus-width' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: $nodename:0: 'dma-controller@67000000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: compatible:1: 'arm,primecell' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: compatible: ['faraday,ftdma020', 'arm,pl080', 'arm,primecell'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: '#dma-cells', 'arm,primecell-periphid', 'interrupts', 'lli-bus-interface-ahb2', 'mem-bus-interface-ahb2', 'memcpy-burst-size', 'memcpy-bus-width', 'resets' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: $nodename:0: 'mmc@80118000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: clocks: [[4294967295, 0], [4294967295, 1]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: '#address-cells', '#size-cells', 'bus-width', 'interrupts', 'non-removable', 'vmmc-supply', 'wifi@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: $nodename:0: 'mmc@5000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: $nodename:0: 'mmc@80126000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: clocks: [[4294967295, 1, 5], [4294967295, 1, 5]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: clock-names: ['sdi', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'cd-gpios', 'dma-names', 'dmas', 'interrupts', 'max-frequency', 'st,sig-dir-cmd', 'st,sig-dir-dat0', 'st,sig-dir-dat2', 'st,sig-pin-fbclk', 'vmmc-supply', 'vqmmc-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: $nodename:0: 'mmc@101f6000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'full-pwr-cycle', 'interrupts', 'max-frequency', 'st,sig-dir-cmd', 'st,sig-dir-dat0', 'st,sig-dir-dat2', 'st,sig-dir-dat31', 'st,sig-pin-fbclk', 'vmmc-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: $nodename:0: 'mmc@52007000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: 'arm,primecell-periphid', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'interrupts', 'max-frequency', 'resets' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/arm,pl031.example.dtb: rtc@10017000: $nodename:0: 'rtc@10017000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/arm,pl031.example.dtb: rtc@10017000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/arm,pl031.example.dtb: rtc@10017000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/arm,pl031.example.dtb: rtc@10017000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: $nodename:0: 'memory-controller@e000e000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: clocks: [[4294967295, 11], [4294967295, 44]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: clock-names: ['memclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: '#address-cells', '#size-cells', 'nand-controller@0,0', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: $nodename:0: 'serial@80120000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: clock-names: ['uartclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: 'dma-names', 'dmas', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: $nodename:0: 'serial@100000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: $nodename:0: 'clcd@10020000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: clock-names: ['clcdclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: 'interrupt-names', 'interrupts', 'max-memory-bandwidth', 'port' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: $nodename:0: 'sysctl@20000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: clock-names: ['refclk', 'timclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: '#clock-cells', 'clock-output-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20020000: $nodename:0: 'cti@20020000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20020000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20020000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20020000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: $nodename:0: 'cti@859000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: compatible:1: 'arm,primecell' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: compatible: ['arm,coresight-cti-v8-arch', 'arm,coresight-cti', 'arm,primecell'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: 'arm,cs-dev-assoc', 'cpu' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: $nodename:0: 'cti@858000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: '#address-cells', '#size-cells', 'arm,cti-ctm-id', 'trig-conns@0', 'trig-conns@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: $nodename:0: 'cti@20110000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: '#address-cells', '#size-cells', 'trig-conns@0', 'trig-conns@1', 'trig-conns@2' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: $nodename:0: 'serio@70000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: clock-names: ['KMIREFCLK', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: $nodename:0: 'watchdog@66090000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: clock-names: ['wdog_clk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: $nodename:0: 'audio-controller@40000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: '#mbox-cells', 'arm,mhuv2-protocols', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: $nodename:0: 'mailbox@2b1f1000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: '#mbox-cells', 'arm,mhuv2-protocols', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: '#mbox-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: $nodename:0: 'mailbox@2b2f0000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: '#mbox-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: $nodename:0: 'dma-controller@11420000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: '#dma-cells', 'dma-channels', 'dma-requests', 'interrupts', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: $nodename:0: 'timer@fc800000' does not match '^tpda(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: compatible:0: 'qcom,coresight-tpda' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: clock-names: ['timer1', 'timer2', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: 'in-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: 'out-ports' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpda.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

