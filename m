Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F04F63AB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiDFPmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiDFPmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:42:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8F455CD37
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D05D9B82390
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 13:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2DDC385A3;
        Wed,  6 Apr 2022 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649250792;
        bh=Gr86iCI3VLTV0BP5gVR9+UdZVYOqcPq/2Fvr8u+Rih0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGW0sKpXgw71/A/bPedf4y1FZqAkOr9Ful3kNG4vaqmeuk1mbbnow5wB3ZMnk+RFB
         Q7SqOIFFXugALMWXlbhoTNW+CVrbWjwD8REtIg0mdOWF5qA9e/CzfDIdD2EGXphGmU
         nn4hGYwVuduaB9jkORXjwc07sDtg8TPwgUHeOfiCgMbrv7237qXeIdNjzjdgOk/NsY
         k4RPd6rnsi8Yq2GiFOKloIKkUOdoZ/OL+LxKUhRJBsdHqi/UUMYtoV6lqYmkZBQUh9
         NaNm/NCHA9KbgF3i9xA1OInRUxTM/mmQU4d6fxexQDbVvmn7Ip+6ns8Tac8Ihg4+NQ
         fbBzmiTwhYilA==
Date:   Wed, 6 Apr 2022 14:13:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Detlev Casanova <detlev.casanova@collabora.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 1/1] regulator/rpi-panel-attiny: Get rid of duplicate
 of_node assignment
Message-ID: <Yk2R5el6fUm4FQo5@sirena.org.uk>
References: <20220325184508.45670-1-andriy.shevchenko@linux.intel.com>
 <Yk2PNas3YIGQLZ04@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NbfDmBCK550LI/U9"
Content-Disposition: inline
In-Reply-To: <Yk2PNas3YIGQLZ04@smile.fi.intel.com>
X-Cookie: <Culus-> libc6 is not essential :|
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NbfDmBCK550LI/U9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 06, 2022 at 04:01:41PM +0300, Andy Shevchenko wrote:
> On Fri, Mar 25, 2022 at 08:45:08PM +0200, Andy Shevchenko wrote:
> > GPIO library does copy the of_node from the parent device of
> > the GPIO chip, there is no need to repeat this in the individual
> > drivers. Remove these assignment all at once.
> >=20
> > For the details one may look into the of_gpio_dev_init() implementation.
>=20
> Any comments on this? Can it be applied now?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--NbfDmBCK550LI/U9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJNkeEACgkQJNaLcl1U
h9DXsAf7BOK5omSdOooKbQLgdj9ov+/a6Q4aFuHudnlGJeh9ayaojABcc4SA2Drw
7ZmtsASXvWpDXlHbNMzAD6lysjUo7FE+v00xRO7uBtcKNAelGKAlInt5EkqaL0Qd
g8LKTLnGTv0aIRLvVVvh5WYkVLeF/1YPlVTFEV+5O+qbMOXomUSZbNpjTKKACMRS
2HYcGe3okbqEpoxztzVMEIvl/RpY4p9VsYLuN4Zb2nY0HxSkgfNoVB9zGC69paze
l9WnPERLRH26PSzBeGlH4H0sSdaSk17/4RJEVuL/CJrGNr2bbWcrTkIuoW1fzuQy
clj9lAh7mJEN+4S9DtvT8HVB5laFnw==
=Gavw
-----END PGP SIGNATURE-----

--NbfDmBCK550LI/U9--
