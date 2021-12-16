Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9154773B7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbhLPNzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhLPNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:55:48 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42C5C061574;
        Thu, 16 Dec 2021 05:55:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t18so44297605wrg.11;
        Thu, 16 Dec 2021 05:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIGXePb6uuyKEdP5anINB0mi5RZTL/ymGbXYta94nJg=;
        b=bjHYxaWsg+7VcP+S4a+QdmgpyK+6giwYoL5QN0eYIcY0V3HuSWIlmByyu0OxeXBODk
         i6QahJMgbb9jvsHn4Y16iSWbXxMwWTeJerl2YSnw0DYeyAFR6Ad4zadmrPktHC+GO8Xy
         m4gPrdna4pb75f55JeaKELoI40ylmCdcis8rep/nAhZC829Mgqi2FLkn69mjeog14CmS
         YoByKy46N2g9Svw59t1GnVD7YBgujN6sc0FwP7v9DMZFooBcZ/0jlxYqmdjIVwFupwr9
         QGq+P0nwEzWlpB5Hpp66E+Imn9aTOL56Ns9n+EdFz+8hLHGUMFQoUIQ7eqq2aT8FPjGH
         7WYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIGXePb6uuyKEdP5anINB0mi5RZTL/ymGbXYta94nJg=;
        b=C/U5nGIDRY5XPzLvqEpCO4K8RD+L0jm0nEXkF72NVizIMKod+njAcOOR5iwzFz4v7r
         jjbwzfTjARNgsn7kxBv3v0T2TM+9mXpH8gaa73pRS0MJegw8bAymdmM/pFauzxJkjUTU
         FQigTzZb7+Xtly+F6s42hBkdL3/CNUzltmjjLDrQeqFp7jUsRS6TT8gygP6NfVQ3ugaF
         kfVQxdtaRWXMBFBjybK8mt1a5NLGE8QwNZJc8rm4VWbDkhNCRIo3u+x0qbHtbLx5aZJ0
         yDAqRKEUlnupkOs4IczyocNWxltmDhvKKEsq3sWDyKo3lEv6h0+o/Y80CNrd645pMfXC
         OtOQ==
X-Gm-Message-State: AOAM530qxvL0W1ut7swQJKjsVdhl7I+voyqwKp4X7F2LYlCQWbDl6a1G
        5VRj8xUbdNGGmp09rx40CDk=
X-Google-Smtp-Source: ABdhPJw0BU7321M+NuHBlUDUl4qArnbnLCrw+1dI3O/QNXo8FyEsKyCBlFIpPZ72vmTMhlcW35T0jw==
X-Received: by 2002:adf:f049:: with SMTP id t9mr3324177wro.399.1639662946541;
        Thu, 16 Dec 2021 05:55:46 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id b19sm9049101wmb.38.2021.12.16.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:55:45 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:55:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 00/22] Support HDMI audio on NVIDIA Tegra20
Message-ID: <YbtFXcteESF0nLZz@orome>
References: <20211204143725.31646-1-digetx@gmail.com>
 <Ybo6tsnQM6OacoZs@sirena.org.uk>
 <26af30a6-9606-72d0-9258-cf9627ddfe77@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/kZ9M+KZOl3BGf8Y"
Content-Disposition: inline
In-Reply-To: <26af30a6-9606-72d0-9258-cf9627ddfe77@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/kZ9M+KZOl3BGf8Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 15, 2021 at 10:19:07PM +0300, Dmitry Osipenko wrote:
> 15.12.2021 21:57, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sat, Dec 04, 2021 at 05:37:03PM +0300, Dmitry Osipenko wrote:
> >=20
> >> I based S/PDIF patches on Arnd's Bergmann patch from a separate series=
 [1]
> >> that removes obsolete slave_id. This eases merging of the patches by
> >> removing the merge conflict. This is a note for Mark Brown.
> >=20
> > That's not in my tree so I'll need either a pull request with the series
> > or a resend after the merge window.
>=20
> This patch is included as a part of this series, please see the patch #6.
>=20
> I saw that Vinod Koul already merged it into his DMA tree [1] a day ago,
> but there is no stable branch there.
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?=
h=3Dnext
>=20
> >  It's also not clear what to do
> > about the DRM bits, I guess it's probably easiest to just apply them
> > along with the ASoC patches.
>=20
> I already asked Thierry Reding to take a look at this patchset. He will
> let to you know how the DRM bits should be handled. Hopefully this
> should happen tomorrow.
>=20
> We will know how to move forward if Vinod and Thierry will reply ASAP.
> Otherwise this series will have to wait for the next cycle.

I've applied the DRM patches to the drm/tegra tree and pulled in the ARM
device tree changes into the Tegra tree. I think the rest can go through
ASoC. Well, provided you can sort out the patch 6 issue with Vinod.

Thierry

--/kZ9M+KZOl3BGf8Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7RV0ACgkQ3SOs138+
s6EvjBAAt2FOUdF0TCSDCaSEKSFVQrAri9CBbbbCiohF9acoD/UG+pUtEe3MxqPD
sRbw0FT1mRbb374jZJOpJG95FQBT3+41QoAbXFB5cVbFCoJDRuyC3dzS738KZYw8
VYoWzTRt2wu247ZYsg6YSc6sAYwO9+GPkKU1CCoDJDlr/jLcof5qJVFXsIRwnjS9
5Qh8y6OiFFrPjlx3PVzPDFY1iYapzCsHTDr3WHKH6VymPo56oxZ/lRHHAnwlDqqC
K2YyGsk+4K0kzB2jokNyMqI2P2ZkDcfKVhMDIE0Zt9F5tf46WQrU3FMgaZ4bx6Rr
mglBqX6d9h8dmVYKWO0/cJLx1TTAMjemnmzM27UOK3xCyheqV+gZ9sEF06pVXP9Q
vxG3Z1ETQB4Tgp4dWLTg4eJmPyvCy/Kl9lTLckV9UQtY3VC1Ig65tZCC5qVZAeBa
627H99VkSbq6eNA6nmCQv3YI+tNuEraAMdQWvbHEmssemjDPiU5ZB7K6Le8PjfEU
wzLSUWPXXcjBQFC/SfGkKxybEQXEcvH7rfEGGOkgxsuSuHM0UR1qzFTPiS6KI+IW
q7EQKFoIE4dOnUer0rZ7fJwlZ5DequydnphOU/ao/Qd51dOaTSxHNDlRXzK92VO7
9EgsrZ/6V8DnYLrzcnF35zpN1rmA9gobNyTodowf/96tvDPF+0c=
=uSDP
-----END PGP SIGNATURE-----

--/kZ9M+KZOl3BGf8Y--
