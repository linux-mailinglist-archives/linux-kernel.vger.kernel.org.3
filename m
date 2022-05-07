Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A57F51E838
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbiEGPkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379343AbiEGPkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:40:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2941631;
        Sat,  7 May 2022 08:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F08B80AF5;
        Sat,  7 May 2022 15:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C999FC385B5;
        Sat,  7 May 2022 15:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651937788;
        bh=xszih1+Cq3Xjrwud28Q+7VWp3eMq4XebND2xzmMcLkg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IadLKrnIL0OyA/c6zj13NgHO347dnipgKE07v9OnbixpTw7JdBmYYMG+UTrrDMMge
         m/HM1iqP2tLbIhsqvTP9AKCeJZ+0VA0jrDfYRgWLaGwmZeq31mPK/66y0+hXtePJE0
         zVPbqFpzrO2/DYAvNr6S1zMZwgQ/bhVaG0B32x6F7fiPUSQuJiIbYo6HLAu/faEdlZ
         ycFYQnAOEGJyhC3DvS60t5fc1H8FKo8GChWgC4C1onc8ifkqZfSzmNItJxmmcqhNOD
         /aEYteEjCDnJ8nvSan7scZk/mRbe/gYcRgAGz3wn9ngbA133f5GWsnnqsLFKAe7boj
         oKk+5WsGu6fRg==
Received: by mail-yb1-f181.google.com with SMTP id v59so17657514ybi.12;
        Sat, 07 May 2022 08:36:28 -0700 (PDT)
X-Gm-Message-State: AOAM531bgVyVeByqXsTeCwfAWL3hLI4BhdaK8mb3jPWO5OgpoRy1QacR
        +dpsvGmVf0Apo9y8VjbnNIHsK1nDaXGCI8TE0g==
X-Google-Smtp-Source: ABdhPJxXklXAgapKtKHtY50KvylR5sWyT+dCgpaCeOO2FWhn2I/4IxcIBHR2wcvnENeeXMDw2Ndi4ga5jlg4qlEzM4Y=
X-Received: by 2002:a25:c842:0:b0:64a:9122:5ec4 with SMTP id
 y63-20020a25c842000000b0064a91225ec4mr4022064ybf.196.1651937787858; Sat, 07
 May 2022 08:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
 <20220504115501.3490-4-rex-bc.chen@mediatek.com> <eb3884ac-56b2-4c37-05bc-82e8e44b22d2@collabora.com>
In-Reply-To: <eb3884ac-56b2-4c37-05bc-82e8e44b22d2@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 7 May 2022 23:36:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-z0buFJ4NRSiEZ9mpSzN7dFUoJYaD8r+GRCFs7cF06_w@mail.gmail.com>
Message-ID: <CAAOTY_-z0buFJ4NRSiEZ9mpSzN7dFUoJYaD8r+GRCFs7cF06_w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] soc: mediatek: devapc: Add support for MT8186
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        runyang.chen@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2022=E5=B9=B45=E6=9C=886=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:26=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 04/05/22 13:55, Rex-BC Chen ha scritto:
> > Add devapc data and compatible to support MT8186 devapc.
> >
> > Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
