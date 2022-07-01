Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297B05630D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbiGAJ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGAJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:58:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB5913F40
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:58:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31bf3656517so18081277b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dI1tKCG644Qtf5LntQ1LK72Maeql6LrYPDDFsKa9Kfk=;
        b=ih6uUxJfo8YJ/xXLIZzLhzeMfMKi+SRTBsaKFKc7Z2Gbc4LAZtWtojXTnfkjBR46o3
         fPrqefwqXLU4ITauDJZmBx5/3sg2HdGnkNQNcZM+jZ2Hl8UmZl1VFSMPM7TlD1FUB6F/
         19tkUcC9xzeL1fOqBK9OjDbf3q2xP0OonEzoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dI1tKCG644Qtf5LntQ1LK72Maeql6LrYPDDFsKa9Kfk=;
        b=X3MpR542x1TAUKLkemnqtL8XnjAUj5CSIKxKymAoY9pSlbof+L4UrjT/G666JkGuf4
         C6d01m2s9UE8+snqwANvCTyrD/g7sQo0S6u3ne0xOc7G0XUH2odRZKHwA+01W1cE5zzS
         Cl+f2kHWpD1uXCDDJmU9F7df6y4psN170N6xDPCzWsq4sbrNq9S9J5rxGpMmDFZKHjlf
         POugeTlRWlzSg2N1xi5BhgDQTC8xugsQGrPg21Jgl4aOaMxBY5TX1nO3rsc3xcaOhK7N
         Pf0TwGSXWi1978beRiDU/4oDw++nRFKSLTCnAwOpwEfJQLAQLioIPWy3AoLqsfchiDvU
         JIqw==
X-Gm-Message-State: AJIora9A9a5WCCG8tHzMU29b1peH3F8qeBwyJlvKD2Qzze/xrL7aaFKr
        ghKqQUhQ5S5ZyWfjKj//dMgTWVzcs7Sjy7dnucCdEA==
X-Google-Smtp-Source: AGRyM1uMYF5aMdLc4pr9cq9nWKk1j3E3Jn6EiTDtabFYLwv3IbGN1vatZaX1epvXyaSslqTAx13hROWNtucbivHxe8o=
X-Received: by 2002:a0d:ff02:0:b0:318:41fd:6b1f with SMTP id
 p2-20020a0dff02000000b0031841fd6b1fmr15083848ywf.354.1656669520663; Fri, 01
 Jul 2022 02:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090547.21429-1-allen-kh.cheng@mediatek.com> <20220701090547.21429-7-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220701090547.21429-7-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 17:58:29 +0800
Message-ID: <CAGXv+5Hp87TPasfD1Jx8bsVu9ApF7rsPkXHNb92aH65ny=pajA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] arm64: dts: mt8192: Add vcodec lat and core nodes
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 5:06 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add vcodec lat and core nodes for mt8192 SoC.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 60 ++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8192.dtsi
> index 6d9164b47bd1..2a1ad3084a01 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -1437,6 +1437,66 @@
>                         power-domains =3D <&spm MT8192_POWER_DOMAIN_ISP2>=
;
>                 };
>
> +               vcodec_dec: vcodec-dec@16000000 {
> +                       compatible =3D "mediatek,mt8192-vcodec-dec";
> +                       reg =3D <0 0x16000000 0 0x1000>;
> +                       mediatek,scp =3D <&scp>;
> +                       iommus =3D <&iommu0 M4U_PORT_L4_VDEC_MC_EXT>;
> +                       dma-ranges =3D <0x1 0x0 0x0 0x40000000 0x0 0xfff0=
0000>;
> +                       #address-cells =3D <2>;
> +                       #size-cells =3D <2>;
> +                       ranges =3D <0 0 0 0x16000000 0 0x26000>;
> +
> +                       vcodec_lat: vcodec-lat@10000 {
> +                               compatible =3D "mediatek,mtk-vcodec-lat";
> +                               reg =3D <0x0 0x10000 0 0x800>;
> +                               interrupts =3D <GIC_SPI 426 IRQ_TYPE_LEVE=
L_HIGH 0>;
> +                               iommus =3D <&iommu0 M4U_PORT_L5_VDEC_LAT0=
_VLD_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_V=
LD2_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_A=
VC_MV_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_P=
RED_RD_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_T=
ILE_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_W=
DMA_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_LAT0_R=
G_CTRL_DMA_EXT>,
> +                                        <&iommu0 M4U_PORT_L5_VDEC_UFO_EN=
C_EXT>;
> +                               clocks =3D <&topckgen CLK_TOP_VDEC_SEL>,
> +                                        <&vdecsys_soc CLK_VDEC_SOC_VDEC>=
,
> +                                        <&vdecsys_soc CLK_VDEC_SOC_LAT>,
> +                                        <&vdecsys_soc CLK_VDEC_SOC_LARB1=
>,
> +                                        <&topckgen CLK_TOP_MAINPLL_D4>;
> +                               clock-names =3D "sel", "soc-vdec", "soc-l=
at", "vdec", "top";

sel and top don't make sense. You should not be referencing upper level
clocks.

CLK_VDEC_SOC_LARB1 doesn't make a lot of sense either, since that should
be referenced in the larb. Unless if the clock doesn't get turned on when
the IOMMU is bypassed.

Last, would it work if lat only referenced CLK_VDEC_SOC_LAT, and core only
referenced CLK_VDEC_SOC_VDEC?


Thanks
ChenYu

> +                               assigned-clocks =3D <&topckgen CLK_TOP_VD=
EC_SEL>;
> +                               assigned-clock-parents =3D <&topckgen CLK=
_TOP_MAINPLL_D4>;
> +                               power-domains =3D <&spm MT8192_POWER_DOMA=
IN_VDEC>;
> +                       };
> +
> +                       vcodec_core: vcodec-core@25000 {
> +                               compatible =3D "mediatek,mtk-vcodec-core"=
;
> +                               reg =3D <0 0x25000 0 0x1000>;
> +                               interrupts =3D <GIC_SPI 425 IRQ_TYPE_LEVE=
L_HIGH 0>;
> +                               iommus =3D <&iommu0 M4U_PORT_L4_VDEC_MC_E=
XT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_UFO_EX=
T>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_PP_EXT=
>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_PRED_R=
D_EXT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_PRED_W=
R_EXT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_PPWRAP=
_EXT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_TILE_E=
XT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_VLD_EX=
T>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_VLD2_E=
XT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_AVC_MV=
_EXT>,
> +                                        <&iommu0 M4U_PORT_L4_VDEC_RG_CTR=
L_DMA_EXT>;
> +                               clocks =3D <&topckgen CLK_TOP_VDEC_SEL>,
> +                                        <&vdecsys CLK_VDEC_VDEC>,
> +                                        <&vdecsys CLK_VDEC_LAT>,
> +                                        <&vdecsys CLK_VDEC_LARB1>,
> +                                        <&topckgen CLK_TOP_MAINPLL_D4>;
> +                               clock-names =3D "sel", "soc-vdec", "soc-l=
at", "vdec", "top";
> +                               assigned-clocks =3D <&topckgen CLK_TOP_VD=
EC_SEL>;
> +                               assigned-clock-parents =3D <&topckgen CLK=
_TOP_MAINPLL_D4>;
> +                               power-domains =3D <&spm MT8192_POWER_DOMA=
IN_VDEC2>;
> +                       };
> +               };
> +
>                 larb5: larb@1600d000 {
>                         compatible =3D "mediatek,mt8192-smi-larb";
>                         reg =3D <0 0x1600d000 0 0x1000>;
> --
> 2.18.0
>
