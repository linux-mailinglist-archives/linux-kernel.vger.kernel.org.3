Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D094567E47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiGFGTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiGFGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:19:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B2514D00;
        Tue,  5 Jul 2022 23:19:14 -0700 (PDT)
X-UUID: 428c1ce0bf624f339c07c6100c280249-20220706
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:8cd32d2b-4b91-407e-a898-52462391aa23,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.8,REQID:8cd32d2b-4b91-407e-a898-52462391aa23,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:0f94e32,CLOUDID:7b7abcd6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:15dc4aa8751e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 428c1ce0bf624f339c07c6100c280249-20220706
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1551361263; Wed, 06 Jul 2022 14:19:10 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 6 Jul 2022 14:19:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 6 Jul 2022 14:19:08 +0800
Message-ID: <b5667c052447d1b3c3498131af98d80a07ed4767.camel@mediatek.com>
Subject: Re: [PATCH v1 03/16] dt-bindings: power: mediatek: Refine multiple
 level power domain nodes
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 6 Jul 2022 14:19:08 +0800
In-Reply-To: <20220705205739.GA2599256-robh@kernel.org>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
         <20220704100028.19932-4-tinghan.shen@mediatek.com>
         <20220705205739.GA2599256-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-05 at 14:57 -0600, Rob Herring wrote:
> On Mon, Jul 04, 2022 at 06:00:15PM +0800, Tinghan Shen wrote:
> > Extract duplicated properties and support more levels of power
> > domain nodes.
> > 
> > This change fix following error when do dtbs_check,
> >     arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:
> > power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not
> > match any of the regexes: 'pinctrl-[0-9]+'
> > 	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../power/mediatek,power-controller.yaml      | 132 ++----------------
> >  1 file changed, 12 insertions(+), 120 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > index 135c6f722091..09a537a802b8 100644
> > --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> > @@ -39,8 +39,17 @@ properties:
> >    '#size-cells':
> >      const: 0
> >  
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> >  patternProperties:
> >    "^power-domain@[0-9a-f]+$":
> > +    $ref: "#/$defs/power-domain-node"
> > +
> > +$defs:
> > +  power-domain-node:
> >      type: object
> >      description: |
> >        Represents the power domains within the power controller node as documented
> > @@ -98,127 +107,10 @@ patternProperties:
> >          $ref: /schemas/types.yaml#/definitions/phandle
> >          description: phandle to the device containing the SMI register range.
> >  
> > -    patternProperties:
> > -      "^power-domain@[0-9a-f]+$":
> > -        type: object
> > -        description: |
> > -          Represents a power domain child within a power domain parent node.
> > -
> > -        properties:
> > -
> > -          '#power-domain-cells':
> > -            description:
> > -              Must be 0 for nodes representing a single PM domain and 1 for nodes
> > -              providing multiple PM domains.
> > -
> > -          '#address-cells':
> > -            const: 1
> > -
> > -          '#size-cells':
> > -            const: 0
> > -
> > -          reg:
> > -            maxItems: 1
> > -
> > -          clocks:
> > -            description: |
> > -              A number of phandles to clocks that need to be enabled during domain
> > -              power-up sequencing.
> > -
> > -          clock-names:
> > -            description: |
> > -              List of names of clocks, in order to match the power-up sequencing
> > -              for each power domain we need to group the clocks by name. BASIC
> > -              clocks need to be enabled before enabling the corresponding power
> > -              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> > -              SUSBYS clocks need to be enabled before releasing the bus protection,
> > -              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> > -
> > -              In order to follow properly the power-up sequencing, the clocks must
> > -              be specified by order, adding first the BASIC clocks followed by the
> > -              SUSBSYS clocks.
> > -
> > -          domain-supply:
> > -            description: domain regulator supply.
> > -
> > -          mediatek,infracfg:
> > -            $ref: /schemas/types.yaml#/definitions/phandle
> > -            description: phandle to the device containing the INFRACFG register range.
> > -
> > -          mediatek,smi:
> > -            $ref: /schemas/types.yaml#/definitions/phandle
> > -            description: phandle to the device containing the SMI register range.
> > -
> > -        patternProperties:
> > -          "^power-domain@[0-9a-f]+$":
> > -            type: object
> > -            description: |
> > -              Represents a power domain child within a power domain parent node.
> > -
> > -            properties:
> > +      required:
> > +        - reg
> >  
> > -              '#power-domain-cells':
> > -                description:
> > -                  Must be 0 for nodes representing a single PM domain and 1 for nodes
> > -                  providing multiple PM domains.
> > -
> > -              '#address-cells':
> > -                const: 1
> > -
> > -              '#size-cells':
> > -                const: 0
> > -
> > -              reg:
> > -                maxItems: 1
> > -
> > -              clocks:
> > -                description: |
> > -                  A number of phandles to clocks that need to be enabled during domain
> > -                  power-up sequencing.
> > -
> > -              clock-names:
> > -                description: |
> > -                  List of names of clocks, in order to match the power-up sequencing
> > -                  for each power domain we need to group the clocks by name. BASIC
> > -                  clocks need to be enabled before enabling the corresponding power
> > -                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
> > -                  SUSBYS clocks need to be enabled before releasing the bus protection,
> > -                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
> > -
> > -                  In order to follow properly the power-up sequencing, the clocks must
> > -                  be specified by order, adding first the BASIC clocks followed by the
> > -                  SUSBSYS clocks.
> > -
> > -              domain-supply:
> > -                description: domain regulator supply.
> > -
> > -              mediatek,infracfg:
> > -                $ref: /schemas/types.yaml#/definitions/phandle
> > -                description: phandle to the device containing the INFRACFG register range.
> > -
> > -              mediatek,smi:
> > -                $ref: /schemas/types.yaml#/definitions/phandle
> > -                description: phandle to the device containing the SMI register range.
> > -
> > -            required:
> > -              - reg
> > -
> > -            additionalProperties: false
> > -
> > -        required:
> > -          - reg
> > -
> > -        additionalProperties: false
> > -
> > -    required:
> > -      - reg
> > -
> > -    additionalProperties: false
> > -
> > -required:
> > -  - compatible
> > -
> > -additionalProperties: false
> > +      additionalProperties: false
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/mediatek,power-
> controller.yaml O=out
> make[1]: Entering directory '/proj/mtk15399/upstream-cros/src/third_party/kernel/v5.10/out'
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /proj/mtk15399/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.ya
> ml: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-
> current-nanoamp
> /proj/mtk15399/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-
> sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
> /proj/mtk15399/upstream-
> cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml: ignoring,
> error parsing file
>   DTEX    Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts
>   DTC     Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
>   CHECK   Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
> Traceback (most recent call last):
>   File "/proj/mtk15399/.venv/py3.9/bin/dt-validate", line 173, in <module>
>     testtree = dtschema.load(filename, line_number=args.line_number)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 913, in load
>     return [ dtschema.dtb.fdt_unflatten(f.read()) ]
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/dtb.py", line 463, in
> fdt_unflatten
>     p = dtschema.get_prop_types()
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 892, in
> get_prop_types
>     props = dtschema.extract_types(schema_cache)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 883, in
> extract_types
>     _extract_subschema_types(props, sch, sch)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
> _extract_subschema_types
> 
> [...snip...]
> 
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 803, in
> _extract_prop_type
>     _extract_prop_type(props, schema, propname, subschema)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 794, in
> _extract_prop_type
>     _extract_subschema_types(props, schema, subschema)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
> _extract_subschema_types
>     _extract_prop_type(props, schema, p, v)
>   File "/proj/mtk15399/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 790, in
> _extract_prop_type
>     if not isinstance(subschema, dict):
> RecursionError: maximum recursion depth exceeded while calling a Python object
> make[1]: Leaving directory '/proj/mtk15399/upstream-cros/src/third_party/kernel/v5.10/out'
> You now aren't checking more than 1 level because you have defined 
> 'additionalProperties' to be a DT property. Check the indentation.
> 
> You need this in $defs/power-domain-node to recurse:
> 
>     additionalProperties:
>       $ref: #/$defs/power-domain-node
Hi Rob,

I get the following error after adding the 'additionalProperties' to $defs/power-domain-node.
The same error occurs when I run dt_binding_check on power/renesas,sysc-rmobile.yaml, which has the
similar property.

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/power/mediatek,power-
controller.yaml O=out
make[1]: Entering directory '/test/upstream-cros/src/third_party/kernel/v5.10/out'
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/test/upstream-
cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
: ignoring, error in schema: patternProperties: ^thermistor@: properties: adi,excitation-current-
nanoamp
/test/upstream-
cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-
sor.yaml: ignoring, error in schema: allOf: 1: if: not: properties
/test/upstream-
cros/src/third_party/kernel/v5.10/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml: ignoring,
error parsing file
  DTEX    Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts
  DTC     Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
  CHECK   Documentation/devicetree/bindings/power/mediatek,power-controller.example.dtb
Traceback (most recent call last):
  File "/test/.venv/py3.9/bin/dt-validate", line 173, in <module>
    testtree = dtschema.load(filename, line_number=args.line_number)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 913, in load
    return [ dtschema.dtb.fdt_unflatten(f.read()) ]
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/dtb.py", line 463, in fdt_unflatten
    p = dtschema.get_prop_types()
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 892, in get_prop_types
    props = dtschema.extract_types(schema_cache)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 883, in extract_types
    _extract_subschema_types(props, sch, sch)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
_extract_subschema_types

[...snip...]

  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 803, in
_extract_prop_type
    _extract_prop_type(props, schema, propname, subschema)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 794, in
_extract_prop_type
    _extract_subschema_types(props, schema, subschema)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 874, in
_extract_subschema_types
    _extract_prop_type(props, schema, p, v)
  File "/test/.venv/py3.9/lib/python3.9/site-packages/dtschema/lib.py", line 790, in
_extract_prop_type
    if not isinstance(subschema, dict):
RecursionError: maximum recursion depth exceeded while calling a Python object
make[1]: Leaving directory '/test/upstream-cros/src/third_party/kernel/v5.10/out'


Best Regards,
TingHan

