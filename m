Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104134ACD44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbiBHBER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiBGXKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:10:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A56C061355;
        Mon,  7 Feb 2022 15:10:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9846C60E88;
        Mon,  7 Feb 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9EDC340F2;
        Mon,  7 Feb 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644275432;
        bh=Lcdb4q3h6FG1qReWPKtwv14iRj024HvkZtSOCVum3ZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A9I3mZ5okqwJnmnOvQ5mSBofABVE4y5mO0TcPlGxxOBsbAHawMshH3hLUNui6Ji7e
         WN67qJAu3A+o3B/w3PUKnpyAFgflRbmISStnyKcUB5Re4kAYc8CsHMHbQA+mGzhIVQ
         IqZKy2dHfrqN98Hi7Beppm3F0UGBrr7RLd4xV3UVW6V1UOOEg6vPRS59NVKWu7GSBX
         1V30BIBHDRrtdRdOtHkTUieqT9DuO4jYxhRXyKr+JTAKXpKomuZM2dPFolgrf1j6J+
         RRWjJzHKPUVN6UwnqF0nZHxBNl3M+t9NJTiBZJrRsTrxALGwb2u6RHDnwnhuSuKkVn
         xPnw2jcz7RnOA==
Received: by mail-ej1-f54.google.com with SMTP id k25so46267693ejp.5;
        Mon, 07 Feb 2022 15:10:31 -0800 (PST)
X-Gm-Message-State: AOAM533UIG/Of2SSaqwKQc3Bk1lgBK48hFg322eylUEnlFMFLYWycq3Z
        EPkUi57qJUEcu0upsHO/YsdM1/Mr81qlz0naaQ==
X-Google-Smtp-Source: ABdhPJz7Qj0TuFoWxZhb8cva0V6D9Wp6M2Hdt+CzzUkPA0uqFFqcscoQvCYXutPCout4QIFnwq1QIvKZFgtuPsC7bWE=
X-Received: by 2002:a17:906:2744:: with SMTP id a4mr1476727ejd.510.1644275430253;
 Mon, 07 Feb 2022 15:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20220126071932.32615-1-jason-jh.lin@mediatek.com> <20220126071932.32615-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20220126071932.32615-7-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 8 Feb 2022 07:10:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9oGmop6nKfpHgNgRb6JaJ2CukOyP-vdrBM1G5sxMAkrA@mail.gmail.com>
Message-ID: <CAAOTY_9oGmop6nKfpHgNgRb6JaJ2CukOyP-vdrBM1G5sxMAkrA@mail.gmail.com>
Subject: Re: [PATCH v15 06/12] dt-bindings: display: mediatek: add mt8195 SoC
 binding for vdosys0
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
> Add mt8195 SoC binding to AAL, CCORR, COLOR, DITHER, GAMMA, MERGE,
> MUTEX, OVL and RDMA yaml schema for vdosys0.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml   | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 5 +++++
>  .../devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
>  .../bindings/display/mediatek/mediatek,dither.yaml           | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml | 1 +
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml | 2 ++
>  .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml | 5 +++--
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml   | 5 +++++
>  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml  | 2 ++
>  9 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.=
yaml
> index 044331f5aacb..225f9dd726d2 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yam=
l
> @@ -28,6 +28,7 @@ properties:
>                - mediatek,mt2712-disp-aal
>                - mediatek,mt8183-disp-aal
>                - mediatek,mt8192-disp-aal
> +              - mediatek,mt8195-disp-aal
>            - enum:
>                - mediatek,mt8173-disp-aal
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,cc=
orr.yaml
> index ea45b40edee7..6894b6999412 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.y=
aml
> @@ -25,6 +25,11 @@ properties:
>            - const: mediatek,mt8183-disp-ccorr
>        - items:
>            - const: mediatek,mt8192-disp-ccorr
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-disp-ccorr
> +          - enum:
> +              - mediatek,mt8192-disp-ccorr
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,co=
lor.yaml
> index 13628f346718..bc83155b3b4c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> @@ -38,6 +38,7 @@ properties:
>            - enum:
>                - mediatek,mt8183-disp-color
>                - mediatek,mt8192-disp-color
> +              - mediatek,mt8195-disp-color
>            - enum:
>                - mediatek,mt8173-disp-color
>    reg:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,d=
ither.yaml
> index 2c05e3019c75..9d89297f5f1d 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.=
yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.=
yaml
> @@ -27,6 +27,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-dither
> +              - mediatek,mt8195-disp-dither
>            - enum:
>                - mediatek,mt8183-disp-dither
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ga=
mma.yaml
> index 89ccb8dbadd7..247baad147b3 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.y=
aml
> @@ -28,6 +28,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8192-disp-gamma
> +              - mediatek,mt8195-disp-gamma
>            - enum:
>                - mediatek,mt8183-disp-gamma
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index fae106cf1753..60b21ef5549b 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -23,6 +23,8 @@ properties:
>      oneOf:
>        - items:
>            - const: mediatek,mt8173-disp-merge
> +      - items:
> +          - const: mediatek,mt8195-disp-merge
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mu=
tex.yaml
> index 90f11e12a55e..6eca525eced0 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.y=
aml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,mutex.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>
> -title: Mediatek display mutex
> +title: Mediatek mutex
>
>  maintainers:
>    - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> @@ -36,7 +36,8 @@ properties:
>            - const: mediatek,mt8183-disp-mutex
>        - items:
>            - const: mediatek,mt8192-disp-mutex
> -
> +      - items:
> +          - const: mediatek,mt8195-disp-mutex
>    reg:
>      maxItems: 1
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.=
yaml
> index 8e4a62cb9c81..e71f79bc2dee 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> @@ -35,6 +35,11 @@ properties:
>                - mediatek,mt2712-disp-ovl
>            - enum:
>                - mediatek,mt2701-disp-ovl
> +      - items:
> +          - enum:
> +              - mediatek,mt8195-disp-ovl
> +          - enum:
> +              - mediatek,mt8183-disp-ovl
>
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdm=
a.yaml
> index a3c5f4c9fbcd..8ef821641672 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.ya=
ml
> @@ -29,6 +29,8 @@ properties:
>            - const: mediatek,mt8173-disp-rdma
>        - items:
>            - const: mediatek,mt8183-disp-rdma
> +      - items:
> +          - const: mediatek,mt8195-disp-rdma
>        - items:
>            - enum:
>                - mediatek,mt7623-disp-rdma
> --
> 2.18.0
>
