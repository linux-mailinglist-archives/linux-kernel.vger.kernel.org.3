Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF7572AC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiGMBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiGMBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:25:35 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7580B6DB1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 18:25:32 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220713012531epoutp01f10b92623e4587645a055662f3da6b9f~BPxzazm482035620356epoutp01B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:25:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220713012531epoutp01f10b92623e4587645a055662f3da6b9f~BPxzazm482035620356epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657675531;
        bh=QPCmKDfkOyojrvl06gPY20z3R9a4i5xdPH4MTj42Ajs=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nVaXdDPEYqdOjBID2piVruZZeB52QuFUUMNtR6Iu3viQ/oKcrWbQStODnDTwZd+9v
         KyNlhAL7PIlUf6fz0GvPyERQU2tDTi0bGKjMnau4wCZKNwcV8gECipvXVmzGPUDrau
         JThqefde6wmNE0+AjrzX4uclu7dLZOORvYoR/9v8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220713012530epcas1p155be1c43bbb6af6e473561ee11940ec7~BPxy43Uto1067810678epcas1p1w;
        Wed, 13 Jul 2022 01:25:30 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.249]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LjKgZ0VTHz4x9Pw; Wed, 13 Jul
        2022 01:25:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.D8.09661.90F1EC26; Wed, 13 Jul 2022 10:25:29 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220713012529epcas1p4938326d4c7fd39ea65ce7d3aa1c8b3fa~BPxyFwRih1605016050epcas1p4d;
        Wed, 13 Jul 2022 01:25:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220713012529epsmtrp2a3b84ee4ec21995e2c4d4054cee7e8af~BPxyE0MfQ2131221312epsmtrp2Z;
        Wed, 13 Jul 2022 01:25:29 +0000 (GMT)
X-AuditID: b6c32a37-2cfff700000025bd-bd-62ce1f09f4be
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.42.08905.90F1EC26; Wed, 13 Jul 2022 10:25:29 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220713012529epsmtip27fdf08f93d60544c81e6f68e77b54501~BPxx2-Cvp1744617446epsmtip23;
        Wed, 13 Jul 2022 01:25:29 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
        <jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>,
        <seunghwan.hyun@samsung.com>
In-Reply-To: <CAPDyKFodLj7McOsT1ObGFU03g0iBLaydo-E5QV=hy+0tOi846A@mail.gmail.com>
Subject: RE: [PATCH] mmc: use mmc_card_* macro and add it for sd_combo
Date:   Wed, 13 Jul 2022 10:25:29 +0900
Message-ID: <056d01d89657$70127a90$50376fb0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGsnp/peaG99Yte9Le8RtwF2g9pOAIxCFJ0AWMm+setts6W0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmgS6n/Lkkg1l/bCxmnGpjtdh37SS7
        xa+/69ktOrZOZrLY8fwMu8Wuv81MFpd3zWGzOPK/n9Hi3MlPrBbXzpxgtTi+Ntxi86VvLA48
        Hneu7WHz6NuyitHj8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
        xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQVmBXrFibnF
        pXnpenmpJVaGBgZGpkCFCdkZ21duZSq45VXxen0rawPjZLMuRg4OCQETiXt32LsYuTiEBHYw
        SnRsPcwM4XxilLgxcycjhPONUeLWr9VAZZxgHVsP/WaFSOxllDg8fSUzSEJI4AWjxJ2vXiA2
        m4COxJtP/1lBbBEge8abZrAGZoGdTBK37t1gAUlwCgRKHN/zFGyqsICbxKlP/5hAbBYBVYlp
        Vw6xgdi8ApYS39rXsUPYghInZz4B62UW0JZYtvA1M8RFChI/ny5jhYiLSMzubGMG+U1EwEni
        7SwXiJKVHBKbfrFC2C4S3w68grKFJV4d3wL1mJTE53d72SDsYom2f/+gxldIHOz7AmUbS3z6
        /JkRZDyzgKbE+l36EGFFiZ2/5zJCXMAn8e5rDyskdHklOtqEIEqUJV4+WsYEYUtKLGm/xTyB
        UWkWkr9mIflrFpJfZiEsW8DIsopRLLWgODc9tdiwwBge1cn5uZsYwalVy3wH47S3H/QOMTJx
        MB5ilOBgVhLh/XP2VJIQb0piZVVqUX58UWlOavEhRlNgSE9klhJNzgcm97ySeEMTSwMTMyMT
        C2NLYzMlcd5V004nCgmkJ5akZqemFqQWwfQxcXBKNTBF9Dznup3+aGa4hP3TtINartnlszpt
        V9dzlz3+N+18xexPsYHKf3XYj636veXiB+O3u39f+Cn31MKFWeXHWc+1m2qdLzzvSZiTOZ3r
        hGKZ6l0D9v5td9VOn3FlWBRie+lwq+EJvfjnE7lkmwTP/+ZlY5+WuT5llnM1660GG5f6oJXW
        N0wZc1bMWXJrwqV/s5rsss/OXx81WVaj+F30y7D5oh+tKlwvMnyOPv43M+N3TKfY3Py3BiLx
        en49fiFi3l8+3mVMueNmpr6H9edqFqXes09vaDTnFnlPnvfc+xn3mn6po/peexZJ9pzm/XbE
        clbm50fbbDZ9EzcOmyPdOXvL1/kHLwlMfRCgkMo4eXGEEktxRqKhFnNRcSIA4ddRqDYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXpdT/lySwZrZchYzTrWxWuy7dpLd
        4tff9ewWHVsnM1nseH6G3WLX32Ymi8u75rBZHPnfz2hx7uQnVotrZ06wWhxfG26x+dI3Fgce
        jzvX9rB59G1ZxejxeZNcAHMUl01Kak5mWWqRvl0CV8adRv6CpR4Vs46FNTA+MO5i5OSQEDCR
        2HroN2sXIxeHkMBuRonla/6wQyQkJRY/esjWxcgBZAtLHD5cDBIWEnjGKHH1ER+IzSagI/Hm
        039WEFsEyJ7xphlsDrPAYSaJncv2sEMMvcgo8er/OTaQKk6BQInje56CLRAWcJM49ekfE4jN
        IqAqMe3KIbAaXgFLiW/t69ghbEGJkzOfsIDYzALaEr0PWxlh7GULXzNDHKog8fPpMlaIuIjE
        7M42ZpCjRQScJN7OcpnAKDwLyaRZSCbNQjJpFpLuBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OL
        S/PS9ZLzczcxgqNMS3MH4/ZVH/QOMTJxMB5ilOBgVhLh/XP2VJIQb0piZVVqUX58UWlOavEh
        RmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTM0cQqem3eM8K9Nk/aF7Weqyf52CXP5W
        h39nKibUeYUH/F2cafnyetsM/6V/+T77ifTpfd11TzP1gukE67q6FSGpJ13m3ytacv1E67Or
        FqHNuzcwpoZZTzjq01P2U2jb/wp7+/XJRk0zjCWnHSmf0vjC7sfTS+Htc+Y289bo21v0z/AU
        TJ0xZ0dVr/zGZOM92t+X5S3iuqM3517F2trwWlPLwv0XDm8t8jplp+MhH7jL2eaRX+Zlu4Od
        yw2bD0dsC62+yMx4XcfS5tLnhQabL2fFOR/xX3PRqYppvcQZwboA++DD6zyW9OqtXaF1sf6K
        g80SHd0Qq7WmxyTWZHWVRz7jTSooaDPf0fW7/zufEktxRqKhFnNRcSIAuCHR9yEDAAA=
X-CMS-MailID: 20220713012529epcas1p4938326d4c7fd39ea65ce7d3aa1c8b3fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3
References: <CGME20220705012516epcas1p2c15e9e9984735c32bcc754ff646ccbf3@epcas1p2.samsung.com>
        <20220705015729.14455-1-sh043.lee@samsung.com>
        <CAPDyKFodLj7McOsT1ObGFU03g0iBLaydo-E5QV=hy+0tOi846A@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Uffe,

Thank you for your review comment. :)
I'll split this patch into two, and re-submit this as your request.


> -----Original Message-----
> From: Ulf Hansson <ulf.hansson=40linaro.org>
> Sent: Tuesday, July 12, 2022 7:57 PM
> To: Seunghui Lee <sh043.lee=40samsung.com>
> Cc: linux-mmc=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> axboe=40kernel.dk; Avri.Altman=40wdc.com; shawn.lin=40rock-chips.com;
> adrian.hunter=40intel.com; grant.jung=40samsung.com; jt77.jang=40samsung.=
com;
> dh0421.hwang=40samsung.com; junwoo80.lee=40samsung.com; jangsub.yi=40sams=
ung.com;
> cw9316.lee=40samsung.com; sh8267.baek=40samsung.com; wkon.kim=40samsung.c=
om;
> seunghwan.hyun=40samsung.com
> Subject: Re: =5BPATCH=5D mmc: use mmc_card_* macro and add it for sd_comb=
o
>=20
> On Tue, 5 Jul 2022 at 03:25, Seunghui Lee <sh043.lee=40samsung.com> wrote=
:
> >
> > add mmc_card_sd_combo() macro for sd combo type card and use
> > mmc_card_* macro to simplify instead of comparing card->type
> >
> > Signed-off-by: Seunghui Lee <sh043.lee=40samsung.com>
>=20
> Nice cleanup=21 I minor thing though, see below.
>=20
> > ---
> >  drivers/mmc/core/block.c  =7C  4 ++--
> >  drivers/mmc/core/bus.c    =7C  4 ++--
> >  drivers/mmc/core/sd.c     =7C  2 +-
> >  drivers/mmc/core/sdio.c   =7C 16 ++++++++--------
> >  drivers/mmc/host/mxcmmc.c =7C  2 +-
>=20
> Please split this patch into two. One for the core and one for the mxcmmc
> driver.
>=20
> Otherwise this looks good to me=21
>=20
> Kind regards
> Uffe
>=20
> >  include/linux/mmc/card.h  =7C  1 +
> >  6 files changed, 15 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > bda6c67ce93f..4d7ae8fc2901 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > =40=40 -2987,7 +2987,7 =40=40 static int mmc_blk_probe(struct mmc_card =
*card)
> >          * Don't enable runtime PM for SD-combo cards here. Leave that
> >          * decision to be taken during the SDIO init sequence instead.
> >          */
> > -       if (card->type =21=3D MMC_TYPE_SD_COMBO) =7B
> > +       if (=21mmc_card_sd_combo(card)) =7B
> >                 pm_runtime_set_active(&card->dev);
> >                 pm_runtime_enable(&card->dev);
> >         =7D
> > =40=40 -3014,7 +3014,7 =40=40 static void mmc_blk_remove(struct mmc_car=
d *card)
> >                 mmc_blk_part_switch(card, md->part_type);
> >                 mmc_release_host(card->host);
> >         =7D
> > -       if (card->type =21=3D MMC_TYPE_SD_COMBO)
> > +       if (=21mmc_card_sd_combo(card))
> >                 pm_runtime_disable(&card->dev);
> >         pm_runtime_put_noidle(&card->dev);
> >         mmc_blk_remove_req(md);
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> > 58a60afa650b..d8762fa3d5cd 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > =40=40 -85,7 +85,7 =40=40 mmc_bus_uevent(struct device *dev, struct
> kobj_uevent_env *env)
> >                         return retval;
> >         =7D
> >
> > -       if (card->type =3D=3D MMC_TYPE_SDIO =7C=7C card->type =3D=3D
> MMC_TYPE_SD_COMBO) =7B
> > +       if (mmc_card_sdio(card) =7C=7C mmc_card_sd_combo(card)) =7B
> >                 retval =3D add_uevent_var(env, =22SDIO_ID=3D%04X:%04X=
=22,
> >                                         card->cis.vendor, card->cis.dev=
ice);
> >                 if (retval)
> > =40=40 -107,7 +107,7 =40=40 mmc_bus_uevent(struct device *dev, struct
> kobj_uevent_env *env)
> >          * SDIO (non-combo) cards are not handled by mmc_block driver a=
nd
> do not
> >          * have accessible CID register which used by mmc_card_name()
> function.
> >          */
> > -       if (card->type =3D=3D MMC_TYPE_SDIO)
> > +       if (mmc_card_sdio(card))
> >                 return 0;
> >
> >         retval =3D add_uevent_var(env, =22MMC_NAME=3D%s=22,
> > mmc_card_name(card)); diff --git a/drivers/mmc/core/sd.c
> > b/drivers/mmc/core/sd.c index c5f1df6ce4c0..f0186bdf2025 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > =40=40 -793,7 +793,7 =40=40 static umode_t sd_std_is_visible(struct kob=
ject
> *kobj, struct attribute *attr,
> >              attr =3D=3D &dev_attr_info2.attr =7C=7C
> >              attr =3D=3D &dev_attr_info3.attr =7C=7C
> >              attr =3D=3D &dev_attr_info4.attr
> > -           ) && card->type =21=3D MMC_TYPE_SD_COMBO)
> > +           ) &&=21mmc_card_sd_combo(card))
> >                 return 0;
> >
> >         return attr->mode;
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c index
> > 25799accf8a0..b589df1c35e0 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > =40=40 -335,7 +335,7 =40=40 static int sdio_disable_4bit_bus(struct mmc=
_card
> > *card)  =7B
> >         int err;
> >
> > -       if (card->type =3D=3D MMC_TYPE_SDIO)
> > +       if (mmc_card_sdio(card))
> >                 goto out;
> >
> >         if (=21(card->host->caps & MMC_CAP_4_BIT_DATA)) =40=40 -360,7 +=
360,7
> > =40=40 static int sdio_enable_4bit_bus(struct mmc_card *card)
> >         err =3D sdio_enable_wide(card);
> >         if (err <=3D 0)
> >                 return err;
> > -       if (card->type =3D=3D MMC_TYPE_SDIO)
> > +       if (mmc_card_sdio(card))
> >                 goto out;
> >
> >         if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) =7B =40=40 -415,=
7
> > +415,7 =40=40 static int sdio_enable_hs(struct mmc_card *card)
> >         int ret;
> >
> >         ret =3D mmc_sdio_switch_hs(card, true);
> > -       if (ret <=3D 0 =7C=7C card->type =3D=3D MMC_TYPE_SDIO)
> > +       if (ret <=3D 0 =7C=7C mmc_card_sdio(card))
> >                 return ret;
> >
> >         ret =3D mmc_sd_switch_hs(card);
> > =40=40 -441,7 +441,7 =40=40 static unsigned mmc_sdio_get_max_clock(stru=
ct
> mmc_card *card)
> >                 max_dtr =3D card->cis.max_dtr;
> >         =7D
> >
> > -       if (card->type =3D=3D MMC_TYPE_SD_COMBO)
> > +       if (mmc_card_sd_combo(card))
> >                 max_dtr =3D min(max_dtr, mmc_sd_get_max_clock(card));
> >
> >         return max_dtr;
> > =40=40 -689,7 +689,7 =40=40 static int mmc_sdio_init_card(struct mmc_ho=
st *host,
> u32 ocr,
> >             mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) =3D=
=3D 0) =7B
> >                 card->type =3D MMC_TYPE_SD_COMBO;
> >
> > -               if (oldcard && (oldcard->type =21=3D MMC_TYPE_SD_COMBO =
=7C=7C
> > +               if (oldcard && (=21mmc_card_sd_combo(oldcard) =7C=7C
> >                     memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card=
-
> >raw_cid)) =21=3D 0)) =7B
> >                         err =3D -ENOENT;
> >                         goto mismatch; =40=40 -697,7 +697,7 =40=40 stat=
ic int
> > mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
> >         =7D else =7B
> >                 card->type =3D MMC_TYPE_SDIO;
> >
> > -               if (oldcard && oldcard->type =21=3D MMC_TYPE_SDIO) =7B
> > +               if (oldcard && =21mmc_card_sdio(oldcard)) =7B
> >                         err =3D -ENOENT;
> >                         goto mismatch;
> >                 =7D
> > =40=40 -754,7 +754,7 =40=40 static int mmc_sdio_init_card(struct mmc_ho=
st *host,
> u32 ocr,
> >         /*
> >          * Read CSD, before selecting the card
> >          */
> > -       if (=21oldcard && card->type =3D=3D MMC_TYPE_SD_COMBO) =7B
> > +       if (=21oldcard && mmc_card_sd_combo(card)) =7B
> >                 err =3D mmc_sd_get_csd(card);
> >                 if (err)
> >                         goto remove;
> > =40=40 -827,7 +827,7 =40=40 static int mmc_sdio_init_card(struct mmc_ho=
st
> > *host, u32 ocr,
> >
> >         mmc_fixup_device(card, sdio_fixup_methods);
> >
> > -       if (card->type =3D=3D MMC_TYPE_SD_COMBO) =7B
> > +       if (mmc_card_sd_combo(card)) =7B
> >                 err =3D mmc_sd_setup_card(host, card, oldcard =21=3D NU=
LL);
> >                 /* handle as SDIO-only card if memory init failed */
> >                 if (err) =7B
> > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> > index 613f13306433..2cf0413407ea 100644
> > --- a/drivers/mmc/host/mxcmmc.c
> > +++ b/drivers/mmc/host/mxcmmc.c
> > =40=40 -923,7 +923,7 =40=40 static void mxcmci_init_card(struct mmc_hos=
t *host,
> struct mmc_card *card)
> >          * One way to prevent this is to only allow 1-bit transfers.
> >          */
> >
> > -       if (is_imx31_mmc(mxcmci) && card->type =3D=3D MMC_TYPE_SDIO)
> > +       if (is_imx31_mmc(mxcmci) && mmc_card_sdio(card))
> >                 host->caps &=3D =7EMMC_CAP_4_BIT_DATA;
> >         else
> >                 host->caps =7C=3D MMC_CAP_4_BIT_DATA; diff --git
> > a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> > 37f975875102..156a7b673a28 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > =40=40 -348,5 +348,6 =40=40 bool mmc_card_is_blockaddr(struct mmc_card =
*card);
> >  =23define mmc_card_mmc(c)                ((c)->type =3D=3D MMC_TYPE_MM=
C)
> >  =23define mmc_card_sd(c)         ((c)->type =3D=3D MMC_TYPE_SD)
> >  =23define mmc_card_sdio(c)       ((c)->type =3D=3D MMC_TYPE_SDIO)
> > +=23define mmc_card_sd_combo(c)   ((c)->type =3D=3D MMC_TYPE_SD_COMBO)
> >
> >  =23endif /* LINUX_MMC_CARD_H */
> > --
> > 2.29.0
> >

