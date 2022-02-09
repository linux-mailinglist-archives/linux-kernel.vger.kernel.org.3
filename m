Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E394AF47F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiBIOyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiBIOyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:54:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96798C06157B;
        Wed,  9 Feb 2022 06:54:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3283361B4A;
        Wed,  9 Feb 2022 14:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D39C340F4;
        Wed,  9 Feb 2022 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644418495;
        bh=x3KYHTnQdcpuPpSms1usX2LA7bATNpiYgyATB3QLAbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DP8bgKOIhroqVt4vja7HreRX2JRYYft7GhrG1w+t9B6isH/MkkvyTg5+SG1Yush54
         vlluQal/lOUpBfY3ljkUOMQi1GyeS0zQtB4uB4Gwa/AWP4T5SwNJ69D4yAEDD6mYT2
         JXAvDi4PQs7+a+/vxVu/f2QtZivrpKjhdRlYj9zNgXQrI02PhH6fjwWwfxAJFGuh20
         dkeExW4jcOlFPZK7/L9c5bWjS7822u3pMYOmx3/nAQJNX8iPS4rCES+arZNCXdSe2z
         XLv/JVtJHu/woigCybi0kThymkgMkqy7oBHZa7wlsHFOlw2Q8vjEbBGt7HKj32eByY
         xxT1uZ/gweetQ==
Received: by mail-ej1-f52.google.com with SMTP id fy20so8217766ejc.0;
        Wed, 09 Feb 2022 06:54:55 -0800 (PST)
X-Gm-Message-State: AOAM5336pqHklblZxVXZ4DrEuyo5rwJw5Q8Tu5j0LOEnq1WnjTpTUOPp
        59yTNAxU9PDcxevgkDh6K9pyJ8uRxopqahbF1w==
X-Google-Smtp-Source: ABdhPJw1d9C+p2auPNdEqgcaTp3i90UkTDIFvXwjsigycoG7QKqrkkRdCImb6AEMWNRJXL/DDV7TXXvY/uMqwA6Xo28=
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr2266508ejc.638.1644418493696;
 Wed, 09 Feb 2022 06:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20220110084645.31191-1-nancy.lin@mediatek.com> <20220110084645.31191-3-nancy.lin@mediatek.com>
In-Reply-To: <20220110084645.31191-3-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 9 Feb 2022 22:54:42 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-3ekRhHcs0QstWMe9hE7X041zwjQeGcRhDq5gavBhPRw@mail.gmail.com>
Message-ID: <CAAOTY_-3ekRhHcs0QstWMe9hE7X041zwjQeGcRhDq5gavBhPRw@mail.gmail.com>
Subject: Re: [PATCH v11 02/22] dt-bindings: mediatek: add vdosys1 MERGE
 property for mt8195
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>
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

Hi, Nancy:

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2022=E5=B9=B41=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> MT8195 vdosys1 merge1 to merge4 have HW mute function.
> Add MERGE additional mute property description.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang

>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Acked-By: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora=
.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,merge.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
merge.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,me=
rge.yaml
> index 28be8ffeb429..f5b1e632bcd5 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,merge.y=
aml
> @@ -61,6 +61,10 @@ properties:
>        command to SMI to speed up the data rate.
>      type: boolean
>
> +  mediatek,merge-mute:
> +    description: Support mute function. Mute the content of merge output=
.
> +    type: boolean
> +
>    mediatek,gce-client-reg:
>      description:
>        The register of client driver can be configured by gce with 4 argu=
ments
> --
> 2.18.0
>
