Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD84F11C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbiDDJQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350832AbiDDJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:16:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2F3B3D7;
        Mon,  4 Apr 2022 02:14:07 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9so6380085ilu.9;
        Mon, 04 Apr 2022 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u9UXLHNcrmX+u+vMYyDcVz6XNsVrgbzMhY+q8oGLZp4=;
        b=oR6yq2REp7ra3dM6jM3FH98T/gPx28zZdefaXVui0EEPW7iGnjBLsqxJnRVyBL5WyO
         Ps5167LxUNzzloOOia40pCLsB1gfD6kuSfRzw2zcHVDaoWrwIqEPHsBY+8BGqWNgckCu
         oY1Vct4VTA+lylhmQvJXaVLTFQCOJTEwFc62lFdL2ZjK/Rnr82l8fYzPemnOPCAMmEET
         fuB10Z9mW+1xDLrUQjmRqrQChEYVJsByfvhuR7O2pEvLBC/d2TONnmvE+YmTohXeZdWg
         2J66uAJsZUFxexF0KYlp1+5er6bK9oiyPx4UVwStvJbwaQHIOZs2oikupHwhxPJEz3mV
         sg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u9UXLHNcrmX+u+vMYyDcVz6XNsVrgbzMhY+q8oGLZp4=;
        b=VBjrOORTekFeGQxS9O8zAj08RYYb/tlYAxhC2dG7CDmYShbAjSU2xqEzTuEgmrP4UX
         7zYeDZRHIxDGVckXcSDGrQtoT9E601zc/1qcoL7S/H4pR3afiNvY+ZQJF233dpoZsq2e
         QeYBXld+6Cg0MMt7VhoI1T1TG49nL2Re5UrQGti9Ax3kuPU4e5QXry8AzESETuozRbLr
         01mT7NmlUcFC5SO6N+xCm1Zv6R4RO92Eb5Ne/CSafmPzYaNh0SuuMh3DDtPThLEi0sss
         Uxop+Cnza2YB5054dSSLTwfbwKGhHpElBEmFFKe1U2ZAacPyHhapdd8jaDCeErotiHZ+
         0jtQ==
X-Gm-Message-State: AOAM532tIXjJTzeHBryPjfcKrQjpeyUH0F9ICuN/KSXoGhCIJcZUgFF9
        9xb1htWIC3ELPvzizKkFtISGDAvguETYbQhrjrY=
X-Google-Smtp-Source: ABdhPJyCjR9pG11w/ipN74ADBjKgVA4MbSqEFKTr/rBObmUFkq0xAMdUJg+sDbd4xIgKypFNB6puqIzickWE6Blk3iU=
X-Received: by 2002:a92:ca0f:0:b0:2c8:c6f3:6a14 with SMTP id
 j15-20020a92ca0f000000b002c8c6f36a14mr4879147ils.200.1649063646248; Mon, 04
 Apr 2022 02:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220404040153.1509966-1-gch981213@gmail.com> <20220404040153.1509966-3-gch981213@gmail.com>
 <20220404095937.20089db7@xps13>
In-Reply-To: <20220404095937.20089db7@xps13>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 4 Apr 2022 17:13:55 +0800
Message-ID: <CAJsYDVK6ya7FR90CtAjbpbF-_+c0GVnsKsN=1wYaoBFx=ysUtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] spi: add driver for MTK SPI NAND Flash Interface
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, Apr 4, 2022 at 3:59 PM Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
>
> Hi Chuanhong,
>
> gch981213@gmail.com wrote on Mon,  4 Apr 2022 12:01:50 +0800:
>
> > This driver implements support for the SPI-NAND mode of MTK NAND Flash
> > Interface as a SPI-MEM controller with piplined ECC capability.
> >
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > ---
> >
> > Change since v1:
> >   fix CI warnings
> >
> >  drivers/spi/Kconfig        |   10 +
> >  drivers/spi/Makefile       |    1 +
> >  drivers/spi/spi-mtk-snfi.c | 1351 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1362 insertions(+)
> >  create mode 100644 drivers/spi/spi-mtk-snfi.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index d2815eb361c0..739eec7d0c15 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -590,6 +590,16 @@ config SPI_MTK_NOR
> >         SPI interface as well as several SPI NOR specific instructions
> >         via SPI MEM interface.
> >
> > +config SPI_MTK_SNFI
> > +     tristate "MediaTek SPI NAND Flash Interface"
> > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> > +     depends on MTD_NAND_ECC_MEDIATEK
> > +     help
> > +       This enables support for SPI-NAND mode on the MediaTek NAND
> > +       Flash Interface found on MediaTek ARM SoCs. This controller
> > +       is implemented as a SPI-MEM controller with pipelined ECC
> > +       capcability.
> > +
> >  config SPI_NPCM_FIU
> >       tristate "Nuvoton NPCM FLASH Interface Unit"
> >       depends on ARCH_NPCM || COMPILE_TEST
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index 3aa28ed3f761..51541ff17e67 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -76,6 +76,7 @@ obj-$(CONFIG_SPI_MPC52xx)           +=3D spi-mpc52xx.=
o
> >  obj-$(CONFIG_SPI_MT65XX)                +=3D spi-mt65xx.o
> >  obj-$(CONFIG_SPI_MT7621)             +=3D spi-mt7621.o
> >  obj-$(CONFIG_SPI_MTK_NOR)            +=3D spi-mtk-nor.o
> > +obj-$(CONFIG_SPI_MTK_SNFI)           +=3D spi-mtk-snfi.o
> >  obj-$(CONFIG_SPI_MXIC)                       +=3D spi-mxic.o
> >  obj-$(CONFIG_SPI_MXS)                        +=3D spi-mxs.o
> >  obj-$(CONFIG_SPI_NPCM_FIU)           +=3D spi-npcm-fiu.o
> > diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
> > new file mode 100644
> > index 000000000000..e8f8f30bd7ee
> > --- /dev/null
> > +++ b/drivers/spi/spi-mtk-snfi.c
>
> [...]
>
> > +static struct mtk_snand *nand_to_mtk_snand(struct nand_device *nand)
> > +{
> > +     struct nand_ecc_engine *eng =3D nand->ecc.engine;
> > +
> > +     return container_of(eng, struct mtk_snand, ecc_eng);
> > +}
> > +
> > +static inline int snand_prepare_bouncebuf(struct mtk_snand *snf, size_=
t size)
> > +{
> > +     if (snf->buf_len >=3D size)
> > +             return 0;
> > +     if (snf->buf)
> > +             dmam_free_coherent(snf->dev, snf->buf_len, snf->buf,
> > +                                snf->buf_dma);
>
> Can't we use a single coherent buffer once for all?

This only reallocates when the page size changes to a larger one,
so there's at most two allocations: one during probe and the other
one in the first call to init_ctx. The other solution is to allocate a
buffer for the maximum supported page size but I think that's a
waste of memory.

>
> > +     snf->buf =3D
> > +             dmam_alloc_coherent(snf->dev, size, &snf->buf_dma, GFP_KE=
RNEL);
> > +     if (!snf->buf)
> > +             return -ENOMEM;
> > +     snf->buf_len =3D size;
> > +     memset(snf->buf, 0xff, snf->buf_len);
> > +     return 0;
> > +}
> > +
>
> [...]
>
> > +static int mtk_snand_ecc_init_ctx(struct nand_device *nand)
> > +{
> > +     struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> > +     struct nand_ecc_props *conf =3D &nand->ecc.ctx.conf;
> > +     struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> > +     int ret;
> > +
> > +     ret =3D mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
> > +                                   nand->memorg.oobsize);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mtd_set_ooblayout(mtd, &mtk_snand_ooblayout);
> > +
> > +     // This driver ignores any ECC capability configured by user or
> > +     // requested by the nand chip because the BootROM and MTK bootloa=
der
> > +     // expects the page format to be the exact one as calculated in
> > +     // setup_pagefmt.
>
> I don't like this :)
>
> I understand that the boot partition might have specific constraints,
> but other partitions (or if we don't use the NAND to boot?) should
> probably be usable with other ECC schemes.

In this controller, the ECC step size is fixed and it can only change
ECC strength. The calculated ECC correction capability is the max
possible one supported by the controller.
I still want the default behavior to match the boot partition
requirement, because we can't just tell end-users to customize
their dts by taking apart their device and figure out which flash
is used.

I can implement the following:
1. select the minimum capability exceeding ecc.user_conf
2. If that doesn't exist, use the calculated one and warn
   if it doesn't meet ecc.requirements
Is this OK?

>
> > +     conf->step_size =3D snf->caps->sector_size;
> > +     conf->strength =3D snf->ecc_cfg.strength;
> > +
> > +     return 0;
> > +}
> > +
> > +static int mtk_snand_ecc_prepare_io_req(struct nand_device *nand,
> > +                                     struct nand_page_io_req *req)
> > +{
> > +     struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> > +     int ret;
> > +
> > +     ret =3D mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
> > +                                   nand->memorg.oobsize);
> > +     if (ret)
> > +             return ret;
> > +     snf->autofmt =3D true;
> > +     return 0;
> > +}
> > +
> > +static int mtk_snand_ecc_finish_io_req(struct nand_device *nand,
> > +                                    struct nand_page_io_req *req)
> > +{
> > +     struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> > +     struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> > +
> > +     snf->autofmt =3D false;
> > +     if ((req->mode =3D=3D MTD_OPS_RAW) || (req->type !=3D NAND_PAGE_R=
EAD))
> > +             return 0;
> > +
> > +     if (snf->ecc_stats.failed)
> > +             mtd->ecc_stats.failed +=3D snf->ecc_stats.failed;
> > +     mtd->ecc_stats.corrected +=3D snf->ecc_stats.corrected;
> > +     return snf->ecc_stats.failed ? -EBADMSG : snf->ecc_stats.bitflips=
;
>
> Did you verify that nandbiterrs -i succeeds?

I did a insmod mtd_nandbiterrs.ko dev=3Dx and the reported bitflips in
kernel log is correct.

Is there a userspace tool for this? I'd like to use that instead of a
kernel module in the future.

>
> > +}
> > +
> > +static struct nand_ecc_engine_ops mtk_snfi_ecc_engine_ops =3D {
> > +     .init_ctx =3D mtk_snand_ecc_init_ctx,
> > +     .prepare_io_req =3D mtk_snand_ecc_prepare_io_req,
> > +     .finish_io_req =3D mtk_snand_ecc_finish_io_req,
>
> I believe you need to take care of the bounce buffer in the exit path?

No. The buffer should be left there for non-ecc spi-mem operations.

>
> > +};
> > +
> > +static void mtk_snand_read_fdm(struct mtk_snand *snf, uint8_t *buf)
> > +{
> > +     uint32_t vall, valm;
> > +     uint8_t *oobptr =3D buf;
> > +     int i, j;
> > +
> > +     for (i =3D 0; i < snf->nfi_cfg.nsectors; i++) {
> > +             vall =3D nfi_read32(snf, NFI_FDML(i));
> > +             valm =3D nfi_read32(snf, NFI_FDMM(i));
> > +
> > +             for (j =3D 0; j < snf->caps->fdm_size; j++)
> > +                     oobptr[j] =3D (j >=3D 4 ? valm : vall) >> ((j % 4=
) * 8);
> > +
> > +             oobptr +=3D snf->caps->fdm_size;
> > +     }
> > +}
>
> Thanks,
> Miqu=C3=A8l



--
Regards,
Chuanhong Guo
