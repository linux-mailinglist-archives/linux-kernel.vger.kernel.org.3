Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6124FE2A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355631AbiDLN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356343AbiDLN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7419BC3F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 476FA61A6A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53F1C385A1;
        Tue, 12 Apr 2022 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649769730;
        bh=6MhtNDR77Uk9x4Ncl/TgZ0K/BInAvzJDofHfnatbD04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVOqaeQ/W+eDm/Y22r40LIR65+/PNZqjaal7DaWcnWH769nA8uOB+yqCl9/mgJsYL
         avn3gVwF5wVZQsdBFFljHdtLRotjQ45CMndTHE/X/eardekI2sSD/AKqAjFZQxnhwu
         5xrrfxuC2WtHXo/aBoo6f+Ie/6ZzPMdH3hqdzfA+eFQxClJmqHhSi0wsymg4iPJm9o
         rB+te/DKTVzbZ6S5S59YVnb83104hx5zcKcEjyqdcIITYnyPXzFx7Lp1mov8B6BQpC
         8dtTgUBhkp14kW2LoebmRNHm9EZVA4xqGIfYdGyZCcn2kNytab1xYcIQ4+TS9Nvypc
         r+o/L8w24DizA==
Date:   Tue, 12 Apr 2022 14:22:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8524: remove rate constraint for FE-BE case
Message-ID: <YlV8/dJeyFFDf/v/@sirena.org.uk>
References: <1649754826-2651-1-git-send-email-shengjiu.wang@nxp.com>
 <YlVy6tAPMw+MHq/f@sirena.org.uk>
 <CAA+D8AP=ydd6f9su=JR1q9NVWTg2tHoTF1OGHQGmFN+gZhAcHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GWZv1Nn8Ww4evgM0"
Content-Disposition: inline
In-Reply-To: <CAA+D8AP=ydd6f9su=JR1q9NVWTg2tHoTF1OGHQGmFN+gZhAcHQ@mail.gmail.com>
X-Cookie: Approved for veterans.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GWZv1Nn8Ww4evgM0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2022 at 09:18:16PM +0800, Shengjiu Wang wrote:
> On Tue, Apr 12, 2022 at 8:39 PM Mark Brown <broonie@kernel.org> wrote:

> > nor is having to open code it into the driver.  I already had it in the
> > back of my head to generalise the set constraints based on sysclk
> > pattern into the core, that might be productive here.

> I also hesitate to add this in the codec driver. I agree that it is better
> to be put in the core.

> When will you have a patch for this?

Dunno, no fixed plans - it partly depends on how gummed up other stuff
I'm doing is waiting for review.

--GWZv1Nn8Ww4evgM0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJVfPwACgkQJNaLcl1U
h9DdDQf/SMZuRMaZ9bCrIvYAiyEfrE/pIxlufwWik0/9voMm3EjRV7tepL47OWve
fgJtDTfj/dDVRpDJHcY9inUS3RCaWloLpo9m0IBRDMaf8iF6TYbY28BxRGJhXmiJ
cLXy5r8Q3oH3VP7u7SaWcISIOx9ETgruHs2sjS5Mf340njtgwZuo1eYT+zHmqTA4
NusMZ/We6OLXHKilgjYBXLAhrtpkFrP8GuNm45Ms3OsUTZnDVC25tdmOTjJtRezg
dx59yb1FMBJng5ZY1OCMrZMB8NPN+rQCTnwX//Mm+xQyjE2SiLBfahCLyvtHDHF8
mnd5ESVkI5BDL3Q8x4doiCZ5FZqg9Q==
=dheu
-----END PGP SIGNATURE-----

--GWZv1Nn8Ww4evgM0--
