Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C23450E03F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiDYMas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiDYMaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63CD3B576
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BD50B8121A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 12:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D92CC385A4;
        Mon, 25 Apr 2022 12:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650889576;
        bh=CCfsBTA5tOM5okHwD5mr1fjJwZTvTnfyFRzdWo61CQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOsgTXh3qLqBYkKsEtDHorXameycdD9qsUjKa79ik/kQwpfkC1vWwwzY5xEpXl+qv
         AIUv6JPKHd8EhWPZ4isMcJSZQLROYRnyQCIQfDa6HE1iJpg4UbW4ple1PgvAFyEWEq
         lnkE43sf8WbQar3VAVMa186wn1OyEG38k6/5/qpndfahwQhSJy+dIZsOXA2m3CT+ro
         JVA53pk4Gcb9yURRgRfRyMkJ8xt44sA+V0OVDYs45dcgumSHEjMhaRTJ29GQF9eV6w
         qFEEoA/C5WcOwPlbdm8ggoIZ/lwz38A7hHoBsOFSUyz5HtzDw9075bfkvvRP+4VaOg
         LH02Rq0fXRqpg==
Date:   Mon, 25 Apr 2022 13:26:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: soc.h: Introduce SOC_DOUBLE_R_S_EXT_TLV() macro
Message-ID: <YmaTZEnMAsqtg2FO@sirena.org.uk>
References: <20220422160112.3026542-1-rf@opensource.cirrus.com>
 <20220422160112.3026542-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dUudKPHLHGWxXp+f"
Content-Disposition: inline
In-Reply-To: <20220422160112.3026542-2-rf@opensource.cirrus.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dUudKPHLHGWxXp+f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 05:01:11PM +0100, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> A straightforward extension of the SOC_DOUBLE_R_S_TLV() macro that
> allows the get and put functions to be customised.
>=20
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--dUudKPHLHGWxXp+f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmk2MACgkQJNaLcl1U
h9Bz7Af+Lf+FoJbAa0i8nRsGp/D2J5caATzoFfmsqnNeRpBfsFEkg05oAcUbaGXL
9a8Enhi1C74R5eW+yhjZ2778l/iB/rI53TaQD96c9pn9wfLIkNpeP5YjVDZDJ/ki
Pfz9GM04a8QYrqQhsAzjUGDdV6x8vBkRINdo9aq/vDmjvfcLRtbNweng3hziT8R9
61W3AQOgE6pvufbsTJONUF7HZdbJCQAt327i2q1e4FRevEoM4yiQNJJIxWYQTJ0H
mvb2bAW3SlZk7Yw42EULySeGI8xlxelerHKWsXdU/wti/fEUcaZzI44F+S4ncOu2
AiBQjJY3fngU+FFvD+Fzf8DG9LI9SQ==
=OCou
-----END PGP SIGNATURE-----

--dUudKPHLHGWxXp+f--
