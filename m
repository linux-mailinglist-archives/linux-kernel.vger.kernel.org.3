Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740FB577230
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiGPXJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiGPXJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:09:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE6823162;
        Sat, 16 Jul 2022 16:08:40 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8DB9166015C4;
        Sun, 17 Jul 2022 00:08:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658012919;
        bh=qFLaZvMg2AYrF82h/8wqHFhuZS2nbfO12rvH/2Eu8BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCay5zWOLvQkDgVoUQVTovwaGr3nmPFhXPw6qztDtxOvYWaEQ2QhKINJ53bd490zg
         gy6u1jwGEzz1DZcXLsQH3AoXXH7MNkr6LNGZ+mu6HQeCyrKY6+njQrPzIDdSrnUJIo
         A8hEKDuNoHnEpzsS/bs5qckaUkY8vkPr0+fH98Gfem6848t6oDGhD2tyPcR4hg4Phr
         7JViFfqQ8Iz2VqLXNi2sN8g+VMoytI82SAlTaMXMfKUu3m6LgR4CBRJPOD70VzNB5G
         uP9RomsVobp4apiGcVRXxZngYrEaTCbXSnJaNC9NqG0VX2MkQnLuXy0IYsgGWQv3HX
         Q5O2VCBAS4Olw==
Received: by mercury (Postfix, from userid 1000)
        id C111D1060428; Sun, 17 Jul 2022 01:08:36 +0200 (CEST)
Date:   Sun, 17 Jul 2022 01:08:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zheng Bin <zhengbin13@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaochao49@huawei.com
Subject: Re: [PATCH -next] power: supply: ab8500: add missing
 destroy_workqueue in ab8500_charger_bind
Message-ID: <20220716230836.5c7wbyasiddkoro4@mercury.elektranox.org>
References: <20220512093844.1109923-1-zhengbin13@huawei.com>
 <20220609222239.5fssqczkdqy4inoz@mercury.elektranox.org>
 <CACRpkdY=BY09fRb+SCTCbb=Nd6i-hD4LznjtOg10VivMbLb2ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgrh2647v3fqrzpm"
Content-Disposition: inline
In-Reply-To: <CACRpkdY=BY09fRb+SCTCbb=Nd6i-hD4LznjtOg10VivMbLb2ew@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgrh2647v3fqrzpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 23, 2022 at 04:20:52PM +0200, Linus Walleij wrote:
> On Fri, Jun 10, 2022 at 12:22 AM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Thu, May 12, 2022 at 05:38:44PM +0800, Zheng Bin wrote:
> > > ab8500_charger_bind misses destroy_workqueue in error path,
> > > this patch fixes that.
> > >
> > > Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> > > ---
> >
> > LGTM, but adding Linus to Cc and waiting a bit to give him time to
> > react.
>=20
> Don't have the original patch in my inbox so can't test it, but looks
> reasonable so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued.

-- Sebastian

--dgrh2647v3fqrzpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmLTRPQACgkQ2O7X88g7
+pr0Gg//bF5Ag+D+1UYkboatf6SG9KQiZ4hDWqFjDDN9DiWDQJls6gWa6TsuBt3h
Fbq1B4B0ko2AcI5ZDN3kxNcQuetMv92VsFGlKmjrGTWybtzx4IsKeX9Ge+nIgulW
Zzm+DMKTqSKEE2RxKo4CBuL2MYhYyfZgy7xlJ1liveO+0j4z2+IqW1+azDLvGZ4S
ABD7HMBCu5/6djw6wM3A6dsRSQsbSp9QWRnn4TbFhwg+/faLNvi7hW1L03VIeN6U
9p+s0RybTNz2oLtwxJ+kO0RHCP9lyI98nmtITTg2cxtnsU5+xAhK87Ve9se26kWk
m2FVGtfRz9cKHfbKaC8BQcEC3heXFc6twMKHS/1aRZPrJ6lY1kp7kOSmymKL8ynQ
K8M6PGxQROy7EE7fpn2UYduZhfSKbxoInRrYLstJnHDrT0XHS5fGr7UfLRFCorSE
gfytq6+GEO7WqEaKlrw47JkvJAKZfZppcWHySo+RLCcGj7ptX2QcNRI84WC5zifS
0B+RrNzJeo9K4ZyDimSJuQT8g2gmYMY3YsE09N31TaMwu/5pqvJClvOzWl+tPv24
955m/xTjlQy/YGORayBnIlEv4xHnMuW7cp5l+890WDm0NW+z8crcSwjm+Br4mkGs
9BeqJ/2IF1UGsJUnuGWjdO5nUg5FUASXR6Nwj0cOOlBJki6pvjw=
=CaEC
-----END PGP SIGNATURE-----

--dgrh2647v3fqrzpm--
