Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A3C57A1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiGSOgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiGSOga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:36:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5ADB35
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:29:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19BACB81BC4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01B6C341C6;
        Tue, 19 Jul 2022 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658240978;
        bh=v4HkP3XW4U1qCFue5Ukcp5Oc3mgsO1oRiSbW9d9/de4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHmSGUMlP8Rw9PQMt3zVNW7kJk7YkdZ9dkZI24HCt3UgRzacjC05Rao3BL4rMo7am
         YaYU9o5Jnv8bObMlJU5OLpaDV2SQRfRFr5RCFnoBEqLkH5QeOxYtj15y3OMzi5Z94L
         x+R7as2qsXI/K9FL9bhUoIsVVOzcaC889nl2ex8ht4r2Cn+NjskcLNY67AOKDt6c84
         +56fD0kdERRzg8+Ry9rkrv5UWV0UgN+8S6ti/nBW3aOgtdz+db2YU6Afwy9DTihkyC
         2bUo5lhGLaXy3Q8tzrfT3BxeXHfnnoYZCmeIOQpMjQfiGl9TSeaxapgXbXmaVRtXX1
         eww4ltb5eLNDA==
Date:   Tue, 19 Jul 2022 15:29:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian =?iso-8859-1?Q?Kohlsch=FCtter?= 
        <christian@kohlschutter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH REBASE] regulator: core: Fix off-on-delay-us for
 always-on/boot-on regulators
Message-ID: <Yta/zrJxQOfYmN4C@sirena.org.uk>
References: <E25D6465-6475-42B4-90EB-3D2C3CAF3B20@kohlschuetter.com>
 <YtVTyzLREdkzYiKS@sirena.org.uk>
 <3270C618-E361-4BC1-B63A-917AE09DA60E@kohlschuetter.com>
 <FAFD5B39-E9C4-47C7-ACF1-2A04CD59758D@kohlschutter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j+7Gf9VrsQ/NTDoK"
Content-Disposition: inline
In-Reply-To: <FAFD5B39-E9C4-47C7-ACF1-2A04CD59758D@kohlschutter.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j+7Gf9VrsQ/NTDoK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2022 at 04:02:00PM +0200, Christian Kohlsch=FCtter wrote:
> Regulators marked with "regulator-always-on" or "regulator-boot-on"
> as well as an "off-on-delay-us", may run into cycling issues that are
> hard to detect.

Specifically the error I'm seeing is

Applying: regulator: core: Fix off-on-delay-us for always-on/boot-on regula=
tors
error: corrupt patch at line 10
error: could not build fake ancestor
Patch failed at 0001 regulator: core: Fix off-on-delay-us for always-on/boo=
t-on regulators

(after fetching with b4).

--j+7Gf9VrsQ/NTDoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLWv80ACgkQJNaLcl1U
h9A9Ggf+Pvzfctz9awmljYD5I1Lkz5LsWvN76uMhaoqvegNPPt/aU8+9GZZWPg1X
A6MTFD5u/Us1UHb68AMw3EdRavJrvMzLDwfQEtfkFgt7dzvNw+7IR1FnrK9/lPQ1
IZtg5qjsY7ADkoQN0KDMb1BFf+Lf6lJIIDOY2+KUBhf/TONK2sAKUZU4Us4XlB6o
Ko5F+jY4dlKajO+X95opn/x3REo9N39fGZlZKTFIksokR+7ApFkX36pYx7+G+8ll
go6tNHDV/YzhMlVlFgfZ69fsfmsaFSFh3XwJ7MUVEaAl9pX7QvjIf6gDePDzLYt6
aBTlux7eMRUAXrj/Nh4130gCc+eeIA==
=zJEy
-----END PGP SIGNATURE-----

--j+7Gf9VrsQ/NTDoK--
