Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE951E848
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385852AbiEGPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238979AbiEGPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B15F5F;
        Sat,  7 May 2022 08:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A29612AE;
        Sat,  7 May 2022 15:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9DC385AC;
        Sat,  7 May 2022 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651938382;
        bh=ej+1y2QDextem2vuVEnoljWBiUbRONI85ImTVfv1aqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1dcXnMAUm+znj4YMNLasYZDWIDhqhVgl4H0TeZqAOkw2TsJA6NozOFiiWHmLY3cT
         GEIZLF8detnZR9nQLB+0DXWJl06fvGzEXgGmXQD6JgaBPeYsiYAlOUcUpXYlw0dMUv
         wtJBS4lfazFQzH7dWXKXuOta0Yn6NOb1EJ686fvDDf2wApYxT5T3hBfi7W60Ei7zye
         8MBd+iLjSJFLXKXzDD98Komf53gQM56TfE//S04c8DOjzffdkx6tdSwf9a7JO/WicQ
         dA0DxX/2tJy3d1R7rHK9eVKkZjgptD38RBcChyahCm6vIYb1E3bjR+KyWoWdBBeLNA
         GbacFwb0CY0Jw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2ef5380669cso107882897b3.9;
        Sat, 07 May 2022 08:46:22 -0700 (PDT)
X-Gm-Message-State: AOAM531qvqOJwwmN5XaatCPj04NtcgXf3EbNpGQJfjyv/1vya0W+zBOm
        B99szLxymtu9Xz4jmK6hecdbd3+3B6bBdzIv6g==
X-Google-Smtp-Source: ABdhPJxIPKZ2rC3PS1X9eqkb62LYQlQ1NxMybmJSYErvxb81ifXvir0lP/7H2a42abesQ1FVjH9jRmBJasjY1ZaaS+Q=
X-Received: by 2002:a0d:ddce:0:b0:2f8:c9f7:8f7c with SMTP id
 g197-20020a0dddce000000b002f8c9f78f7cmr7317081ywe.301.1651938381918; Sat, 07
 May 2022 08:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
 <20220429065429.7957-2-rex-bc.chen@mediatek.com> <276ef83c-c824-3874-c36e-4d422794d7dc@collabora.com>
In-Reply-To: <276ef83c-c824-3874-c36e-4d422794d7dc@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 7 May 2022 23:46:11 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-XQXe3aarTgVmnFoU84qihr+trFtM_f9+csgZ69qnT9A@mail.gmail.com>
Message-ID: <CAAOTY_-XQXe3aarTgVmnFoU84qihr+trFtM_f9+csgZ69qnT9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: mediatek: devapc: Add bindings for MT8186
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Neal Liu <neal.liu@mediatek.com>, runyang.chen@mediatek.com,
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
2022=E5=B9=B45=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:53=
=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Il 29/04/22 08:54, Rex-BC Chen ha scritto:
> > Add the dt-binding to support MT8186 devapc.
> >
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
