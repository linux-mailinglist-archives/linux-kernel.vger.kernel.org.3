Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76559BFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiHVMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiHVMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A333429
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:47:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD0E60FF9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 12:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D0C433C1;
        Mon, 22 Aug 2022 12:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661172441;
        bh=45sAp7NJ5Cp2njuLK4XNvKlRVvcRksGwnpjWb0Min2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPHQHw7XYZrenAs5qCyREmmfBceoRLmbWQfwLqlBQ5wzQrSkwqG9UNT1sx4QOb1Wy
         vRcEuTYz9n6tbcfncVaVkf5melaONOwjsKdn+GuyUEvrhEpNewYQa5MlOKqUrL1+h2
         eemx8iPdaOVmHOFbL+S+cuNaVC6TCpQwsvyJZ3GEXnCcUBS0GdnI3hwwnepn1sNKDe
         51J7i5j1rrY/yQJkd6eni20Uu3z3SCQGCEN4JhmVNWwOhav6qVOeVDqS2DoNk2v7mk
         tzxBqBajClRF1iZP28HfmOBok0poMQwGdpKri/HrCHRl0qvwvEp6mtAxpAyxeiaEP4
         4WPjBIFuZYQpw==
Date:   Mon, 22 Aug 2022 13:47:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Message-ID: <YwN61JsJZNqCT/Vf@sirena.org.uk>
References: <20220822095242.3779-1-povik+lin@cutebit.org>
 <YwN2Pd4Ez08yDFno@sirena.org.uk>
 <87bksccv7x.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIOPiZGstgIytBzh"
Content-Disposition: inline
In-Reply-To: <87bksccv7x.wl-tiwai@suse.de>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIOPiZGstgIytBzh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 22, 2022 at 02:34:58PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > There was a tool floating about in the past (last copy I knew about was
> > on Wolfson's git but they took that down) - can we not just continue to
> > do that?

> IMO such a conversion could be done in user-space gracefully.
> Or is any info missing in debugfs as of now to achieve that?

Yes, we should fill any blanks in the data that's present already.

> If any, we may put such a tool in the standard repo (e.g. alsa-tools),
> too.

Indeed.

--WIOPiZGstgIytBzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMDetMACgkQJNaLcl1U
h9Ac+QgAhdjWb5JcUjMSz6beTHlNa/jbsyJiL7IKyCYZc11ipw8TpfGug2pwad6K
jGTPMuJielQfFZoaYZP1cEMiuxTilJrnQbxRuDEIf6lp6c2X/UNyHe0UIp/ZAuKX
Ef9eIHN9IrLII+gcmhhmN0jU7YY3PcrmCUmI5lFvHkXmPMR/JjLjLL0DEHu5S5Jl
Wq1/osIrHEjDGhxd8Z5ZPRS+MPBm7AD/1jyaGj4jlse0JqEq3hoQM3S3cuqLyevn
jbTrItUrfiWIZDWOmUk9bN7VIfDUg1TI3orZczGOD7719/wah0fy57PVczV5kRpA
HEjPVfJjap+2OuH1zL7tHARKZGs8iw==
=D+yb
-----END PGP SIGNATURE-----

--WIOPiZGstgIytBzh--
