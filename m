Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF34C4FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbiBYUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiBYUkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:40:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6D20B38C;
        Fri, 25 Feb 2022 12:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD1D619B0;
        Fri, 25 Feb 2022 20:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0684FC340E7;
        Fri, 25 Feb 2022 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821605;
        bh=zxDATE5T4nAxC32Whq1+k2Ts5ipceAvf6DKKgR9mfUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrpQ7YwSeh5sscihYcV+TYDt1O1t3NgWkx5jOWu+WSlXp+Glrz/YlfV/x9AGEUQg6
         KW9W50yPmmkhpl2dCQJ0UDYT7ii7otMq7bmriBAqifVREs7SPVMS23+SEdHRrtZje3
         z9M2gTLBRQM8x7BKzkHa0SNpLuxLbHVHOp2TplWn22MqP2g5SVymEik2ZlDYeeaVWU
         Q7aIfqk04dAzRpjaf0i4035gtcx9EXtZF4e8pC0GxOyG57/2iwlZMdTioq4R+5bOOx
         JquN1ANWyZ5kGRSBF5Co235A8oZWLEDB+br1bEpCLNuZzPbjenRGpAOyp44sFk89Xr
         YzoaR6mZz0L4A==
Date:   Fri, 25 Feb 2022 20:40:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Rob Herring <robh@kernel.org>, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH V2 1/2] ASoC: dt-bindings: audio-graph-port: Add
 dai-tdm-slot-width-map
Message-ID: <Yhk+oFJBMAqYNc6r@sirena.org.uk>
References: <20220217134835.282389-1-rf@opensource.cirrus.com>
 <20220217134835.282389-2-rf@opensource.cirrus.com>
 <YhgCbKzfPXEVauwW@robh.at.kernel.org>
 <7d11f36e-4b56-8c17-a114-d024f76f3b9e@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/T0XV2S4I1DB6qKN"
Content-Disposition: inline
In-Reply-To: <7d11f36e-4b56-8c17-a114-d024f76f3b9e@opensource.cirrus.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/T0XV2S4I1DB6qKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 25, 2022 at 12:08:00PM +0000, Richard Fitzgerald wrote:
> On 24/02/2022 22:10, Rob Herring wrote:

> > Is there a need for specifying where in the slot the data is?

> I don't believe so, all the protocols I know of have the data bits
> transmitted first followed by padding. There's no harm adding a
> reserved field to allow for this info if it is ever needed, but it would
> be unused at present as there's no kernel API to do this.

It's part of the general format for the bus I'd say.

--/T0XV2S4I1DB6qKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIZPqAACgkQJNaLcl1U
h9Ajhwf+J82kl/TOlVA+wFKSsRgst+nXorJvUGgpk40srNqnLsDbtFdEl0VhpVMb
9dQGF5YwjfvOI52ERTvwRrlYrAcUZom76BY2nCDuPclvHmpKkL1WF9CVPfLPszpc
NOcd8gYtM3M52wSSgroFI2crtlFuY6G+qCsrp9+p/7oMyzALrt4kjmrksAAmb4lv
92Q974Uc2MX9t0meFmZFKUqYuJFsn7FzNlVjuFZbpPEM8i4GVbdjEfkMr3cMrQMy
JaZmgPVoEdsM609PprJ4LxbUHwNrEVIXMecDZ1L/GU/SMVYYC6gKlxUEeJs3Arcv
gfInPtVf4G9xCM6SdPWqFtTGzIcmtQ==
=/qfj
-----END PGP SIGNATURE-----

--/T0XV2S4I1DB6qKN--
