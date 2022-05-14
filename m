Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B807B527487
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 00:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiENWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 18:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiENWpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 18:45:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4A393D5;
        Sat, 14 May 2022 15:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D97CB80AF0;
        Sat, 14 May 2022 22:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08149C34116;
        Sat, 14 May 2022 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652568336;
        bh=bS5HQAMDtikZldwnYUYBmDVi720L89RDOZV60SNkgDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G3X7Ev3uaoY/99lBrRDH0OqAad20kfM8hFPhKgOuiy71sVqP3jfe1TTCpq41mQr8L
         kYPnzbCMHWA6jUl1tjPUWUgNSW/7ouRo/NPU6rQAdBI4Dy+yAtZq7xXfMT5mMX5NiM
         N2W9MztlpmbJ/1e8Nr0FmquYQIAxKIs/0tYYng0cUog1vEKlaNMTvQVcxfRB73Pii3
         mIx7UT970RvOi6UJLcfSvIMv5CISDxRVc2azYHrqQJOChXgkzjsadFFE/6yuGiOQav
         W7s0iRCV6s0KCUxyKZa458d+pNBHY3TQQmOJ79m5r9t8R4HhM43mhaT8WwhII9tCn4
         sZQjFC7Tih8+w==
Received: by mail-yb1-f175.google.com with SMTP id e78so106550ybc.12;
        Sat, 14 May 2022 15:45:35 -0700 (PDT)
X-Gm-Message-State: AOAM533KfEmCtwk+1TNjpwW8OsC088Fp7cQ1u5jfUR1qlhi1FZbh4QlF
        13aU13ET0Zi/1HPwYx2GLEKrki1fcdqaa7W9gw==
X-Google-Smtp-Source: ABdhPJzl9etzP0gMxcOzXLXqcN7qDo28gwQdlJmLqkufMpWnqlfrfltoJeXr0AOfQGCpVjoKglRILz+NUksdOsA4GYs=
X-Received: by 2002:a25:df16:0:b0:64a:9f33:829c with SMTP id
 w22-20020a25df16000000b0064a9f33829cmr11383457ybg.641.1652568335010; Sat, 14
 May 2022 15:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220419094143.9561-1-jason-jh.lin@mediatek.com>
 <20220419094143.9561-9-jason-jh.lin@mediatek.com> <402f0e60-8d3c-850d-84ff-af5424b72b73@gmail.com>
 <CAAOTY_-jiX_BhaZ5+skRu4RSZLjcHJerVtwH34fz4N6_jbVK0w@mail.gmail.com> <623fb170-b59a-84a0-3826-4b78968924bc@gmail.com>
In-Reply-To: <623fb170-b59a-84a0-3826-4b78968924bc@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 15 May 2022 06:45:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9gReO45qVhd5-9UrDYsDkOeS+FZT2Dw2McVgZvK3jfeg@mail.gmail.com>
Message-ID: <CAAOTY_9gReO45qVhd5-9UrDYsDkOeS+FZT2Dw2McVgZvK3jfeg@mail.gmail.com>
Subject: Re: [PATCH v20 8/8] soc: mediatek: remove DDP_DOMPONENT_DITHER from enum
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
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

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2022=E5=B9=B45=E6=9C=88=
13=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:42=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Chun-Kuang,
>
> On 02/05/2022 00:54, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2022=E5=B9=B44=E6=
=9C=8822=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:42=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >>
> >>
> >> On 19/04/2022 11:41, jason-jh.lin wrote:
> >>> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
> >>> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
> >>>
> >>> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> >>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> >>
> >> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> >>
> >> Chun-Kuang, I think it would make sense to take that through your tree=
 as it
> >> depends on the previous patches.
> >>
> >> I provide you a stable tag so that you can take it:
> >> v5.18-next-vdso0-stable-tag
> >
> > After I take this tag, I find one checkpatch warning:
> >
> > WARNING: DT compatible string "mediatek,mt8195-mmsys" appears
> > un-documented -- check ./Documentation/devicetree/bindings/
> > #670: FILE: drivers/soc/mediatek/mtk-mmsys.c:390:
> > +               .compatible =3D "mediatek,mt8195-mmsys",
> >
> > I think this tag lost one binding patch, it's better that this tag has
> > no this warning.
> >
>
> Sorry for the late reply I was sick.
> The warning is, because the stable branch misses commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/co=
mmit/?h=3Dv5.18-next/soc&id=3D81c5a41d10b968ea89d5f44fe1e5c2fc70289209
>
> So it's not a real issue and will go away once our branches land in upstr=
eam.
> Is it OK for you to ignore the issue?

It's OK for me, but the patch would go through different maintainer's
tree and I'm not sure it's OK for all of them. So I would wait for the
necessary patch land in upstream.

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > Regards,
> > Chun-Kuang.
> >
> >>
> >> Regards,
> >> Matthias
> >>
> >>> ---
> >>>    include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
> >>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/s=
oc/mediatek/mtk-mmsys.h
> >>> index 59117d970daf..fb719fd1281c 100644
> >>> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> >>> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> >>> @@ -16,8 +16,7 @@ enum mtk_ddp_comp_id {
> >>>        DDP_COMPONENT_CCORR,
> >>>        DDP_COMPONENT_COLOR0,
> >>>        DDP_COMPONENT_COLOR1,
> >>> -     DDP_COMPONENT_DITHER,
> >>> -     DDP_COMPONENT_DITHER0 =3D DDP_COMPONENT_DITHER,
> >>> +     DDP_COMPONENT_DITHER0,
> >>>        DDP_COMPONENT_DITHER1,
> >>>        DDP_COMPONENT_DP_INTF0,
> >>>        DDP_COMPONENT_DP_INTF1,
