Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5095524B76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353221AbiELLVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353276AbiELLUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:20:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C0377D2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E1BAB82796
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2DDC34113;
        Thu, 12 May 2022 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652354349;
        bh=Wboi126+YfBCgOZel66M9W/DGH8CF2/wuN0i039Wu6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZESPBE0mbOTwKOmNVL1PzjoweYsLMFyPKWGtzvQhQWoIa9wXhkBVdQML2hjBgvCB
         /AVhPc0xAIuR1UWKTa5OFR1ChZkqkXnX4yul7/l88pJxcf0KYWCIXHyUAGjZhGqocK
         pnJ3zP7B9dU8GorwT78p1Z6HvgbXxZmAHyE2kC7HWWDWHydbL7lqaal+W81mC1WNEc
         n95QhdcsIOCqov3D0aDefEKJ7cRhg81/V/LccDFxGbPs4ECm9XUGptBaI6ECAcWUMH
         gMUhM8a3YT64r2xuImOSACMoDeBovCvLaAbEv2FAdgRkczkPhZyCkJEIv1UxtiLZoU
         831Nvw6fKMFtQ==
Date:   Thu, 12 May 2022 12:19:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98088: add support for reg_4a_cfg_bypass reg
Message-ID: <YnztJxdSFau6SYC5@sirena.org.uk>
References: <20220512074359.446999-1-tommaso.merciai@amarulasolutions.com>
 <YnzdcubW7m+CwnvN@sirena.org.uk>
 <20220512104642.GD649073@tom-ThinkPad-T14s-Gen-2i>
 <YnznExLDOvRpXNVh@sirena.org.uk>
 <20220512110959.GF649073@tom-ThinkPad-T14s-Gen-2i>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzfHvuAqf/UpV8KV"
Content-Disposition: inline
In-Reply-To: <20220512110959.GF649073@tom-ThinkPad-T14s-Gen-2i>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vzfHvuAqf/UpV8KV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2022 at 01:09:59PM +0200, Tommaso Merciai wrote:
> On Thu, May 12, 2022 at 11:53:07AM +0100, Mark Brown wrote:
> > On Thu, May 12, 2022 at 12:46:42PM +0200, Tommaso Merciai wrote:
> > > On Thu, May 12, 2022 at 11:12:02AM +0100, Mark Brown wrote:

> > > > These look like they should be DAPM controls since they're controll=
ing
> > > > audio routing but they're being added as regular controls.

> > > Sorry again. You suggest to create a new structure for these entries,
> > > for example:

> > If that's how they fit into the routing for the device, yes - you'd need
> > to define the bypass mixer as well and set up appropraite routes.

> I added this reg as regular controls because this reg is pretty generic
> as you can see this controll bypass of some output, not all.=20
> What do you think about?

That sounds exactly like a DAPM control, please make them DAPM controls.

--vzfHvuAqf/UpV8KV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ87ScACgkQJNaLcl1U
h9Dw5Qf+IAzN05yBHx3+P8CnH/ZzZvCdfKCMrlXsGMWEkbvsl7M3RXLXCsyK7ZR7
3ENP4a7u/wSJi01dsgRrP1lz+NCTk7tfjLOFSgfyWDKIwvdRQ8C2S3HfGNwX2FSu
pDN2MgiPqvodD4XiYPQcVTq8SXE6rA0y9kmiflbpQSCWIz4UyJmCAL6nz0AdjuJ9
6XowU37kD6PeDIZlUABJmUhGLChCpi5+WBwE+yXHtOFyu0JNzl+p89ZmvS1KnQUI
YmIDIgNFGC4augrVxeOslEOye6MV58IHCSK2a6FS8IyJFs8lmVkNUtiouASIsU54
dsoyyOewGtIR4a3aG+OpiTFOAVWFNA==
=JvJ6
-----END PGP SIGNATURE-----

--vzfHvuAqf/UpV8KV--
