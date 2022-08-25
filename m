Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E55A1D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiHYXjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiHYXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:39:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5FAE232
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A43D2B82732
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F3CC433B5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661470744;
        bh=VUu5XtDzSApD4jLb7/Kt0DoXKUHclEkJ4teSyXFURGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rD8xvt2pteiCf7B0fVx16f3admXr98oUj03A6jJl33zd/hBrlyoBzEuf62ecPkzn1
         d0O2JYJRpVthX+cP8GQX4aDEhfPUPAGLYEqnMtUJQhX0X1ATcMMIbHcrG4u2ifqSd9
         AS2QUhvdNqdXaPwM/0ymaqSZjsCFX12KFHxcqPACKrSID0C98MAfl3L9Bcz8zRtMg+
         oOqcgpK7sC1h1V331+rE2xU0iTl1/hkYCD1QXXbYdkFujycqruC9LZuXmEvX4+ij20
         KAMSIQN2C19FDrJAHSwg9naMe0mux8v59pzsDyN6moWW9VoigbqT7oAsMdB/Y4YD8u
         NjkGnIHGUCdQw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso113081fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 16:39:04 -0700 (PDT)
X-Gm-Message-State: ACgBeo2SNGtP8pK4bW6uhrwPXn3iO+wqVZ29iR4OhSDnEQ4Ims/Y2lPB
        pR2/R19Lyj7QcHwbsYNlZkeBwlyG7iihw5GXaA==
X-Google-Smtp-Source: AA6agR4yMz40Tc+owCwkA0C1natVNZY/C/63StQqXp7qxYkhIoBcWs+BRlYcrECKpE6WFMhpawFp3BSWiY7+jb/YoyY=
X-Received: by 2002:a05:6870:4690:b0:11c:d599:4f41 with SMTP id
 a16-20020a056870469000b0011cd5994f41mr634922oap.69.1661470743518; Thu, 25 Aug
 2022 16:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220825072335.228921-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220825072335.228921-1-ye.xingchen@zte.com.cn>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 26 Aug 2022 07:38:51 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-oP0QOpk0Zo_VGrdBoUgn78PhXeYUr-WPvpVcAHx+rEg@mail.gmail.com>
Message-ID: <CAAOTY_-oP0QOpk0Zo_VGrdBoUgn78PhXeYUr-WPvpVcAHx+rEg@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] drm/mediatek: Remove the unneeded result
To:     cgel.zte@gmail.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

Hi, cgel:

<cgel.zte@gmail.com> =E6=96=BC 2022=E5=B9=B48=E6=9C=8825=E6=97=A5 =E9=80=B1=
=E5=9B=9B =E4=B8=8B=E5=8D=883:24=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value drm_mode_config_helper_suspend() directly instead of
>  storing it in another redundant variable.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
> v1 -> v2
> Add all the mailinglists that get_maintainers.pl give.
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 5f02f8d0e4fc..91f58db5915f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -833,11 +833,8 @@ static int mtk_drm_sys_prepare(struct device *dev)
>  {
>         struct mtk_drm_private *private =3D dev_get_drvdata(dev);
>         struct drm_device *drm =3D private->drm;
> -       int ret;
> -
> -       ret =3D drm_mode_config_helper_suspend(drm);
>
> -       return ret;
> +       return drm_mode_config_helper_suspend(drm);
>  }
>
>  static void mtk_drm_sys_complete(struct device *dev)
> --
> 2.25.1
