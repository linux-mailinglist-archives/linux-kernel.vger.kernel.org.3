Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB39E4998E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 22:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453677AbiAXVah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347869AbiAXU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:59:06 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509BC05487F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:01:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x11so52286073lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9d/LljxdQFk/8v03A59TsFaR9pVRTvDbBagxt/vWhj8=;
        b=Ntri0HCzdk31bT7UnQbWab1+vHBzqQ+fXAefDkzolzabvzJIxSfnO2MmF3vDrvc99D
         eJ68tMf0fD/4+vtwn993CD+sEdfpx/Ab0z/QgdqY5KQ+NcCbAJ7MkAE9h7zp5VZ6WhW5
         aIMVMUrQQdxB1PLNOmXXJP0im8vEctusN2yO/hawcQrBBatbuF7XQQDPIK4dFlsAcoob
         eJe5RzJuHQXVDPe+RSX03Ro5EtiWcf5VBre2uQLkoMBKJ9I1ZlED/pm3f8M0cxNfXD35
         Ud6xxmBMa6bMnBXpg12yy87XHxpGt2mIiK/7fqaww6rzDzV4Iau9OACXi2o3k3jqqh1N
         cTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9d/LljxdQFk/8v03A59TsFaR9pVRTvDbBagxt/vWhj8=;
        b=x2ikeEzNop6khxHxkTITmSXrlUEy6LRvWLGpL8OnJN1Q4HTnxuxkzq8XfjjyXkAzUk
         jVV8GWMtNGbwi/9ybevvJbLiubRs9ShF9zONRdpYDQsi2Df1r22rFJrZtXkMsZA7zRjH
         5NqwVe99Y1COSJtkrT4OwD6cBsz2L0i3H0veKqYW/9KQLPoiy52/3PLzFavYRgzbLj5n
         I4+fAtxIhRJFzjZDj6FFuu9V7FEhKMBvqtqtyH+AXYHfbSnTp4d0lGV1VKP/upSj5rf+
         cfLdH1fKrzoC59/ihugS7uwqqeeFF24tismh9K/0KgMWAPrBv0BvTuBnnY+izuxCWDub
         P/ig==
X-Gm-Message-State: AOAM532ql4c4nQRODHdAcGMrmPisQcPNy6OUXeB30u8a0Uma1d3fwp7X
        V/YosIUOyNLvb26BctEXq/tn2vVqt9Jd5ryVr9Ku1Q==
X-Google-Smtp-Source: ABdhPJz3vOMKc7w8t/aRtiTShdqmYvLtD3vHMppmryVlYq5BmMuK5OPb2pEke6T5vpI2Cn5jVPUOkZMMggaNlqqQxnk=
X-Received: by 2002:a05:6512:2348:: with SMTP id p8mr2992234lfu.71.1643054462040;
 Mon, 24 Jan 2022 12:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20220119085719.1357874-1-daniel.lezcano@linaro.org> <20220119085719.1357874-3-daniel.lezcano@linaro.org>
In-Reply-To: <20220119085719.1357874-3-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 21:00:25 +0100
Message-ID: <CAPDyKFrtq0J2O0WBwLr7Zb+WkomhLcR1h+eDzzV-SxpiJmm_yQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] powercap/drivers/dtpm: Add hierarchy creation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, robh@kernel.org, lukasz.luba@arm.com,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 09:58, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The DTPM framework is available but without a way to configure it.
>
> This change provides a way to create a hierarchy of DTPM node where
> the power consumption reflects the sum of the children's power
> consumption.
>
> It is up to the platform to specify an array of dtpm nodes where each
> element has a pointer to its parent, except the top most one. The type
> of the node gives the indication of which initialization callback to
> call. At this time, we can create a virtual node, where its purpose is
> to be a parent in the hierarchy, and a DT node where the name
> describes its path.
>
> In order to ensure a nice self-encapsulation, the DTPM subsys array
> contains a couple of initialization functions, one to setup the DTPM
> backend and one to initialize it up. With this approach, the DTPM
> framework has a very few material to export.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/powercap/Kconfig |   1 +
>  drivers/powercap/dtpm.c  | 168 ++++++++++++++++++++++++++++++++++++++-
>  include/linux/dtpm.h     |  15 ++++
>  3 files changed, 181 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
> index 8242e8c5ed77..b1ca339957e3 100644
> --- a/drivers/powercap/Kconfig
> +++ b/drivers/powercap/Kconfig
> @@ -46,6 +46,7 @@ config IDLE_INJECT
>
>  config DTPM
>         bool "Power capping for Dynamic Thermal Power Management (EXPERIMENTAL)"
> +       depends on OF
>         help
>           This enables support for the power capping for the dynamic
>           thermal power management userspace engine.
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index 0e5c93443c70..10032f7132c4 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -23,6 +23,7 @@
>  #include <linux/powercap.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/of.h>
>
>  #include "dtpm_subsys.h"
>
> @@ -463,14 +464,175 @@ int dtpm_register(const char *name, struct dtpm *dtpm, struct dtpm *parent)
>         return 0;
>  }
>
> -static int __init init_dtpm(void)
> +static struct dtpm *dtpm_setup_virtual(const struct dtpm_node *hierarchy,
> +                                      struct dtpm *parent)
>  {
> +       struct dtpm *dtpm;
> +       int ret;
> +
> +       dtpm = kzalloc(sizeof(*dtpm), GFP_KERNEL);
> +       if (!dtpm)
> +               return ERR_PTR(-ENOMEM);
> +       dtpm_init(dtpm, NULL);
> +
> +       ret = dtpm_register(hierarchy->name, dtpm, parent);
> +       if (ret) {
> +               pr_err("Failed to register dtpm node '%s': %d\n",
> +                      hierarchy->name, ret);
> +               kfree(dtpm);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return dtpm;
> +}
> +
> +static struct dtpm *dtpm_setup_dt(const struct dtpm_node *hierarchy,
> +                                 struct dtpm *parent)
> +{
> +       struct device_node *np;
> +       int i, ret;
> +
> +       np = of_find_node_by_path(hierarchy->name);
> +       if (!np) {
> +               pr_err("Failed to find '%s'\n", hierarchy->name);
> +               return ERR_PTR(-ENXIO);
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(dtpm_subsys); i++) {
> +
> +               if (!dtpm_subsys[i]->setup)
> +                       continue;
> +
> +               ret = dtpm_subsys[i]->setup(parent, np);
> +               if (ret) {
> +                       pr_err("Failed to setup '%s': %d\n", dtpm_subsys[i]->name, ret);
> +                       of_node_put(np);
> +                       return ERR_PTR(ret);
> +               }
> +       }
> +
> +       of_node_put(np);
> +
> +       /*
> +        * By returning a NULL pointer, we let know the caller there
> +        * is no child for us as we are a leaf of the tree
> +        */
> +       return NULL;
> +}
> +
> +typedef struct dtpm * (*dtpm_node_callback_t)(const struct dtpm_node *, struct dtpm *);
> +
> +dtpm_node_callback_t dtpm_node_callback[] = {
> +       [DTPM_NODE_VIRTUAL] = dtpm_setup_virtual,
> +       [DTPM_NODE_DT] = dtpm_setup_dt,
> +};
> +
> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> +                              const struct dtpm_node *it, struct dtpm *parent)
> +{
> +       struct dtpm *dtpm;
> +       int i, ret;
> +
> +       for (i = 0; hierarchy[i].name; i++) {
> +
> +               if (hierarchy[i].parent != it)
> +                       continue;
> +
> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
> +               if (!dtpm || IS_ERR(dtpm))

This can be tested with the "IS_ERR_OR_NULL()" macro.

> +                       continue;

We have discussed the error path previously. Just ignoring errors here
and continuing with the initialization, isn't normally how we design
good kernel code.

However, you have also explained that the error path is special and
somewhat non-trivial to manage in this case. I get that now and thanks
for clarifying.

Nevertheless, I think it deserves to be explained a bit with a comment
in the code of what goes on here. Otherwise another developer that
looks at this code in the future, may think it looks suspicious too.

> +
> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}

[...]

Other than the above, this looks good to me!

Kind regards
Uffe
