Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4322857C9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiGULWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiGULWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:22:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E46B41D2E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:22:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D35E61B33
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA288C3411E;
        Thu, 21 Jul 2022 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658402532;
        bh=USJlBh7yL447OVSeuPpyWmX+61phCJ207hQItAmCkN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZbLg9oWcnLQyQ0C9hCkzwpBOhmjhpzC9I0W009Eubw+1APUX8+R42Xu6yZ1004G9a
         TOvBun74ReB0F7GvPJwIRTx047jOLzdwY1TMJBOPxSYQoR7UjdqYCRc65GCx8V+k/0
         FURq+URa7d7elSX/vUunP6OkwW3xdEV+tkfzuIkGeTnX0I2UXYUdsAQdEPQE3BeCXg
         dQgpOXHT+bPknKgxKkKepvoW1bNvgGOKYskyGpCCEBhJYmDAqp7h1DUkq8sGz5oJ3n
         S41DaJYzskDVZ7vhowz5DJXyPWcfniiISbr+0/z/9HrEhfBw8BROG4ZIEFKekpvwo6
         andxDqOMNXBBw==
Date:   Thu, 21 Jul 2022 12:22:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/2] ASoC: Cleanup deprecated regmap-irq
 functionality
Message-ID: <Ytk235u8xWD+vEMB@sirena.org.uk>
References: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KMTdyiBZDjPPqsZY"
Content-Disposition: inline
In-Reply-To: <20220721102558.25457-1-aidanmacdonald.0x0@gmail.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KMTdyiBZDjPPqsZY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 11:25:56AM +0100, Aidan MacDonald wrote:
> Update two ASoC codec drivers to remove uses of regmap-irq type
> registers, which have recently been deprecated by the "regmap-irq
> cleanups and refactoring" series in linux-next.
>=20
> Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald=
=2E0x0@gmail.com/
>=20
> Aidan MacDonald (2):
>   sound: soc: codecs: wcd9335: Convert irq chip to config regs
>   sound: soc: codecs: wcd938x: Remove spurious type_base from irq chip

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--KMTdyiBZDjPPqsZY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZNt4ACgkQJNaLcl1U
h9AuIAgAg9Rr7yRd2g/1EHbmeqzhD4cKtfo9RALBDOIpP/Lmap97lADvcEotdFqG
tUiFtFqjLZjgbb8pldkuq56YjsZu/F/AhIeNI8iCRPgtqsKWc15wHN2bUp61EVax
st9M/JdrYOwugRlYZL30W+wugq0Pr+QlUOWax9ZYpz8Va7w62X7UiypHreu/BiQj
B/o7jsZU6BOyHFP2MPdfWFPfdgQ/SMo6oudT7YC7sWqnNBqIXnaa6ZoPvGWWpMcw
j4VSAbUJCHcX7E7vs/oLZUb/xot2aYQdYMMAjEOIY7T3M5CKV7gQRNz3+zpsYGNl
Wb+oALqz8QMsovJqugPmOUhBsudLxw==
=WUQv
-----END PGP SIGNATURE-----

--KMTdyiBZDjPPqsZY--
