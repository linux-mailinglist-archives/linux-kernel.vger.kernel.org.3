Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766A34AC024
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388996AbiBGNu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449196AbiBGNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:17:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F76AC0401EA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15A99B81230
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B55C004E1;
        Mon,  7 Feb 2022 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644239848;
        bh=16LtBqoEMMiLQCTXhAEgcV9F72cfpCz0MRGQUmR5x/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgzKT68Bq710WvquBg7y3NXAM/Iod+ZcAnvjYD4VuMtrTAlVXobLNEETmL7Ka43+q
         O/qgHMj1k3EiUFzAaOkrPMrDz00JbP0nN81GwmlLoCCzDQMr/jta4Yidb8LYZeg4Ad
         tgP+eraON92tLnXxTcgHuY+6+oge+kIq9UlsiO0mZnVRIdVMfS1tQebItQU3r4huO3
         TUlINgq3vqORn+YQVHyQn33n8RnBFZWZN/lPeDpPC7wPrAlpZvJsMnbepGjlE7tbww
         m9C5A9zx3AXoqecq6FwbsyI9XKQtFyQYYxrMngH+GixVeoH/xE23LGmEV6eMrl2XBK
         +82yZslluD8gw==
Date:   Mon, 7 Feb 2022 13:17:23 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] Revert "ASoC: mediatek: Check for error clk pointer"
Message-ID: <YgEb42YZI1iKwqiS@sirena.org.uk>
References: <20220205014755.699603-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Aqk5F9s36CVnq371"
Content-Disposition: inline
In-Reply-To: <20220205014755.699603-1-linux@roeck-us.net>
X-Cookie: Never give an inch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Aqk5F9s36CVnq371
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 04, 2022 at 05:47:55PM -0800, Guenter Roeck wrote:
> This reverts commit 9de2b9286a6dd16966959b3cb34fc2ddfd39213e.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--Aqk5F9s36CVnq371
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIBG+IACgkQJNaLcl1U
h9BJnQf+KcWHmQpnCUz7tmRRQV7SHRdfESvOFdafzfZcgMvJqn170QtNLNqQak4h
P0b+AzksW4Ku0XUDtG22ToW3GL6xaahhdK3z1BIBHv42kHlClcOwqtoaLSEV0q4h
OxIEZaiwRFDLX/a0NByy2M3WThSg9SO6W8wnCXGeghAN9nl3tZgIefVg9Vbns/FF
xHtph1zJ8BEHT8c3k6diVcVIWObQNx2Tsyli6hk78+NgCl2vbLLp7tmxIqPM5/iN
mBYNXhOhFl/Fzq5qAOMqTs8/3EWGpXq8ddodg7xO1JgNLLiMI+C3XZUkn8A0l2Y3
Un2z1wcm9xs2FfCnpoxOpM6hJxoTTA==
=v5Ec
-----END PGP SIGNATURE-----

--Aqk5F9s36CVnq371--
