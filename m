Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CB4CE121
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiCDXqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:46:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D4580C8;
        Fri,  4 Mar 2022 15:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7438B82C6E;
        Fri,  4 Mar 2022 23:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6340FC340F3;
        Fri,  4 Mar 2022 23:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646437515;
        bh=NeRBwotyA+2T4DJi4XwW8R9F5009UEd0x0u94q4HzSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F4kIJg1JBz7deNxMyZ/NWRHbYHAWiOoPzls/nqlVNxWR4XRC0AXHq9Bu8c/tdM0nt
         F/b68J2MS2rmnOFIhnh3J31DgEZgxe6h6VKEUKH1UDGlmAD+ruRiX51NkXcPnYxO53
         P38M7Rdo1D/zecUw92XgmrDTpmYDJ+bWeiZ3I4USeCvAvrNblBNMVo/bJXvvNV2M2T
         Rkn7GhSGMcgQIa76sgpyGpdKgmNMvNibCCGlw7lwJ+Y9MxIyNGSgJ/IkZbyn7j/rPd
         xopIiph9c6NMqICzJUO0XL7G8oJm+nO7ps0zP/z3AktHuIn+CoDwm9JGjBzUMey3eK
         +5qbQBJ5uWYrA==
Received: by mail-ej1-f48.google.com with SMTP id kt27so20618831ejb.0;
        Fri, 04 Mar 2022 15:45:15 -0800 (PST)
X-Gm-Message-State: AOAM5300/Oc4i1tbgZkXO9Nzm9ZlcOV7AzkauM1eOwKOPJsCyaj0ygs9
        3lP3d5NPSdwhGwXgqSABsWGYSSow2PxS9p+j6A==
X-Google-Smtp-Source: ABdhPJxYS0br7Fg3mai1Y52kvgn22FUhmJLrfoIufPjrILVKI7waYv7yh1S/8ojIS55W4FhA8IZFUbN9+nd9WWD+qnA=
X-Received: by 2002:a17:906:b348:b0:6cf:5b66:2f80 with SMTP id
 cd8-20020a170906b34800b006cf5b662f80mr903212ejb.638.1646437513692; Fri, 04
 Mar 2022 15:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com> <20220304095458.12409-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220304095458.12409-3-angelogioacchino.delregno@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 5 Mar 2022 07:45:02 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9m06C63xXQqDSZeV2ZojEqE_Hb+V8stPc1x4oUdD5OGA@mail.gmail.com>
Message-ID: <CAAOTY_9m06C63xXQqDSZeV2ZojEqE_Hb+V8stPc1x4oUdD5OGA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: display: mediatek,ovl: Fix 'iommu'
 required property typo
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski@canonical.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B43=E6=9C=884=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:55=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The property is called 'iommus' and not 'iommu'. Fix this typo.

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each bl=
ock to individual yaml")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.=
yaml
> index 93d5c68a2dbd..fc691d00c60e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> @@ -75,7 +75,7 @@ required:
>    - interrupts
>    - power-domains
>    - clocks
> -  - iommu
> +  - iommus
>
>  additionalProperties: false
>
> --
> 2.35.1
>
