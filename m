Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7EA51FB2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiEILZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiEILZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:25:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8AE26571
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A12F06118C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804C1C385A8;
        Mon,  9 May 2022 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652095297;
        bh=IIvsWODmX0KI3MoORXOy0Ju3TSkGG3RxXgnBJ4rEB7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeCAK2rYuJDg4HjfqQhuGMfkRZ2uM+bYFA67XcWJP5jgWSXIPZmTEkRJCfnyoiGp/
         mBO/9QLCbp4XcM/fzCOd9PQm5rqWdQl1MmQACg4SV2NE0SnH76sW5A5E+MejMDuuVy
         ycxvOITauQA3DzIiRSiAUciE/t5CuXaO+Wr9+y+/IytZMpVBLjmuLJX3vRG/hKhjxX
         Zpimic9+G8vhSCgFcpQMOzr5pnX7ZAgEq3e+vYadzX0F6HhCTHFUwdxHotbB9Ur4/T
         ftFiaLcRDICi1/6MWKBw48KgGgXhClXD2vsQsKgUS+wuxpx3Y+1nPKN8K9LsjicyeS
         f09cWfZE/xJyw==
Date:   Mon, 9 May 2022 12:21:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] ALSA: hda: cirrus: Add initial DSP support and
 firmware loading
Message-ID: <Ynj5PG0flJhn9iYD@sirena.org.uk>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
 <YmljEm6jUr3Odsv9@sirena.org.uk>
 <s5hbkw7m6ew.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p9Zw1zY8ht5OOUdB"
Content-Disposition: inline
In-Reply-To: <s5hbkw7m6ew.wl-tiwai@suse.de>
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


--p9Zw1zY8ht5OOUdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 10:55:35AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Wed, Apr 27, 2022 at 04:06:54PM +0100, Vitaly Rodionov wrote:
> > > The CS35L41 Amplifier contains a DSP, capable of running firmware.
> > > The firmware can run algorithms such as Speaker Protection, to ensure
> > > that playback at high gains do not harm the speakers.
> > > Adding support for CS35L41 firmware into the CS35L41 HDA driver also
> > > allows us to support several extra features, such as hiberation=20
> > > and interrupts.

> > There's a bunch of changes for this driver in the ASoC tree, it looks
> > like the bits that touch ASoC will need basing off those.

> How is the situation for the time being?
> I've been off in the last weeks, so couldn't follow the whole
> thread.

No change, Vitaly didn't update or respond as far as I remember.  We'll
need a new version.

--p9Zw1zY8ht5OOUdB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ4+TsACgkQJNaLcl1U
h9Beagf/as89leek9FmSiElfBkp4f1KqydfalbmNjD8V4is3Iu63RMb4Vba7xepv
pa05jYfRfhuU7H7fw4Dxy3tOkFWF1Y2qq76HqL+MfC3kFB4sQbBoK8Fujq+c9o4u
ZgK626VB7WsYimYvzJsKClQPvA4bfkvRaS40uKkUx9vLm6WSCs/JRIAck12sXPUp
J5Be37OsScV07pZ11wWateu4fFLRDIIz7Xv0QbqKy/Y7U4OAQpKfPJwHIx13II7Y
5SqL87jRoNYNcBjfVQZaWlZewmfLUedpBB1t9olUZkr9/1k6VgI0HV70HgJ5nnRZ
SE1JOWGdP+INy/G4JNmGUks5Rx2oqw==
=I9P/
-----END PGP SIGNATURE-----

--p9Zw1zY8ht5OOUdB--
