Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7977D4D6288
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiCKNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiCKNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:43:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C6131978
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:42:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FE7E61E48
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 13:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FFEC340ED;
        Fri, 11 Mar 2022 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006136;
        bh=wI6UuXlLPmF+qv4XpIJMKmpFK9hfMx3Ab58Dr4Epttg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S4HVB2ll2W5NBFeOEgZwnkeKASyGnhD13eZyBm68QNV3CbXV8VDbrFbHUc+9a6RXH
         Yqx3S8jap69MDRuHAAsvAvhrLwvWV6tn4OvgPyjhA7l+BIOAj+UaHbBRJ8MvDGILGM
         dMAEM7pjO5CJJkZZmFOm3PRSupbArAbI28rSFBe4A+3PYKKlrb+9nzJpoyL95OhrmU
         zPEqioWhJSiJOxLcseBuiB63MSEtG+6jFfehF4F4vhvDho/wvcbrGjHWYTD9DkTfn9
         qtuL499OHGeV7xkq/Z4uE7n8SWNIAUIChlINwbAfX99E2FjOZGXWgo0fSxtZYdZFal
         y44him4yy6XFQ==
Date:   Fri, 11 Mar 2022 13:42:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: boards: Use temporary variable for struct
 device
Message-ID: <YitRs1YveURmYtJ/@sirena.org.uk>
References: <20220310065354.14493-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PVsnp86vmEPqoFG0"
Content-Disposition: inline
In-Reply-To: <20220310065354.14493-1-nizhen@uniontech.com>
X-Cookie: We just joined the civil hair patrol!
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PVsnp86vmEPqoFG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 02:53:54PM +0800, Zhen Ni wrote:
> Use temporary variable for struct device to make code neater.

This doesn't apply against current code, please check and resend.

--PVsnp86vmEPqoFG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrUbIACgkQJNaLcl1U
h9CBRwf9Hq8LMCKweiAiVucGSDGqVOMiINe743Xoxg0p+QIgN85lxu2KcjAE2NRQ
hi6R66z+i4M92QZQRxoCBBKv8WsR0jMvDN/msmxdQkY1tFkqtFhiJvuwSbZJrip6
fIN4z57K5VhfhP48ze6f0AzO/caY/CWCsBgcrIDS+UFM5DkFgksWjt129FRyrEuv
cu+YwqtDsLU0eRvV/MsqXAB7209ViZV7U1yg+jvpGFtsnStHqZuYgssaw1ZH5KKN
OQD8Hh7pxRUZn2GyIpCqzRDW78hNwVPTOlJc7m9niLf0GNY+zryvKy21qi+CZDuI
EmdVaP6rjlVTiQ+0bQY0q7vtsfOjgw==
=HNGE
-----END PGP SIGNATURE-----

--PVsnp86vmEPqoFG0--
