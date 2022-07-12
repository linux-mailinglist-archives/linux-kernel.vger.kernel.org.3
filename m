Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13DF572626
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiGLTnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiGLTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:42:40 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7D7DC8A8;
        Tue, 12 Jul 2022 12:21:22 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id a20so5443338ilk.9;
        Tue, 12 Jul 2022 12:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t0aNyxP21GZCBEkZVZT8NoRqTZzqSF9erFDxLkI8OCE=;
        b=tLDWRFzjBhkygv0aTn/+kP8tjG/jisQERrqfmkMw8g5YP8rAOZQep0kqSXF5SU5IlU
         lfbEPO+YV8+oUw0oATzrNnFNSo/PPAm6QoVnEPEMdpee8x3ZE3OolapLZlFdvyhcEokm
         3fSRhiFsSIBD0RvYLhbWzlTU8c/Bwk6ydG1fVz2JYIcZ6eZEb9mjpghCnW+rAhKrdjA8
         Jo4u4DvLDCvP6NDCMu5980EQy9d1dToLnN0sS89OMNXwAiamV8Y4P1GVHEmVbn2/T14Q
         KivSuSWPcFvEwhrFB2L7BrqQuIYlAGqh/easyZCjAaVgiwZl255k0E3O/9W7xfofqKSZ
         ZYDQ==
X-Gm-Message-State: AJIora/zGCY7CL4GNIK0ykzuQhpH3zCNgvOs46jYBUrZxs4i/4nhwHst
        OP6z0oCkmQUqZldy5e5Rzw==
X-Google-Smtp-Source: AGRyM1s5cpn8A2ors+BY93VkqJFWZPkOCrE2BaSZNJ/3lIe92TyVMWqAp3du+VuHapI0beHPSumJuQ==
X-Received: by 2002:a05:6e02:1c42:b0:2dc:11b4:4fca with SMTP id d2-20020a056e021c4200b002dc11b44fcamr13712769ilg.307.1657653681737;
        Tue, 12 Jul 2022 12:21:21 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f24-20020a056638113800b0033f3ab94271sm4421144jar.139.2022.07.12.12.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 12:21:21 -0700 (PDT)
Received: (nullmailer pid 2216514 invoked by uid 1000);
        Tue, 12 Jul 2022 19:21:19 -0000
Date:   Tue, 12 Jul 2022 13:21:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 03/16] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
Message-ID: <20220712192119.GK1823936-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
 <20220704100028.19932-4-tinghan.shen@mediatek.com>
 <20220705205739.GA2599256-robh@kernel.org>
 <b5667c052447d1b3c3498131af98d80a07ed4767.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5667c052447d1b3c3498131af98d80a07ed4767.camel@mediatek.com>
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

On Wed, Jul 06, 2022 at 02:19:08PM +0800, Tinghan Shen wrote:
> On Tue, 2022-07-05 at 14:57 -0600, Rob Herring wrote:
> > On Mon, Jul 04, 2022 at 06:00:15PM +0800, Tinghan Shen wrote:
> > > Extract duplicated properties and support more levels of power
> > > domain nodes.
> > > 
> > > This change fix following error when do dtbs_check,
> > >     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:
> > > power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not
> > > match any of the regexes: 'pinctrl-[0-9]+'
> > > 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > > 
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > ---
> > >  .../power/mediatek,power-controller.yaml      | 132 ++----------------
> > >  1 file changed, 12 insertions(+), 120 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > > b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > > index 135c6f722091..09a537a802b8 100644
> > > --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > > @@ -39,8 +39,17 @@ properties:
> > >    '#size-cells':
> > >      const: 0
> > >  
> > > +required:
> > > +  - compatible
> > > +
> > > +additionalProperties: false
> > > +
> > >  patternProperties:
> > >    "^power-domain@[0-9a-f]+$":
> > > +    $ref: "#/$defs/power-domain-node"
> > > +
> > > +$defs:
> > > +  power-domain-node:
> > >      type: object
> > >      description: |
> > >        Represents the power domains within the power controller node as documented
> > > @@ -98,127 +107,10 @@ patternProperties:
> > >          $ref: /schemas/types.yaml#/definitions/phandle
> > >          description: phandle to the device containing the SMI register range.
> > >  
> > > -    patternProperties:
> > > -      "^power-domain@[0-9a-f]+$":
> > > -        type: object
> > > -        description: |
> > > -          Represents a power domain child within a power domain parent node.
> > > -
> > > -        properties:
> > > -
> > > -          '#power-domain-cells':
> > > -            description:
> > > -              Must be 0 for nodes representing a single PM domain and 1 for nodes
> > > -              providing multiple PM domains.
> > > -
> > > -          '#address-cells':
> > > -            const: 1
> > > -
> > > -          '#size-cells':
> > > -            const: 0
> > > -
> > > -          reg:
> > > -            maxItems: 1
> > > -
> > > -          clocks:
> > > -            description: |
> > > -              A number of phandles to clocks that need to be enabled during domain
> > > -              power-up sequencing.
> > > -
> > > -          clock-names:
> > > -            description: |
> > > -              List of names of clocks, in order to match the power-up sequencing
> > > -              for each power domain we need to group the clocks by name. BASIC
> > > -              clocks need to be enabled before enabling the corresponding power
> > > -              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> > > -              SUSBYS clocks need to be enabled before releasing the bus protection,
> > > -              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> > > -
> > > -              In order to follow properly the power-up sequencing, the clocks must
> > > -              be specified by order, adding first the BASIC clocks followed by the
> > > -              SUSBSYS clocks.
> > > -
> > > -          domain-supply:
> > > -            description: domain regulator supply.
> > > -
> > > -          mediatek,infracfg:
> > > -            $ref: /schemas/types.yaml#/definitions/phandle
> > > -            description: phandle to the device containing the INFRACFG register range.
> > > -
> > > -          mediatek,smi:
> > > -            $ref: /schemas/types.yaml#/definitions/phandle
> > > -            description: phandle to the device containing the SMI register range.
> > > -
> > > -        patternProperties:
> > > -          "^power-domain@[0-9a-f]+$":
> > > -            type: object
> > > -            description: |
> > > -              Represents a power domain child within a power domain parent node.
> > > -
> > > -            properties:
> > > +      required:
> > > +        - reg
> > >  
> > > -              '#power-domain-cells':
> > > -                description:
> > > -                  Must be 0 for nodes representing a single PM domain and 1 for nodes
> > > -                  providing multiple PM domains.
> > > -
> > > -              '#address-cells':
> > > -                const: 1
> > > -
> > > -              '#size-cells':
> > > -                const: 0
> > > -
> > > -              reg:
> > > -                maxItems: 1
> > > -
> > > -              clocks:
> > > -                description: |
> > > -                  A number of phandles to clocks that need to be enabled during domain
> > > -                  power-up sequencing.
> > > -
> > > -              clock-names:
> > > -                description: |
> > > -                  List of names of clocks, in order to match the power-up sequencing
> > > -                  for each power domain we need to group the clocks by name. BASIC
> > > -                  clocks need to be enabled before enabling the corresponding power
> > > -                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> > > -                  SUSBYS clocks need to be enabled before releasing the bus protection,
> > > -                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> > > -
> > > -                  In order to follow properly the power-up sequencing, the clocks must
> > > -                  be specified by order, adding first the BASIC clocks followed by the
> > > -                  SUSBSYS clocks.
> > > -
> > > -              domain-supply:
> > > -                description: domain regulator supply.
> > > -
> > > -              mediatek,infracfg:
> > > -                $ref: /schemas/types.yaml#/definitions/phandle
> > > -                description: phandle to the device containing the INFRACFG register range.
> > > -
> > > -              mediatek,smi:
> > > -                $ref: /schemas/types.yaml#/definitions/phandle
> > > -                description: phandle to the device containing the SMI register range.
> > > -
> > > -            required:
> > > -              - reg
> > > -
> > > -            additionalProperties: false
> > > -
> > > -        required:
> > > -          - reg
> > > -
> > > -        additionalProperties: false
> > > -
> > > -    required:
> > > -      - reg
> > > -
> > > -    additionalProperties: false
> > > -
> > > -required:
> > > -  - compatible
> > > -
> > > -additionalProperties: false
> > > +      additionalProperties: false
> > You now aren't checking more than 1 level because you have defined 
> > 'additionalProperties' to be a DT property. Check the indentation.
> > 
> > You need this in $defs/power-domain-node to recurse:
> > 
> >     additionalProperties:
> >       $ref: #/$defs/power-domain-node
> Hi Rob,
> 
> I get the following error after adding the 'additionalProperties' to $defs/power-domain-node.
> The same error occurs when I run dt_binding_check on power/renesas,sysc-rmobile.yaml, which has the
> similar property.
> 
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/mediatek,power-
> controller.yaml O=out
> make[1]: Entering directory '/test/upstream-cros/src/third_party/kernel/v5.10/out'
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /test/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> : ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-
> nanoamp
> /test/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-
> sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
> /test/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml: ignoring,
> error parsing file
>   DTEX    Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts
>   DTC     Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
>   CHECK   Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
> Traceback (most recent call last):
>   File "/test/.venv/py3.9/bin/dt-validate", line 173, in <module>
>     testtree = dtschema.load(filename, line_number=args.line_number)
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 913, in load
>     return [ dtschema.dtb.fdt_unflatten(f.read()) ]
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/dtb.py", line 463, in fdt_unflatten
>     p = dtschema.get_prop_types()
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 892, in get_prop_types
>     props = dtschema.extract_types(schema_cache)
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 883, in extract_types
>     _extract_subschema_types(props, sch, sch)
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
> _extract_subschema_types
> 
> [...snip...]
> 
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 803, in
> _extract_prop_type
>     _extract_prop_type(props, schema, propname, subschema)
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 794, in
> _extract_prop_type
>     _extract_subschema_types(props, schema, subschema)
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
> _extract_subschema_types
>     _extract_prop_type(props, schema, p, v)
>   File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 790, in
> _extract_prop_type
>     if not isinstance(subschema, dict):
> RecursionError: maximum recursion depth exceeded while calling a Python object
> make[1]: Leaving directory '/test/upstream-cros/src/third_party/kernel/v5.10/out'

Okay, I think you need something more like this that doesn't recurse 
infinitely:

patternProperties:
  "^power-domain@[0-9a-f]+$":
    $ref: #/$defs/power-domain-node

    unevaluatedProperties:
      $ref: #/$defs/power-domain-node

If you need a 3rd level of nodes:
      unevaluatedProperties:
        $ref: #/$defs/power-domain-node


Rob
