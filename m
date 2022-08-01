Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5339F586C30
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiHANoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiHANn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:43:58 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53C95BB;
        Mon,  1 Aug 2022 06:43:57 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id n138so8393763iod.4;
        Mon, 01 Aug 2022 06:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=zsZQN63lOHh8h4GXaIvhTBnUEILZRHFu8ewz58HKTGY=;
        b=hDem/g4l+oFS2ei0esqWY9ZaNfAo94ZSEPCgFulNQvyMKFoVr6ZzItT71gkjb9msSE
         R6DNLCLvrttj0pe9NSCWviOFMI+4Gp4r7VmuYk1vNhnNCDdX/kCXjEN9b7p+qO5MD7dT
         Yk5yiMH97ws8Er+fYm11hRfkohX++uvLI/08sd5d0ZOTqa8vlxE69hebmYjspc97TN6s
         JxRcjwoKEcnEdyMBA/HWxCsMeqKHcEmxv9w3vqsR9XzKMPJqBja7/Z0Xs7S94xSrmU0F
         i0oGWKpg5GCLHL76Vizb3Lg6Hhj7CKE+2CxDpc2Rn2Rp4omQQdbzUsxNFZYBU6r3qfby
         wr3w==
X-Gm-Message-State: AJIora/YzEZdfng7R+8BtiC24m/q+H6vWkuALQb2N+jWVf+2Sg5aVKAr
        uSdV4S63wn0+74cLv9Zd/A==
X-Google-Smtp-Source: AGRyM1t9Mj5nTHd4BV8E79tZn1dYTdEMV9X5kGdVN8crTiTo4iJ1VJeyJLdxHMNomc1wjgRKUpobrw==
X-Received: by 2002:a05:6638:30b:b0:33f:8d28:4d85 with SMTP id w11-20020a056638030b00b0033f8d284d85mr5996500jap.13.1659361436772;
        Mon, 01 Aug 2022 06:43:56 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t3-20020a02b183000000b0033e9c4c6a9esm5149828jah.82.2022.08.01.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:43:56 -0700 (PDT)
Received: (nullmailer pid 914821 invoked by uid 1000);
        Mon, 01 Aug 2022 13:43:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Will Deacon <will@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
In-Reply-To: <20220801060049.1655177-4-jiucheng.xu@amlogic.com>
References: <20220801060049.1655177-1-jiucheng.xu@amlogic.com> <20220801060049.1655177-4-jiucheng.xu@amlogic.com>
Subject: Re: [PATCH v3 4/4] dt-binding: perf: Add Amlogic DDR PMU
Date:   Mon, 01 Aug 2022 07:43:53 -0600
Message-Id: <1659361433.078688.914820.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022 14:00:49 +0800, Jiucheng Xu wrote:
> Add binding documentation for the Amlogic G12 series DDR
> performance monitor unit.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v2 -> v3:
>   - Remove oneOf
>   - Add descriptions
>   - Fix compiling warning
> 
> Changes v1 -> v2:
>   - Rename file, from aml_ddr_pmu.yaml to amlogic,g12_ddr_pmu.yaml
>   - Delete "model", "dmc_nr", "chann_nr" new properties
>   - Fix compiling error
> ---
>  .../bindings/perf/amlogic,g12_ddr_pmu.yaml    | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/perf/amlogic,g12_ddr_pmu.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/perf/amlogic,g12_ddr_pmu.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

