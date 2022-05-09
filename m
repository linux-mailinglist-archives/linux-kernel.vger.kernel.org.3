Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB28520107
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiEIPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiEIPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:24:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4D28FE95
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5623B816E9
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D957BC385AE;
        Mon,  9 May 2022 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652109606;
        bh=Otn/1pW+YnVWg2O+X9tl6pzhmsugj4MKdcjS46dn8R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L1t5LK1ioC0q9YcMSkEliKW70l9F/yrflXmF3DnLS+UrDqiqlHk23XBh2OvB1i6Gh
         nh43mAnNM71AVPZUz5eFqc7hRzmu/nD8ktyKlYb9/UnKUfPfpfyrVl6/y2iC0eA+qh
         s7uxSsn+VuaSl4gsY3I3h8ovcFiPn19goJGFaNsUQe62beoaxlN1EKrKNs4IvEUgNW
         /tg29mJrjLGSeo9TGVWHAGnmP34bbQ8JFkEEAGKVAYD4JaIhNPK6ay+jYfY4iYwDaB
         kDflRN5wyRe0dkGQmeLneHPVOku3tY0ruRCqmRjU4r2eYREDaS72ThhekUq56YgQQ6
         9dGOVrtk9eJew==
Date:   Mon, 9 May 2022 16:20:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 1/2] ASoC: wm8940: add devicetree support
Message-ID: <YnkxIe1nVUiKNmdq@sirena.org.uk>
References: <20220509121055.31103-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="guiHyUClsBYNl/Vo"
Content-Disposition: inline
In-Reply-To: <20220509121055.31103-1-lukma@denx.de>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--guiHyUClsBYNl/Vo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 02:10:55PM +0200, Lukasz Majewski wrote:

> This adds devicetree support to the wm8940 codec driver.
> With a DT-based kernel, there is no board-specific setting
> to select the driver so allow it to be manually chosen.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  sound/soc/codecs/Kconfig  | 2 +-
>  sound/soc/codecs/wm8940.c | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

You need to provide a binding document for any new bindings you add in
code.

--guiHyUClsBYNl/Vo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5MSAACgkQJNaLcl1U
h9ABUAf/QLihyIhlv9B+mH3K/QMNPGVNFnQaQzlyt3XGwFECkKhgxluXAyk0aush
IKXP04UdPiy/gC0iS3QXlrVDZhV094djNT42xGJzz2H9UKovYZjrYky76j7kduYI
2WeMoo8KZ5GfxZ5/HfHW+bw168wfH8SGEzuUPMqOs6NZJZ1HgXOeCoc7X+C7QJh7
d6Q0YKBafi8cYM0Eg48RloS17x5X8xYKYXdpc/ebA4buuM6NjQ83Jb3HN8w3IL/q
yHi5178payfHMp9JDmFuqc+pTHIcyf9oW4eTVxe2b2BLIZjwciE8ZIU1Y93lJUOO
7/rn7KPWzBaAgp/v0Uiup/jeelXIuQ==
=JEQ5
-----END PGP SIGNATURE-----

--guiHyUClsBYNl/Vo--
