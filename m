Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24F7598400
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiHRNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiHRNXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:23:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35E15FFE;
        Thu, 18 Aug 2022 06:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE31D6153A;
        Thu, 18 Aug 2022 13:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B2FC433D6;
        Thu, 18 Aug 2022 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829027;
        bh=7Jvb9VTNTGyJevS3lgNMgSmphDuDuYli74EbuMld70M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJRAhCjxfceD0/NRdpH1rqi3S9qlJKifQfmcF0Qojaje3rJ+Zc4mlYEP17mKisiL3
         rUnXKoskTQ4OPazWMfmsvCMTJ6W72qcQUf3DBqtGpJXZQBUFxUPmqoK9iiEvbySh7c
         ikr7l5/4FuUrY7yv9iSSqsn17N57qEtJ3XXhYswTfM+VXPE7oN18CChPr7vm+7ohBZ
         6RFZoFIJxSedXUlZJowCGCEpgMfKx06YXs1nKcanpUyr9JA/bsJntdaeqlcWFv/5fg
         n7GvHEr3/lYueiSjBdobJ6zpLwXyvCaLt+f9H6WWR7oR8Mumxgb3IyxEjUBqTxjk7l
         JodKLTToJxIXg==
Date:   Thu, 18 Aug 2022 14:23:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     sanju.mehta@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, alvaro.soliverez@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH] spi: amd: Configure device speed
Message-ID: <Yv49XpsaRzerUuMl@sirena.org.uk>
References: <20220817131809.312533-1-shreeya.patel@collabora.com>
 <Yvzw0GqUd9ZgxUTo@sirena.org.uk>
 <3e2a0f50-c396-5af6-5cbe-303978378587@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpON6ygzczDYYJtZ"
Content-Disposition: inline
In-Reply-To: <3e2a0f50-c396-5af6-5cbe-303978378587@collabora.com>
X-Cookie: Logic is the chastity belt of the mind!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wpON6ygzczDYYJtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2022 at 07:40:31PM +0530, Shreeya Patel wrote:

> yes, the code is actually configuring it to use the frequency which is
> strictly less than the requested one.
> I just didn't use the correct words. I will make the change in commit
> message for v2 once you review the patch.

Please just resend with a fixed commit message, I'll only have to review
it again anyway when you resend.

--wpON6ygzczDYYJtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL+PV0ACgkQJNaLcl1U
h9BEBwgAhIXtiH5DF+MI83yuJvAokOdJxz4J+febdaSBzNrTECfN7mr7moYpsmyT
JzKCQubxRAPeFRStvx47bB2cbLiNCLZmXDq+bfxd87vPLGOmRhxsmkQAwTB40NeB
+m/ToXHS65FsMZo2Z1zDAE/3BtTW6VkQFoMXzw6xUlokN2yFHekhLMj2zSLsbpK4
cGt+HX+AVu5LE/KvDqm73mBnDnVZ4MV1IWCqChFielHqbx+YRfmCPp/HNMkCFFar
x3GNngih9khR+FRAv7heZH+Wuj2fFbO/IA5eIQ9nCr6Rd0Dh8XMLFSB8Io8Jmq6Z
Z0lWGLNIMzNcdm/tNM5SfS3Gtbz7Uw==
=nDTc
-----END PGP SIGNATURE-----

--wpON6ygzczDYYJtZ--
