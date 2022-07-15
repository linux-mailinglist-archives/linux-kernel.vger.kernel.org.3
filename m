Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9E575A30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiGOEKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiGOEKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:10:47 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A47821A;
        Thu, 14 Jul 2022 21:10:44 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id z132so3088652iof.0;
        Thu, 14 Jul 2022 21:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=E7Fg+MV2e/bPhHnHkaMwMTaDWkJm3NnH26DLJHQT/M0=;
        b=vMhh7vjkgK3zBTc6AsrSIj1MRSvRtuG5FE+WxC7CLquELZSe1pMR0CvixdCFH9ivj3
         eUw5GTiyHPytQ508lvymQ1/46oJqX6HTeUpHhd06OIEYJHeWM/qQ4rlqBkZfgxVGY0Sp
         R27yK7FypvPDwQ/67fn/At0nzHJ1/EFawOFPiBPktiS7gJuZLZMg/paWINmcXVStf0EK
         5ILj73GimD+TyhlaboBkaR5Ktj/1rNhdEsZASihazP5K4LBCo0mCcYR8ayEl3x9VRgVE
         FOCcd3hsUEXa8zqfy64wKWySOwYzztcVJCOaXeAOy133GkRMt1wFwmi0aoVbZYlxBMaN
         Qd/g==
X-Gm-Message-State: AJIora9u007Cy45h6sNeoEf2cHOJP8CzCcnCXAEO6t6aKxoMWH+7i2If
        LTxs+r77pWs7Nq7fUvmf1Q==
X-Google-Smtp-Source: AGRyM1tmnSz6ythoDFJg2wDkxNG61OkgikNlESLrdgMrS1wpzE1ury8Y2U7B94DVtlTWpphzc1VGpg==
X-Received: by 2002:a5d:8582:0:b0:669:835f:48b0 with SMTP id f2-20020a5d8582000000b00669835f48b0mr5943449ioj.146.1657858243849;
        Thu, 14 Jul 2022 21:10:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m9-20020a02a149000000b0033f1772fd24sm1526183jah.20.2022.07.14.21.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 21:10:43 -0700 (PDT)
Received: (nullmailer pid 3702464 invoked by uid 1000);
        Fri, 15 Jul 2022 04:10:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Max Buchholz <max.buchholz@gmx.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>,
        Max Buchholz <Max.Buchholz@gmx.de>,
        Sameer Pujar <spujar@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-input@vger.kernel.org
In-Reply-To: <20220714153732.48698-1-max.buchholz@gmx.de>
References: <20220714153732.48698-1-max.buchholz@gmx.de>
Subject: Re: [PATCH v2] dt-bindings: nvidia,tegra20-kbc: Convert to json-schema
Date:   Thu, 14 Jul 2022 22:10:41 -0600
Message-Id: <1657858241.636403.3702463.nullmailer@robh.at.kernel.org>
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

On Thu, 14 Jul 2022 17:37:31 +0200, Max Buchholz wrote:
> From: Max Buchholz <Max.Buchholz@gmx.de>
> 
> This converts the Nvidia Tegra keyboard controller bindings to YAML
> and fix them up a bit.
> 
> Reviewed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Max Buchholz <max.buchholz@gmx.de>
> ---
>  .../bindings/input/nvidia,tegra20-kbc.txt     |  55 ---------
>  .../bindings/input/nvidia,tegra20-kbc.yaml    | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 55 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt
>  create mode 100644 Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.example.dtb: kbc@7000e200: nvidia,kbc-row-pins: 'oneOf' conditional failed, one must be fixed:
	[0, 1, 2] is too long
	[0, 1, 2] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.example.dtb: kbc@7000e200: nvidia,kbc-col-pins: 'oneOf' conditional failed, one must be fixed:
	[11, 12, 13] is too long
	[11, 12, 13] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.example.dtb: kbc@7000e200: 'linux,keymap' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.yaml

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/power/wakeup-source.txt: Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

