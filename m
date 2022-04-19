Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBBF5075F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350623AbiDSRHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355729AbiDSRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3513CC5;
        Tue, 19 Apr 2022 10:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0116EB81C0E;
        Tue, 19 Apr 2022 17:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922D3C385A7;
        Tue, 19 Apr 2022 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650387647;
        bh=8IybAGIoEFhxdFIoViUdHi9R1OLP0LV7n7ET52ewC2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qdjUxUzOK47L0cZIifXSz7UsJ/T7pNWT1lav0S4UTA8SkRPMr6OdjuoKmjjzSRWfJ
         c3Xc1N3dEddrAcMeEEi8qeX5V5sR4mj5H2pl/GqHbzIrg/5uen4eHooQ7QK27CxD93
         /bgTlksGlnGhbtU2K/wLZ1TtfMwjR2bY2Me8a/6EsoJHYJe7AmE3j9jK687/wZjmYG
         FwBmVqne5WOPD1xmA8Jr7ZwOKbe2EMNx954jbcxWcC/YLLogTiVNzqEv5qZ5QH87AW
         0EyiQAOimaazn0wf9dDUIUWArgmFqwLHtciNhvT+xOtcx+skhmwvBV8+TgAnsie9I7
         dQNvu8BfrMzDA==
Date:   Tue, 19 Apr 2022 18:00:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: Re: [PATCH 1/3] SPI: Ingenic: Add support for use GPIO as chip
 select line.
Message-ID: <Yl7quUXmEEPHfTfC@sirena.org.uk>
References: <1650032528-118220-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1650032528-118220-2-git-send-email-zhouyanjie@wanyeetech.com>
 <61ZDAR.SD20HFTWMIBH3@crapouillou.net>
 <d7926a1d-c5e3-6519-6a52-1bd3ca3cf773@wanyeetech.com>
 <A5YFAR.5U5RNX82OXJY1@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TPbCuVtMSsnBjIIh"
Content-Disposition: inline
In-Reply-To: <A5YFAR.5U5RNX82OXJY1@crapouillou.net>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TPbCuVtMSsnBjIIh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 16, 2022 at 05:36:46PM +0100, Paul Cercueil wrote:
> Le sam., avril 16 2022 at 19:55:13 +0800, Zhou Yanjie
> > On 2022/4/15 =E4=B8=8B=E5=8D=8811:00, Paul Cercueil wrote:

> > > > -    ctlr->num_chipselect =3D 2;
> > > > +    ctlr->use_gpio_descriptors =3D true;

> > > I wonder if this should be set conditionally instead. Maybe set it
> > > to =7F"true" if the "num-cs" property exists?

> > I'm not too sure, but it seems some other drivers like "spi-sun6i.c",
> > "spi-stm32.c", "spi-s3c64xx.c", "spi-pic32.c", etc. set it
> > unconditionally.

> Ok, maybe Mark can enlighten us here.

use_gpio_descriptions is just selecting which version of the GPIO APIs
we should use if we're handling GPIOs rather than if we should handle
them.  We've got one last driver using the numerical GPIO APIs, once
that one is converted we should just be able to drop the flag since
everything will be using descriptors.

--TPbCuVtMSsnBjIIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJe6rgACgkQJNaLcl1U
h9AHLwf9E2iqsfV37dO0NFH186Odz4Z0j8xceQsmNj3PyljXnw7Lbtdei5aoZuwM
sZXNQuwleO6VDzrjN5Wo7SapZyL520L0HOXQPZG+hMk97RiHFMO5olCkJyOZet6S
Ypu4loL1Qh+HZp1OWU824dxjQqthLJoCDMHdH0PVPqIAceXjX3MFw64eQrQy+MG8
+EPD7uM0Zlun8NJ2h/i/7ufTnblDAXvxGb4XJah8Pl1KBTvHGy8C8Agiv6fKJxZW
v+4qI1x+OP/DczQ3JK2TGW9q3a7QiekvFpFoMgx7GEl/c2UEYd9VvhGJF2biZRD+
720Kf278lwoaPdTexlUFU91unE2XuQ==
=syA4
-----END PGP SIGNATURE-----

--TPbCuVtMSsnBjIIh--
