Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9755A04A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiFXR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiFXR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:55 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ADDBA6;
        Fri, 24 Jun 2022 10:26:54 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id y18so3401356iof.2;
        Fri, 24 Jun 2022 10:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=W9o9Q8p3oMHAVX7O1A1F5sZAeGnXCxQ/vXrDDAt7Do8=;
        b=K9u/urnLXEihK8n9xBDGUK+3+AiBADxPbru6i8JVJS0lMyQrGgr8w6WNbRwfZFFFSq
         4hQbqWh27mpyjP/p2GtFuTeo9yEp9MS6V8pxIQR9H2yZoXnMgXV4KlzWHj4b9l9UtlGO
         N/4PR1jw/fJpa9g+3wbFvtCYiXm45ydR/G/3Cu3lteTxVSOxr6oQQYmrcsuYe2KdwOCp
         IVV3SEutDZR/ZG8arGyr8K86zg0inal0H8CTwnSnfYiXdBa5Hi6b5OpbR2DLhRXnar5v
         QsDTbaxMhfIy7u4usKNPgaCjMmUeizxq9MTzMCjDF5oQSp/aQ4ik/GXUCoKLi794DP/z
         bvXw==
X-Gm-Message-State: AJIora/hUVyeeyZcS5BaEIF4ggA7MJVFi8tdJVa9jazOgSeKP01DG6hg
        axXkiiwcbPFsaaumx4YLrg==
X-Google-Smtp-Source: AGRyM1sVEh8rq+3905/IcPFgRU7Fy1TLeRbAXiXeOp+CmyUaFz0EH/Vzb8EIUR4m9bvLyRLCKVigUw==
X-Received: by 2002:a05:6638:31c2:b0:335:dd22:83ec with SMTP id n2-20020a05663831c200b00335dd2283ecmr164947jav.88.1656091613790;
        Fri, 24 Jun 2022 10:26:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h22-20020a022b16000000b00339d10e9d22sm1308243jaa.111.2022.06.24.10.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:53 -0700 (PDT)
Received: (nullmailer pid 146332 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     devicetree@vger.kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org,
        Thierry Reding <treding@nvidia.com>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        will@kernel.org, krzysztof.kozlowski@canonical.com,
        dri-devel@lists.freedesktop.org, thierry.reding@gmail.com
In-Reply-To: <20220621151022.1416300-3-cyndis@kapsi.fi>
References: <20220621151022.1416300-1-cyndis@kapsi.fi> <20220621151022.1416300-3-cyndis@kapsi.fi>
Subject: Re: [PATCH v6 02/10] dt-bindings: display: tegra: Convert to json-schema
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.348474.146331.nullmailer@robh.at.kernel.org>
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

On Tue, 21 Jun 2022 18:10:14 +0300, Mikko Perttunen wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Convert the Tegra host1x controller bindings from the free-form text
> format to json-schema.
> 
> This also adds the missing display-hub DT bindings that were not
> previously documented.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../display/tegra/nvidia,tegra114-mipi.txt    |  41 --
>  .../display/tegra/nvidia,tegra114-mipi.yaml   |  74 ++
>  .../display/tegra/nvidia,tegra124-dpaux.yaml  | 149 ++++
>  .../display/tegra/nvidia,tegra124-sor.yaml    | 206 ++++++
>  .../display/tegra/nvidia,tegra124-vic.yaml    |  71 ++
>  .../display/tegra/nvidia,tegra186-dc.yaml     |  85 +++
>  .../tegra/nvidia,tegra186-display.yaml        | 310 ++++++++
>  .../tegra/nvidia,tegra186-dsi-padctl.yaml     |  45 ++
>  .../display/tegra/nvidia,tegra20-dc.yaml      | 181 +++++
>  .../display/tegra/nvidia,tegra20-dsi.yaml     | 159 +++++
>  .../display/tegra/nvidia,tegra20-epp.yaml     |  70 ++
>  .../display/tegra/nvidia,tegra20-gr2d.yaml    |  73 ++
>  .../display/tegra/nvidia,tegra20-gr3d.yaml    | 214 ++++++
>  .../display/tegra/nvidia,tegra20-hdmi.yaml    | 126 ++++
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 675 ------------------
>  .../display/tegra/nvidia,tegra20-host1x.yaml  | 347 +++++++++
>  .../display/tegra/nvidia,tegra20-isp.yaml     |  67 ++
>  .../display/tegra/nvidia,tegra20-mpe.yaml     |  73 ++
>  .../display/tegra/nvidia,tegra20-tvo.yaml     |  58 ++
>  .../display/tegra/nvidia,tegra20-vi.yaml      | 163 +++++
>  .../display/tegra/nvidia,tegra210-csi.yaml    |  52 ++
>  .../pinctrl/nvidia,tegra124-dpaux-padctl.txt  |  59 --
>  22 files changed, 2523 insertions(+), 775 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-dpaux.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-display.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra210-csi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-dpaux-padctl.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml: allOf:1:if:not:properties: {'contains': {'const': 'nvidia,panel'}} should not be valid under {'$ref': '#/definitions/sub-schemas'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.example.dtb: gr3d@54180000: resets: [[4294967295, 24]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.example.dtb: gr3d@54180000: reset-names: ['3d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr2d@54140000: resets: [[4294967295, 21]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr2d@54140000: reset-names: ['2d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr3d@54180000: resets: [[4294967295, 24]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr3d@54180000: reset-names: ['3d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.example.dtb:0:0: /example-0/sor@54540000: failed to match any schema with compatible: ['nvidia,tegra210-sor']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.example.dtb: gr2d@54140000: resets: [[4294967295, 21]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.example.dtb: gr2d@54140000: reset-names: ['2d'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
MAINTAINERS: Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

