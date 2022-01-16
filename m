Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0448FF8E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 23:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiAPW4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiAPW4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:56:34 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03653C061401
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 14:56:32 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id l15so27237582uai.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoNGsI8t9CKq9IrvZzRuVSXMlGhPFmiiFSrtj2O8/9c=;
        b=edEueIJkIJgD+FVRZVSErl/RrTCHzHISK+zmIWd2KEJJLLrrQ4pWHF3B4Xl+YL6Z8W
         xa/k7hI2SfrXb3I8oqciFeiPkA1/lx6GFtTgiUrI/QxQY+CiPiKXXSjZ7Uq8qk+Eum1y
         fqkgtHON3BTP+qumA+cXhGMY2fR536+bjL42EUa9NwQl5zBVCYPk4Ruy/6fxKP8wFnDZ
         4LObgTLG47jTHOZxeSaDGvdod+ENGNsejsYBdGzPUvnrKEY9uoT1ejqsr9kPD4KUjr95
         061ZXvtMBMNzWvY+Okazl1sPYM1XEGl65PX3yPilWaH9T5h+9I+ae9XCBR3zUWPCa3Kh
         d/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoNGsI8t9CKq9IrvZzRuVSXMlGhPFmiiFSrtj2O8/9c=;
        b=h9MGa3sHDpPPqM89hDpmF3aDsRnjy/4WngmnpgknNsX9Ua6IYpjcDjHEkYjVsTx9uA
         rnaV1bApIV3YHxhzEdWLv6w2mtglceiekuULUW2DHFbsdm8i7b82Jm+bz38aekATsEOb
         wtZERmoXYl3ZdtoCrnXt6hAweGarasFkVxmvuwkFzaJ3jR75CyQ610+tUUhn3vYK92dp
         o8xl5/hImylhmno4fOf+i7BJH57CngvlaNXGAYHn9PP1NZVmRUxAkNG5Tvz/6d6mdu6D
         EQUr5Wca+Uq8lD86rUzhvoNJ9QEZ0W2p5FoEYKVrCYbzTj9Wek8R9eD92XVsmFuwrUsy
         ndGw==
X-Gm-Message-State: AOAM530y3U+7QVZL+ZJKIl/0U0JCWwdOJVk02S8c1qDQsRCM9Xzy+a6x
        jLLnPT3QKgLMuewqPfBS5OXQvdGgjvBvR3lGeyFEYA==
X-Google-Smtp-Source: ABdhPJy9UAd+MOlNIZaT/jQ4i3oLvxIDYWUmVNyCXKO0pCFBXQc3Kudi4chx6kOD5MBWwigIo8LDL1EP2gf4qQKt6UE=
X-Received: by 2002:a05:6102:108c:: with SMTP id s12mr6823947vsr.20.1642373791020;
 Sun, 16 Jan 2022 14:56:31 -0800 (PST)
MIME-Version: 1.0
References: <3c0087a9-5c3b-d665-136e-6110a0482775@canonical.com>
 <CAPLW+4nrPKA66GrF4XukyHWHJ=wBycjyK3ZPLCofEFe-VJ9wWg@mail.gmail.com>
 <06320ea8-9297-1e90-dafd-978f73c22fff@canonical.com> <CAPLW+4=xD5hM_tYDD+kwqkiVq5h0tjO+7q6Akbd6iO_Ou-g=0A@mail.gmail.com>
 <1a09cd4e-71da-43e6-9732-33d704e1744e@canonical.com> <CAPLW+4kEQYrTvMwodbha4SV9mDS36sjxdsiCwVQptmoShb_5hQ@mail.gmail.com>
 <e966dfb3-0f90-68fe-f27e-caeda2abf0bd@canonical.com>
In-Reply-To: <e966dfb3-0f90-68fe-f27e-caeda2abf0bd@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Mon, 17 Jan 2022 00:56:19 +0200
Message-ID: <CAPLW+4moXyd7bcsxw340-GFWj9TD=R7BLj1a9em5JG2A+iik4A@mail.gmail.com>
Subject: Re: Exynos850 and ExynosAuto v9 pinctrl wakeup muxed interrupt
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jan 2022 at 19:15, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 15/01/2022 21:38, Sam Protsenko wrote:
> > On Sat, 15 Jan 2022 at 17:46, Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> This would mean that my dts patch removing all interrupts for alive and
> >> cmgp was correct:
> >> https://lore.kernel.org/linux-samsung-soc/66754058-187e-ffd5-71ba-4720101f5d98@canonical.com/T/#mf0b06ebdac554d57d8230dc546c3d57d59d7bd6b
> >> Was it?
> >>
> >
> > Yep. But patches [1,2] I sent recently should be probably applied
> > before yours -- they belong together. Please take those in your patch
> > series (when sending the next version).
> >
> > Thanks!
> >
> > [1] https://lkml.org/lkml/2022/1/14/861
> > [2] https://lkml.org/lkml/2022/1/3/680
> >
> >>> Will send the patch soon -- please add it to the beginning of your
> >>> series along with my other patch I already submitted.
>
> DTS and driver changes never go via same tree, so if you say there is
> such dependency, then my patch should wait till another release so your
> driver change will be in mainline.
>
> What is actually the dependency here between my patch removing incorrect
> interrupts and yours:
> 1. removing EINT for these GPIO banks from pinctrl driver,
> 2. adding missing GPIO banks?
>

No dependency really. I just assumed those can go through one tree,
and it would be nice to avoid error messages to appear between
commits. But those errors are actually already there anyway (just
masked by the code you remove), and nothing is broken functionally in
your commit. So if those patches go thru different trees -- no harm in
changing the order. I'm more concerned about time needed to get those
in mainline. So please send all the patches together. Sorry for
confusion :)

Thanks!

>
> Best regards,
> Krzysztof
