Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA747E421
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348673AbhLWNdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348667AbhLWNdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:33:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB5C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:33:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h2so1856423lfv.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N7vgevEe5WAYHkfQ6WaZYFMwuRhmD21COV/RY1gvJbg=;
        b=hFHGP6Npw/5k5XVBdZeXj7qHSZC02f86qgNhlE3+g4VYen2I2wZQRsqZHTP4o4I2fF
         fSIX30CMGGuRAuGEe99rm7U4ekF3m3zo4e8uQBIG9Yc1gLxGNvKTQaco11X0BMRoOfDD
         wZcOGYpY8C5o9RHwv5ARrMezON3Q0V40lCFucoikl6AHWdPica8xJzT0Z0g4YGN6ZeKN
         lDuuRF+BtoAEZemUFcgEFU/IjY+eQqsv7lr7/IFeqXKfDp5B2VqvIInMB7Ks/k+Eet15
         4yD0wDM4aPuvKZCHIN6rTUMg2kgAPmNHGe/uDxlf4MUyUOrwybnzopLTaAuflpMpugxE
         tVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N7vgevEe5WAYHkfQ6WaZYFMwuRhmD21COV/RY1gvJbg=;
        b=RlKi7oam+ewJdIb72hYgkOd9gIG+sIUzojr9VfNxjj1kYykuS3KFWb5MZV7BsKOgdl
         fMkXIZZfG2JKfyaQ0qYA+0phGTLg5HdnXNcyIpC5MbPR2ML3qpziEm/ZBYcSdCwcnGtm
         3FFp0r+3DplVkFLdHW/tMMzNGJbi/PbilHrAkNvfwf+nmoSfiF4aZIUUcBFfnyR7bUAp
         enp42PggY+AzBEUmplS0LyRJU/rmBfARU/zdFrcIkr+VYp2qX1vkYzyvutRPSf6Wmt6y
         om/VdoTYiWOyYtyUsQ3DEIzAnPPCAw0JxoYGTuqVTkp6y5LDKGda0b6yuDX9uKFew4yl
         lNSw==
X-Gm-Message-State: AOAM530A1CgcCMUoV0VhD9pYCqvedy2uVYOAOXArZWKJba3L3BEllu6r
        zM1qAbP65f79343VYNkq7TJJiPS90wMx53th7bqhew==
X-Google-Smtp-Source: ABdhPJzeknIZEpkG86QKm9MgDA8X9ooe6HcnCTv4bg/PS+Bj9dvQtovRRBNfgdjYQju0yIoZmLkSzHbweyMNG9/71Qo=
X-Received: by 2002:a05:6512:4015:: with SMTP id br21mr1919784lfb.233.1640266383602;
 Thu, 23 Dec 2021 05:33:03 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org> <3badc321-381d-a48c-8abd-7702639304bb@linaro.org>
In-Reply-To: <3badc321-381d-a48c-8abd-7702639304bb@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Dec 2021 14:32:27 +0100
Message-ID: <CAPDyKFpSeD5qqUMrBojga=3ecK_z4ad8PL7u+ZpyWXRpqHf94A@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] powercap/drivers/dtpm: Create the dtpm hierarchy
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 at 14:20, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> Hi all,
>
> any comments on this series. Is it fine if I merge it without patch 6/6?
>
> Heiko, is the description fine for you in the SoC specific code?

FYI, I intend to have a closer look at the series next week. Happy holidays=
!

Kind regards
Uffe

>
> Thanks
>   -- Daniel
>
> On 18/12/2021 14:00, Daniel Lezcano wrote:
> > The DTPM hierarchy is the base to build on top of it a power budget
> > allocator. It reflects the power consumption of the group of devices
> > and allows to cap their power.
> >
> > The core code is there but there is no way to describe the desired
> > hierarchy yet.
> >
> > A first proposal introduced the description through configfs [1] but
> > was rejected [2].
> >
> > A second proposal based on the device tree with a binding similar to
> > the power domains [3] was proposed but finally rejected [4].
> >
> > This fifth version delegates the hierarchy creation to the SoC with a
> > specific and self-encapsulated code using an array to describe the tree=
. The
> > SoC DTPM driver defines an array of nodes pointing to their parents.  T=
he
> > hierarchy description can integrate a DT node and in the future a SCMI =
node,
> > that means the description can mix different type of nodes.
> >
> > In addition to the hierarchy creation, the devfreq dtpm support is also
> > integrated into this series.
> >
> > This series was tested on a rock960 (revision B - rk3399 based) and a
> > db845c (Qualcomm sdm845 based).
> >
> > [1] https://lore.kernel.org/all/20210401183654.27214-1-daniel.lezcano@l=
inaro.org/
> > [2] https://lore.kernel.org/all/YGYg6ZeZ1181%2FpXk@kroah.com/
> > [3] https://lore.kernel.org/all/20211205231558.779698-1-daniel.lezcano@=
linaro.org/
> > [4] https://lore.kernel.org/all/YbfFapsmsjs4qnsg@robh.at.kernel.org/
> >
> > Changelog:
> >    V5:
> >    - Remove DT bindings
> >    - Added description with an array
> >    - Added simple description for rk3399 and sdm845
> >    - Moved dtpm table to the data section
> >
> >    V4:
> >    - Added missing powerzone-cells
> >    - Changed powerzone name to comply with the pattern property
> >
> >    V3:
> >    - Remove GPU section as no power is available (yet)
> >    - Remove '#powerzone-cells' conforming to the bindings change
> >    - Removed required property 'compatible'
> >    - Removed powerzone-cells from the topmost node
> >    - Removed powerzone-cells from cpus 'consumers' in example
> >    - Set additionnal property to false
> >
> >    V2:
> >    - Added pattern properties and stick to powerzone-*
> >    - Added required property compatible and powerzone-cells
> >    - Added additionnal property
> >    - Added compatible
> >    - Renamed to 'powerzones'
> >    - Added missing powerzone-cells to the topmost node
> >    - Fixed errors reported by 'make DT_CHECKER_FLAGS=3D-m dt_binding_ch=
eck'
> >    - Move description in the SoC dtsi specific file
> >    - Fixed missing prototype warning reported by lkp@
> >
> >    V1: Initial post
> >
> > Daniel Lezcano (6):
> >   powercap/drivers/dtpm: Move dtpm table from init to data section
> >   powercap/drivers/dtpm: Add hierarchy creation
> >   powercap/drivers/dtpm: Add CPU DT initialization support
> >   powercap/drivers/dtpm: Add dtpm devfreq with energy model support
> >   rockchip/soc/drivers: Add DTPM description for rk3399
> >   qcom/soc/drivers: Add DTPM description for sdm845
> >
> >  drivers/powercap/Kconfig          |   8 ++
> >  drivers/powercap/Makefile         |   1 +
> >  drivers/powercap/dtpm.c           | 155 ++++++++++++++++++++++-
> >  drivers/powercap/dtpm_cpu.c       |  37 ++++--
> >  drivers/powercap/dtpm_devfreq.c   | 201 ++++++++++++++++++++++++++++++
> >  drivers/soc/qcom/Kconfig          |   9 ++
> >  drivers/soc/qcom/Makefile         |   1 +
> >  drivers/soc/qcom/dtpm.c           |  65 ++++++++++
> >  drivers/soc/rockchip/Kconfig      |   8 ++
> >  drivers/soc/rockchip/Makefile     |   1 +
> >  drivers/soc/rockchip/dtpm.c       |  56 +++++++++
> >  include/asm-generic/vmlinux.lds.h |   4 +-
> >  include/linux/dtpm.h              |  21 +++-
> >  13 files changed, 551 insertions(+), 16 deletions(-)
> >  create mode 100644 drivers/powercap/dtpm_devfreq.c
> >  create mode 100644 drivers/soc/qcom/dtpm.c
> >  create mode 100644 drivers/soc/rockchip/dtpm.c
> >
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
