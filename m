Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282F581E50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiG0DgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiG0DgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:36:07 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2889EDEF9;
        Tue, 26 Jul 2022 20:36:06 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id p5so1093244ilg.9;
        Tue, 26 Jul 2022 20:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dnK7WbRCdK4HBAuf4lsZCAqmt9UgwDBVwNpaccKaKvo=;
        b=Bz+JYWQvtW8OvXdOQcmzkhrxay6Hd4yv2RFYJwCz3vxOBdVOdJ68CNwbwhL+AduvZW
         fCU8DkCKby6+4dmZCTiOFnGMOZ0TfyunJrWvTGJC8w0x5WyKiVfJWrqy9ho84tCI6dEq
         u14qRCLtpKYAmJwLoMW85AVmsY/lckZF96+BMprELCSudjRlyQw3gVZc8CvetGBsLIoB
         gGp5W1u7xtXQz+shOIoKTXTBAw1Z9bvTiTGuYySWkV2mWy7Ie+6qTsrNElud9iMDgUab
         Ab8MkyPOscwCMjikwrcoLKq5ijuJqXtYrdeOeFbicyQVhzw251vCJU17sQpLNMT/SOu+
         sydw==
X-Gm-Message-State: AJIora+jn4B+QhyBZIbXZKwA9M2OP7Nv9i7b9DfroAl20IP+jq16nt5+
        v1ElPduB8PYNssYohsiuBQ==
X-Google-Smtp-Source: AGRyM1vPpRVEUNUO4vaxRM4Cs/vOlGLG2Tz+Cv5RcXMqMX7kBrmifz+HCaRGiayZ4f4YJmOABxm/aQ==
X-Received: by 2002:a05:6e02:11a3:b0:2dd:1a51:119c with SMTP id 3-20020a056e0211a300b002dd1a51119cmr7657899ilj.308.1658892965199;
        Tue, 26 Jul 2022 20:36:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y4-20020a056602178400b0067c05ad90d6sm8016707iox.19.2022.07.26.20.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 20:36:04 -0700 (PDT)
Received: (nullmailer pid 1589324 invoked by uid 1000);
        Wed, 27 Jul 2022 03:36:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Chris Healy <cphealy@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20220726230329.2844101-4-jiucheng.xu@amlogic.com>
References: <20220726230329.2844101-1-jiucheng.xu@amlogic.com> <20220726230329.2844101-4-jiucheng.xu@amlogic.com>
Subject: Re: [PATCH v2 4/4] dt-binding: perf: Add Amlogic DDR PMU
Date:   Tue, 26 Jul 2022 21:36:03 -0600
Message-Id: <1658892963.218595.1589323.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 07:03:29 +0800, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v1 -> v2:
>   - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>   - Delete "model", "dmc_nr", "chann_nr" new properties
>   - Fix compiling error
> ---
>  .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/perf/amlogic,g12_ddr_pmu.yaml#
Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.example.dts:21.26-29.11: Warning (unit_address_vs_reg): /example-0/ddr_pmu: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.example.dtb:0:0: /example-0/ddr_pmu: failed to match any schema with compatible: ['amlogic,g12a-ddr-pmu']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

