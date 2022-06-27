Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4455E03D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiF0Ndi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236264AbiF0Nde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9775E6399;
        Mon, 27 Jun 2022 06:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41067B816B0;
        Mon, 27 Jun 2022 13:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B42AC341D0;
        Mon, 27 Jun 2022 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656336811;
        bh=ozPyfku+IxLJ/xWqltXSkq39bDAVGGKGz9HK5lRI660=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bd5Muo0k50BmpMKNCQwFcq1j67DQkwTwX0UmSF26tAHbqPvfeDci31nPqRtNrUurV
         +UZTak+TRJUJv0oppssC6cYX1Fc4Lpjy02HhtTKlQuv7C9eYEdfPw06kRYST0ecBHj
         ZRUTFh5lsbiGTA6KQbhxSzX23tKGD5pGbiUzqr3zTs+xD/HDjBOfirpm9RBpkGTa9p
         FCsMN6HsgZsPlss0Sodi+1Lis8qhsoeJrswvvTpNx+ip5k8TdP9HY+O2ZdoIGOIUJ1
         RcDed/3NLRZW/xk0/63cK87Ia40LtFmh/tYeZ/mc9mo+JAK2KaNsjUTDPiTTHUVCcs
         pV3DCTqIa8uFw==
Received: by mail-vk1-f175.google.com with SMTP id b5so4469999vkp.4;
        Mon, 27 Jun 2022 06:33:31 -0700 (PDT)
X-Gm-Message-State: AJIora9M6JDDkfWLj1YeERI0KOE6lFk+CrJBoltUz9gcvuq6WH6sQhbC
        ytDlruTFO+XdsNVCbGZAG3LbiID4k5ErEBXT8A==
X-Google-Smtp-Source: AGRyM1scsPUWNixG94RrMA/c0WdzqcCV5semb71Np32MVVYQN0Tnz33ChJSrmtGpjWTGsYsOWzKI4Q7hjj31Llm839Y=
X-Received: by 2002:a1f:aac7:0:b0:35e:1c45:def with SMTP id
 t190-20020a1faac7000000b0035e1c450defmr4200423vke.35.1656336809878; Mon, 27
 Jun 2022 06:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220621151022.1416300-1-cyndis@kapsi.fi> <20220621151022.1416300-3-cyndis@kapsi.fi>
 <1656091594.348474.146331.nullmailer@robh.at.kernel.org>
In-Reply-To: <1656091594.348474.146331.nullmailer@robh.at.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 27 Jun 2022 07:33:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMDEf1_3P2q2XPKKuOqr=+sYixVfMwnouGXPkMPWtjGA@mail.gmail.com>
Message-ID: <CAL_JsqJMDEf1_3P2q2XPKKuOqr=+sYixVfMwnouGXPkMPWtjGA@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] dt-bindings: display: tegra: Convert to json-schema
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 21 Jun 2022 18:10:14 +0300, Mikko Perttunen wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Convert the Tegra host1x controller bindings from the free-form text
> > format to json-schema.
> >
> > This also adds the missing display-hub DT bindings that were not
> > previously documented.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../display/tegra/nvidia,tegra114-mipi.txt    |  41 --
> >  .../display/tegra/nvidia,tegra114-mipi.yaml   |  74 ++
> >  .../display/tegra/nvidia,tegra124-dpaux.yaml  | 149 ++++
> >  .../display/tegra/nvidia,tegra124-sor.yaml    | 206 ++++++
> >  .../display/tegra/nvidia,tegra124-vic.yaml    |  71 ++
> >  .../display/tegra/nvidia,tegra186-dc.yaml     |  85 +++
> >  .../tegra/nvidia,tegra186-display.yaml        | 310 ++++++++
> >  .../tegra/nvidia,tegra186-dsi-padctl.yaml     |  45 ++
> >  .../display/tegra/nvidia,tegra20-dc.yaml      | 181 +++++
> >  .../display/tegra/nvidia,tegra20-dsi.yaml     | 159 +++++
> >  .../display/tegra/nvidia,tegra20-epp.yaml     |  70 ++
> >  .../display/tegra/nvidia,tegra20-gr2d.yaml    |  73 ++
> >  .../display/tegra/nvidia,tegra20-gr3d.yaml    | 214 ++++++
> >  .../display/tegra/nvidia,tegra20-hdmi.yaml    | 126 ++++
> >  .../display/tegra/nvidia,tegra20-host1x.txt   | 675 ------------------
> >  .../display/tegra/nvidia,tegra20-host1x.yaml  | 347 +++++++++
> >  .../display/tegra/nvidia,tegra20-isp.yaml     |  67 ++
> >  .../display/tegra/nvidia,tegra20-mpe.yaml     |  73 ++
> >  .../display/tegra/nvidia,tegra20-tvo.yaml     |  58 ++
> >  .../display/tegra/nvidia,tegra20-vi.yaml      | 163 +++++
> >  .../display/tegra/nvidia,tegra210-csi.yaml    |  52 ++
> >  .../pinctrl/nvidia,tegra124-dpaux-padctl.txt  |  59 --
> >  22 files changed, 2523 insertions(+), 775 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-dpaux.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-display.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-epp.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-isp.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-mpe.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-tvo.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra210-csi.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-dpaux-padctl.txt
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml: allOf:1:if:not:properties: {'contains': {'const': 'nvidia,panel'}} should not be valid under {'$ref': '#/definitions/sub-schemas'}
>         hint: A json-schema keyword was found instead of a DT property name.
>         from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.example.dtb: gr3d@54180000: resets: [[4294967295, 24]] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.example.dtb: gr3d@54180000: reset-names: ['3d'] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr2d@54140000: resets: [[4294967295, 21]] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr2d@54140000: reset-names: ['2d'] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr3d@54180000: resets: [[4294967295, 24]] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.example.dtb: gr3d@54180000: reset-names: ['3d'] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr3d.yaml
> Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.example.dtb:0:0: /example-0/sor@54540000: failed to match any schema with compatible: ['nvidia,tegra210-sor']
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.example.dtb: gr2d@54140000: resets: [[4294967295, 21]] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.example.dtb: gr2d@54140000: reset-names: ['2d'] is too short
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-gr2d.yaml
>
> doc reference errors (make refcheckdocs):
> MAINTAINERS: Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> MAINTAINERS: Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
>
> See https://patchwork.ozlabs.org/patch/
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.

Now failing in linux-next. Please fix.

Rob
