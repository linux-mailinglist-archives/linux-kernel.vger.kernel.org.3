Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD8530FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiEWMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiEWMzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:55:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606E65372B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:55:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ff53d86abbso127623207b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eDfy6GqpIfaV2D3gJJczHKjLm3vz3xNZVsVwjBEGHAk=;
        b=XIWqezSV7/NwqmML1vVCi0to8RMc5lNXcUXL3XQPhELyW8dZA2LQAyULwEy2suR0zv
         4uTa57OMPSrjxlJqoLkarNGhJ1s2VlBJHr5Uohuh1UK6t+KvLBJSqGqaCgIGBe6X6HX8
         7EHOYuIukYNOkAEzGhpUyQKgCZKhz5RSMLdOGlJ9aY51zDwLPbPeL+Vy6nmgi+bRbXQw
         3kebQnfjJFdKtMuPHRc7tdKjjPxjL0mvrk9LkQwzKO1nlGQTAJZ0dZ3dc7/K6MeXf6qy
         uJuqKW2ViFJu/C7jbivSInZuS+x4nvyloC8O9pwsFF9ffZlwoceQ9Trju2vJlwI1h+4O
         kcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eDfy6GqpIfaV2D3gJJczHKjLm3vz3xNZVsVwjBEGHAk=;
        b=PqOVdgEGOLxhsZCZsq4tPkf72U6x6qRicyzrNfGKH95ip26Ga5vNLQkKqKFmXaH4ap
         uOdWkvSymdAq8gFf4WNAktWbC1+Ds5t7cm9jkjK/ReSdjmkFNk6XAVLmBcflx+K/jURV
         z2tODy0hvOSzJLg3Z1OeQaclUjA9gzlZIVEXKOXzG51wEl7+5VTr4pXS8zYFtZWHX17D
         c2pFDNEnAJHBzUZ0uxBFxhuNEFJsVo537M3F2eP7HGlbSK+lXAw2/IODjKwf5VJf7rAc
         uW2LINpAgc1MqctvZihtk+bW2gfraWKZeX6irrOmIw/jB1GbwO/X4OAy5t1W+JEbtDvn
         2Bfw==
X-Gm-Message-State: AOAM532hx/ve86L+VmtXU6rwRUv6vWhhZJnXy1LPWOZWWGzM3qOK4lU5
        kBr1+4OWP8o5yKkMjg9qiReRiZ9Hj8wEiixwloO/9Q==
X-Google-Smtp-Source: ABdhPJzy078pPsAixd7aoHZE4fZKF4ic8N0z/2T9Yw3r8eUBViOKz7NYD0OqMiHkS7D5dBNqQ6QLB2GiEpY/njCXIlo=
X-Received: by 2002:a81:c07:0:b0:2ff:8a7b:f37c with SMTP id
 7-20020a810c07000000b002ff8a7bf37cmr15476962ywm.118.1653310510641; Mon, 23
 May 2022 05:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220506123246.21788-1-yuehaibing@huawei.com> <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
In-Reply-To: <CACRpkdZUwfVNZyS6RgcupJ+TRUZVM+1_3ABj_-f_3+v+wNE6mg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 23 May 2022 14:54:59 +0200
Message-ID: <CACRpkdaKrk+cj9Yvpe3kmR1iJFczi-yckHiKeLGu9F=hRFiU9w@mail.gmail.com>
Subject: Re: [PATCH v2 -next] drm/display: Fix build error without CONFIG_OF
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, tzimmermann@suse.de,
        dmitry.baryshkov@linaro.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 2:46 PM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> On Fri, May 6, 2022 at 2:33 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> > While CONFIG_OF is n but COMPILE_TEST is y, we got this:
> >
> > WARNING: unmet direct dependencies detected for DRM_DP_AUX_BUS
> >   Depends on [n]: HAS_IOMEM [=3Dy] && DRM [=3Dy] && OF [=3Dn]
> >   Selected by [y]:
> >   - DRM_MSM [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && (ARCH_QCOM || S=
OC_IMX5 || COMPILE_TEST [=3Dy]) && COMMON_CLK [=3Dy] && IOMMU_SUPPORT [=3Dy=
] && (QCOM_OCMEM [=3Dn] || QCOM_OCMEM [=3Dn]=3Dn) && (QCOM_LLCC [=3Dy] || Q=
COM_LLCC [=3Dy]=3Dn) && (QCOM_COMMAND_DB [=3Dn] || QCOM_COMMAND_DB [=3Dn]=
=3Dn)
> >
> > Make DRM_DP_AUX_BUS depends on OF || COMPILE_TEST to fix this warning.
> >
> > Fixes: f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus su=
pport")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Patch applied to the DRM tree.

Nope, failed:

$ dim push-branch drm-misc-next
dim: ac890b9eeb9b ("drm/display: Fix build error without CONFIG_OF"):
Fixes: SHA1 in not pointing at an ancestor:
dim:     f5d01644921b ("drm/msm: select DRM_DP_AUX_BUS for the AUX bus supp=
ort")
dim: ERROR: issues in commits detected, aborting

I don't know what to do with this, sorry. The other committers are maybe be=
tter
with this kind of situations. I think it is designed to stop me from
shooting myself
in the foot.

Yours,
Linus Walleij
