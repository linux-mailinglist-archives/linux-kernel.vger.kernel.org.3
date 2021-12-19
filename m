Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF856479F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 05:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhLSEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 23:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbhLSEIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 23:08:53 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F0AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 20:08:52 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id s144so4069506vkb.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 20:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzP3Tp0AphEvmykMrgQMzrR3Qf/LWzjoW3P1IKbZm0g=;
        b=vrm6BpP0WKqCQONwmdZb3wFKOHnNswIO28257SwMW+4jk1CCzutSs1jyJcRzyp3jkz
         p7ViWBaAkAUaf0yrj24an3ip/fuhdmqKB89vplFCmof1eTyQO7em7ZTEYhOC9GtNllhq
         PKT1ULwSnAhu+jYjQy6yZML09r2hVBVQZNYVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzP3Tp0AphEvmykMrgQMzrR3Qf/LWzjoW3P1IKbZm0g=;
        b=GvM9mKtOeyNgUOjZ2J6AAfsuyJxABTQOKYSD3aPGo0yim6NqtMtMaVn94NxbPe8N3X
         vR5D+5M0jRH3pUc6LBlgsVV5iY7IRSuAdZ4JXmmFdvF+M77DxryEn4Js7J4yS+jtFLRQ
         CBhQlMJ4oRg6w+WhX0PJ98mdWkjoT836rDV8W0rxYhFLa8flg3CXviVJPe6OTtBHKHWM
         BUPW9h7upN29hKNBHCfK6FR6U/qnubuVb39XGec4xS291NRscM3P5VKJ4pizNf/vz186
         D4GTKJuflCDCbVVtZXXwa0sHS/QKbMEpK23ZCsWq1OS3K3ipViIW60xiEniD/r2/E+Sd
         7ugw==
X-Gm-Message-State: AOAM533t6Eh4G5l7sVRlOWTFAZXn/wFLMk8myl1FOWijfgmwkpKF/LF3
        /94Ueb+4YidV25qV0fH1ORa5Q7s2f076dbsX/GVaBQ==
X-Google-Smtp-Source: ABdhPJz54UP/JnsWT9Xj9GvOLNh0ciOdDIibZByO2ZIJzfqMLmbIq4DPIc84KW9ugoeNj7CdFM+smKuwgCIhwHFDlJs=
X-Received: by 2002:ac5:ca0c:: with SMTP id c12mr3813624vkm.34.1639886931827;
 Sat, 18 Dec 2021 20:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <CACRpkdaLt8O4ONZL0vY44gMbuSR_tT3Gkbh9f3sg7m23tUKO2g@mail.gmail.com>
In-Reply-To: <CACRpkdaLt8O4ONZL0vY44gMbuSR_tT3Gkbh9f3sg7m23tUKO2g@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 19 Dec 2021 13:08:41 +0900
Message-ID: <CAFr9PXnjAKw_ex=O7wjtHi9cOrUrPDVegomCKBCz2zL801KnFA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpio: msc313: Add gpio support for ssd20xd
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, 16 Dec 2021 at 11:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Dec 13, 2021 at 10:40 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> > As suggested by Linus I have dropped the DTS commits that were
> > in the series to add a usage of this code to a target.
> > If possible can you take the first 4 commits for the GPIO driver
> > for me? The final DTS commit will go via our tree.
>
> Looks to me like patches 1-4 are good to go, but Bartosz
> must decide if he wants to merge this late in the development
> cycle.

I'd like them in 5.17 as we have a ton of DTS updates that use this
stuff to wire up LEDs and buttons,
but if that doesn't happen it's not a major problem.
Some response from Bartosz to say if he wants anything done before
taking them would be nice.

Thanks,

Daniel
