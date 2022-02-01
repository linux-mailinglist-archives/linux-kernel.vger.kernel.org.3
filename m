Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76C04A6294
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiBARhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiBARhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:37:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F5C061714;
        Tue,  1 Feb 2022 09:37:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0508A612E5;
        Tue,  1 Feb 2022 17:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC84BC340EB;
        Tue,  1 Feb 2022 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643737034;
        bh=5+e2/1ovVlkoJZG7HnhqfG3Xn95vLy9k+cqRL0uJ2do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxW1qIGED3bDGK2mg5prOpEGSfiWe7+fT3a7V37OfTRi8YAXEE6+hyhVVbNrLuA32
         mznzf9FkC9qKTCzrAUGCn4of/W1v78w5mW1Vl9gJGJz5Xlvq6Y1bSCXTlXVH0IH7rP
         5yLlePfUTRbmaGnMsFHH3yUcK3EQq1nfxEOdr7zwk8+5+/dNtynakmCuofnjDoXTWW
         Yy8Lvzhk0TTU+hKzLjKb1/btwnyYv0ICzYMniyYyT/wvq/RjgUkmTHnG4e/dD6IbWP
         FP3pgRbqa9hJxOzvX2vwfNJpj8BAMyY/TkaGnp7t7wJP6uE2I+p4plxj1Jlzaw82We
         hzxMb/hloQWPw==
Date:   Tue, 1 Feb 2022 17:37:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     'Hans de Goede' <hdegoede@redhat.com>,
        "'Rafael J . Wysocki'" <rafael@kernel.org>,
        'Len Brown' <lenb@kernel.org>,
        'Mark Gross' <markgross@kernel.org>,
        'Jaroslav Kysela' <perex@perex.cz>,
        'Takashi Iwai' <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v6 2/9] spi: Create helper API to lookup ACPI info for
 spi device
Message-ID: <YflvxPmiwL0TbjPM@sirena.org.uk>
References: <20220121172431.6876-1-sbinding@opensource.cirrus.com>
 <20220121172431.6876-3-sbinding@opensource.cirrus.com>
 <36df02cc-d164-eb6a-4ce7-54d2ee916650@redhat.com>
 <001101d81791$23f56090$6be021b0$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NYU0R5j8dZiNHmNm"
Content-Disposition: inline
In-Reply-To: <001101d81791$23f56090$6be021b0$@opensource.cirrus.com>
X-Cookie: All's well that ends.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NYU0R5j8dZiNHmNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 01, 2022 at 05:28:34PM +0000, Stefan Binding wrote:

> I was just fixing this, however, I just noticed that a subset of this chain - including
> this patch - just got applied. Do you want me to fix this in a separate patch?

Quoting from the mail you got saying that the series was applied:

| If any updates are required or you are submitting further changes they
| should be sent as incremental updates against current git, existing
| patches will not be replaced.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--NYU0R5j8dZiNHmNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH5b8MACgkQJNaLcl1U
h9Dzzgf/Qaojnc1Tj+koHQ+yotSwO0JMyuM6KElApYmMkU67dQwQgn79wFstjmqU
I0QX8F3k8rDQaYuS7MjeWCee4raTsSQ3eQb3k0ORuUGE96RWPcsrK4MgpwIR+K/D
uR7Bvva58ALZI0Y9u2nLwQGfcOeXt3TmUIIsmIgdBu0e3KAOfKcFD+98x/AOWGON
/TiklP8RFuqYiMDAij6vS7RflZ3zlN1yR/aGqYgfgiH9UXBIpgJd8mZ42Nb3sCQg
IbILq+R6RyR6bVUODSdegfsizQLkTRFK0EWQlgVtDNkmn8feOxPC0erAhCbI1kaK
ukivFigIPevnB5Phdi5brz3lda3nGw==
=z7h3
-----END PGP SIGNATURE-----

--NYU0R5j8dZiNHmNm--
