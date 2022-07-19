Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F242557A12A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbiGSOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiGSOTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:19:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E884ED3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20022B81B96
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC3FC341C6;
        Tue, 19 Jul 2022 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658239032;
        bh=vG/PYJWjOA0dZGLVlpwRmukXsss533fpnWPhCGstMFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y31IhWhFXz4i3HfFYedO+G6cphZbYh1i8gtglLwLeNeMHm1SN2dr/FC97N56mQlAN
         UMSk+LDkjHVMWnao8mMxVwQSyqIG5p5ook2g6dcoLcudq24cyv95MA6wPUISS/0lQw
         RKjsdkFBmTtWPF+3q73/uO06pb3fO1+v9BsFMLoAPfIN2GYE5yKj2BVHFD3++DLgId
         6LdrldS7KR6XraSxjmNIr9ea+2bo+/afCylqDYIZnb3niMpE1g9f1PcLKu0qS6nNsO
         9huZdk6IQN9OPhri/kPaNa5I0tL1/41oyk5884PyYGhbBeXHCSVL/qmnNlFU1gDn4d
         Y6qp6o5oHE33w==
Date:   Tue, 19 Jul 2022 14:57:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian Kohlschuetter <christian@kohlschuetter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
Message-ID: <Yta4NGGYyZ6Doglr@sirena.org.uk>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
 <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J6pgg35jo6kjN59l"
Content-Disposition: inline
In-Reply-To: <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
X-Cookie: APL hackers do it in the quad.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J6pgg35jo6kjN59l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2022 at 07:24:37PM +0200, Christian Kohlschuetter wrote:

> Signed-off-by: Christian Kohlsch=FCtter <christian@kohlschutter.com>

You have an umlaut in your signoff here but not in your e-mail address
which causes tooling to complain that there's a missing signoff - you
might get some complaints about this.

--J6pgg35jo6kjN59l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWuDMACgkQJNaLcl1U
h9BqWAf+JeBnbNBC+OScexa6uJnV1+M7M7K9uor4vjdCfRrByQMmdqHVys4hGatW
8ZjR/05Ac4PpufJJ3FZDlr7I4i3kcWpvR/B1hv5BM4yNPXGo8ZWz42Beut/iuI2Q
T+AqBN/kciBzHQNb2PGHqMtGQQmw34zJjuNntJkP33sxtoO4487ZiH5oUTuvSGKG
Wmvhd2gEE4AnXI5ZgJMEK8jijqMh/7YewXLtKP9NBQlDnvfkr2Z8McabgYaAWcnU
6UBaoL2OUD4vzwHeC/qBf6YLUKouSLDPxiCH/LbJquT+kDhGvOGS5ijUczs2FOkB
BiEY7NJUHOR41V6/4AuutfJOMm6fNw==
=qtmQ
-----END PGP SIGNATURE-----

--J6pgg35jo6kjN59l--
