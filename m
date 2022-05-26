Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42946534F79
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiEZMls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiEZMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 08:41:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760B275FE;
        Thu, 26 May 2022 05:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E57661A41;
        Thu, 26 May 2022 12:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E89AC385A9;
        Thu, 26 May 2022 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653568902;
        bh=wTJaY6UYeSQMpyCf6Zoa3Et0K39VOxkxRDN0JzGNRuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pi94MKiQV/HcCpM68GJEhEfgg8b/8JIMYc91v+ya7OvQRIcWDTm7B4xOMdHhFJeak
         mAoQV3kIbM7RLMwKm46KUf30aZngTCAV+TuI4iq3YrGWuVpyosfq+GPpfiuxSeavEK
         SdCSRT3acHUqRWm8eHEX+qgUDbOAASeYnoYQwW/HiLVQagZXaEBU6xW/+0cgAX9X8h
         yEtw8udj1vpnBEl45XwQTSwmHFSDhxOTzPIzA2yRhMjiNxN/08LuzuVo4ik2AmIHBp
         vcIHN0qe3rzZk/Ns/ZMiLeExiVsWT7UsBPP22NnfQJrmbj1sq/x9oQ0RwDpCqiopnV
         uS1OW9z5luLBg==
Date:   Thu, 26 May 2022 13:41:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/31] spi: qcom: Migrate to dev_pm_opp_set_config()
Message-ID: <Yo91gCrJR1Hkw3tl@sirena.org.uk>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
 <09fde85449e0e189572ea847e86148943aff8b2e.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0tXUzCv+bLIQI/l6"
Content-Disposition: inline
In-Reply-To: <09fde85449e0e189572ea847e86148943aff8b2e.1653564321.git.viresh.kumar@linaro.org>
X-Cookie: Money is the root of all wealth.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0tXUzCv+bLIQI/l6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2022 at 05:12:22PM +0530, Viresh Kumar wrote:
> The OPP core now provides a unified API for setting all configuration
> types, i.e. dev_pm_opp_set_config().
>=20
> Lets start using it.

Acked-by: Mark Brown <broonie@kernel.org>

--0tXUzCv+bLIQI/l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKPdX8ACgkQJNaLcl1U
h9DhFwf/cYBqrNp3vBqv2DwNXoefB9v8zUwrtWUHRECmnkVJekcGzC8pl0wlqPQZ
mw3r4zVDugva/Pd8iZM/TwvrQI7l8kFA2H5T40RwRFgrPfsSQ8d62X4MyJbZfVJB
JqlGIKXBZF9gt7q9NwulTbln0eFC+BJFnrRwtjo+LY4lzf8WItIlgk02r+q98uwD
PXTtOFxJ3S2KMqSo50/rGpp79KR46I1LqekgucI6gkKaohCzgthfPEPoylByPUu2
uCWqHcVw1IwYxf0MnGPwEQYKsWbUMe3rUL/BBDV0r8xywH5nFNLhu4fr9nO8AG28
hDnTtPs9ekk6QkqD2kWrOJZpDr27Ng==
=cGQq
-----END PGP SIGNATURE-----

--0tXUzCv+bLIQI/l6--
