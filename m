Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6615137C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348828AbiD1PLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiD1PLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:11:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F249F30
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:07:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08878B82DCD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538E3C385A0;
        Thu, 28 Apr 2022 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158463;
        bh=/nZBCLAs0DiSHJT2X9gPs0ZJ3x3yLbI4Y8HLjG8WgNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RS3Bg7Ev5Qev0vpQkKrR4PF2ixWf6uLo2R64cHFFZcBkP/E8rgZm73wROgim5uknb
         elaFMLyTSZIzXAZWFcSKns3tJZkUa3EDN1bx5MbwzYiQWDUS2GT31Jw04bDtcLPGWR
         ZRKSAS5/eUuLNUWm9epdOYVuIOrpqvReDir79pof1p8UPm192tuWfqBlrgc7tf3Ppj
         sARqQa+vPi/LGYkoW7KeysTP5YbNwO/yLu1FAt5G7UCY05qWwgPMj6OS3v//4epVmd
         5KY+gH/F93X5P1StcCi6dVAH1H0O6/S9T9lKNsJDG/uHjaeK2G1lhgK+0dUXh3gefc
         wkyM2FtM8vm9A==
Date:   Thu, 28 Apr 2022 16:07:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rickard Andersson <rickaran@axis.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        yibin.gong@nxp.com, rickard314.andersson@gmail.com, perdo@axis.com
Subject: Re: [PATCH 1/5] dt-bindings: regulator: Add property for I2C level
 shifter
Message-ID: <Ymqtuk7PgOjPmncJ@sirena.org.uk>
References: <20220428140139.7349-1-rickaran@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MoxdRMsUyaT6B4L7"
Content-Disposition: inline
In-Reply-To: <20220428140139.7349-1-rickaran@axis.com>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MoxdRMsUyaT6B4L7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2022 at 04:01:35PM +0200, Rickard Andersson wrote:
> From: Per-Daniel Olsson <perdo@axis.com>
>=20
> By setting nxp,i2c-lt-enable the I2C level translator is
> enabled.
>=20
> Signed-off-by: Per-Daniel Olsson <perdo@axis.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--MoxdRMsUyaT6B4L7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJqrboACgkQJNaLcl1U
h9AtSwf/UcnKV4gNRoljWK8sIEWwavJg3OdTE2Oh2aP23GSU4Xwx4dy3zUCYrpYn
nkLfHPkkH9bccu2Na9XmuOYCSLRokTOq6e4jEqhuLle6ILWIjGQElw36mMJ3eRcN
3KbSJbT5FsBHJxLFSahj0ro2krHdqpPi+xsZzfXGEY3oQE8nGVujIAbUZ2XBCtHv
ooXlyZ9Z4FBDjK5N6f6eAA4IQ616fisr/XMNJvdT1ZbFmwCzUahjSYkwIcSqfg+K
+8Kat3Pj6I0JogTNg3H5MrV9hZoycug5Lhvk24gv6SfNUrBqoeOWEbfRNC1DTito
Mh3h9NX2McTSQqNZBRysQb2cLdcLMQ==
=o49c
-----END PGP SIGNATURE-----

--MoxdRMsUyaT6B4L7--
