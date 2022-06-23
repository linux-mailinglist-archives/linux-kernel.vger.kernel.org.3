Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE3557CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiFWNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiFWNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1482249B74;
        Thu, 23 Jun 2022 06:18:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A186961D59;
        Thu, 23 Jun 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E80C3411B;
        Thu, 23 Jun 2022 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655990335;
        bh=+q91rozLXV1F07SnlyqqwQIzXat1VY2KS3Sqp7xJIY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HS+pblC4MwqlSH7SyaOuXtrYtqHzDCKRC5rHPEdOtp9Ja+Pm2+gC9OaEkRKwGe5BE
         AtYJ1Uej8uOcdPPUoXJhdwkCXZDZ/feogxiyLKNs5ESSloKWTtgBK3kHd7IyPkdZqW
         amzSnzAk9WrzI0UnAVXTKKL9buWhwWPl9Cvtr5aeEBys4Jz8Ifgry/I3uqBQAU4SRf
         aNeigM5Xd1rRKUcaEmWz50nF00ZO+pIcLQSoFmswWuP3GAgs5TuGtCk4nUUyRpSDgC
         RwuJQL+mMeIlG6q0ShhzO1Fjtm+1E622/Y1kJy7n7yVQHs01pJWzm7qP3QERVUKsYA
         NBCSqbGMG+Wdg==
Date:   Thu, 23 Jun 2022 14:18:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/49] regmap-irq cleanups and refactoring
Message-ID: <YrRoMya3Rf8E2S4D@sirena.org.uk>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <YrH7JurP2LAl1uYU@sirena.org.uk>
 <oewDtaKXJJctSx2HcLTI4xuAmbzWo8Vb@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uZnLRbY3NTiniDs7"
Content-Disposition: inline
In-Reply-To: <oewDtaKXJJctSx2HcLTI4xuAmbzWo8Vb@localhost>
X-Cookie: I had pancake makeup for brunch!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uZnLRbY3NTiniDs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2022 at 10:04:59PM +0100, Aidan MacDonald wrote:

> Thanks for the advice. After reading this and some of Andy's comments I
> think I understand how to organize this better.

> I'll send a trimmed down series including only regmap changes, and
> instead of removing things right away I'll just mark them deprecated.
> Then the driver patches can go by subsystem (one series per subsystem?)
> and once everything is merged the deprecated stuff in regmap-irq can be
> removed at a later date.

That sounds like it should help a lot, thanks.

--uZnLRbY3NTiniDs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK0aDMACgkQJNaLcl1U
h9Ciawf+O3sPwoZ7b2cwMa7fzkJuh3cMIYDwQqI91x9o3Rt/Ao6QDFqqFiizb0zm
mxT6/xlzsCfci3loaADC6+l4mERSTrv9+H6ZyuCBGIUDi8HEARM5nVW22SVRrpDz
5iG8AsjJi24GWheFMBDyq+quYM7E/2uVnyXlyBp/ujgLWoI1Wr6AK2s5NDcgGYBV
1Z/i3iwu6Q0dHydTMVMHTzp+2JR+3AxNeAFsj5n5F2jZu3fT6GbyJmjP8fw2MzzZ
7vtCDr2ZiWOTXolV4yzl7z8izc32LCB11q9XRqpqvMWDO0nGGzovdkzszfyjwoDl
B6Yyutu8vbrp0o1+HBUTrFrKIMA7Zg==
=uNbN
-----END PGP SIGNATURE-----

--uZnLRbY3NTiniDs7--
