Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2351210A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiD0PQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239216AbiD0PQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:16:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003136E1D;
        Wed, 27 Apr 2022 08:13:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EBD57FF807;
        Wed, 27 Apr 2022 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651072387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=77woMB9sIvE36mfc5Tehmi9aSEDP7KlMxvPibRtT2hY=;
        b=ezWpYA4+8e7y5MyQ8IuWyHLreUzgT/6Y2GMum2gh2jsNxMk4nQbU0HQSmS6K4F/T/OuDdP
        3n+IB8jRO6U7q369DZZsSacWNPgAWWythX5mundXVJtfVO+YI0m72NSy++vE65oqU6pI3k
        5W3wvL2Cm3UheSG7FqcDKo8XRpAgUiXovPMQIaPslimXRusFD6bAaAv1Njl2E8umvnxckZ
        jRswnkAuKSohoiTa6W0NqGWu4fKk77ioHnDSLdpACQxmJ1Dm9PG04Hq3Yqpregl9OpshyF
        vedacIlLlmdEZRe+Ot4/HAO/6F9cs+ibR1UrrBcbMa6s/NOlJKQkD7WhbHuAxw==
Date:   Wed, 27 Apr 2022 17:13:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
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
Subject: Re: [PATCH v6 0/5] spi: add support for Mediatek SPI-NAND
 controller
Message-ID: <20220427171302.5d374ea9@xps13>
In-Reply-To: <YmlPlhKTrRXZo/Sx@sirena.org.uk>
References: <20220424032527.673605-1-gch981213@gmail.com>
        <20220427112857.7ddd7fc8@xps13>
        <CAJsYDV+DfBEmWr7D1aO8F=3WMurAg6aEhf5gY86BXOUSyJ2nXA@mail.gmail.com>
        <YmlPlhKTrRXZo/Sx@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Wed, 27 Apr 2022 15:13:42 +0100:

> On Wed, Apr 27, 2022 at 10:04:57PM +0800, Chuanhong Guo wrote:
> > On Wed, Apr 27, 2022 at 5:29 PM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote: =20
>=20
> > > The patch actually look independent, so if it's fine for you I can ta=
ke
> > > the two mtd patches and let you merge the spi/binding changes. =20
>=20
> > Out of curiosity:
> > Wouldn't that break the build for spi subsystem? Because... =20
>=20
> > > >  rename drivers/mtd/nand/raw/mtk_ecc.h =3D> include/linux/mtd/nand-=
ecc-mtk.h (100%) =20
>=20
> > The spi driver needs this header file which is moved in the mtd patch. =
=20

Ah, yeah, right.

> Ah, that'll be an issue indeed - if I could get a signed tag with the
> dependency in it I can go ahead with the SPI bits?

Ok, I'll share an immutable tag.

Thanks,
Miqu=C3=A8l
