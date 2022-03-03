Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB5B4CC50F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiCCSZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiCCSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:25:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD13F7463;
        Thu,  3 Mar 2022 10:24:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DCA661A0A;
        Thu,  3 Mar 2022 18:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB8CC004E1;
        Thu,  3 Mar 2022 18:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646331889;
        bh=3MZNzrhAk/+psbz8VzU1OByNwI7vUL1qSMbaehVjBIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unqwnnoIczOaQY52OttmcXQyJLAjp0Oai11cxoDhm9fxfyzNYxCbGG5xfBCE/6k7k
         tpAYbd0AHpmgDoYYINTeAnJELhdWCb7hHSS1UzI3y7ctVNpLJ1YMWXqjJceDSpT+7f
         RgHJ76zABcWbFYzI2+4dJe+lMPudHm+xq97Q/faBLY/SNBy0DXvPtmAU86zed9hLVC
         YCXNnsMnl1D8sBI1v7EKD1sPKrJIsRzwGFDwoAZ3X21P/Fuep0sg+u1fiF4RXVzg/i
         lf1qZ6niI+cDhDNa//BJaA2mXBvCtE5GGIX3hD4+MH3VwwOisTpw82Ti4tXkXF3Ui6
         +c2tm0AjiX9lg==
Date:   Thu, 3 Mar 2022 18:24:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH 20/20] Documentation: devicetree: CS35l41 External Boost
Message-ID: <YiEH7B3btDrwGW5M@sirena.org.uk>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
 <20220303173059.269657-21-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5+pn/WO7t9hPQNbs"
Content-Disposition: inline
In-Reply-To: <20220303173059.269657-21-tanureal@opensource.cirrus.com>
X-Cookie: Password:
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5+pn/WO7t9hPQNbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 03, 2022 at 05:30:59PM +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
>=20
> Document external boost feature on CS35L41

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Generally DT bindings patches come before the changes that they
document.

--5+pn/WO7t9hPQNbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIhB+sACgkQJNaLcl1U
h9B2fQf+JyZdYpzru6DQzdgIuNNm9UZokagqpucw/b8YH2hd1KNhxnM24CP6DS+J
AJvhMrlvuHTNsQYS9rSKb+FI897TAuwTyFp9yrdy5xiJf0RaNaGcq41to0/I7Gvd
ZTFNXf23QKUbkfDN8bdzxksByfCrFX41IcrPxt9qSo4M2DLrmvty8vSYgYa8nsU+
QIytNm6Uyrd7e5IPufaM9XrRA1aztpjQwmaP9jSYUJvI3Pl/T894JtiA89V9ntxG
cBXI3GNifKfG4mOXw7fgs70+1lmfvKdFN9TqYf71s4DNhoWhqwmnDXEL7k4OEW23
UBIRaCDbl3gJevI5BmfhOa2tpOtQcQ==
=/fvV
-----END PGP SIGNATURE-----

--5+pn/WO7t9hPQNbs--
