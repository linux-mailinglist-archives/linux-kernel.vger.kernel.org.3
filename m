Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AAF472BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhLMMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhLMMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:00:30 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3D8C061574;
        Mon, 13 Dec 2021 04:00:29 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id w23so28707591uao.5;
        Mon, 13 Dec 2021 04:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/o19ia8lQkLfbNTP4cmgHrP0h6uYgT0nkLc/whxa57g=;
        b=daC1FU3GPJN6PmMvBZVmw3eSIQXxSXNscAPNLtxi140HGXvjDb8frf+b0mDquadfY6
         FPqkloF+W/CEn/aw/6FVRIuPp7DiZIqtG4Q00halWkTGEy7kfSJZ6rFyPrdA5OJCey0M
         FQ1t/+QRmvNgJ2Z4A0idNerYRJCiSjpLZGEpJ6Tu6HUaJz2kXbZ1b3erneof9oaA6l8g
         AzHIAZ7ziC/4eQiiY5lEjQgICgTJKPcOdiiTGYupbDcx2lf2qpggEOyPHV0mB2ONBIGV
         KZED7O4akOJUJOMiw5gkvF0uhmhVLmWfHfQ5XkUsHu+e0WBoBMZq18OW7a/ITHolPUGf
         M4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/o19ia8lQkLfbNTP4cmgHrP0h6uYgT0nkLc/whxa57g=;
        b=cUfdgECAJuuJHOx0TJn4KqXyh7AHqC6XAt/R/3pDp9Me1uNn5hJCwUttHurjQjHXI8
         XBhbzn/ZfBORCnQB/RAh2v99KlccHHileubXGjPXIEKMVEpl58G9jf2R/op7ctJIj7SO
         trp6V3fv1lRykCBYx1C8B3vqf5bjacue0o+d+0UPg9pfMplRSrY1PN/70B/RYnF36bMA
         RkIJyjy7vGz7KyVZQgGghGtOaJ3OLzSHyloPCHkdIcolBBOW0DMy8oHO01Lx3n/NOR+U
         Bn8fbZMWwLPB8j3VjolKm4ERBYgXJDbVrkUidG7E8HtFm+fQa9k2eqHvDQWfnGt/j7y/
         c0XQ==
X-Gm-Message-State: AOAM532SJzzkCjRj1lPlRiqA/1irtPHcZc+8ZHCKxigtoUkLE0tbjzHd
        8FkIQxH2Xy6lFZsHwKN5MtkL7fY4znlyL7E/r4wRTprN
X-Google-Smtp-Source: ABdhPJwXMcAbl88mhQp96FiN5dEzB++peSYemp0N3olGZJb6/cmV5LsL1jViPW27DhvszAzHdtRW7rt7qI+Pcum28Dk=
X-Received: by 2002:a05:6102:38ce:: with SMTP id k14mr26291964vst.70.1639396828635;
 Mon, 13 Dec 2021 04:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20211107074200.18911-1-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 13 Dec 2021 13:00:17 +0100
Message-ID: <CAMhs-H81xnaFqgTJT3jiNy_BBCuHhrA-t0A+0wMnp5Y0kFjGUQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] clk: ralink: make system controller a reset provider
To:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Crispin <john@phrozen.org>, linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Nov 7, 2021 at 8:42 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi all,
>
> This patch series add minimal change to provide mt7621 resets properly
> defining them in the 'mediatek,mt7621-sysc' node which is the system
> controller of the SoC and is already providing clocks to the rest of
> the world.
>
> There is shared architecture code for all ralink platforms in 'reset.c'
> file located in 'arch/mips/ralink' but the correct thing to do to align
> hardware with software seems to define and add related reset code to the
> already mainlined clock driver.
>
> After this changes, we can get rid of the useless reset controller node
> in the device tree and use system controller node instead where the property
> '#reset-cells' has been added. Binding documentation for this nodeq has
> been updated with the new property accordly.
>
> This series also provide a bindings include header where all related
> reset bits for the MT7621 SoC are defined.
>
> Also, please take a look to this review [0] to understand better motivation
> for this series.
>
> Regarding the way of merging this:
>  - I'd like patches 1 and 4 which are related going through staging tree.
>  - The other two (patches 2 and 3) can perfectly go through the clock tree.
>
> Thanks in advance for your feedback.
>
> Changes in v5:
>  - Move platform driver init process into 'arch_initcall' to be sure the
>    rest of the world can get the resets available when needed (since PCIe
>    controller driver has been moved from staging into 'drivers/pci/controller'
>    is probed earlier and reset was not available so it was returning
>    -EPROBE_DEFER on firt try. Moving into 'arch_initcall' avoids the 'a bit
>    anoying' PCI first failed log trace.

Gentle ping on this series.

Thanks,
     Sergio Paracuellos

>
> Changes in v4:
>  - I sent wrong patch 3 accidentaly so now include the good version, sorry.
>
> Changes in v3:
>  - Collect Rob's Acked-by for patches 1 and 2.
>  - Rebase on the top of staging-next since there were already many
>    changes there and PATCH 4 of the series didn't apply cleanly.
>
> Changes in v2:
>  - Address review comments of Dan Carpenter [1]:
>  + Avoid 'inline' in function definition.
>  + Return proper error codes (-EINVAL) instead of '-1'.
>  + Make use of 'devm_kzalloc' instead of 'kzalloc'.
>
> Best regards,
>    Sergio Paracuellos
>
> Sergio Paracuellos (4):
>   dt-bindings: reset: add dt binding header for Mediatek MT7621 resets
>   dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
>   clk: ralink: make system controller node a reset provider
>   staging: mt7621-dts: align resets with binding documentation
>
>  .../bindings/clock/mediatek,mt7621-sysc.yaml  | 12 +++
>  drivers/clk/ralink/clk-mt7621.c               | 86 ++++++++++++++++++-
>  drivers/staging/mt7621-dts/mt7621.dtsi        | 25 +++---
>  include/dt-bindings/reset/mt7621-reset.h      | 37 ++++++++
>  4 files changed, 145 insertions(+), 15 deletions(-)
>  create mode 100644 include/dt-bindings/reset/mt7621-reset.h
>
> --
> 2.33.0
>
