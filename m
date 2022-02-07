Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F7E4ACD47
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbiBHBED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbiBGXJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:09:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE0C061355;
        Mon,  7 Feb 2022 15:09:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C87360E9D;
        Mon,  7 Feb 2022 23:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661ECC340F0;
        Mon,  7 Feb 2022 23:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644275376;
        bh=fy67XNlfUJrOzDkN7wHfeOhocEh0q0yDRq3ETbbXHtg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EXKH2ArpThS7H8A8/Q2zoSm8hsUAitDcof6/lrVcHzfavkafpqgf9loCL0QYWi3CX
         XEUJ1DNiKMpoJKgWRLHkFWFJiOHQgG2Q0pK10jcne7gGNuTuYcKq+fpUAvJzEwpa99
         k262CWquj8chiseoGmptlMZNo5NnSJkPscUXcjjGidKDENTGqOQc4nBQKZvGMjPi+k
         qIwbQANtHigpXr+qAvDUKAEQzv2RcTlM9GIr4aB4LMITqp/bwxrk70Vu/ULyA3Hjxn
         kkeLEoRoGx9OFMHJ7JCveFHAkibxWBvQ/zOj49ONPiEmukM3mxRQtjg2rFLWVAVt7B
         DKXQFoaVsDymA==
Received: by mail-ed1-f44.google.com with SMTP id cf2so17453212edb.9;
        Mon, 07 Feb 2022 15:09:36 -0800 (PST)
X-Gm-Message-State: AOAM533iF61tY+1qn+ab9DfoWzro3jiUrMojwnQcqVlWO/Awza4/IqtD
        JNz0ZY6QYAjb/ydpyq1xskXjALlmslItQmFocg==
X-Google-Smtp-Source: ABdhPJyizGp1sBtLlSMdCLxQdjqEzCe7yhHi6Gz9O8lrHqMrtd/akuCjMrAOXiWfaEPJ+hbTrb2OCazxb+9h9qbXHiU=
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr1716800edo.131.1644275374664;
 Mon, 07 Feb 2022 15:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com> <20220126071932.32615-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20220126071932.32615-5-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 8 Feb 2022 07:09:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY__SLgV_Bd-uMg8+ebbUWdpkq6SyyqfwEGguXVR9afXRJQ@mail.gmail.com>
Message-ID: <CAAOTY__SLgV_Bd-uMg8+ebbUWdpkq6SyyqfwEGguXVR9afXRJQ@mail.gmail.com>
Subject: Re: [PATCH v15 04/12] dt-bindings: display: mediatek: dsc: add yaml
 for mt8195 SoC binding
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>, roy-cw.yeh@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi, Jason:

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=882=
6=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> 1. Add mediatek,dsc.yaml to describe DSC module in details.
> 2. Add mt8195 SoC binding to mediatek,dsc.yaml.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  .../display/mediatek/mediatek,dsc.yaml        | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/me=
diatek,dsc.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsc.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.=
yaml
> new file mode 100644
> index 000000000000..1ec083eff824
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsc.yam=
l
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,dsc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mediatek display DSC controller
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
> +  The DSC standard is a specification of the algorithms used for
> +  compressing and decompressing image display streams, including
> +  the specification of the syntax and semantics of the compressed
> +  video bit stream. DSC is designed for real-time systems with
> +  real-time compression, transmission, decompression and Display.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: mediatek,mt8195-disp-dsc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DSC Wrapper Clock
> +
> +  power-domains:
> +    description: A phandle and PM domain specifier as defined by binding=
s of
> +      the power controller specified by phandle. See
> +      Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.
> +
> +  mediatek,gce-client-reg:
> +    description:
> +      The register of client driver can be configured by gce with 4 argu=
ments
> +      defined in this property, such as phandle of gce, subsys id,
> +      register offset and size.
> +      Each subsys id is mapping to a base address of display function bl=
ocks
> +      register which is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - power-domains
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    dsc0: disp_dsc_wrap@1c009000 {
> +        compatible =3D "mediatek,mt8195-disp-dsc";
> +        reg =3D <0 0x1c009000 0 0x1000>;
> +        interrupts =3D <GIC_SPI 645 IRQ_TYPE_LEVEL_HIGH 0>;
> +        power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
> +        clocks =3D <&vdosys0 CLK_VDO0_DSC_WRAP0>;
> +        mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c00XXXX 0x9000 0x1000=
>;
> +    };
> --
> 2.18.0
>
