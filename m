Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094214AF329
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiBINnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbiBINnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:43:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957DC061355;
        Wed,  9 Feb 2022 05:43:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC202B821A0;
        Wed,  9 Feb 2022 13:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEF5C340E7;
        Wed,  9 Feb 2022 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644414200;
        bh=37OR1ffupD9w9dKrsD/tXWDzbP9itwcwvYTx3uXtOps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUge2DMeusx+jhrGmSAodUdP1Qlf9acOZcs8TjQf49xFNLNknrvgg4CY0s7fVgCF8
         Cix15WePuCE8YLeekKTb76Y/rXKbN1SD+6r0LxYI3H0d/imAIpMAl6lJgmm/jNVjzA
         WVB148FwaqUS5h6YKprZT6lPNyNuX5vPGeT9sQsgVI6BSEAJ4IQISslWPIRma9Al4A
         lAP9PBsiTlNG9LvPNdqJ/cdlV9LQad+75PzzcBLAgtfl1lKk9+d9kbJDxHLGVt79qY
         AWui1oqCXtrqDGBpfykYd4GAzGL+a/BPqHb5kqhe2BYye1Vu+IpQlkWBJ40Wul6tk1
         Pxlei95pitoIQ==
Date:   Wed, 9 Feb 2022 13:43:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] drm: Add driver for Solomon SSD130X OLED displays
Message-ID: <YgPE8Z7HxU2wv7J/@sirena.org.uk>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <20220209090314.2511959-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hG/Egg4kkWequsOJ"
Content-Disposition: inline
In-Reply-To: <20220209090314.2511959-4-javierm@redhat.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hG/Egg4kkWequsOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 10:03:10AM +0100, Javier Martinez Canillas wrote:

> +	if (ssd130x->vbat_reg) {
> +		ret = regulator_enable(ssd130x->vbat_reg);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable VBAT: %d\n", ret);
> +			return ret;
> +		}
> +	}

Unless the device supports power being physically omitted regulator
usage should not be optional, it's just more code and a recipie for poor
error handling.

--hG/Egg4kkWequsOJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDxPAACgkQJNaLcl1U
h9BlsAf8DXkDpBzNae52DdUZC+O3yzYIWFFywhEjjDbPX9wmJ4924EI/wjD/igl6
YeYnHYx0kj0SLfHYbpBFUehzykJQ/puIGOnDJ6FpE0SEtcl6fRWcLyKOuhvl+bHr
2vaJbS/pQ53i53EbMU5Zg5PXsZ18GkuDd+9zgz3aC3wSJAOr4LkPIpLe8sQpfSUM
O6QgrmffoUFahtVadrpjAd+We/dGDUuLvcJCrO184AWXoi3pHtpnzhI0k2/GHBfm
qJghua+CfAPUdSthNyVYVZ/YAB+QLAS5NLfW+QX2Ot0XctA6Lk006jjJ+H8LxFWM
BoGgjBzeIw+303F+wx4Ep1mBFYA2DA==
=MgLt
-----END PGP SIGNATURE-----

--hG/Egg4kkWequsOJ--
