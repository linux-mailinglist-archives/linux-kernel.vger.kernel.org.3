Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBB84D45A6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbiCJLab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiCJLaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:30:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5713D56C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 03:29:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A01F61602
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902C0C340E8;
        Thu, 10 Mar 2022 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646911762;
        bh=uKKQrIIKFBwSgsheqX3HqJPqfhTRezkt/iDCDYvlKjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAcTTaf/++SYkJuCwSUTxJMpZrgKyZrjOaqYjC1VoO98l0THMkZSMbZu7LKF3496a
         e1HwiQ07mfaL7e3jcAIbdp00GgKWPbU6uy5CMHl7pqvxfX2WVsz4R+eLnkBvtpnzCQ
         s0LP+clmvzK72uKL07fwm8pF/O1HU/lVRO4rsYGTVdQRkzGioNhRsrgECcVS+pe9bi
         mi33nmsiN/e3wf+0aEsQM1dJGhkBuA3+vr+aUT/TpNY6uLWGidNg8FbmvakJ4qb5nb
         PbjkB8tnAL08YlKmgIawgsFQJG3OHg8yroIX3KC8PsqkGN0v0PwSyt5/kS1FwVl7/P
         bLoBpimh95KWg==
Date:   Thu, 10 Mar 2022 11:29:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Steve Lee <steve.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "steves.lee@maximintegrated.com" <steves.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ASoC: max98390: Add reset gpio control
Message-ID: <YinhDPrSvrYV5vKp@sirena.org.uk>
References: <20220310081548.31846-1-steve.lee.analog@gmail.com>
 <SJ0PR03MB67794358405FA661992A206D990B9@SJ0PR03MB6779.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MNhXQ4XGIMsIAMHL"
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB67794358405FA661992A206D990B9@SJ0PR03MB6779.namprd03.prod.outlook.com>
X-Cookie: Package sold by weight, not volume.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MNhXQ4XGIMsIAMHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 08:48:09AM +0000, Sa, Nuno wrote:

> > +	max98390->reset_gpio = of_get_named_gpio(i2c-
> > >dev.of_node,
> > +						"maxim,reset-gpios", 0);

> Why not using devm_gpiod_get_optional()? We could request the pin
> already in the asserted state and make the code slightly better...

Yes, and it'd support other firmware interfaces too.  We also need an
update to the binding document covering the new property.

Might also be worth putting the device into reset when unloading the
driver, though that's not essential.

--MNhXQ4XGIMsIAMHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIp4QsACgkQJNaLcl1U
h9D6+Af5AXegHDTeiZ2MbFDMHQu/VHpOn1eZieGYkMAzHrNIZ2MzpuTWfomE5iHl
7G5MqciVxPQpF37CSt52SiQhpFbIsaTgJ1d7gM9PMWhLWCElhKVJu1XUWZOEH92E
v+GRHLgkF6JNgpQpUgLejjH1uo/LeVJX9o2UKir4pPAJKhB40VuYhi80k7AqVXPC
9WF8f7tiIowmOozzmTwkjmJuWHgGbZ83mCyz15OtOpitXDTrxgoABc+XxXnJEAEJ
nUBMjbl7kknWM8+hGNjoVLG7q0MiSB5SNM3K6RWfAgUHQKG2UmGcA07sz+4GSJpI
A7wBQjTNTErXCjUsqVIetHCW6iKBgw==
=GZqX
-----END PGP SIGNATURE-----

--MNhXQ4XGIMsIAMHL--
