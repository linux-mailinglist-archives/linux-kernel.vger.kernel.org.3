Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020155C529
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiF1LLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbiF1LL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AAD2C128;
        Tue, 28 Jun 2022 04:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10341619B0;
        Tue, 28 Jun 2022 11:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08980C341CA;
        Tue, 28 Jun 2022 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414686;
        bh=Q06wn05EDIiCZhzyJg+//FJxCEIuxbdNRC9lnKSV+B8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOyd3GdS/fVsE2MhWSblkcjtiQD18VLEXN2awyX6Y79NyU/fcTy1lkKHLtnyzekia
         rTaIN3+rft0HIGX4LO/MFWLcF62lcG5//ZTUPjpQYRitGT94qP6/PAi7Qeh7YbQc03
         F5CTIRxpjkfwaiSJUMEX9e5UczNMmeRjBYvNcVa3Fu3r0k6TchY1+uu6VRkUTAcmLS
         fx1EnhFm7SEhjlwbZ8x1WkZtMGvO00leI5/Esi1rbFccYBK8QwfSsXNXg9jc10lnGR
         J6X/7YH17lmzjpla/NtzBc47IYB+DXmqQauc1Q+LK1lllqO23EVV9vfLN4Bntnduxw
         G1Xl1FNmgeROQ==
Date:   Tue, 28 Jun 2022 12:11:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] regulator: fix a kernel-doc warning
Message-ID: <Yrrh2QvCT7t79vPu@sirena.org.uk>
References: <cover.1656409369.git.mchehab@kernel.org>
 <15efc16e878aa327aa2769023bcdf959a795f41d.1656409369.git.mchehab@kernel.org>
 <YrrZVDUXzHNtvLNi@sirena.org.uk>
 <20220628120715.36080b8b@sal.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Iyx/hEnVpiXqAWtm"
Content-Disposition: inline
In-Reply-To: <20220628120715.36080b8b@sal.lan>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Iyx/hEnVpiXqAWtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2022 at 12:07:15PM +0100, Mauro Carvalho Chehab wrote:
> Mark Brown <broonie@kernel.org> escreveu:
> > On Tue, Jun 28, 2022 at 10:46:22AM +0100, Mauro Carvalho Chehab wrote:

> > > document n_ramp_values field at struct regulator_desc, in order
> > > to solve this warning: =20

> > This is patch 18 of a series for which I don't have a cover letter or
> > anything.  What's the story with dependencies here?

> There are no dependnecies. Each patch in this series is independent,
> touching different files.

OK.  In cases like this it really does generally help to send the
patches indepdently (or perhaps split per subsystem), it avoids
confusion.

--Iyx/hEnVpiXqAWtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK64dgACgkQJNaLcl1U
h9CBawf/R9XQ+I8Pi4AlmSKFKPDWvmnfoeKP4mEdF9XBmvZSuGtZva5Jnp6FzyY4
XHr96BoVMWobmayGiH6DD32AT8AgoFBebS1FRpfxTV9xheEryZAC86glnr8it6ey
h24LZR9cMeUKu58sKABZoPoEWeTw/AB/1RrBsrI9BW6PJOGAGPFBt3S2xMMgk2hb
LUZp6DOnCac3CP12nDcSHu+OHfczSh49AYZXbR+MfBWbIay+ESF2YqIvJsX7n+iQ
XBLkftiq+5I3a/DZotqib6OpRavpKN62KME5v1lnx8TRaWeQ/xdpdruVH4cxi6+P
BWxRAS8nbAHfbKCVD+PFoGBSqKPdTA==
=Hc8Y
-----END PGP SIGNATURE-----

--Iyx/hEnVpiXqAWtm--
