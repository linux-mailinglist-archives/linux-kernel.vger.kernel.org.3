Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A195953B4DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiFBIS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiFBISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:18:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE1C15
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:18:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d129so4140411pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9x70fvT7190YbXzYteL9ewuvFT6uvelNfhT9PEGH0Jo=;
        b=l3pImPs02AnbeW4PG6d/LLREKZDDPuOgmTR7BZEc8TFrQLuOHeR5H7dBdjLTSUIMJq
         MW2ss1m0nACsyV8pT5yo14DvK6odeFduMzd+hFmR1X1ymeFIqUba+q7gQJTR0O5fx8GV
         YM+SaHyioTlula8sifqJ+/RZtFC0G12A0gP5mvZWZaf/WAJR34YssAkGLHRRsmeEBkDo
         DA28WTc89C+tVtCBx00I3whLNqR7i/sRfb8gQXMJVJUy0Ph/565BWG+474XPruA6OGrO
         awIKjmmKhQn/Psondu1fRyAWE4+XSImuJR99/VLdvbNnq1+DjQTBL7rkbtEuN5joZi8D
         2W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9x70fvT7190YbXzYteL9ewuvFT6uvelNfhT9PEGH0Jo=;
        b=nZMExs4tMh+tdvupoGGriLrLzlJkj4rVAesR0Phey0sw5oKvpMuTyEmD4ohvSIsTyY
         SdpZLlFJNjNP0cFkNs/qcXnoLQrAhkev8eoJ0VfIk6/aGRNJi3XcQFR+4jD2Zs2EAu2n
         fLYZBXXMR6C/0DvqN8mK5I7ToW/zjmCb/Ht8LtSWz/OD1uNMK/EvV9RaVeCU+25sQJpk
         E3Th83XWF23fEpng3M7LfMwl6tqVvJYRkGJZK/fCbnywvNuD3/bXmsXq8WHAdV6R0v9t
         HFQDf3AMOGSXFozQZuAzWuRZQlrJ5nByF8i3ZLRlCczAMNWuM32E8l+D36iX0tMOt9Ft
         UDOg==
X-Gm-Message-State: AOAM533SerwD8x7tww3StSfxDVcsfzbnCTcky4DV50DaDNUm0eDurAVW
        DNllknnLY9fKqe1kRfpJ82B/QtFBSvcMYnFj28HL2uDsHYA=
X-Google-Smtp-Source: ABdhPJyG4+cUsja7ESmtAXhM7XYcDz7HxGU78eyY7PjZw8CmobXFOmEGx/kKArbjttnCiuftnEG8a5gfQ6QWrpsd1JI=
X-Received: by 2002:a63:8749:0:b0:3fc:9fd7:1e20 with SMTP id
 i70-20020a638749000000b003fc9fd71e20mr3253985pge.619.1654157932832; Thu, 02
 Jun 2022 01:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220505080954.84416-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220505080954.84416-1-jiapeng.chong@linux.alibaba.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 2 Jun 2022 10:18:41 +0200
Message-ID: <CAMeQTsZVaqw8oj+Ovk+jbKK83XJ10e4XdE7=ibHBRs=BcE_v0g@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 5, 2022 at 10:10 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Eliminate the follow smatch warning:
>
> drivers/gpu/drm/gma500/cdv_device.c:250 cdv_errata() warn:
> inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Hi Jiapeng,
One entire patch to remove a single whitespace seems a bit excessive.
Would you mind fixing a few more of the code style issues in
cdv_device.c while you're at it?

Checkpatch can give you a few hints:
./scripts/checkpatch.pl -f drivers/gpu/drm/gma500/cdv_device.c

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/cdv_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
> index dd32b484dd82..09684c42cbf6 100644
> --- a/drivers/gpu/drm/gma500/cdv_device.c
> +++ b/drivers/gpu/drm/gma500/cdv_device.c
> @@ -247,7 +247,7 @@ static void cdv_errata(struct drm_device *dev)
>          *      Bonus Launch to work around the issue, by degrading
>          *      performance.
>          */
> -        CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
> +       CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
>  }
>
>  /**
> --
> 2.20.1.7.g153144c
>
