Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C0248AB36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiAKKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:14:53 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:44813 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiAKKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:14:52 -0500
Received: by mail-ua1-f49.google.com with SMTP id l15so17242873uai.11;
        Tue, 11 Jan 2022 02:14:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WC7G6vkWzKe7686M1twI77VkZDIsn5dgTzG4HQCrkC8=;
        b=apLqzgVN7TqCMGSnMT8TFDohQdEisJxTJA40CyofJ2db5RGaYCmk5F9sK54TAWBqCP
         RnPrUUjMP2ZlFkt8rk4HcqQBgcCwsbLRBlU/4eXI+ZXDQz5wVyxY+hhv3QVHpsK2rZDx
         rEgyJX54VN57DFM8U91lL3YY7SvWJ4wHGr2K9Q6StFXLTmT7z7frfnVtEmUdTBKq7oXS
         epUYGp/zoExuz4apJ4EBKb965+vrV/YWlIUWu6F+bdZmFAJyAZrZzW8A6mM8ZQcr7agf
         PTJSMi99Ld/t0u6NGoKWwmsYtX1+ic3jPN4bbXI15SfYze3qJ+IhgPuyX3Ht162f6xSa
         77Ow==
X-Gm-Message-State: AOAM5332nSQ+Ux5YSuf7XFbPBZsaORKlhPd7cxNV3V0j2vSSSe1vkE3m
        ivO9t54HMw5iOJREWhZjQYMi6zTLV8aEdw==
X-Google-Smtp-Source: ABdhPJxu2FBL+CNRIadogtn9xPTxK7mkYG/b3cbLWUoHdsdgGnnzKINDqbdphcoJSXFey3yTUWfbdA==
X-Received: by 2002:ab0:59cf:: with SMTP id k15mr1560872uad.47.1641896091677;
        Tue, 11 Jan 2022 02:14:51 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id m62sm5545204uam.0.2022.01.11.02.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 02:14:51 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id 19so2254669vkl.2;
        Tue, 11 Jan 2022 02:14:51 -0800 (PST)
X-Received: by 2002:a05:6122:c89:: with SMTP id ba9mr290347vkb.39.1641896091170;
 Tue, 11 Jan 2022 02:14:51 -0800 (PST)
MIME-Version: 1.0
References: <20211222145901.23661-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW6wZLYGttKaSiX_ZknfGrqo5Z6mFBA6ZhqxURtzbaHCw@mail.gmail.com>
In-Reply-To: <CAMuHMdW6wZLYGttKaSiX_ZknfGrqo5Z6mFBA6ZhqxURtzbaHCw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 Jan 2022 11:14:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcZr0mXQFL6Q3Cu6rpU4WaM2tBw+N06LtmaD_=D00tSg@mail.gmail.com>
Message-ID: <CAMuHMdWcZr0mXQFL6Q3Cu6rpU4WaM2tBw+N06LtmaD_=D00tSg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add
 description for power-source property
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 4:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Dec 22, 2021 at 3:59 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > Add description for "power-source" property mentioning the values in enum
> > are in millivolts.
> >
> > Suggested-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-pinctrl-for-v5.18.

... with s/millivolts/millivolt/.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
