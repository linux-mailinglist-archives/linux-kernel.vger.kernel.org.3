Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765F24D962A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345825AbiCOI3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiCOI3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA04A396;
        Tue, 15 Mar 2022 01:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E657614B1;
        Tue, 15 Mar 2022 08:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449EC340E8;
        Tue, 15 Mar 2022 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647332866;
        bh=PzaSS6OJhjKG8MRjLmHkIO4J1pFecT5G3HQMXrvWXnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DOyVbRt97sAMMgd6Znohcz4a+IAm1dZrKjPIezbNGUUKt94/f2aIastNcy1e0xq4W
         cuT6WhU3QvONJZe58I186sZiLAkHxE/xdAGX0tuwIrkMpwFObSPxAD+bZmO4XIorfU
         WyEPxPgX6/yUY5smIhhgrDJfrnm38wUneSIKojIDkh+V3pUsY8eu8EDIC5BHAs3NFe
         PVgwSJHOCf/qrLlI+YPEyIMrG2R0/EirX/2Xx5gmOPuMlk60nBULpEaxQKznaoO03B
         QhoH8tboq0FC4dy+qID/xBHIbblLWSXijN9wOeNzQ5CueQe3YjK+B0PDf2mdV4lGHb
         sjwX8X0sSGjrg==
Date:   Tue, 15 Mar 2022 09:27:36 +0100
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
Message-ID: <20220315092736.7e805c81@coco.lan>
In-Reply-To: <YjA4IRD//lb8SKgs@pendragon.ideasonboard.com>
References: <cover.1647274406.git.mchehab@kernel.org>
        <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
        <2816975.e9J7NaK4W3@kista>
        <20220315064005.10ecdab2@coco.lan>
        <YjA4IRD//lb8SKgs@pendragon.ideasonboard.com>
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

Em Tue, 15 Mar 2022 08:54:25 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:

> Hi Mauro,
>=20
> On Tue, Mar 15, 2022 at 06:40:05AM +0100, Mauro Carvalho Chehab wrote:
> > Em Mon, 14 Mar 2022 18:22:20 +0100 Jernej =C5=A0krabec escreveu:
> >  =20
> > > Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho Cheh=
ab=20
> > > napisal(a): =20
> > > > As the end goal is to have platform drivers split by vendor,
> > > > rename sunxi/ to allwinner/.
> > > >=20
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>   =20
> > >=20
> > > I would rather not do that. Everything related to Allwinner is called=
 sunxi,=20
> > > albeit there are a few outliers. This is similar to Amlogic/meson sit=
uation. =20
> >=20
> > The rationale of having one directory per manufacturer is that, if driv=
ers
> > for newer platforms with different names from the same manufacturers ar=
e=20
> > added, those will still fit under allwinner/ and amlogic/.
> >=20
> > The Kconfig names for sunxi and meson didn't change, nor the driver's n=
ame.=20
> > Also, the directories under allwinner preserve sun<x>i name on them:
> >=20
> > 	drivers/media/platform/allwinner/
> > 	=E2=94=9C=E2=94=80=E2=94=80 sun4i-csi
> > 	=E2=94=9C=E2=94=80=E2=94=80 sun6i-csi
> > 	=E2=94=9C=E2=94=80=E2=94=80 sun8i-di
> > 	=E2=94=94=E2=94=80=E2=94=80 sun8i-rotate
> >=20
> > and so the directory under amlogic/:
> >=20
> > 	drivers/media/platform/amlogic/
> > 	=E2=94=94=E2=94=80=E2=94=80 meson-ge2d
> >=20
> > Now, if Allinner decides to release a new platforms named after another=
 star,
> > let's say, "Vega" and "Rigel", it would be just a matter of adding=20
> > "vega/" and "rigel/" directories under allwinner. No need to touch
> > media/platform/Kconfig and media/platform/Makefile. Everything will hap=
pen
> > on much more smaller vendor-specific Kconfig/Makefile. =20
>=20
> But the day Allwinner changes its name to Noloser, we'll have a similar
> problem.=20

Not really. It will still be a single directory per vendor (whatever
name it is).

> Thnk about Freescale vs. NXP, or Altera bought by Intel.

Yeah, when some drivers move from one vendor to another one that
already exists there, we should probably move the directories, in
order to keep things well organized.

The worse case scenario is really if, let's say, TI decides to sell their
omap architecture to NXP, keeping the rest. On such case, the best would
be to move platform/ti/omap* to the directory of its newer owner.

That's said, when things like that happen, there are usually a change
at MAINTAINERS, as e-mails, mailing lists and contact people will
likely change. So, this will very likely generate patches anyway.

> No
> naming scheme is totally future-proof. If the accepted standard through
> the kernel is to use sunxi to refer to Allwinner SoCs, I don't think
> it's a bit idea to go with that.

I'm not too concerned about the name here, but rather about the
process. Needing to do reorg like this is painful, as it causes=20
all pending work to fail merging against upstream, requiring rebases.
So, we should avoid needing to re-do it by trying our best to avoid
the need of another global change like that in the future.

By organizing entries per vendor, while we may need to do puntual
per-vendor adjustments when they rename and change IP with other
vendors, the global platform Kconfig/Make will contain a single entry
per vendor. I can't foresee any need to change this in the future,
if we take care of keeping the entries there properly sorted.

With regards to naming the per-vendor directory, while I do prefer to have
the  directories named after the vendor, and not after a vendor's nick=20
name, It should also be ok to use a vendor's nick name, provided that=20
such name is meant to be used by all their current and future IP.

Not sure if "sunxi" is actually a vendor's nick name. It sounds
much likely that it is, instead, a brand name that covers their=20
current media-related SoC.=20

Can someone from the vendor shed a light on it?

Thanks,
Mauro
