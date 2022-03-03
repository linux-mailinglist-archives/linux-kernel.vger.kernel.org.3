Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13D4CC460
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiCCRvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiCCRvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:51:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ADD134DF1;
        Thu,  3 Mar 2022 09:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CC56B8260E;
        Thu,  3 Mar 2022 17:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3867EC004E1;
        Thu,  3 Mar 2022 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646329816;
        bh=51aBfP9l60XsWjT3AW2tScEWeXi7FkOMBaVOzj6T4U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYepwbHZViE06tVzwTabGfx+dND6DkiOL5oHV2vCeJfXqPlEdeWpX+LsiInFpB65K
         TuyTT/GKDIQCIq6JSFe6cHEpxrfX4l3R8xo+Agsk+JFo1k3m1I7k+tH5ho6fDUn5J1
         s9fEggP0XzGvCSRZ5k67BIm7hbcSipLQWoWdalczzXwS5pTynVJrPxwpPcnRWmiqZ8
         IFSdqp4oa0CTPNXmbmGpaZ9l+vON/lCKhqHPb5VRllJ2FeP6iAQvH5dRRJDCpdsgDc
         SGc1FrzJrjWDIUaxWFjS9Z8nzyKfp0n/jL7UyFJ+uhrUXF/zz3mzTVjVi97nyl1Sk8
         UXjter6yA6N+A==
Date:   Thu, 3 Mar 2022 17:50:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/20] hda: cs35l41: Remove unnecessary log
Message-ID: <YiD/0ZMcSGVRTZxx@sirena.org.uk>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
 <20220303173059.269657-16-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlaslmZqugs/gzML"
Content-Disposition: inline
In-Reply-To: <20220303173059.269657-16-tanureal@opensource.cirrus.com>
X-Cookie: Password:
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wlaslmZqugs/gzML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2022 at 05:30:54PM +0000, Lucas Tanure wrote:

> If regmap fails would fail during probe of the device.

I'm pretty sure circumstances could arise which would break things at
runtime.

--wlaslmZqugs/gzML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIg/9AACgkQJNaLcl1U
h9Bwygf/Y5M+R1e68KG9SptbJokKsEqBQC7gRAujY/dvMRDKz/TJ2DkuYo4d2Gsq
827x8cbebcmHHBCFlWP9ZReFuSFAeYY8n39eB3BAKAtuLPMCEasz6kUy4yWIr179
Zbj9U/PMQL6DRIJOLdx9BHfq0Y95xk9dNd96InSsQwy9uVWcVYWSHxgNGnLRJfqW
0lEmLhmGqMpIVDPVB96puHB2asziHmDJPjSTSk4gF0K7nIH/dFHLvn4H9GlAXvUw
dc22X2SGYlPVzG2z8rzZHmGOLvc4qYyORC8b9ui93j8RJwFDqtTX8ZXz+yQD3v+6
/mnzCZZESsxzpqCwqmr8GuOdw9mahg==
=9o+e
-----END PGP SIGNATURE-----

--wlaslmZqugs/gzML--
