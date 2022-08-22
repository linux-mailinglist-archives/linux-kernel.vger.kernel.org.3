Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE1F59C0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiHVNrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiHVNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:47:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F5E326D8;
        Mon, 22 Aug 2022 06:47:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CF55240003;
        Mon, 22 Aug 2022 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661176042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sscI+utw7UeN+kt2px5VHaoBUQ5CCQ3wrVjDujYWxo=;
        b=Dzy88cGhBVSh02adf6d2cLr9vLxIMwZ6RXeyIPfRrQ0DYQe6vOvL0nJrfjjCyzdGy2vS4X
        Lvzeqs3dbLlD9qIFeGsZ1vV4+vSPgqiGMRphQNKuATrLiHupejBTxhSm8OLWv/J35tbc0l
        ELkf9zztr8A+1AC83IRddo4qGgoJlm2I5gQwa8wx98P9WT6xHTuTY4xbruSzajx7uGwgvx
        mEak+Q/cLlxrwkq6C3hnim9zSdgHxYtOE6fLT5wr6kahHAOfmsc6j9gFHdDNBc8t/++/WS
        2gAgtZJNnfoq5SlCMe58cxkLhQ9mwTUg/qg6Zvo8jkQHgfdPuv4F5QrjFqCERA==
Date:   Mon, 22 Aug 2022 15:47:15 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/6] media: sun8i-a83t-mipi-csi2: Add a Kconfig
 dependency on RESET_CONTROLLER
Message-ID: <YwOI42B5sNnBl3E5@aptenodytes>
References: <20220812220045.800820-1-paul.kocialkowski@bootlin.com>
 <20220812220045.800820-2-paul.kocialkowski@bootlin.com>
 <5847498.lOV4Wx5bFT@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JOyupF446Ly1kWag"
Content-Disposition: inline
In-Reply-To: <5847498.lOV4Wx5bFT@jernej-laptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JOyupF446Ly1kWag
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Sun 14 Aug 22, 08:46, Jernej =C5=A0krabec wrote:
> Dne sobota, 13. avgust 2022 ob 00:00:41 CEST je Paul Kocialkowski napisal=
(a):
> > The driver relies on the reset controller API to work, so add
> > RESET_CONTROLLER as one of its Kconfig dependencies.
> >=20
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>=20
> Please add fixes tag here and in the rest of the series.

Okay I wasn't sure it was worth it since there is no build-time requirement
and no Kconfig select/depend issue here.

But I guess it doesn't hurt, so will do.

Thanks,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--JOyupF446Ly1kWag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMDiOMACgkQ3cLmz3+f
v9Hy4Qf+O2dYeRSZv812GHguUIsbBoP1zxN9Irplf8+U+xE52iA5uc3+45JRedmE
DfQJOBkGVUFGlLB0hTaJuPLo7biU2RqW8cVKNNihiw1AlBMChpoYHtTdGaLHqn5T
f4GmoTQ7EwfxPw2NsrxxFdgyeH8mLRxfOZv/Ld9q+4w9GooX5cLshjpQ/pmjpz4e
eYmTyyw9/iIED6mLErLuYmA5TdK2UPet+zf/w6LuIZFNRk6wWcfOhrq701MgtoG3
KjBFPTaOc5wBoCtjhpwKJQ5EMVOAE8E3qTj8BhgfT9UHJAEUss2xox7a09hrWAK8
nmShJ8P0wFZ6nrrg5MraxYoxbq15Rw==
=VBYz
-----END PGP SIGNATURE-----

--JOyupF446Ly1kWag--
