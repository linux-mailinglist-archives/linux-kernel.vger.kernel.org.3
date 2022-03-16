Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDF74DB0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356158AbiCPNPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiCPNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:15:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223172FFF4;
        Wed, 16 Mar 2022 06:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFA6EB81AF1;
        Wed, 16 Mar 2022 13:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68261C340E9;
        Wed, 16 Mar 2022 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647436445;
        bh=PPEdrkC2g3AuMzIflKtsmZp90mDJiQKJzTZHqWU7j2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dsQEHOPi4VCSBnpZQFMtW9oY+THFPTyhl3Y/NRkS65ZWneiV0VUm9UOuKn/GC4XO6
         MIkWB9Hum2j9HAl2keiGrrH17W3rHooUubujo4wvxFVpETB4uzHtkiRR8EzibKmvMq
         7ZBNg+uZpMGItP3htNY/EPIb2WVVhKufl49dNTWzxmSN3qzHWuQiq3vZkZnWApI5CI
         nx0i4JWp1RSM+0Dwu2WSPz+fPLdfHC6MGWzz9LWZxFgEZUxz+xfkOYa07uw2IWJPEf
         02hMl7yIkzBtmyJrTM4n2CrLmW0yv9/4EOJq21Q2SgaTXs9opGPrVJBKaa9hMhnPbS
         aLwgaUe5PWmVw==
Date:   Wed, 16 Mar 2022 14:13:57 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <20220316141357.2a460bf3@coco.lan>
In-Reply-To: <5701348.MhkbZ0Pkbq@kista>
References: <cover.1647274406.git.mchehab@kernel.org>
        <20220315092736.7e805c81@coco.lan>
        <YjBPuafv1B5dbu/r@pendragon.ideasonboard.com>
        <5701348.MhkbZ0Pkbq@kista>
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

Em Tue, 15 Mar 2022 19:04:05 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> escreveu:

> > > By organizing entries per vendor, while we may need to do puntual
> > > per-vendor adjustments when they rename and change IP with other
> > > vendors, the global platform Kconfig/Make will contain a single entry
> > > per vendor. I can't foresee any need to change this in the future,
> > > if we take care of keeping the entries there properly sorted.
> > >=20
> > > With regards to naming the per-vendor directory, while I do prefer to=
 have
> > > the  directories named after the vendor, and not after a vendor's nic=
k=20
> > > name, It should also be ok to use a vendor's nick name, provided that=
=20
> > > such name is meant to be used by all their current and future IP.
> > >=20
> > > Not sure if "sunxi" is actually a vendor's nick name. It sounds
> > > much likely that it is, instead, a brand name that covers their=20
> > > current media-related SoC.=20
> > >=20
> > > Can someone from the vendor shed a light on it? =20
>=20
> Allwinner (as a company) isn't directly involved in maintaining upstream =
Linux=20
> support. Drivers are provided by linux-sunxi community, sometimes by clea=
ning=20
> up vendor drivers or more often by writing them from scratch.
>=20
> That being said, "sunxi" is extensively used in vendor kernel, most often=
 it's=20
> directory name containing vendor specific driver. It's derived from SoC f=
amily=20
> name, like sun4i, sun5i, sun5i, sun50i, etc. where number is replaced wit=
h X.
>=20
> sunxi is synonym for Allwinner basically from the start. Community build=
=20
> around these SoCs is called linux-sunxi and even entry in MAINTAINERS con=
tains=20
> both names: "ARM/Allwinner sunXi SoC support". Note that sunxi is not lim=
ited=20
> to ARM SoCs. RISC-V family is called sun20i.
>=20
> Hope this helps.

Ok, so let's then keep it named as "sunxi", and place all drivers from=20
Allwinner there.

Thanks,
Mauro
