Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265BE57F138
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiGWTc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23391CFCC;
        Sat, 23 Jul 2022 12:32:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD9260EE7;
        Sat, 23 Jul 2022 19:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABA4C341C0;
        Sat, 23 Jul 2022 19:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658604742;
        bh=r76yhUR7QKLJMAoy6hSEb7FVeJ3UbPDQ0zjweE5Xi7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbCcUVRVkjXPWali+tO0le/YmpX51kLQ4oWzUFmBExYjbQC7O1nmjM8fAt2liyx10
         c2/cunLWptyOx1cS6vkIUrjkFL+eNFHuOTMtSvwxvN0kYoba1eC+hcnGX9taFMJjJE
         iNDaUsstaZsBr2m0Wsg+vs/hLO3k8hbLELgDPWrxM3Kzf4VEOYE1BCiUQQh265U4R+
         2xvrgFZTGkSxSXwKvhPjOyCOE93CUKs1sqy0WoCHFD2mAIpgWwl028tVq8fvFUNt5c
         ECpvhJ5ZCTkARqs53RovCFNakByC1TTefUmD4v88UIP4euaUJXxNeZVdNbIvIdKbiI
         xpdfhkjtWCu7g==
Date:   Sat, 23 Jul 2022 20:32:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zhou Yanjie <zhouyanjie@wanyeetech.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Subject: Re: [PATCH 3/3] SPI: Ingenic: Add SFC support for Ingenic SoCs.
Message-ID: <YtxMwyRghFKS/vu5@sirena.org.uk>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-4-git-send-email-zhouyanjie@wanyeetech.com>
 <YtrukeLk9fInqQIL@sirena.org.uk>
 <89d22457-8c62-e441-3bf4-2734ec2a45e1@wanyeetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkIhzO/ccCxeVEBm"
Content-Disposition: inline
In-Reply-To: <89d22457-8c62-e441-3bf4-2734ec2a45e1@wanyeetech.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kkIhzO/ccCxeVEBm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 24, 2022 at 01:06:16AM +0800, Zhou Yanjie wrote:
> On 2022/7/23 =E4=B8=8A=E5=8D=882:38, Mark Brown wrote:

> > > +++ b/drivers/spi/spi-ingenic-sfc.c
> > > @@ -0,0 +1,662 @@
> > > +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +/*
> > > + * Ingenic SoCs SPI Flash Controller Driver

> > Please make the entire comment a C++ one so things look more
> > intentional.

> I'm sorry, I didn't understand well what you meant :(
> Could you please explain a little more detail?

The above comment block uses both C /* */ and C++ // style comments,
please make it just use the C++ style.

> > > +static irqreturn_t ingenic_sfc_irq_handler(int irq, void *data)
> > > +{
> > > +	struct ingenic_sfc *sfc =3D data;
> > > +
> > > +	writel(0x1f, sfc->base + SFC_REG_INTC);
> > > +
> > > +	complete(&sfc->completion);
> > > +
> > > +	return IRQ_HANDLED;
> > > +}

> > This doesn't pay any attention to any status registers in the chip so
> > won't work if the interrupt is shared and won't notice any error reports
> > from the device...

> This interrupt is exclusively owned by SFC, do we still
> need to perform the operation you said? I haven't done
> these operations before because I want to minimize the
> overhead and avoid affecting performance.

Even if the device is not shared is there no possibility that the
device can report an unexpected interrupt status?  It's not just
the sharing case, it's also the fact that it looks like there's a
status being reported but we're not checking it so if anything
goes wrong then we're less likely to notice.  I'd worry about
data corruption.

--kkIhzO/ccCxeVEBm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLcTMIACgkQJNaLcl1U
h9BGtQgAggYv7Qn1OTgVIXH8mGUCfK3TknrnNuKFde/MvOziGFcDFwDuHzjYQZa3
00276bM4+r3UL3UZqxzUBDDUfDrjD++d40lyIBtMOiSoTdMAM6IAXYmrVkPwe/0D
4A9fXEdkuFEQAB/aaQGHhlHVFSHhJG20/vTZ5n0DFVUFnT1O134ido7AZU6RUQZ3
/9g92pmE3u8sNn0OFpGRsNoOdK1pZtrd9D0ByyY3PJy9QeM3gkGtkhdC4DISvB0U
234iv6TDKZ/sfHTPZ7lnifdxuEKFzqVlYlPAchiu0xY0sEzq0JbxeZLCkjS3s8de
1QRQhBSwCyXFQPsacWETl7fHXwO+2A==
=AxAB
-----END PGP SIGNATURE-----

--kkIhzO/ccCxeVEBm--
