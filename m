Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5789A4D0D50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbiCHBI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiCHBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:08:47 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976422CC80;
        Mon,  7 Mar 2022 17:07:50 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id x193so17290312oix.0;
        Mon, 07 Mar 2022 17:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=4Vh0skU/TpnaqVycF2Gk7ec7Z9iE5PhyKRGG3sXCJBg=;
        b=IzzfGnauhUxQaaQdsK7A5xAaArzRgja09UERKryKqQmii0HogCjjH77xoNWvjtgd6s
         k7hE1EOs+0vnGXO2KmSCjVy3SsMjUjvEzq0HMIUT4WAj0KajXZgGiC915VlbXu0q3oEI
         M1/coqzSS3KTqEoCkSNSVzmDI2aPjbsut8ku3H89ZzDZbbKyIIZjrO3EPDvgHDkfX6e0
         HpOUoBu5kdO4ppfc9WgdfzpPvya5J8K5eqirLRa+cW87bTHc+Al+3mDvtza4vHXGiLIf
         ofH1p4TFRnJZU7MRZGT5axUxSpcEWO5TJqG6rSXvBvun8BQsKvZU57WxjoCbMWplvDx3
         pfnA==
X-Gm-Message-State: AOAM533CuF2BGNIXemU6vRv4uACabhvfACWo6Vk7/cuLhmnwSHQGl/6d
        lw5pdpItJqBP0Y8cJx/U3A==
X-Google-Smtp-Source: ABdhPJxEXFX5X26D3/ir03omCumnoMENEbRGwsO3RleYVqWM2D929Ye1JbqjPzZIxCh8ZhbBCUC6lg==
X-Received: by 2002:a05:6808:1450:b0:2d9:dad1:a14e with SMTP id x16-20020a056808145000b002d9dad1a14emr1137355oiv.294.1646701669918;
        Mon, 07 Mar 2022 17:07:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q16-20020a9d4b10000000b005b22b93d468sm3186416otf.74.2022.03.07.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:07:49 -0800 (PST)
Received: (nullmailer pid 3624787 invoked by uid 1000);
        Tue, 08 Mar 2022 01:07:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        olof@lixom.net, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220307091923.9909-3-ychuang3@nuvoton.com>
References: <20220307091923.9909-1-ychuang3@nuvoton.com> <20220307091923.9909-3-ychuang3@nuvoton.com>
Subject: Re: [PATCH 2/3] dt-bindings: clock: Document MA35D1 clock controller bindings
Date:   Mon, 07 Mar 2022 19:07:40 -0600
Message-Id: <1646701660.895821.3624783.nullmailer@robh.at.kernel.org>
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

On Mon, 07 Mar 2022 17:19:22 +0800, Jacky Huang wrote:
> Add documentation to describe Nuvoton MA35D1 clock driver bindings.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml: properties: 'clocks' is a dependency of 'assigned-clocks'
	from schema $id: http://devicetree.org/meta-schemas/clocks.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml: ignoring, error in schema: properties
Error: Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example.dts:24.37-38 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1601972

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

