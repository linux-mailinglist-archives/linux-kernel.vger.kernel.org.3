Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3134ACCE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbiBHBEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245565AbiBGXKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:10:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF681C061355;
        Mon,  7 Feb 2022 15:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D665B8172A;
        Mon,  7 Feb 2022 23:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F4C36AE5;
        Mon,  7 Feb 2022 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644275402;
        bh=X55ltdzNwPy1g/p9q8Hmw02ExsfYSQ15IJvBXM3YtY0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b35MZEt7F3ub1UmW59dP/jK1FHeinkHi47vnikF6f0tn/LYxYvBlTyxSaTnh48zsw
         bj+LHNVU4kHEuS9oU7MqEOEbF9z3BTwYM0EbkbcyPMvVD/DV0DrdT35pzzpRNQcADu
         Oy4/rEvaS0eLVeS86L7tF6GhJ91h/XYPGz9RK7QGv55ktzTlvSi1Yxhv9iw5hOsyWY
         yYd5IgGp5w1C4rz4hX5sRzve4MfCRJnkiroZyRIynTp8e1riDW2zttvuWuOZbNDDn2
         0RmzMaaEUj0DTUpU/v70SKTeU4fE4cOtOBpEgY7MUx7Dg0KzrNTqszT53CTqcxcJuP
         vevjRA2C7EiJQ==
Received: by mail-ej1-f53.google.com with SMTP id ka4so46527021ejc.11;
        Mon, 07 Feb 2022 15:10:02 -0800 (PST)
X-Gm-Message-State: AOAM531tlh9RyQOQbL/hg3TObEYti54yAyJDBk4mr5xUTTRhvW4sY50B
        r5c7yc5oWV3V77LO1zoiXtqgg20/iLn5T6EmVQ==
X-Google-Smtp-Source: ABdhPJzHug39pCeEURXinndAsC1Ag6qOi9HiunS1b6JUbZ+czMiULQBPsCGdREFSWexfLvxwtF92P+X+IxVE5/XVA1I=
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr1461761ejc.638.1644275400392;
 Mon, 07 Feb 2022 15:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com> <20220126071932.32615-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20220126071932.32615-6-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 8 Feb 2022 07:09:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8zd6QDs3om8-oGaLJuw9OjTmak_cqbkUpVjyqCUV_LLQ@mail.gmail.com>
Message-ID: <CAAOTY_8zd6QDs3om8-oGaLJuw9OjTmak_cqbkUpVjyqCUV_LLQ@mail.gmail.com>
Subject: Re: [PATCH v15 05/12] dt-bindings: display: mediatek: merge: add
 additional prop for mt8195
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
> add MERGE additional properties description for mt8195:
> 1. async clock
> 2. fifo setting enable
> 3. reset controller

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  .../display/mediatek/mediatek,merge.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 7aa6974d509d..fae106cf1753 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -36,8 +36,28 @@ properties:
>        Documentation/devicetree/bindings/power/power-domain.yaml for deta=
ils.
>
>    clocks:
> +    maxItems: 2
>      items:
>        - description: MERGE Clock
> +      - description: MERGE Async Clock
> +          Controlling the synchronous process between MERGE and other di=
splay
> +          function blocks cross clock domain.
> +
> +  clock-names:
> +    maxItems: 2
> +    items:
> +      - const: merge
> +      - const: merge_async
> +
> +  mediatek,merge-fifo-en:
> +    description:
> +      The setting of merge fifo is mainly provided for the display laten=
cy
> +      buffer to ensure that the back-end panel display data will not be
> +      underrun, a little more data is needed in the fifo.
> +      According to the merge fifo settings, when the water level is dete=
cted
> +      to be insufficient, it will trigger RDMA sending ultra and preulra
> +      command to SMI to speed up the data rate.
> +    type: boolean
>
>    mediatek,gce-client-reg:
>      description: The register of client driver can be configured by gce =
with
> @@ -47,6 +67,11 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>
> +  resets:
> +    description: reset controller
> +      See Documentation/devicetree/bindings/reset/reset.txt for details.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -64,3 +89,16 @@ examples:
>          power-domains =3D <&spm MT8173_POWER_DOMAIN_MM>;
>          clocks =3D <&mmsys CLK_MM_DISP_MERGE>;
>      };
> +
> +    merge5: disp_vpp_merge5@1c110000 {
> +        compatible =3D "mediatek,mt8195-disp-merge";
> +        reg =3D <0 0x1c110000 0 0x1000>;
> +        interrupts =3D <GIC_SPI 507 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks =3D <&vdosys1 CLK_VDO1_VPP_MERGE4>,
> +                 <&vdosys1 CLK_VDO1_MERGE4_DL_ASYNC>;
> +        clock-names =3D "merge","merge_async";
> +        power-domains =3D <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +        mediatek,gce-client-reg =3D <&gce1 SUBSYS_1c11XXXX 0x0000 0x1000=
>;
> +        mediatek,merge-fifo-en =3D <1>;
> +        resets =3D <&vdosys1 MT8195_VDOSYS1_SW0_RST_B_MERGE4_DL_ASYNC>;
> +    };
> --
> 2.18.0
>
