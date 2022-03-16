Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B74DB08A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356081AbiCPNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356044AbiCPNMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:12:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4325D66211;
        Wed, 16 Mar 2022 06:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65FBDB81B10;
        Wed, 16 Mar 2022 13:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C654CC340E9;
        Wed, 16 Mar 2022 13:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647436244;
        bh=ESbbcLu/1iy4VCTs0pWTJ94umpC1+FygKacL+9W4w10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DcPUYzV1Aku3NcbcTL9mdkMh1LWnKoJ2XTkIoBo8wtuneK7AqFc5LHQ4+RsZN47Ro
         TUy+Ll7nYCAG/HLI4ecmBAy3F8pMq2hKFdrktfkGgYIUyQIqhi6BpKNY4NNZlrwBdc
         bDycPpgG8QFWVaCQyI7Z7R9RUmhpU3ikfyMX+RiOvQJFuCwXkoOHOdgqt3f3mh2/4A
         FLjpYtyz+8GJAufTG1ItDJyYjVNYgohQjdE6hRq2Z3M53jAH1DdJ8nEs29BzSHqjX1
         WgXwGnUKBXVbeoSSLJNdFH0PUjhcoFnbgVtX/co3lCeBFRoQLvayqkwO2Xcs8DRi1M
         UUGpV/32fmXNg==
Date:   Wed, 16 Mar 2022 14:10:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Ondrej Jirman <megous@megous.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 47/67] media: platform: rename sunxi/ to allwinner/
Message-ID: <20220316141036.1c9ad0c6@coco.lan>
In-Reply-To: <YjBPuafv1B5dbu/r@pendragon.ideasonboard.com>
References: <cover.1647274406.git.mchehab@kernel.org>
        <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
        <2816975.e9J7NaK4W3@kista>
        <20220315064005.10ecdab2@coco.lan>
        <YjA4IRD//lb8SKgs@pendragon.ideasonboard.com>
        <20220315092736.7e805c81@coco.lan>
        <YjBPuafv1B5dbu/r@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 15 Mar 2022 10:35:05 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> On Tue, Mar 15, 2022 at 09:27:36AM +0100, Mauro Carvalho Chehab wrote:
> > Em Tue, 15 Mar 2022 08:54:25 +0200
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> >  =20
> > > Hi Mauro,
> > >=20
> > > On Tue, Mar 15, 2022 at 06:40:05AM +0100, Mauro Carvalho Chehab wrote=
: =20
> > > > Em Mon, 14 Mar 2022 18:22:20 +0100 Jernej =C5=A0krabec escreveu:
> > > >    =20
> > > > > Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho =
Chehab=20
> > > > > napisal(a):   =20
> > > > > > As the end goal is to have platform drivers split by vendor,
> > > > > > rename sunxi/ to allwinner/.
> > > > > >=20
> > > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>     =
=20
> > > > >=20
> > > > > I would rather not do that. Everything related to Allwinner is ca=
lled sunxi,=20
> > > > > albeit there are a few outliers. This is similar to Amlogic/meson=
 situation.   =20
> > > >=20
> > > > The rationale of having one directory per manufacturer is that, if =
drivers
> > > > for newer platforms with different names from the same manufacturer=
s are=20
> > > > added, those will still fit under allwinner/ and amlogic/.
> > > >=20
> > > > The Kconfig names for sunxi and meson didn't change, nor the driver=
's name.=20
> > > > Also, the directories under allwinner preserve sun<x>i name on them:
> > > >=20
> > > > 	drivers/media/platform/allwinner/
> > > > 	=E2=94=9C=E2=94=80=E2=94=80 sun4i-csi
> > > > 	=E2=94=9C=E2=94=80=E2=94=80 sun6i-csi
> > > > 	=E2=94=9C=E2=94=80=E2=94=80 sun8i-di
> > > > 	=E2=94=94=E2=94=80=E2=94=80 sun8i-rotate
> > > >=20
> > > > and so the directory under amlogic/:
> > > >=20
> > > > 	drivers/media/platform/amlogic/
> > > > 	=E2=94=94=E2=94=80=E2=94=80 meson-ge2d
> > > >=20
> > > > Now, if Allinner decides to release a new platforms named after ano=
ther star,
> > > > let's say, "Vega" and "Rigel", it would be just a matter of adding=
=20
> > > > "vega/" and "rigel/" directories under allwinner. No need to touch
> > > > media/platform/Kconfig and media/platform/Makefile. Everything will=
 happen
> > > > on much more smaller vendor-specific Kconfig/Makefile.   =20
> > >=20
> > > But the day Allwinner changes its name to Noloser, we'll have a simil=
ar
> > > problem.  =20
> >=20
> > Not really. It will still be a single directory per vendor (whatever
> > name it is).
> >  =20
> > > Thnk about Freescale vs. NXP, or Altera bought by Intel. =20
> >=20
> > Yeah, when some drivers move from one vendor to another one that
> > already exists there, we should probably move the directories, in
> > order to keep things well organized. =20
>=20
> I'm not sure we should. We still have arch/arm64/boot/dts/freescale/ for
> instance. We can answer that question later though, when confronted with
> the situation.

It would be messy if some drivers under a

	media/platform/vendor_a/

directory would actually belong to vendor_b, which also has its own
media/platform/vendor_b/ directory.

On such case, I do think we should move stuff. Now, if everything
under a "media/platform/vendor_a/" directory are now property of
a vendor_c which doesn't have yet any directory there, I don't see
and problems on not renaming - and even adding new drivers there
that would belong to vendor_c.

>=20
> > The worse case scenario is really if, let's say, TI decides to sell the=
ir
> > omap architecture to NXP, keeping the rest. On such case, the best would
> > be to move platform/ti/omap* to the directory of its newer owner.
> >=20
> > That's said, when things like that happen, there are usually a change
> > at MAINTAINERS, as e-mails, mailing lists and contact people will
> > likely change. So, this will very likely generate patches anyway.
> >  =20
> > > No
> > > naming scheme is totally future-proof. If the accepted standard throu=
gh
> > > the kernel is to use sunxi to refer to Allwinner SoCs, I don't think
> > > it's a bit idea to go with that. =20
> >=20
> > I'm not too concerned about the name here, but rather about the
> > process. Needing to do reorg like this is painful, as it causes=20
> > all pending work to fail merging against upstream, requiring rebases.
> > So, we should avoid needing to re-do it by trying our best to avoid
> > the need of another global change like that in the future. =20
>=20
> Most of the pain we'll go through in the immediate future comes from the
> fact that we never really cared about this.=20

Nah, we had other reorgs in the past, also trying to better organize
stuff, like splitting M2M from V4L and DVB platform drivers.

The thing is that the number of entries at platform/ increased
a lot, and that justifies a major change.

> I think renames (of vendors
> or product lines) will be infrequent enough that picking sunxi for
> Allwinner drivers wouldn't be an issue.

Agreed.

> There's a similar think with Renesas, which had an SH product line and
> then moved to ARM, creating R-Mobile and R-Car (among other product
> liens). That's why we still have drivers/dma/sh/ for Renesas DMA
> drivers.
>=20
> > By organizing entries per vendor, while we may need to do puntual
> > per-vendor adjustments when they rename and change IP with other
> > vendors, the global platform Kconfig/Make will contain a single entry
> > per vendor. I can't foresee any need to change this in the future,
> > if we take care of keeping the entries there properly sorted.
> >=20
> > With regards to naming the per-vendor directory, while I do prefer to h=
ave
> > the  directories named after the vendor, and not after a vendor's nick=
=20
> > name, It should also be ok to use a vendor's nick name, provided that=20
> > such name is meant to be used by all their current and future IP.
> >=20
> > Not sure if "sunxi" is actually a vendor's nick name. It sounds
> > much likely that it is, instead, a brand name that covers their=20
> > current media-related SoC.=20
> >=20
> > Can someone from the vendor shed a light on it? =20
>=20
> Maybe we can let the Allwinner upstream community tell us what name to
> pick ? I'm sure they know better than us :-)

Works for me.

Thanks,
Mauro
