Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06CE51E831
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353433AbiEGPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbiEGPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:39:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372619024;
        Sat,  7 May 2022 08:35:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53704B80AE5;
        Sat,  7 May 2022 15:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1104AC385A9;
        Sat,  7 May 2022 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651937746;
        bh=5JdWStqnLHVOx/3OlLYMVcxQ/dWOc4viCFvQaLtKBWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pjBDxRKcm19ggHCT3GT0gO97hf7JMvQEn4r8VlkDTogfba8iz4MuCfZLMDAuvQCQ0
         Rg4G0dHTJIK+zNkhSLi7AI9kK/HSudOMYkBii0A02exRIRv1UZdZT1gOO5FtS26TK4
         r1geeG28gGHRgxOuQWB3YgHUSk06tt7cDV6EbXQF0/xr0HhqyNbzCU18zmWJ2JJGJm
         oz/gj8GbeCU4cmUMNaR9h9LyQej5J19zUGknAOv+gI4L8a8LaTZJEZ8KKOIGYxxpFM
         1xtTKnqMAXzRXuT8t90mEjy4OATW/So6JvefbePD5upGqf4oUM2uBMmKG9ZN6MmF7s
         +gtKvGrUVV6XA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7b815ac06so107980507b3.3;
        Sat, 07 May 2022 08:35:46 -0700 (PDT)
X-Gm-Message-State: AOAM530dopUEVxh/5DksAPMEXH0CptQkqpE5TpT5fYPQOv0uh3ICnTR/
        iGezR8fpuyRs5MRF6f57h0qgB352OVZTnJ1CQQ==
X-Google-Smtp-Source: ABdhPJwDhtthoa7AUtDJmXtXr6BoSIIvTt63knY9cK0lyKPgCmY+/9linfuCKIw9ocYEdDjBwqTrr0a8d1n7WjOKuDw=
X-Received: by 2002:a81:3214:0:b0:2f4:dc10:33ba with SMTP id
 y20-20020a813214000000b002f4dc1033bamr7214015ywy.3.1651937745103; Sat, 07 May
 2022 08:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220504115501.3490-1-rex-bc.chen@mediatek.com>
 <20220504115501.3490-3-rex-bc.chen@mediatek.com> <7a4e7d71-4460-21f4-35fa-d3b11559785b@collabora.com>
In-Reply-To: <7a4e7d71-4460-21f4-35fa-d3b11559785b@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 7 May 2022 23:35:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-5QLEYyqqiw6WtepHrykXJgatUyxLMYU+61P-21CBVZw@mail.gmail.com>
Message-ID: <CAAOTY_-5QLEYyqqiw6WtepHrykXJgatUyxLMYU+61P-21CBVZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] soc: mediatek: devapc: Separate register offsets
 from mtk_devapc_data
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
> > The register offsets is the same between MT6779 and MT8186. To reuse th=
e
> > register offsets, we move these register offsets to another structure
> > "mtk_devapc_regs_ofs".
> >
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
