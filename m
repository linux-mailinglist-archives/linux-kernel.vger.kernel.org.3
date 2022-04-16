Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AE750370E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiDPOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiDPOXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B82C137;
        Sat, 16 Apr 2022 07:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3553160F50;
        Sat, 16 Apr 2022 14:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B553C385A3;
        Sat, 16 Apr 2022 14:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650118847;
        bh=cWFwLZ0gsVucA5Es4p84LruYFLWbrqoMEwSN0TuIkzU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XDzfBSksXEI8qGNWOHFtln3WMB9rNV8dHxdESNVd28Tycyp8gxI14j+GAueK0vdoo
         x52nmuvKOi1hSqYc4FyW+ZiFl8k9MsO6fSGIxXICkqa6xj2UgMJf5g8fpAvC7hc3Qm
         6rf3JtbNezGuA1rUkmYwsSVbkciLwK3jKixYXM7M3VFWOjiTTOM7OJuwHxIGmN6cKe
         7SmTLyrYHEoJrDm01TEbyaZQsSC4a+KXjSLcnqqvQOz2juxXRUqxltuzwlYBj2pg7S
         jFrMzs+50pBrPEHMhJYcpE1TjyCDemN3Sd0etL4BxaocQo/aNlKeyMr6pZhU2jH7Rr
         TxBv3XBppqQgA==
Received: by mail-ed1-f51.google.com with SMTP id b15so12878302edn.4;
        Sat, 16 Apr 2022 07:20:47 -0700 (PDT)
X-Gm-Message-State: AOAM533szeMmJ8UzTxnuAh1mNffiQMnXPTMHY67baiGTF2b+7EVaUpk0
        UlfHq2WtEN5yI9cgHXCeabBLCLnDfmVs7SmzJw==
X-Google-Smtp-Source: ABdhPJwQkbTe35To395M3KGFQV4l935J7hGJqs1dYrMx9rEk+J0ELzSpWfOjk+VIW7myhFOyzkXfRd5cnptK29wlYcI=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr3964452edd.405.1650118845815; Sat, 16
 Apr 2022 07:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220411035843.19847-1-rex-bc.chen@mediatek.com>
 <20220411035843.19847-2-rex-bc.chen@mediatek.com> <YldWhNA6SwNBGXa8@robh.at.kernel.org>
In-Reply-To: <YldWhNA6SwNBGXa8@robh.at.kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 16 Apr 2022 22:20:38 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8L1EVvAOvD757o3kTq=AKf20yAsDGbuHFQ_mdkfoKwOg@mail.gmail.com>
Message-ID: <CAAOTY_8L1EVvAOvD757o3kTq=AKf20yAsDGbuHFQ_mdkfoKwOg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: display: mediatek: Update disp_aal
 binding for MT8183
To:     Rob Herring <robh@kernel.org>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        allen-kh.cheng@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>, krzk+dt@kernel.org,
        David Airlie <airlied@linux.ie>,
        DTML <devicetree@vger.kernel.org>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
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

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B44=E6=9C=8814=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 11 Apr 2022 11:58:41 +0800, Rex-BC Chen wrote:
> > The driver data of MT8183 and MT8173 are different.
> >
> > For MT8173, the gamma module is inside disp_aal. When we need to adjust
> > gamma value, we need to use "has_gamma" to control gamma function
> > inside disp_aal to adjust the gamma value.
> >
> > For successors like MT8183, disp_gamma is separated from disp_aal. We
> > just need to control disp_gamma directly and don't need to control gamm=
a
> > function inside disp_aal.
> >
> > With this modification, the driver doesn't require any functional chang=
es.
> > We only update the dt-binding and DTS node to make it clear.
> >
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml  | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.
