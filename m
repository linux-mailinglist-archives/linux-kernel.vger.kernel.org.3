Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A682353EB75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbiFFPt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiFFPtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:49:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5F211A9A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3B2608CD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E37C34115;
        Mon,  6 Jun 2022 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654530591;
        bh=vhd5my6p23hzPqpYXTafX+9Xs19bDMxSRZYPH7CeDlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1UwXXIe6PMVX+f1UufErS7LJbgs9RYdhUl4Is9wM3UnmxSAfwqgSLLa96U/2Mglb
         g52qJI5Rn7mbjk2b7cBf/BlXDrBLa8/+wMo6H/ddwk5ByzUZthj1SVOUz01lkf6Qdj
         FrJMyqa8noqzZhIiwRYTPuieKVnfp5d2Z+1vTtiXM7ErOsNVhxHZ1qQw81hwzmN/HZ
         8q3U5HCcwHNU7szMY5MSLLUDPlD49MBtN+PlIZil2tIRojdjHbqtfxXAA9lws/sE/c
         mzBTZiXCQXTQeg0gkoOocf21FZlSrYbUk5LeI0+MEQ85innUjvMaSDxgRN+SJDPZbN
         3MS7FqGnH9aQg==
Date:   Mon, 6 Jun 2022 16:49:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Remove warning when no plat data
Message-ID: <Yp4iGvGFD9jo4WUP@sirena.org.uk>
References: <20220606154441.20848-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SMfXIdWXQXrCzSBB"
Content-Disposition: inline
In-Reply-To: <20220606154441.20848-1-lukma@denx.de>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SMfXIdWXQXrCzSBB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 05:44:39PM +0200, Lukasz Majewski wrote:
> The lack of platform data in the contemporary Linux
> shall not be the reason to display warnings to the
> kernel logs.
>=20
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Given that the device requires configuration and doesn't appear to have
any other firmware interface support that's rather a strong statement...

--SMfXIdWXQXrCzSBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeIhkACgkQJNaLcl1U
h9CQawf+IvjMRjYTtlCxj94jZmQcyXcO4QjnvuR2CTFXHZXSO7Su/6NpQz+9eGpm
D/dhru7Esj1HAPzHx+6XIcK1JauvrxbOfPH6Nrzu2ZgV30No/XI9s6/wO4wIwE3e
McZ+A90coMQE5oNukg85LGp6B7xrzIuoAccZkw9EOR4N7LUkQBVJOjPMlqXW3moV
uyAa+wWRFNBiNzPp+l07Tx6znMlzPunwa7FBMJdrsEn3RNCty3US0kE1LMuuxSLz
3j3SvZSISWeckk/aMXvfxyWJtZWmNj1sZ8R06wjY62IbWAFxoxwZ/50jo0h6yunS
n7tiOGDHYntybspAABL4q89tdQtXEg==
=T/Bx
-----END PGP SIGNATURE-----

--SMfXIdWXQXrCzSBB--
