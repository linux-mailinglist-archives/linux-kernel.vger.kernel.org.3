Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703EC487942
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239306AbiAGOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiAGOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:52:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B9C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:52:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F10AF611EC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB90C36AE0;
        Fri,  7 Jan 2022 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641567154;
        bh=SSfH/FiGlP71ZZUlQcsn9kFCbrQiH+wUpaW61PMfEsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vf3InwUDtTiZYBDEYD1PXZ0vo4JsxTKiWCPm7eEa5NwSwHpA2IbPdBGfAk+toIeZe
         2UBdYFaOwA6g6l0WFmqIVLRsTUoouyUcBBqNZfkiQLh4AsKWpxE5NrAneeM82ch/ES
         FPNd81XaoPw40rjuVbtYdNim+LekCfDz6eOxly37dSKHXyA6h8VjiHDJWRhZqejyOe
         IQiXgdGVVPgAfFl0kQMUE20Ml+BiuKKMTq9r56Xd1JNL1m9S/jOCxecD6O5pLhLnEU
         lbfQuxkeXGAKQ50YfjaHh8DtRv7q2k/vT72mZSNnowrgRS6hbsI6U3o5N/AGtMGIzy
         FmT+qXHgkHl+g==
Date:   Fri, 7 Jan 2022 14:52:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
Message-ID: <YdhTrkcFASCwOD2w@sirena.org.uk>
References: <20220106175019.3116389-1-festevam@gmail.com>
 <Ydc2EHf5f12w4YcW@sirena.org.uk>
 <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
 <YddLe8cCvj5fVBTQ@sirena.org.uk>
 <CAOMZO5B63zHEiZc-Z1AR8za6eWXX8y0wbYLmrVkXC85ewFSqbg@mail.gmail.com>
 <CAOMZO5DQEEHYJHv08nC=uYXbFtL9VTAatNAB8V5D_JHiQ0q=3A@mail.gmail.com>
 <Ydg/tOqbeT1Cg6sh@sirena.org.uk>
 <CAOMZO5AJy7arJM9v9A6n84k7yzWEoBxX5zTakK50dL6obSR6WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NYF0mpFJBDkO0H1w"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AJy7arJM9v9A6n84k7yzWEoBxX5zTakK50dL6obSR6WA@mail.gmail.com>
X-Cookie: teamwork, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NYF0mpFJBDkO0H1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 07, 2022 at 11:48:59AM -0300, Fabio Estevam wrote:

> Will send a patch shortly.

Great!

--NYF0mpFJBDkO0H1w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHYU60ACgkQJNaLcl1U
h9DRpgf+K5T8FgNihxDvrOK7OMo2h3IKSL1qW43wl5wHDoWTDTBT8KBPIu2Ppz7Y
J5PbRv83gE9Iin9FAH2nOD52kyUn5OhsqBVBygSYtT3/JL4Mm+MSeB+s6gSh7uHs
lxsKR19B0DQpZQgUKIi6Qq5UPGpf13S4L4SA0Rvk7/kjAfyjtYg1sHUAsLnjvhjU
CcDdKbS98aZbmR7gfbgtZGMSE4RXv/jOETlj0lwhGsNYNuAuxJShq7n/TU0ZNDOM
2kesLX1g4S9LxfClEcVxpZy5u2XzCanMMqNOZoPoP6AAgFRTKG8yc5AVt0NUoFGI
pm8YgovDPrVmYhBqLbTSZO7eSmdXeA==
=qfGs
-----END PGP SIGNATURE-----

--NYF0mpFJBDkO0H1w--
