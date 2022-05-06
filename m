Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5351DE9C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389015AbiEFSIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388946AbiEFSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:08:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9BC62BE6
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 11:04:28 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c12so2094348edv.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 11:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6cV3MY08Q5J5EMqd7RYTn/K8x3EoQFULKeiQvTiDEg=;
        b=T2HDqLM0GDt44cOJq5nd/iZFwFe1nypV9GZH3QUrdg9Kzx3Cu242a610phGvfuyACC
         YjCrruvvXl6Wj8zAKANgpfjxzm74bIibd0RK+vOzDhlyICWgQztSY0d9A1KwMt2x1YYS
         5n7z1HFAbOkVNrCvKtGhcvdCF9Rg9OmAoACykcvr5eV5pcoqHw2R7ZI8d+l8lmBKVjQr
         zG2T4IIyMfTz4aK4Q9RfqMIz5PLSfiZxu0A1WJEWvpVWc44AnUVHrJ22U7zxiY2o56pC
         BMLQkBtp0YhKo9aEdwpcc+yDCxjUDM+k81sCwyBFxlvuhcU6nx/Ie34KNcM4CWWO1US3
         mzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6cV3MY08Q5J5EMqd7RYTn/K8x3EoQFULKeiQvTiDEg=;
        b=XaQUhb2hr8xTHNpky6rOVsCF6mQlOKHVVN8YANXt/1HPpKH/NokFvq5bjq0/ucwrMt
         GmTSCETX+6myS+8wgT0b6E7wYxDPwUA5Y8oieBB12O8IHabiFVAR23kU0OK6+ObWGiN/
         zHYFKF4g3Yip+EIJw+YwXAdX4FnYP8jQ7U9zBIEh2rWp4BNVILH+8BJo2zdLD5RY6BRN
         KVPHOQ7Imm7o/opsLgv9PjVF1c1rDQ8kbXTPWk6qTf+rMLOVufIjzMtVORQZ53CIdDCf
         suV5ZS5SRgplF5VAIEbMf6ExtDW0sZY4ti0AWypHbJ+p8DIbesxQdcJnVj65+0I4uULH
         81LQ==
X-Gm-Message-State: AOAM533hQrJyyLNXv+W4vbmRUdJZ6efdzhVq7CcESagdTosobPqyt4wb
        boyCMuhYgCcOn/8UPJsbAUIwyCg0ZyGvS/4IEEI=
X-Google-Smtp-Source: ABdhPJwXEqZpCx25tK13QTqbjFhsfW3K4TjOOqyGoUK/Rt7XPD+Wd9WrJFUT7OGgDT/FLCXxCU2lkTuCiJ3xVZ4VuqA=
X-Received: by 2002:a05:6402:d52:b0:425:dda4:b676 with SMTP id
 ec18-20020a0564020d5200b00425dda4b676mr4595071edb.277.1651860266859; Fri, 06
 May 2022 11:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyaQ8RSYwuh4muEefV3fbjio5gVvYipWVaKjqUycRkS+A@mail.gmail.com>
 <CAHk-=wjtEptPBvJtdbezMLJh6k3O7Y-on=tbC31z4e+ksLda1w@mail.gmail.com>
In-Reply-To: <CAHk-=wjtEptPBvJtdbezMLJh6k3O7Y-on=tbC31z4e+ksLda1w@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 7 May 2022 04:04:15 +1000
Message-ID: <CAPM=9txZv6tvFxQptYdwdyeyTs+rUZmm9K_D1f+4SFV_bOb-KQ@mail.gmail.com>
Subject: Re: drm pull request (was Re: )
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sat, 7 May 2022 at 02:50, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 5, 2022 at 9:07 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > pretty quiet week, one fbdev, msm, kconfig, and 2 amdgpu fixes, about
> > what I'd expect for rc6.
>
> You're not getting the automated pr-tracker-bot response, because your
> subject line was missing...
>
> Just a "how did that happen" together with a "here's the manual
> response instead".

I just forgot to type it in, I send the email from gmail manually
pasting in the contents from the PR.

Dave.
