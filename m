Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812A1597019
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiHQNm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHQNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:42:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6BA8E989
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5416A61403
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D122AC433C1;
        Wed, 17 Aug 2022 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660743766;
        bh=d6Ro+H9k2fE0b9BT9o/yke+QEo0HDikhsAxMCLLhZs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ljX2QUQS2PYBowrm7nNRFZ2BkUsHqbLzInrWD6OQlgOPc37d6EYZGO0ImLJuNhXkZ
         goCH/i7pTeqRa9dsvI3tMh4NjrrZhE49ZAXc7QZAEbb3bHft1w3U5OOoDZlSvWLltL
         jiALW7xF7Kka9ivSPpemJVwA09XJDUFwsuP74lRu+fBiFRGGGduauM4xkj/2BnfY5F
         5qx0D3drqVp6K+IzUBE69LGnax+MEsPaISj8v8XSQITmIS0u/tZLNxUeSPD9WZQ5M1
         JvvQ4uUbkDendvZ94WZ03jBOmLPi67EHt/BQQPp79JD6D07HvKH2lNBl58n/C6Nyd4
         yZ3tLfjR/1GUA==
Date:   Wed, 17 Aug 2022 14:42:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com
Subject: Re: [RFC PATCH 5/6] firmware: arm_scmi: Add raw transmission support
Message-ID: <YvzwUPGmZPFAzw07@sirena.org.uk>
References: <20220816072450.3120959-1-cristian.marussi@arm.com>
 <20220816072450.3120959-6-cristian.marussi@arm.com>
 <Yvvb6Y+lzuABT1fy@sirena.org.uk>
 <YvypBAnzjKvHBEzi@e120937-lin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QELZVTyl/Moevx8A"
Content-Disposition: inline
In-Reply-To: <YvypBAnzjKvHBEzi@e120937-lin>
X-Cookie: Use extra care when cleaning on stairs.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QELZVTyl/Moevx8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 17, 2022 at 09:38:57AM +0100, Cristian Marussi wrote:

> ...moreover at the end the whole disable and go-back-to-normal really
> makes little sense in a typical CI scenario where anyway the system
> under test is most probably rebooted between runs of different test
> suites, so we really do not care about any weird final state probably.

> I, nonetheless, posted this RFC with this such support, at first to have
> some general feedback, BUT also because I'm still anyway wondering if it
> would not be worth to keep at least the capability to only enable it at
> run-time (dropping the disable-back-to-normal feat), because this would
> enable to build an image which includes this SCMI Raw support, which is
> default disabled, and that can at will enabled at runtime only on selected
> runs, so that this same test-image could still be used in a number of
> different CI test-runs (keeping raw mode disabled and silent) but also then
> used for a specific SCMI testing run that would eventually enable it.

The enable usecase does indeed make more sense, though I'd still worry
about other code having problems with the SCMI support getting
hotplugged out from underneath it since that isn't a thing that happens
in practical systems.  For example the archrandom code is going to get
confused since it probes once to see if SMCCC TRNG support is available
and if it's present sets a flag which it assumes will be true for the
rest of system runtime.  I don't entirely know how the image build costs
play off here for the people who'd actually be running these tests, but
my instinct is that the extra kernel build isn't really much in the
grand scheme of things compared to shaking out the consequences of a
runtime switch and the costs of actually running the tests.

--QELZVTyl/Moevx8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL88E8ACgkQJNaLcl1U
h9CeJgf+Ikq6PaL+60Wk0LZxkHbDz6nkjhCcCTvXPgUzqJkDAF3ogJ62Gr2ciwfz
1k1pRouQrKifP96mZNH5RnqEXYxlK8EY78KsokTatrZJtkT6/03MH0iOv7WkqqJz
3Rw+TiJH9WKCVph2aIo0XOBu+QBJRenhMrrXO8InnKgXvyVac82DYytYeGXzRWDf
2DAYEHt+mFenJkv4nI7ei55L7ODvpe/zP6WyhUTKuSk+DqtvzhmCSRzmQ9ebUOD7
k3uBUfhcn9tuYrtzt+YYFfeaKkGbnSY/Pm42U/Yl0FBdbMUyif6wJunAWw5A2PZZ
ruW/+/d//2AQqo2qT14MCQBm5mGG/A==
=92om
-----END PGP SIGNATURE-----

--QELZVTyl/Moevx8A--
