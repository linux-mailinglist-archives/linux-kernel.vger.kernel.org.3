Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558353FEDD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbiFGMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiFGMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886BDB0A44
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A0DE6062B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB273C34115;
        Tue,  7 Jun 2022 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654605311;
        bh=YTReIKFapkRU/vz0TQ4ZybHkAiDZOqBVEplw3ml6HGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDjt13GG68qEmMTz09aQ0LrFH3FHYIRRjlbWRXxgUKadxTHsXEWn4uD0HSVF1Lfvv
         CGeDiWJP6+avear1/tbhZwahJS8sjkEXpN/sLsJnpXnCgvK9PUoZ0P0awhrqpYQbTW
         pveJl9BpbJo6IOv+iWGioH2FOsvb+Gzo1Xe0MU0j1huXRh4tN4hY63oQuTzCvT5E9m
         zBIfEghcalLJ+2M/a/sqk+UhmdiagifNTCDIvr2ZHhdEIuxgEOLfNATwfCuLNQZqTw
         4mlGtycCQDQcYqHDyekatgxa2ckU8knGJs6GdfPCrqnBRQVW7C311JaavpURXj85WY
         anXcmVZaVM7Nw==
Date:   Tue, 7 Jun 2022 13:35:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Remove warning when no plat data
Message-ID: <Yp9F+r1WryNFzyrM@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
 <Yp4iGvGFD9jo4WUP@sirena.org.uk>
 <20220606181731.04b6f771@ktm>
 <Yp4wzS0aLEo5werI@sirena.org.uk>
 <20220607143039.01cdff80@ktm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VwEHQR+T8zP616/F"
Content-Disposition: inline
In-Reply-To: <20220607143039.01cdff80@ktm>
X-Cookie: Where's SANDY DUNCAN?
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VwEHQR+T8zP616/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2022 at 02:30:39PM +0200, Lukasz Majewski wrote:
> > On Mon, Jun 06, 2022 at 06:17:31PM +0200, Lukasz Majewski wrote:
> > > > On Mon, Jun 06, 2022 at 05:44:39PM +0200, Lukasz Majewski wrote: =
=20

> > > My point is that - similar codec - wm8974 don't display such
> > > warnings. (this code was not updated/refactored for a quite long
> > > time). =20

> > Perhaps those drivers are buggy, or those devices lack this specific
> > configuration that's being adjusted?  The changelog should at least
> > address why the driver was warning about configuration being required
> > but it's safe to ignore that.

> With v4.4 from which I forward port those changes only the PXA
> 'stargate2' mach is using this codec.

> In this version there is no reference to 'vroi'.

That's equivalent to setting a value of 0 given the way platform data
works.

> I guess that one can provide the 'vroi' information via DTS nowadays if
> required.

Yes, that's what I'd expect.

--VwEHQR+T8zP616/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKfRfkACgkQJNaLcl1U
h9C+VQf/a2Lo4791u9dihgpYWy514oujclrH2q6cIYgSRs9nrNvyOBW46Lzfk6to
Bju+dCExmD48HfkH0jLbHI18b+nrtmH2NU6AD5qe9AFlGk/lVtEnECpV+bZBHpKu
DTEuq94BC1cMe6KWPapmGuoPLmzDw3PTbUu3hGIHm17hHpHzMIzHmOPpNdopO4Sx
YLRktN3V5F3T55l3KlGTsQKu46ddvNtWKzcBdZCu8APIHZtn9dQnTtdBcD0gtDQz
FYuiYZfbyIiVbmKdaU3P1Wqb1QN4wXCme7GXyJ5jrEqlNrMzTdcAkgfvkGu66hnf
EVNDP8a39faQa6wbv1xUu/AcvEDGUA==
=MyNE
-----END PGP SIGNATURE-----

--VwEHQR+T8zP616/F--
