Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE64C461F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiBYNXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbiBYNXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:23:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC1B1A7D93;
        Fri, 25 Feb 2022 05:22:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3674BB830AF;
        Fri, 25 Feb 2022 13:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DB5C340E8;
        Fri, 25 Feb 2022 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645795353;
        bh=BE4hrEf++LTFDnQPp/ZoaVBPWw8PZwKwJBycLMFea9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NcFz/JrzExXH97+JJ7qlsESz+8CuhDSU/01BWfkr2ImhObWUjXNILKNFnuPBT3RYr
         xQUTU069umQyMHFkRpY1lypH2KDkkdH74NhUmrGCkCgG2MqWGj4c2pLwFk6/3wO4NQ
         kKuHUtMuKJXvSlv2NP4LODYTOA6KzwMfyDxF0IuUpm/CSidjJeciTDNVPH1fi6NEis
         7XwSjgw7OvVT6Gpf+fzvGS6c8ilhPBaNUvePC8w0fjPUJB14Q4gASJ47oySeSZKv2n
         GrqIzDNaTG5bKUXDVkXjhPAQgH6O7y8CobhbocBxxrcrUVmBJmGG2n0Bo3XtB6rAe3
         b9QfbpHj6Toww==
Date:   Fri, 25 Feb 2022 13:22:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ying.xue@windriver.com, richard.danter@windriver.com
Subject: Re: [v2][PATCH] spi: use specific last_cs instead of last_cs_enable
Message-ID: <YhjYFc2HaGjydMqO@sirena.org.uk>
References: <20220217141234.72737-1-yun.zhou@windriver.com>
 <4d621283-2a48-35ec-2131-1471a6b94c51@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M58BZv/y8CRnoqht"
Content-Disposition: inline
In-Reply-To: <4d621283-2a48-35ec-2131-1471a6b94c51@windriver.com>
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


--M58BZv/y8CRnoqht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2022 at 04:22:01PM +0800, Yun Zhou wrote:

> Do you have any comments on the new patch? It just fixes the
> regression introduced by d40f0b6f2e21, and it no longer affect cs_change.

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

--M58BZv/y8CRnoqht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIY2BQACgkQJNaLcl1U
h9Da7Af/XNWdUV3sNmp0eF542/LjeEc9cNbzIdfJkQyNhxi6m3W8ca3XHaQUTfLJ
w/8G3q5uIw6vN0wjHSFkof0S0j6fSdONKL3t6z62o6mBcfPTtTCkZVnnmd5iSOAK
yDWXG90BvorEMgp81w1DfEz7s0GYUOZOgaA8iZseNRnnnNyq8v3Dcj98nukbXQrr
ou3RepnK31XKIOXN4yJwNyEaCIwPkz7knMdjbBSuBVQYxPxaIno3FC6CBxuDAqXV
lTDKhQLdUFQlOT2QlpSMjXBQWzein7gi4W7fRRH12ES81M3qed9CcwH9uzF2WIvU
5Jlet0uvsCoN6+IQuji3MnYz8XfuMQ==
=7NE0
-----END PGP SIGNATURE-----

--M58BZv/y8CRnoqht--
