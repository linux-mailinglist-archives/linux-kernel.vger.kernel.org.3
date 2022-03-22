Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C38D4E3E08
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 13:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiCVMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiCVMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 08:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A38301B;
        Tue, 22 Mar 2022 05:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE5ED61382;
        Tue, 22 Mar 2022 12:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545B5C340EC;
        Tue, 22 Mar 2022 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647950556;
        bh=oXomf+OroFKXPI727l4Y0841A5BkhUXzo5xCfhdMsC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKE/1FWW/oIajs0VV3zmrI5NUmCEutISIFYySMXYpw+kvv0dJFWgyqzsVMXykcuoX
         PyW7CTXlKifLMnywE5dTPyddnXvi+eurEpvnVBN1blVkHfFTNnAhPA7OE976g/tlqX
         qbH1SznaPVG4E7H6Fq+qBcpe1PMXBezhJxT6ktcaIQRGDLiQWddT0rcKHLQi6S76bn
         nuH0sA2NVhSCD0GcNMHL/GhCRYNfhBtAtnl4B1E4WmVWpqwLjXfwYlNfiQ+eIw1biZ
         yxcoyoqSE0Vw3q7w4p3fNwK+Njl8UbLlQfh8LnObtcK56M/8fqDoxNl9qtaEAcMHc9
         fzBoxgyDpyTYQ==
Date:   Tue, 22 Mar 2022 12:02:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-mmc@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2] ARM: OMAP1: Prepare for conversion of OMAP1 clocks to
 CCF
Message-ID: <Yjm61MFGuo0Yug/B@sirena.org.uk>
References: <20220310233307.99220-3-jmkrzyszt@gmail.com>
 <20220321215416.236250-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j44egohE1ZoQznmQ"
Content-Disposition: inline
In-Reply-To: <20220321215416.236250-1-jmkrzyszt@gmail.com>
X-Cookie: Drop that pickle!
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j44egohE1ZoQznmQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2022 at 10:54:16PM +0100, Janusz Krzysztofik wrote:
> In preparation for conversion of OMAP1 clocks to common clock framework,
> identify users of those clocks which don't call clk_prepare/unprepare()
> and update them to call clk_prepare_enable/clk_disable_unprepare() instead
> of just clk_enable/disable(), as required by CCF implementation of clock
> API.

Acked-by: Mark Brown <broonie@kernel.org>

--j44egohE1ZoQznmQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI5utQACgkQJNaLcl1U
h9COEQf9ELwbgSwwn1JVU6FAUZODISuwoWMyUuvHTGdNQEvrMH3GFIUbXQVQONw5
wO62KwasXhYThVzc3rrC74tKTRzwY9/CvA4GNJfZqmHSuXg02O1XqYe6zUmlRbdt
qxVjr4o/EKcY48qmrI9SV9k4GBDuOeU2fSZJP7EIvFqLC/tfDbQYYuRB+TY9Ig+j
oTmg/0JXVooTcMULwexILHzRg4S4+mxOAjfsMojVzku0MepzEPzGo0xZDGYmD0RC
QggKUpiyDnHPKgNk+pEG+1HmSf9sEd2Vb4k2eMfkacZ7Tz81/FON54F8K/213wKl
hCsEajyZs2COxhX4Xfe+zoGXkLD3bg==
=HhWj
-----END PGP SIGNATURE-----

--j44egohE1ZoQznmQ--
