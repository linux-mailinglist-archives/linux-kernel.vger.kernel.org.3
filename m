Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9D156335F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiGAMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiGAMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:17:59 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F39C340EE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:17:57 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31bf327d4b5so21397247b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OeFEXEeuxQywhhUwc04U+bwz5KZPm/3fkyXZz25KGfw=;
        b=GMYOB4VdXQqK5nQ9DdqjYthCByYBWHMC7PS9aK0vdB5WHIw00SEFRbeqrOTkOva5+0
         9vDIoZ79WqQbQFjjERSMdXRtELXY8HlLo14SRigLhueM/WNJJx76gYuylaT12KWvdfnK
         DQTlAPDX1Tar+g2CrgdghnZ3wJTIX2IhoKV6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OeFEXEeuxQywhhUwc04U+bwz5KZPm/3fkyXZz25KGfw=;
        b=oITwuCm1WkVoZXdCJlGZgJw7KGOA78t95OqZRb1RpK1Tlrnv4oKAFpWQdFjODM78fY
         qvvlGnMpXfK7Rp9gBBq7kjmS3fHOeo9gmuHZHhZSLc5hf7pSImiSsOc6T7A4pMtg/iCl
         EFUy0O4simzgfhpivnsuiydxmAK5IUzR7VR2v4gzCPjHRc9plpjZr/DfHNzJY+NDJorA
         dqQAsH2z5DhVCCiwGwBNT2nX4mq0/ra5WmgE3g2x0OX/OLlbaqtcFH7LfICoeQQArFd1
         qQDjyQ3JRAXkY+NMH7rE057B+sc6oRWcLwSeAdH2VHsLV3WRGUjNqaxQr/XiZKX9Yn+8
         2eaw==
X-Gm-Message-State: AJIora+VxVj1CXUGli0JAVQ3Aujmqk+wf/zXz0h21HxiJkPxuvN8Qjt2
        6Ozex/wohPRG0enSOZirGdmHcmX6oe1Yq9JSjIypgQWoAQLOhA==
X-Google-Smtp-Source: AGRyM1uZNWNmWtR0njNvXbQvTDKxY2Iko1JAqKD5WQuetGxzVxS5CuRnlks1P2s3aeTr4thJjl4ATAYe10bhQxmCwR0=
X-Received: by 2002:a05:690c:295:b0:317:759b:a661 with SMTP id
 bf21-20020a05690c029500b00317759ba661mr17180203ywb.144.1656677875926; Fri, 01
 Jul 2022 05:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090547.21429-1-allen-kh.cheng@mediatek.com> <20220701090547.21429-5-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220701090547.21429-5-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 1 Jul 2022 20:17:44 +0800
Message-ID: <CAGXv+5F_Gi_=vV1NSk0AGRVYCa3Q8+gBaE+nv3OJ1AKe2voOwg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: mt8192: Add display nodes
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
> Add display nodes and gce info for mt8192 SoC.
>
> GCE (Global Command Engine) properties to the display nodes in order to
> enable the usage of the CMDQ (Command Queue), which is required for
> operating the display.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 137 +++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8192.dtsi
> index a789b7c9b2af..c4dc8777f26c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -6,6 +6,7 @@
>
>  /dts-v1/;
>  #include <dt-bindings/clock/mt8192-clk.h>
> +#include <dt-bindings/gce/mt8192-gce.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/memory/mt8192-larb-port.h>
> @@ -553,6 +554,15 @@
>                         assigned-clock-parents =3D <&topckgen CLK_TOP_OSC=
_D10>;
>                 };
>
> +               gce: mailbox@10228000 {
> +                       compatible =3D "mediatek,mt8192-gce";
> +                       reg =3D <0 0x10228000 0 0x4000>;
> +                       interrupts =3D <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       #mbox-cells =3D <2>;
> +                       clocks =3D <&infracfg CLK_INFRA_GCE>;
> +                       clock-names =3D "gce";
> +               };
> +
>                 scp_adsp: clock-controller@10720000 {
>                         compatible =3D "mediatek,mt8192-scp_adsp";
>                         reg =3D <0 0x10720000 0 0x1000>;
> @@ -1186,9 +1196,22 @@
>                 mmsys: syscon@14000000 {
>                         compatible =3D "mediatek,mt8192-mmsys", "syscon";
>                         reg =3D <0 0x14000000 0 0x1000>;
> +                       mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST>,
> +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400XXXX=
 0 0x1000>;
>                         #clock-cells =3D <1>;

This also needs #reset-cells =3D <1>; othewise

    resets =3D <&mmsys MT8192_MMSYS_SW0_RST_B_DISP_DSI0>;

in patch 5 will fail to be parsed by the kernel.

Can you add this in a separate patch?

>                 };
>

[...]

> +               ovl_2l2: ovl@14014000 {
> +                       compatible =3D "mediatek,mt8192-disp-ovl-2l";
> +                       reg =3D <0 0x14014000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       power-domains =3D <&spm MT8192_POWER_DOMAIN_DISP>=
;
> +                       clocks =3D <&mmsys CLK_MM_DISP_OVL2_2L>;
> +                       iommus =3D <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2>,
> +                                <&iommu0 M4U_PORT_L1_OVL_2L_RDMA2_HDR>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x4000 0x1000>;
> +               };
> +
> +               rdma4: rdma@14015000 {
> +                       compatible =3D "mediatek,mt8192-disp-rdma";
> +                       reg =3D <0 0x14015000 0 0x1000>;
> +                       interrupts =3D <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0=
>;
> +                       power-domains =3D <&spm MT8192_POWER_DOMAIN_DISP>=
;
> +                       clocks =3D <&mmsys CLK_MM_DISP_RDMA4>;
> +                       iommus =3D <&iommu0 M4U_PORT_L1_DISP_RDMA4>;
> +                       mediatek,rdma-fifo-size =3D <2048>;
> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1401XXXX=
 0x5000 0x1000>;
> +               };
> +

The aliases for these need to be added. Otherwise the display pipeline
will stall.


ChenYu
