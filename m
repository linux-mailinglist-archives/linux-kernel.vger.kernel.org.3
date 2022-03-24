Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932544E640D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350403AbiCXN1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiCXN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A78A7752;
        Thu, 24 Mar 2022 06:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27CC8B823E1;
        Thu, 24 Mar 2022 13:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC825C340F9;
        Thu, 24 Mar 2022 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648128360;
        bh=fyIiU5RZ5vQvJ0AbYHjhGoBAWCrDkNOaT9PweDfIA54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q5jVk0jR0N8AxYnAmlI/4hn9WXOJoqruiN3Lx4o5Q7LvZ7+QE7Os06E+7SSbr55jK
         AjNuwfG++wDfE+/s3NDSLIJfCb+2ktBuloavqEAmw7YphDTda4uOxn/oUPRqlu3F7Y
         orG4xR6LpBhXMERtPv8WWxtisu3krU/p0+bIGgbdXdFvuCJ+l8GR5tqTZPIiqs+ULD
         +y7kI2iUuz8DojIZ7dmk7HgWETysRWE2svWhvxRZbDT8j9gytgcGh/0zCfZo7YUzm2
         OIo0ksBhURzjt2b+H3GembODH1Q6MzPFgeBgAHPHiNXydBJoiKybaVS25qDAJ/AgyH
         izJ/bVYB21G0w==
Received: by mail-ej1-f53.google.com with SMTP id d10so9121101eje.10;
        Thu, 24 Mar 2022 06:26:00 -0700 (PDT)
X-Gm-Message-State: AOAM532Vi5UXdShLrVj4Nc2GEp1FgzlEnaED3YwKf+NnFk5Lz0bsp2xK
        trWOtls0ul5xMZEWrHCtdMDWiwmSgHTLBFbQRg==
X-Google-Smtp-Source: ABdhPJxMtishIXyQnHytEurL58PXSNq0mjIOLyhlOsXwq+vbDhHOyF+FHGCUAHZ5No9IqBKpjNCuQP5Pnh/dbKKnyGA=
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id
 m4-20020a17090679c400b006cf5489da57mr5757085ejo.48.1648128358773; Thu, 24 Mar
 2022 06:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220309134702.9942-1-jason-jh.lin@mediatek.com> <CAL_Jsq+=hTKTjB8rR77_uQYKDWHzLyTdeU7zbixSCZCNrdmNvg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+=hTKTjB8rR77_uQYKDWHzLyTdeU7zbixSCZCNrdmNvg@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 24 Mar 2022 21:25:44 +0800
X-Gmail-Original-Message-ID: <CAAOTY__kzL8YuGo-oKct4c_bL-Ch5rW8wBpkhOXkK+a10gNXVg@mail.gmail.com>
Message-ID: <CAAOTY__kzL8YuGo-oKct4c_bL-Ch5rW8wBpkhOXkK+a10gNXVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix MediaTek display dt-bindings issues
To:     Rob Herring <robh@kernel.org>
Cc:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "roy-cw.yeh" <roy-cw.yeh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8823=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Mar 9, 2022 at 7:47 AM jason-jh.lin <jason-jh.lin@mediatek.com> w=
rote:
> >
> > The vdosys0 series carried a nice dt-bindings conversion of the old
> > txt documentation for the entire mediatek-drm driver, but some of
> > the issues in there weren't seen.
> >
> > This series is fixing all of the issues pointed out by a
> > `dt_binding_check` run, followed by `dtbs_check`.
> >
> > Change in v2:
> > - remove mediatek,ethdr.yaml file
> > - change include header of mediatek,ovl-2l.yaml from mt8173 to mt8183
> >
> > AngeloGioacchino Del Regno (3):
> >   dt-bindings: display: mediatek, mutex: Fix mediatek, gce-events type
> >   dt-bindings: display: mediatek, ovl: Fix 'iommu' required property
> >     typo
> >   dt-bindings: display: mediatek: Fix examples on new bindings
> >
> > jason-jh.lin (1):
> >   Revert "dt-bindings: display: mediatek: add ethdr definition for
> >     mt8195"
>
> Can this series get applied soon? linux-next is still broken.
>
> If it hits Linus' tree, I will be applying them.

I've applied this series to my tree [1], but now is merge window, so I
plan to send this series through Dave's tree after 5.18-rc1. Would
this be too late for you?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-fixes

Regards,
Chun-Kuang.

>
> Rob
