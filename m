Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90C543068
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiFHMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239319AbiFHMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88790254445;
        Wed,  8 Jun 2022 05:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C021561989;
        Wed,  8 Jun 2022 12:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC139C34116;
        Wed,  8 Jun 2022 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654691509;
        bh=wCnYRZBxGyUKef4VTi5QtcmExzsl1dSCCREqJefOnVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UY22bJ3DUSHOjm907zQMtNTN1RYJ450j2ibq/Q2BgPu6yVFFiMmVASRPF4yQuCBsr
         9p951FboNmJ6ag8VGSq270ecj5GhJa+OGNZbr+C7Eli9BVbQlHtvgRjW9e2RHimk5J
         miwEln8aUIOjY3Ruq0gPthVkE31HTrZMQbiexCxU4Tn+AujbhhjkTg3EAqMdGRc9Lw
         cVTkWi37jZfYXkcth+GREAFdbCxXlUQUUKbVYOEkx1+zriY/4czLT1poh6XZnQkw/R
         RuHvaxxIcnNsR9KUydZeoPtje1CWoYT6+iQJJ4LamacvYdKFx+OheGmOS46GA7z6o/
         3xix4jt7cHiqw==
Date:   Wed, 8 Jun 2022 13:31:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] include: linux: spi: spi.h: Add missing documentation
 for struct members
Message-ID: <YqCWsJI4xPFO1gYs@sirena.org.uk>
References: <20220608122917.2892953-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VtcYoMsHYZmsI3QG"
Content-Disposition: inline
In-Reply-To: <20220608122917.2892953-1-david@protonic.nl>
X-Cookie: My NOSE is NUMB!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VtcYoMsHYZmsI3QG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 02:29:17PM +0200, David Jander wrote:
> Fixes "make htmldocs" warnings.
>=20
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: David Jander <david@protonic.nl>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--VtcYoMsHYZmsI3QG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKglq8ACgkQJNaLcl1U
h9DF1wf/UXe6VSorZ58oWhUU+MjuqwhIEtco+z9ydp2YpTObjA6rj67wOZgj8WrG
d6TUnd+rnvseZzVwHCu87h7xnk11PulQuQQ5GUGiaY8vGuaL8gny8AXnis3tvyqM
+KbiDL59M/BL2FZywSsRovsa9PDvU0w19QCrMFrkBKECdSaGI/B94nB48XGQoAks
OeAmZ8YWRkhYSTtfSrpDO8XJ4hhNaqvt5jB5QYHKrgW83AjlRlX0Gd2BwWxbgt1G
r77lR3esINOgl5xUj+EfVQrJ9ESJYcbzqkDj2f40WDzLvFCp9ORhwEt3XlKq5Q7N
edZFAca5/apLYgUk9tEYoC1FeQzpWw==
=JXc4
-----END PGP SIGNATURE-----

--VtcYoMsHYZmsI3QG--
