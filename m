Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974D1507234
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354054AbiDSPyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiDSPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:54:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA101ADAF;
        Tue, 19 Apr 2022 08:51:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE22EB81B81;
        Tue, 19 Apr 2022 15:51:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8408FC385B0;
        Tue, 19 Apr 2022 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650383489;
        bh=O4kGVoQeyYUokLkOOMtZf5WOtbhgJryyxOH96kgYGWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=klJHKV5I+g2Y1d16IPc8lyj1aPp+9M5Mz4/MZb8GLEi2UzIvqnRpna2bs6GRg/RvB
         DIRSqYsV/a/EX4sbCleHHU5NWQUqS7OEu3dcDv6n0iWPz7gx2C58sfCyTqB8hstH2T
         V1v8Ccuy0wGWLTQIjc15N8ITf7AQKRYKDZuKuXkCmU194O32ViY4PClMNKd+yhH8p5
         HviGRNHbYUXKiGsfzeRocm5BCRBhVIc/95trLdt/hgYu2l41XA2QdYhlMxm45CVsmM
         Q4wUpVtraPwZ859xkSJkO5Fb5KcPTsgG8jEa0oK/SCJf8npZOsac3S26ihnoj5ohGx
         Zct9bEjLhlP6A==
Received: by mail-ed1-f48.google.com with SMTP id t25so21843307edt.9;
        Tue, 19 Apr 2022 08:51:29 -0700 (PDT)
X-Gm-Message-State: AOAM530SYMRldg2fvFLiP6Q9T8SSAWnfUUnQVftDDsSs+6oAJDhOEJ0T
        9kXJSIoIsUFdIDVbyGmyyaNrERauGDhCJhmYMQ==
X-Google-Smtp-Source: ABdhPJxRQq1KhhEnyhwExUKH5+pHmDmDmtEOzqa8MsO/Bzy4bhTSovBUc9c64I5QmB4PSBJ5skgDN0lf1caFPvqdiLw=
X-Received: by 2002:a50:d4d9:0:b0:41d:6ee0:80d with SMTP id
 e25-20020a50d4d9000000b0041d6ee0080dmr17812286edj.254.1650383487528; Tue, 19
 Apr 2022 08:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220419033237.23405-1-rex-bc.chen@mediatek.com>
 <20220419033237.23405-4-rex-bc.chen@mediatek.com> <74b3f0e3-1d9f-de9e-ccf0-1f2174ba7c25@gmail.com>
In-Reply-To: <74b3f0e3-1d9f-de9e-ccf0-1f2174ba7c25@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 19 Apr 2022 23:51:16 +0800
X-Gmail-Original-Message-ID: <CAAOTY__u3q1YcNwGpyEUpRbThsg6U1-gYtaqtGgy2J4jMwSOUg@mail.gmail.com>
Message-ID: <CAAOTY__u3q1YcNwGpyEUpRbThsg6U1-gYtaqtGgy2J4jMwSOUg@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: mediatek: add vdosys1 RDMA definition
 for mt8195
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=9C=88=
19=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 19/04/2022 05:32, Rex-BC Chen wrote:
> > From: "Nancy.Lin" <nancy.lin@mediatek.com>
> >
> > Add vdosys1 RDMA definition.
> >
> > Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > ---
> >   .../display/mediatek/mediatek,mdp-rdma.yaml   | 86 ++++++++++++++++++=
+
> >   1 file changed, 86 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/display/mediatek=
/mediatek,mdp-rdma.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,mdp-rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediat=
ek,mdp-rdma.yaml
> > new file mode 100644
> > index 000000000000..6ab773569462
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-r=
dma.yaml
> > @@ -0,0 +1,86 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,mdp-rdma.yaml=
#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MDP RDMA
> > +
> > +maintainers:
> > +  - Matthias Brugger <matthias.bgg@gmail.com>
>
> I don't think I would be the correct person to maintain this. This should=
 be the
> person that is maintaining the driver.

Agree. This should be

Chun-Kuang Hu <chunkuang.hu@kernel.org>
Philipp Zabel <p.zabel@pengutronix.de>

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > +
> > +description: |
> > +  The mediatek MDP RDMA stands for Read Direct Memory Access.
> > +  It provides real time data to the back-end panel driver, such as DSI=
,
> > +  DPI and DP_INTF.
> > +  It contains one line buffer to store the sufficient pixel data.
> > +  RDMA device node must be siblings to the central MMSYS_CONFIG node.
> > +  For a description of the MMSYS_CONFIG binding, see
> > +  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml f=
or details.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: mediatek,mt8195-vdo1-rdma
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    description: A phandle and PM domain specifier as defined by bindi=
ngs of
> > +      the power controller specified by phandle. See
> > +      Documentation/devicetree/bindings/power/power-domain.yaml for de=
tails.
> > +
> > +  clocks:
> > +    items:
> > +      - description: RDMA Clock
> > +
> > +  iommus:
> > +    description:
> > +      This property should point to the respective IOMMU block with ma=
ster port as argument,
> > +      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml =
for details.
> > +
> > +  mediatek,gce-client-reg:
> > +    description:
> > +      The register of display function block to be set by gce. There a=
re 4 arguments,
> > +      such as gce node, subsys id, offset and register size. The subsy=
s id that is
> > +      mapping to the register of display function blocks is defined in=
 the gce header
> > +      include/include/dt-bindings/gce/<chip>-gce.h of each chips.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - power-domains
> > +  - clocks
> > +  - iommus
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/mt8195-clk.h>
> > +    #include <dt-bindings/power/mt8195-power.h>
> > +    #include <dt-bindings/gce/mt8195-gce.h>
> > +    #include <dt-bindings/memory/mt8195-memory-port.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        vdo1_rdma0: mdp-rdma@1c104000 {
> > +            compatible =3D "mediatek,mt8195-vdo1-rdma";
> > +            reg =3D <0 0x1c104000 0 0x1000>;
> > +            interrupts =3D <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH 0>;
> > +            clocks =3D <&vdosys1 CLK_VDO1_MDP_RDMA0>;
> > +            power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> > +            iommus =3D <&iommu_vdo M4U_PORT_L2_MDP_RDMA0>;
> > +            mediatek,gce-client-reg =3D <&gce0 SUBSYS_1c10XXXX 0x4000 =
0x1000>;
> > +        };
> > +    };
