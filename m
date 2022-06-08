Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41CA543EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiFHVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiFHVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:48:13 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C5B7DA;
        Wed,  8 Jun 2022 14:48:10 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id r3so17567725ilt.8;
        Wed, 08 Jun 2022 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=C89YCUmtmvFF9KOpRVLOD+5qPTcSVv9Czo8wmpOn5QQ=;
        b=alB36/sD9JC3TNY6DVf2tOsBKw/IbXJRM9jtbdtdOTbWoZxMjSwJ2y9M8GOCg8UdFE
         DBH5zOc+aEw0km/M7bE0yPN+Ek28bDiWIdp2mFPtD1pDI6zWegcRBj7dNrMfGSw/9oHh
         7E4UJg8jI3dDwS0zGU/a6aRp1dAhsYX9qJbwJPHP+HzdYMNnrIyVbRV9b7K5Uj9K6/Hn
         0cw0RmmQGHbhIEhskzd1oElBHEKhMP+mqVfutKsXkAgydt2s41rMNJVzsD8Vty64ToJ+
         4Ubw1j9wcAg/QYeFd2nSYJro/0rEWIHq7o6ULuIrFPklQ7OQt7opLOXIrkY3YuhI8Bnw
         5xPA==
X-Gm-Message-State: AOAM531fdb6N5D4F+08GDgvauqXCpr1Id2PIfaoQH6nK06yopSeIDeKk
        Rg+67KHiq41miWxI1qFlOg==
X-Google-Smtp-Source: ABdhPJx4kXTRzt2vSXL59HFyfqF6TvyiFJZYp0xXhzYA3wWXF0PYLeBW9AYJMsXKlTA8+kE6c+7aXg==
X-Received: by 2002:a92:cbcd:0:b0:2d1:ba4f:2f4f with SMTP id s13-20020a92cbcd000000b002d1ba4f2f4fmr20059291ilq.181.1654724889366;
        Wed, 08 Jun 2022 14:48:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t17-20020a92c0d1000000b002d3da8e4af5sm9164913ilf.23.2022.06.08.14.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:48:08 -0700 (PDT)
Received: (nullmailer pid 2134376 invoked by uid 1000);
        Wed, 08 Jun 2022 21:48:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        coresight@lists.linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20220608154705.40322-4-quic_jinlmao@quicinc.com>
References: <20220608154705.40322-1-quic_jinlmao@quicinc.com> <20220608154705.40322-4-quic_jinlmao@quicinc.com>
Subject: Re: [PATCH v8 03/10] dt-bindings: arm: Adds CoreSight TPDM hardware definitions
Date:   Wed, 08 Jun 2022 15:48:06 -0600
Message-Id: <1654724886.784606.2134375.nullmailer@robh.at.kernel.org>
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

On Wed, 08 Jun 2022 23:46:58 +0800, Mao Jinlong wrote:
> Adds new coresight-tpdm.yaml file describing the bindings required
> to define tpdm in the device trees.
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/coresight-tpdm.yaml          | 99 +++++++++++++++++++
>  .../devicetree/bindings/arm/coresight.txt     |  7 ++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: $nodename:0: 'memory-controller@e000e000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: clocks: [[4294967295, 11], [4294967295, 44]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: clock-names: ['memclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.example.dtb: memory-controller@e000e000: '#address-cells', '#size-cells', 'nand-controller@0,0', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: $nodename:0: 'spi@e0100000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: '#address-cells', '#size-cells', 'dma-names', 'dmas', 'flash@1', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: $nodename:0: 'dma-controller@12680000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm,pl330.example.dtb: dma-controller@12680000: '#dma-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: $nodename:0: 'dma-controller@10130000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@10130000: '#dma-cells', 'interrupts', 'lli-bus-interface-ahb1', 'lli-bus-interface-ahb2', 'mem-bus-interface-ahb2', 'memcpy-burst-size', 'memcpy-bus-width' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: $nodename:0: 'dma-controller@67000000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: compatible:1: 'arm,primecell' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: compatible: ['faraday,ftdma020', 'arm,pl080', 'arm,primecell'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.example.dtb: dma-controller@67000000: '#dma-cells', 'arm,primecell-periphid', 'interrupts', 'lli-bus-interface-ahb2', 'mem-bus-interface-ahb2', 'memcpy-burst-size', 'memcpy-bus-width', 'resets' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: $nodename:0: 'mmc@80118000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: clocks: [[4294967295, 0], [4294967295, 1]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dtb: mmc@80118000: '#address-cells', '#size-cells', 'bus-width', 'interrupts', 'non-removable', 'vmmc-supply', 'wifi@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: $nodename:0: 'mmc@5000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@5000: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: $nodename:0: 'mmc@80126000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: clocks: [[4294967295, 1, 5], [4294967295, 1, 5]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: clock-names: ['sdi', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@80126000: 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'cd-gpios', 'dma-names', 'dmas', 'interrupts', 'max-frequency', 'st,sig-dir-cmd', 'st,sig-dir-dat0', 'st,sig-dir-dat2', 'st,sig-pin-fbclk', 'vmmc-supply', 'vqmmc-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: $nodename:0: 'mmc@101f6000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@101f6000: 'bus-width', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'full-pwr-cycle', 'interrupts', 'max-frequency', 'st,sig-dir-cmd', 'st,sig-dir-dat0', 'st,sig-dir-dat2', 'st,sig-dir-dat31', 'st,sig-pin-fbclk', 'vmmc-supply' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: $nodename:0: 'mmc@52007000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dtb: mmc@52007000: 'arm,primecell-periphid', 'cap-mmc-highspeed', 'cap-sd-highspeed', 'interrupts', 'max-frequency', 'resets' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/arm,pl031.example.dtb: rtc@10017000: $nodename:0: 'rtc@10017000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/rtc/arm,pl031.example.dtb: rtc@10017000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: $nodename:0: 'memory-controller@e000e000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: clocks: [[4294967295, 11], [4294967295, 44]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: clock-names: ['memclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/arm,pl353-smc.example.dtb: memory-controller@e000e000: '#address-cells', '#size-cells', 'nand-controller@0,0', 'ranges' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: $nodename:0: 'serial@80120000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: clock-names: ['uartclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dtb: serial@80120000: 'dma-names', 'dmas', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: $nodename:0: 'serial@100000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dtb: serial@100000: 'interrupts-extended' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: $nodename:0: 'clcd@10020000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: clock-names: ['clcdclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/arm,pl11x.example.dtb: clcd@10020000: 'interrupt-names', 'interrupts', 'max-memory-bandwidth', 'port' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: $nodename:0: 'sysctl@20000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: clock-names: ['refclk', 'timclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/sp810.example.dtb: sysctl@20000: '#clock-cells', 'clock-output-names' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20020000: $nodename:0: 'cti@20020000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20020000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: $nodename:0: 'cti@859000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: compatible:1: 'arm,primecell' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: compatible: ['arm,coresight-cti-v8-arch', 'arm,coresight-cti', 'arm,primecell'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@859000: 'arm,cs-dev-assoc', 'cpu' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: $nodename:0: 'cti@858000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@858000: '#address-cells', '#size-cells', 'arm,cti-ctm-id', 'trig-conns@0', 'trig-conns@1' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: $nodename:0: 'cti@20110000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dtb: cti@20110000: '#address-cells', '#size-cells', 'trig-conns@0', 'trig-conns@1', 'trig-conns@2' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: $nodename:0: 'serio@70000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: clock-names: ['KMIREFCLK', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serio/arm,pl050.example.dtb: serio@70000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: $nodename:0: 'watchdog@66090000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: clock-names: ['wdog_clk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dtb: watchdog@66090000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: $nodename:0: 'audio-controller@40000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/arm,pl041.example.dtb: audio-controller@40000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f0000: '#mbox-cells', 'arm,mhuv2-protocols', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: $nodename:0: 'mailbox@2b1f1000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: mailbox@2b1f1000: '#mbox-cells', 'arm,mhuv2-protocols', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b1f0000: '#mbox-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: $nodename:0: 'mailbox@2b2f0000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dtb: mailbox@2b2f0000: '#mbox-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: $nodename:0: 'dma-controller@11420000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/samsung,exynos5433-lpass.example.dtb: dma-controller@11420000: '#dma-cells', 'dma-channels', 'dma-requests', 'interrupts', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: $nodename:0: 'timer@fc800000' does not match '^tpdm(@[0-9a-f]+)$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: compatible:0: 'qcom,coresight-tpdm' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: clock-names: ['timer1', 'timer2', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dtb: timer@fc800000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-tpdm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

