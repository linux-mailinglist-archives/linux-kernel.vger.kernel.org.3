Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3997746BDCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhLGOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:37:33 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:38593 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbhLGOhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:37:31 -0500
Received: by mail-vk1-f175.google.com with SMTP id s17so9411813vka.5;
        Tue, 07 Dec 2021 06:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpQwqoT8XwAAdzoQ9aX+buSx+t+PONUN1DKB1Js0qIY=;
        b=Qkl9wEXZR6NT9yA1rL9JSKHQZV+rSOTrFOFN59QE1KwAKzoIHZyyWEseUcu0lFRGiX
         qyIfIkmrtxO9tEZOAWVWWEWiDe373x8twbrBNdQHZ1th+7WZ/oLRGHqtZoJcHsGxnTwH
         r3Ifr0um3tA+HVVgMpmMVNqIFCmucpo7kkgbLUe0/zbm0r00oGSOuBu/XqwSih5S1vgv
         f1LkdEwc4hH7B867KOGmsTRW1whERSy9c0QgdWIImlaMQRH0QTeC/d2725bYO0OurI4A
         bdg3hHIpetafDRxZlzeYC+G0ySwVBtIMmRtlT2cn7eEE1VHoW3I1S7y+ejunbnMsptGb
         gEtA==
X-Gm-Message-State: AOAM5304G5wIDNZlgGFR/YQeh5uYrDlJHllRwW3L0aAdeJNmbzXraeS0
        F4bMBwGYeeQPfqF9GNHYMzlss0FO7+umsg==
X-Google-Smtp-Source: ABdhPJyIlVg355hB6brafrIKzc/ptkFOMFuLYllkn7XoHdTKrN2/gPk2d2/KHxf4gyUSi7HAvzxM9g==
X-Received: by 2002:a1f:d642:: with SMTP id n63mr52528306vkg.32.1638887639973;
        Tue, 07 Dec 2021 06:33:59 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id x9sm6420104vkn.36.2021.12.07.06.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 06:33:59 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id ay21so26892588uab.12;
        Tue, 07 Dec 2021 06:33:59 -0800 (PST)
X-Received: by 2002:a05:6102:21dc:: with SMTP id r28mr46694326vsg.57.1638887638783;
 Tue, 07 Dec 2021 06:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20211202062733.20338-1-moudy.ho@mediatek.com> <20211202062733.20338-4-moudy.ho@mediatek.com>
 <c48154b9-b202-c47c-c27e-53aa97877430@xs4all.nl>
In-Reply-To: <c48154b9-b202-c47c-c27e-53aa97877430@xs4all.nl>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Dec 2021 15:33:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDQMUcYSnvPj=TOepSbgSj7fO7oxd9QvQBDSttpVz=ew@mail.gmail.com>
Message-ID: <CAMuHMdVDQMUcYSnvPj=TOepSbgSj7fO7oxd9QvQBDSttpVz=ew@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] media: platform: mtk-mdp3: add Mediatek MDP3 driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, drinkcat@chromium.org,
        pihsun@chromium.org, hsinyi@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Tue, Dec 7, 2021 at 3:20 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
> On 12/2/21 7:27 AM, Moudy Ho wrote:
> > This patch adds driver for Mediatek's Media Data Path ver.3 (MDP3).
> > It provides the following functions:
> >   color transform, format conversion, resize, crop, rotate, flip
> >   and additional image quality enhancement.
> >
> > The MDP3 driver is mainly used for Google Chromebook products to
> > import the new architecture to set the HW settings as shown below:
> >   User -> V4L2 framework
> >     -> MDP3 driver -> SCP (setting calculations)
> >       -> MDP3 driver -> CMDQ (GCE driver) -> HW
> >
> > Each modules' related operation control is sited in mtk-mdp3-comp.c
> > Each modules' register table is defined in file with "mdp_reg_" prefix
> > GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> > V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> > Probe, power, suspend/resume, system level functions are defined in
> > mtk-mdp3-core.c
> >
> > Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> > Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >  drivers/media/platform/Kconfig                |   19 +
> >  drivers/media/platform/Makefile               |    2 +
> >  drivers/media/platform/mtk-mdp3/Makefile      |    6 +
> >  .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   19 +
> >  drivers/media/platform/mtk-mdp3/mdp_reg_isp.h |   27 +
> >  .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |   65 +
> >  drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |   39 +
> >  .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |   47 +
> >  .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |   55 +
> >  drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  280 ++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  505 +++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   46 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1264 +++++++++++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  147 ++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  338 +++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   76 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  789 ++++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   49 +
> >  .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  737 ++++++++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  372 +++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  312 ++++
> >  .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   78 +
> >  22 files changed, 5272 insertions(+)
> >  create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_ccorr.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_isp.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-comp.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-core.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-regs.h
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
> >  create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h
> >
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index cf4adc64c953..e6c1e8892154 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -315,6 +315,25 @@ config VIDEO_MEDIATEK_MDP
> >           To compile this driver as a module, choose M here: the
> >           module will be called mtk-mdp.
> >
> > +config VIDEO_MEDIATEK_MDP3
> > +     tristate "Mediatek MDP v3 driver"
> > +     depends on MTK_IOMMU || COMPLIE_TEST
>
> Typo: COMPLIE_TEST -> COMPILE_TEST
>
> After fixing this, trying to build this driver on my PC results in:
>
> ERROR: modpost: "mtk_mmsys_mdp_connect" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mmsys_mdp_camin_ctrl" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mmsys_mdp_isp_ctrl" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_prepare" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mmsys_mdp_disconnect" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_unprepare" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_get_mdp_mod" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_put" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_mdp_get" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> ERROR: modpost: "mtk_mutex_add_mod_by_cmdq" [drivers/media/platform/mtk-mdp3/mtk-mdp3.ko] undefined!
> WARNING: modpost: suppressed 1 unresolved symbol warnings because there were too many)
>
> include/linux/soc/mediatek/mtk-mmsys.h should probably provide dummy functions
> if CONFIG_MTK_MMSYS is undefined. Ditto for include/linux/soc/mediatek/mtk-mutex.h.

Or add a hard dependency on MTK_MMSYS?
The latter can be enabled when compile-testing.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
