Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4F4E428A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbiCVPMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiCVPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:12:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B4245BD;
        Tue, 22 Mar 2022 08:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C244B81D14;
        Tue, 22 Mar 2022 15:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F8C340F8;
        Tue, 22 Mar 2022 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647961845;
        bh=iD3r2C8ohus5StZzu+HIHENCtSsyhMruFFh9RM7/ok0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lTfrr6Xx5T7dbCIZGWoVSA4ezDO8SPB4V6YiBOHileBU/8ywOv7AWeMUKIdBFO6mz
         MvY51MObY0A/m/xTXiyLMLUAPYZ6+actWLn4LlYJqH3g/L4jHHzy1wCWg70oZIXspZ
         U6x970s8lT3VvnYOpTRHlqx2tDKXxKQ8DwacUVkUrJ627HzygQZjwNdf37sragLX6I
         bv5f/jPoJ3qdHmRLPmHthWGXr32polEsPw4OQWIeCq8MGYMWb/SYtKycLUnFl/f0w3
         gU4qi+iDUfcOw13fViapVaP64M1Fj7vJK1yygwrMI30M63p4q3O58w9LVF3z2np3Le
         yUcdLHGQehvQQ==
Received: by mail-ej1-f48.google.com with SMTP id p15so36862235ejc.7;
        Tue, 22 Mar 2022 08:10:45 -0700 (PDT)
X-Gm-Message-State: AOAM531XSdB6/OWFAEaTqiF0zfcNM5lVuxjgPZXdnvcd8qGySgbFTyr9
        txTki9x94MqUVpkO/HDZhsKqEE6CMN06Kin/yA==
X-Google-Smtp-Source: ABdhPJwcstYlhae/VDeErmYlaX8hBZSodjccbiEArN1YhP3mCzfkMUHmbq6+FoN7ayATI+AtiuwrK2GB7QQaqZOLugM=
X-Received: by 2002:a17:907:97c9:b0:6db:ab53:1fdf with SMTP id
 js9-20020a17090797c900b006dbab531fdfmr26610884ejc.406.1647961843159; Tue, 22
 Mar 2022 08:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220317143926.15835-1-moudy.ho@mediatek.com> <20220317143926.15835-4-moudy.ho@mediatek.com>
 <Yjj8CanzmdHeX7qz@robh.at.kernel.org>
In-Reply-To: <Yjj8CanzmdHeX7qz@robh.at.kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 22 Mar 2022 23:10:32 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-nTojmt44ts2VtXU3_kNpbn=CniHJh8dDeM0bPj8ouRA@mail.gmail.com>
Message-ID: <CAAOTY_-nTojmt44ts2VtXU3_kNpbn=CniHJh8dDeM0bPj8ouRA@mail.gmail.com>
Subject: Re: [PATCH v14 3/6] dt-bindings: soc: mediatek: move out common
 module from display folder
To:     Rob Herring <robh@kernel.org>
Cc:     Moudy Ho <moudy.ho@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        river.cheng@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        roy-cw.yeh@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        randy.wu@mediatek.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        allen-kh.cheng@mediatek.com,
        =?UTF-8?B?U2ogSHVhbmcgKOm7g+S/oeeSiyk=?= <sj.huang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        menghui.lin@mediatek.com,
        Alexandre Courbot <acourbot@chromium.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8822=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=886:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 17 Mar 2022 22:39:23 +0800, Moudy Ho wrote:
> > In order to share the same hardware information with MDP3,
> > change the MUTEX dt-binding to the path "soc/mediatek".

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> >
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >  .../bindings/{display =3D> soc}/mediatek/mediatek,mutex.yaml      | 2 =
+-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  rename Documentation/devicetree/bindings/{display =3D> soc}/mediatek/m=
ediatek,mutex.yaml (97%)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>
