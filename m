Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D014B8D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiBPQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:08:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiBPQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:08:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF456BB573;
        Wed, 16 Feb 2022 08:08:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B5F161AC0;
        Wed, 16 Feb 2022 16:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E93C004E1;
        Wed, 16 Feb 2022 16:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645027698;
        bh=mjr4Url4IwxZmbQKJe7epd1L1irQIl41yeN8c8f7hjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=siNmeK9pkkGXQjNt3U+kKaJDKTAFpJTvMt16/diMX2WZt8dhVrpgU31qjL61Thbf5
         fdJspFsKJoJe0WaC7zo+G+4BplZHfPcKYBYml/Y5Umq8VLFX4eM4tPbJXxTWhc8eIB
         hps/xP57totzW0RAU/IVq/QXQu95bSNAgaUC+ef+CVTVUQFsJxZsMJEfQYKaDwbCxZ
         o7jVA+ugSJa8ESgZPvSlDVAhqgu4CANwb64rKx7PzE3dmDQ5tBFq8p3tAV8CclGhUS
         nUoHuFdNpKJZJOv9VUV88tEax7IPSjpsWodi7YjTXATgK9xvF8RKRP6ZPvSvoRlUKF
         XJs0lSKxKGBsQ==
Date:   Wed, 16 Feb 2022 16:08:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the spi tree
Message-ID: <Yg0hbeSPpDa4Oy2x@sirena.org.uk>
References: <20220216161718.2c094b08@canb.auug.org.au>
 <c041df98-fbea-bc76-75c0-42d549248dfd@collabora.com>
 <284e2e05-9402-e480-7a69-3282b7e95b6f@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hjqty4fVI3z9EMvB"
Content-Disposition: inline
In-Reply-To: <284e2e05-9402-e480-7a69-3282b7e95b6f@collabora.com>
X-Cookie: Fremen add life to spice!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjqty4fVI3z9EMvB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 10:07:02AM -0300, Andr=E9 Almeida wrote:

> ACPI_PTR() make it as NULL if CONFIG_ACPI is not set, making the driver
> suitable for test compiling even without ACPI enabled. Mark, I'll send a
> v3 with this fixed.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--hjqty4fVI3z9EMvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmINIW0ACgkQJNaLcl1U
h9BAcQf9F5mT9SUL7RC+pxU9jwsqYTHzirfjmEkkS9LckSf1BwKRld1ZY16Kd9Qu
xZx3eOp5A1z2QX0ufzawFZnerPHeyPRqKfEolSXTvQK4Va6Ec9s2QdSyrlvxO86h
bIwMokJlLfm+drc/T2NbN62/vqEMF4RhiglW5DpM76mxAKuulL7raLmvWQ9tyUkH
Y0p1kwBtovH/nRK+O1gosTd4rheyxNgrRtibvB2gwDMbAtGOjlrpFAKXahngo1hr
S7rby87Kd/LdOAUeOwo8yu3wYG+sikFsdzUCGJQFOleEd+o7Fk3RUFZ0IpH5Qt2b
lRA9OuM+6+Z6BwJpv2scYo90SVYeuQ==
=Gqw5
-----END PGP SIGNATURE-----

--hjqty4fVI3z9EMvB--
