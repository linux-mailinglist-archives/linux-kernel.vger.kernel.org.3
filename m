Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7A483F25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiADJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:29:24 -0500
Received: from mail-ua1-f54.google.com ([209.85.222.54]:44653 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiADJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:29:23 -0500
Received: by mail-ua1-f54.google.com with SMTP id e19so16221368uaa.11;
        Tue, 04 Jan 2022 01:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUoXbVhVMYKDpJAJ6ZGooR6UYcia39qicQ7sK9A/xs8=;
        b=qT5sVKCOe4QJBSuS20dA8b8EAHmvZ6JuHFu/v+iu8QUN2UGafLaOswuLCxUUAIimhI
         Dt3NV4ELsUnFvO+CKSsvH2xnihZNGwj9FFijTuzSVf1792XrrN2Vcdz1DP9aBhZcYz82
         R7Fp3Dwbs0Y1VCfKumR3V6Em+eiR2BscaHN1IvMSF57ubknFwzZJbk/i51GAwZlKAnFW
         LsBwB2JpyvZZHuXsLrtUuiUwJNI4SFQNkHV+dh7KQ0UnpxnZjdKHQYO/lmoXhKaM0KlR
         n3AxwvhrqzHWbr1mf4l1+ZIcSO4GaptWAdedp9N4qV6jD45YjiE8fVFX9pdRfCj8BJvY
         nSVQ==
X-Gm-Message-State: AOAM5314R2PnTIkdpz2MDaiaRDjxIxp0clserH2dC2mi3rwqmUfd380M
        rd33DVJTAaWiuG2hMdqMABm/FlpyBAHF/A==
X-Google-Smtp-Source: ABdhPJxBN9dUkANKNIqcJeqU7aQtI4bWPKYq/GLNmc13niEa9/2lnW39UxeyQhrf8Hi+ir38qvMT5w==
X-Received: by 2002:a67:d39a:: with SMTP id b26mr14500630vsj.47.1641288562065;
        Tue, 04 Jan 2022 01:29:22 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id p186sm4903301vkg.13.2022.01.04.01.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 01:29:20 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id e19so16221274uaa.11;
        Tue, 04 Jan 2022 01:29:20 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr14495371vsg.68.1641288560266;
 Tue, 04 Jan 2022 01:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-6-daniel.lezcano@linaro.org> <CAPDyKFqWUJTKte3dM=7xG6EtKR8i9neCCNYFs7Jf1J34TezUEQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqWUJTKte3dM=7xG6EtKR8i9neCCNYFs7Jf1J34TezUEQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jan 2022 10:29:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXzs9WMksQAJXdYaQndsqK3CnQZTGYw=TSFVrDEdX8PCA@mail.gmail.com>
Message-ID: <CAMuHMdXzs9WMksQAJXdYaQndsqK3CnQZTGYw=TSFVrDEdX8PCA@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] rockchip/soc/drivers: Add DTPM description for rk3399
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh@kernel.org>, rjw@rjwysocki.net,
        lukasz.luba@arm.com, heiko@sntech.de, arnd@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 2:58 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Sat, 18 Dec 2021 at 14:00, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > The DTPM framework does support now the hierarchy description.
> >
> > The platform specific code can call the hierarchy creation function
> > with an array of struct dtpm_node pointing to their parent.
> >
> > This patch provides a description of the big and Little CPUs and the
> > GPU and tie them together under a virtual package name. Only rk3399 is
> > described now.
> >
> > The description could be extended in the future with the memory
> > controller with devfreq if it has the energy information.
> >
> > The hierarchy uses the GPU devfreq with the panfrost driver, and this
> > one could be loaded as a module. If the hierarchy is created before
> > the panfrost driver is loaded, it will fail. For this reason the
> > Kconfig option depends on the panfrost Kconfig's option. If this one
> > is compiled as a module, automatically the dtpm hierarchy code will be
> > a module also. Module loading ordering will fix this chicken-egg
> > problem.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> > --- /dev/null
> > +++ b/drivers/soc/rockchip/dtpm.c
> > @@ -0,0 +1,56 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2021 Linaro Limited
> > + *
> > + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> > + *
> > + * DTPM hierarchy description
> > + */
> > +#include <linux/dtpm.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +
> > +static struct dtpm_node __initdata rk3399_hierarchy[] = {
> > +       [0]{ .name = "rk3399" },
> > +       [1]{ .name = "package",
> > +            .parent = &rk3399_hierarchy[0] },
> > +       [2]{ .name = "/cpus/cpu@0",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [3]{ .name = "/cpus/cpu@1",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [4]{ .name = "/cpus/cpu@2",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [5]{ .name = "/cpus/cpu@3",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [6]{ .name = "/cpus/cpu@100",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [7]{ .name = "/cpus/cpu@101",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [8]{ .name = "rockchip,rk3399-mali",
> > +            .type = DTPM_NODE_DT,
> > +            .parent = &rk3399_hierarchy[1] },
> > +       [9]{ },
> > +};
>
> I will not object to this, as in the end this seems like what we need
> to do, unless we can describe things through generic DT bindings for
> DTPM. Right?
>
> Although, if the above is correct, I need to stress that I am kind of
> worried that this doesn't really scale. We would need to copy lots of
> information from the DTS files into platform specific c-files, to be
> able to describe the DTPM hierarchy.

The description in rk3399_hierarchy[] looks fairly similar to a
power-domains hierarchy, like we have in e.g. the various
drivers/soc/renesas/r8*-sysc.c files.  One big difference is that the
latter do not hardcode the node paths in the driver, but use power
domain indices, referenced from DT in power-domains properties.

Perhaps a similar approach can be used for DTPM?
Does DTPM differ a lot from PM Domains? If not, perhaps no new
properties are needed, and power-domains/#power-domain-cells can be
used as is?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
