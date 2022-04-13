Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72324FF9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiDMPHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiDMPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:07:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD82A271;
        Wed, 13 Apr 2022 08:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4193861D1D;
        Wed, 13 Apr 2022 15:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F2C385A6;
        Wed, 13 Apr 2022 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649862297;
        bh=VjQY5nrpmgcSuXTK7yu3ew0bxgkZKQoSqOgDwl0n0qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPlaH6Uwu0ASIIeC4tABPUXxD+o5rD0bVVjxiaGSaGJzSnoa7pEbwYOJVPzdwxBr8
         gjmVBL3QASH7L3+kPUTYd3ATwDf+Ww0FtHN/+gbvrLwirjJnoM+Ox8JGAveDN8iQhi
         SdaVZOW03yWFbj2CcXTV4aWWL0XDafDczT09RCDSqlvv7X+Rl5IVzmVger+t9Iy9eH
         jThrWoEVjusVit/qemkFT1q2MPHcWZwM9WuBMXMhtyTzr35msxMUgJEUao4rjg/dAk
         2SM9lnWA7c1kD7cKtP8brJcgyKbwO3srdZROYmi951/rZzD5QjgTYtIODfsI9TJUc5
         LmilSMYDd1Pwg==
Date:   Wed, 13 Apr 2022 16:04:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Agathe Porte <agathe.porte@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-hwmon@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix array constraints on scalar properties
Message-ID: <YlbmkSFqY34UuVzN@sirena.org.uk>
References: <20220413140121.3132837-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VekwRPP0COgtFOIs"
Content-Disposition: inline
In-Reply-To: <20220413140121.3132837-1-robh@kernel.org>
X-Cookie: The horror... the horror!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VekwRPP0COgtFOIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2022 at 09:01:21AM -0500, Rob Herring wrote:
> Scalar properties shouldn't have array constraints (minItems, maxItems,
> items). These constraints can simply be dropped with any constraints under
> 'items' moved up a level.

Acked-by: Mark Brown <broonie@kernel.org>

--VekwRPP0COgtFOIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJW5pAACgkQJNaLcl1U
h9DmlQf+J09i7xHNBLa9qVJkVXaOe/HVJYPPltu9GIpREcAJsawEZ8ZgDKwby26+
+O8wcS47jwyM2wZ375w8CG/0FcziZRNk6g7yndlWyV64CN/Df4tje+K9ZC9Gdo4n
OQrfdNzqXLPs7KxCpSYGQUhDaEKBAd0bUY/L+lszBvk1MzWBaDVeexfjwLGy+YVL
4M+OkSQ++mNAsRvPNgyOqID8nPkKlrnkXL5dm/GG8SHl39P3GxGKl4Cag+Gd1/R9
yIrjCokgS3AhWjKGygEYh1AFNJZqueydevyr6s4e1JRm/Fi6lYL0xRlPPx5aPsGZ
xfaeAjTvT59WiM8RA/ZX4aZX46zCXg==
=O1L2
-----END PGP SIGNATURE-----

--VekwRPP0COgtFOIs--
