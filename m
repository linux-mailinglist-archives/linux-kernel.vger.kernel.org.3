Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887E457DB19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiGVHUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiGVHUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:20:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC035D7E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:20:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oy13so7129554ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouSSdITZq0FsaMVncH1X0sX6Yphj9Cjyf72zkTGekO0=;
        b=bPYF3z0YzAGpQX9WgEBtgnp6WiDyVCcYK9pFLbm2x9uoNu4SrZJg153jrQrjKNwBLK
         KnCjXGj4hxLR86UZDs8B1FF+a37Wd9Y2DWSooabAQgmz+Js2vAgLrdd1t06GTBAdFSyu
         +9fhHvL8lPlBs/BcBn2LJv8Y8dlJwkoOYnx3w2lvOHCzhvc5/MOhcX6GHAFh22gcTlsJ
         K/tS/fdrmn28u5U2xuNwNH9KjUs+9/zhA+jDHVEiLhiqG8ZgvHzf7onb+IGq0wn1xX9A
         fFqlCw29sIdFMT1OHKBHN8ZorrcwqFBD9KaT74K/zqx6fIJaaG0J6dUO4IcU+cWP5UqN
         PEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouSSdITZq0FsaMVncH1X0sX6Yphj9Cjyf72zkTGekO0=;
        b=l1whsZL3u5nmqVhT95yUlGkcOZkdQCcAtbB1SE5j4oRDevoVYhQkJoXIpO5ritjUme
         vw/1xvUS+PJ88X0dZXiAylO/GZXCjUPVJ7/BgiQHg3W62vBBXrZrMAz98/SHjfuBDyyU
         9HxF12jcM+tKsdL3494rJhk+Hcm58aB9MVzRrgaInQ+/WZmwtpCcBADdzfGBPiP5Dei1
         TdSFJ9io6TDcYqVLIJMs2vfA50FRrzJQZqGwz4nbJz5xz+Vut82KPcZGe2mk0ChfmLzU
         gl3s1bLsL1LVL/Ze6dOXOj6airSBCzeWn6PXZLHuBFsGVZaKZZTm+wgQOojmfZew4X9p
         j+Lw==
X-Gm-Message-State: AJIora/NP3EO/587e+z3W11flXtrItH+mSGSAs44Uf35kc9zRrj8Vkmx
        GPLndIjvdC14QT3Spn8bxkdLiQ9aMomr6Nqy6c5Olg==
X-Google-Smtp-Source: AGRyM1vaaCFD7cdmMQ6HjkruGEujivTRBWp8780hsCXuLcgaXUNWfcvbAmpbQv+nwnM7DI/pHZJH5TtPuyiXiEigPak=
X-Received: by 2002:a17:907:1c0a:b0:72b:378f:2fa1 with SMTP id
 nc10-20020a1709071c0a00b0072b378f2fa1mr1969373ejc.492.1658474401450; Fri, 22
 Jul 2022 00:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220721152508.3661-1-william.gray@linaro.org>
In-Reply-To: <20220721152508.3661-1-william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Jul 2022 09:19:50 +0200
Message-ID: <CAMRc=MfmykYAnBzhFO-XQd0j646gDHNqdUZyAivQbgFtwY5Dig@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update Intel 8255 GPIO driver file list
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 9:15 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> The drivers/gpio/gpio-i8255.h header file is also maintained.
>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960abc07304e..2bd82ce171ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9907,6 +9907,7 @@ M:        William Breathitt Gray <william.gray@linaro.org>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     drivers/gpio/gpio-i8255.c
> +F:     drivers/gpio/gpio-i8255.h
>
>  INTEL ASoC DRIVERS
>  M:     Cezary Rojewski <cezary.rojewski@intel.com>
>
> base-commit: 949506dc608f9820e0cee51b106c35fd3503bbb2
> --
> 2.36.1
>

Applied, thanks!

Bart
