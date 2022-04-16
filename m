Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AA8503715
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiDPOYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDPOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:24:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CE92DABF;
        Sat, 16 Apr 2022 07:22:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26E56B82417;
        Sat, 16 Apr 2022 14:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFB0C385AA;
        Sat, 16 Apr 2022 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650118920;
        bh=AQEu64jaXboAv+zoYsgsiYMWLuLEVN/IlKXUW/p/mps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E0cUbtpNFUtMtgLzUGDRPk1ps4WTOQ6oEsPx+kxBcp6AtkAxIZMJNc61Bmwu5BN9d
         7d9m/UE8LMvVLGmH3uqoqkkeTg1mUnbTzWuVHrDUFGINZetndpzYrFJSKtJRlTgZZY
         W20TnC595lz8I6gO6/TT14wcxLKlImcvaZhmligz/9dhvCVSgjM+6TNDLOWec1dQNv
         VjcUiv2gT2yv2EdPYRHdjkAdjnlQXYSg2ksm32u6ZjQR7t0SJO2IX9sLiN2z6SiKac
         /SWGtK25uh/IrA6XiGTY5BzUWNSixeZhMySR6VeNbsOygmK2eQVLxdA2hbAQW/+9i1
         RwduB5sdJ5rIw==
Received: by mail-ed1-f45.google.com with SMTP id z12so12903498edl.2;
        Sat, 16 Apr 2022 07:22:00 -0700 (PDT)
X-Gm-Message-State: AOAM5302tkI5+G0BoIofk79LOo/IQxlB94ocHuybW0CvUVMFQetrW0MF
        d/JK90mrr03yiPZ991iBk20qK6mSWiaehC3aXA==
X-Google-Smtp-Source: ABdhPJxbmEV+hwk4GL9LWk4P/pzE9nAuwmYPGG4NNYd79+xQNfoh8INhSk/eBBi9Q4r3fxMonmeqRsOfHI+xYyVF7gw=
X-Received: by 2002:aa7:c38f:0:b0:41d:82c7:7751 with SMTP id
 k15-20020aa7c38f000000b0041d82c77751mr3960939edq.215.1650118919152; Sat, 16
 Apr 2022 07:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220411035843.19847-1-rex-bc.chen@mediatek.com>
 <20220411035843.19847-4-rex-bc.chen@mediatek.com> <YldWk9eTLbXBcbX+@robh.at.kernel.org>
In-Reply-To: <YldWk9eTLbXBcbX+@robh.at.kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 16 Apr 2022 22:21:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8j407wX8SEmK4rSfLheb4GQjQBJPyfXgy=5m+dLw7XPw@mail.gmail.com>
Message-ID: <CAAOTY_8j407wX8SEmK4rSfLheb4GQjQBJPyfXgy=5m+dLw7XPw@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] dt-bindings: display: mediatek: Update disp_aal
 binding for MT8192 and MT8195
To:     Rob Herring <robh@kernel.org>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, krzk+dt@kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        allen-kh.cheng@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B44=E6=9C=8814=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:02=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 11 Apr 2022 11:58:43 +0800, Rex-BC Chen wrote:
> > Disp_aal of MT8192 and MT8195 are fully compatible with disp_aal of
> > MT8183. Therefore, we move the them to item "mediatek,mt8183-disp-aal".
> >
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.
