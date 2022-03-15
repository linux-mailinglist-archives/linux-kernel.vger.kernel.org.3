Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990794D940A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbiCOFlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344987AbiCOFl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:41:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5785D2B25A;
        Mon, 14 Mar 2022 22:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D5C61230;
        Tue, 15 Mar 2022 05:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E2AC340E8;
        Tue, 15 Mar 2022 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647322814;
        bh=wXWPVXRPXENP8NALGralEqtS/drLb+SU4td0zBti85A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SjyYaCDrBrxyzNRbxFxckn94UJrvFdqkrAYM80hBMEh14/035F6SfjhZOIczhfubO
         U8PI9fVMEk4CJKylYZH6Frv8NlKImGJuhlyI+LSnVT8jXqNwYDkjgJPh7VAO4kubf1
         P3G+OsBafh6RuaazbR2aOdcVAsYAsoAhlvdy6f5MvAbanXIiqZrr4xqnlsInx6HlUx
         pR3WOwBPhShKg2I0OsAaFGRMVZG0yFEAk5YhdVU5jhOa/mXRgR7fUpySIMA5N1zBvy
         Lno+1T4Oqu+ZUzJRhfri+MST2t/4RS+rb4quJR331WRe3RZuMuGNIuTMvr0PPvh8h2
         OX32b4tZQh53w==
Date:   Tue, 15 Mar 2022 06:40:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <20220315064005.10ecdab2@coco.lan>
In-Reply-To: <2816975.e9J7NaK4W3@kista>
References: <cover.1647274406.git.mchehab@kernel.org>
        <85266b480902079391d4206b8aa276ff131a730f.1647274407.git.mchehab@kernel.org>
        <2816975.e9J7NaK4W3@kista>
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

Em Mon, 14 Mar 2022 18:22:20 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> escreveu:

> Dne ponedeljek, 14. marec 2022 ob 17:34:42 CET je Mauro Carvalho Chehab=20
> napisal(a):
> > As the end goal is to have platform drivers split by vendor,
> > rename sunxi/ to allwinner/.
> >=20
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org> =20
>=20
> I would rather not do that. Everything related to Allwinner is called sun=
xi,=20
> albeit there are a few outliers. This is similar to Amlogic/meson situati=
on.

The rationale of having one directory per manufacturer is that, if drivers
for newer platforms with different names from the same manufacturers are=20
added, those will still fit under allwinner/ and amlogic/.

The Kconfig names for sunxi and meson didn't change, nor the driver's name.=
=20
Also, the directories under allwinner preserve sun<x>i name on them:

	drivers/media/platform/allwinner/
	=E2=94=9C=E2=94=80=E2=94=80 sun4i-csi
	=E2=94=9C=E2=94=80=E2=94=80 sun6i-csi
	=E2=94=9C=E2=94=80=E2=94=80 sun8i-di
	=E2=94=94=E2=94=80=E2=94=80 sun8i-rotate

and so the directory under amlogic/:

	drivers/media/platform/amlogic/
	=E2=94=94=E2=94=80=E2=94=80 meson-ge2d

Now, if Allinner decides to release a new platforms named after another sta=
r,
let's say, "Vega" and "Rigel", it would be just a matter of adding=20
"vega/" and "rigel/" directories under allwinner. No need to touch
media/platform/Kconfig and media/platform/Makefile. Everything will happen
on much more smaller vendor-specific Kconfig/Makefile.

See for instance, TI. We had initially a single driver, and everywhere it
was called "omap", which was had gained different versions (omap2, omap3,=20
...). Then, TI decided to use other names for newer IP (davinci, am437x),=20
and now the current development is at cal and vpe.

If we had placed a ti/ directory by the time omap were added (and the
same for the other vendors), we would have avoided the need of this
reorg.

Thanks,
Mauro
