Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDB47B02D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239805AbhLTP1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbhLTP1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:27:00 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E9C08EB1F;
        Mon, 20 Dec 2021 07:11:16 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z5so39666392edd.3;
        Mon, 20 Dec 2021 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBIoGw/e/zcvG+pHiU6S4HSaNOHwibSXXHgdcOqKpt0=;
        b=g5w3zq2NJj7FJNKB6S4eRDs8mFKJE6NotK7FF6GXMEgZ18UwBT107QQbz/ylRJ7XAD
         rxMXVmWZocz1dWweCJ2U+MWs5LfN2YOXXpHQ6R7YVX5Ap6+8XTiet4rQbNbnW3nowwVS
         8N3oMITPRhSHD2f7ULqqZ3trHI9x/5BuskLxk0KwxbygoH3ALIDkpcUmyg5RMTzRvGHh
         yJPWWLUNnGQXmUvhgp+o3fwjdRsRwO37RHPCmyC3K0n8P3fhLxW5ZcrZ8dqdALg1cNZN
         3tFRVXQDd6/az+dttSn69qu74M70HGJj0fpJpn/KayqQWWY0VpUau1OGGvvFa2CIThk3
         G+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBIoGw/e/zcvG+pHiU6S4HSaNOHwibSXXHgdcOqKpt0=;
        b=M4Z6D2R37WqYrdEc4PdJtZb2FEj53mcIJM3dll0GH61st0/LI8DB4eL2dzMUfCrjH4
         G8X4bmzH5NM6zQ1mBylel0K0cQrJWMPMYgxPLfY9wramDGTabByYr4wfLPQAjhWEr+Tr
         4XzYmFPyP4f1h+gGqRPgF1OScHhRqBNSILxErfUtL6GTUgJn2AQTPpB+gLlPX6LhQ6Mi
         6XcRl1AIJPROTIJmzl6abu9MmjNYIg/4jDjt8zXG1ny9racmdrinuox0S/AbmK41in2y
         G304VEcdxUNYw/z09k9UC3D82Ixwhad1Zpk6mCBgwlRaxQfG5uIu4UMOtX/56xfQ6Q7z
         9drA==
X-Gm-Message-State: AOAM5329OnYupZ1heotXo4kC6Vm26L8VLSKcqtdHWdLXIJvtCtsOHh3x
        zEQLvUIfhxIxY5JtqdJl8Fm8pFYzzMsoLrk2iYU=
X-Google-Smtp-Source: ABdhPJwNPdlFiyq6tdH9hFgzAwymj19tpiQ0KxZM4gqqznfenD0pSWIWIRrWm9wcb1jCZbCyqF5YMjt/cuc4WnfY9lc=
X-Received: by 2002:aa7:c7cd:: with SMTP id o13mr16731637eds.37.1640013075412;
 Mon, 20 Dec 2021 07:11:15 -0800 (PST)
MIME-Version: 1.0
References: <20211220132439.1194-1-andriy.shevchenko@linux.intel.com> <CAMRc=Md3bpCJe_eFBjiKuhCRO_xqnFxSc1sw100fgNmajy6gaw@mail.gmail.com>
In-Reply-To: <CAMRc=Md3bpCJe_eFBjiKuhCRO_xqnFxSc1sw100fgNmajy6gaw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Dec 2021 17:09:15 +0200
Message-ID: <CAHp75VcbaYXfDpc7xE=asSqUspscRoHfqrg-yMtx=uo5UNqxfw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused local OF node pointers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-unisoc@lists.infradead.org,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 5:09 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Dec 20, 2021 at 2:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > After the commit 448cf90513d9 ("gpio: Get rid of duplicate of_node
> > assignment in the drivers") the OF node local pointers become unused.
> > Remove them for good and make compiler happy about.
> >
> > Fixes: 448cf90513d9 ("gpio: Get rid of duplicate of_node assignment in the drivers")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> > -               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", dev->of_node);
> > +               gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
>
> This is unrelated though. Can you make it a separate patch?

It actually makes use of the local np IIRC.
It's related, no?

-- 
With Best Regards,
Andy Shevchenko
