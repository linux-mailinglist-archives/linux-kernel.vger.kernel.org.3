Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398354C70EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbiB1Pr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiB1Pr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:47:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930D7A985;
        Mon, 28 Feb 2022 07:46:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3855B811C9;
        Mon, 28 Feb 2022 15:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810D8C340E7;
        Mon, 28 Feb 2022 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646063206;
        bh=zh6mvTHgv6lw8dZUkV2NkLSn/51hOyLeWJyliQ2KXLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNg3VtPwbqGxzPOoOwGjIVZcODgMtfwe2GjCNGAOIF+yAiwp/V1oSDK94NeMWCISh
         2zKqmOMO52UUNJNqhf0ySuXIJWfI0aqOpYoN0o7ELy5sfK43fuLOAb46SnGJWb+v3E
         JDnugjV/rD//WSv9HPiaKLwqKX9qolbP2W9PiKwYmOiguMWPJs7iLcXDs6H9NNDJDn
         dq+2EYGL41Dqh9YLW7CdXz8KC6aQRWf8uvjt+yWx0xZXBSpkaRMh+2ZCer1GkvrRZa
         r9C9ZQBmSnoXKCn+I2knGhxMBMebItWYj6EPpv95+K4Kmp96X8lC/IW8lsI/7iuVXy
         arPXRg2b6Fb+g==
Date:   Mon, 28 Feb 2022 15:46:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Update clocks property for ARM
 pl022
Message-ID: <YhzuYdB+Y/euzql4@sirena.org.uk>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
 <20220228124345.99474-2-singh.kuldeep87k@gmail.com>
 <6e14bdd4-5924-dd58-41ef-5bdb5561913b@arm.com>
 <YhzmHgV3L+3nmt+Y@sirena.org.uk>
 <1763f668-2582-c05e-7ac8-d635bc84ef82@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3sg9MoE27A1IvpMe"
Content-Disposition: inline
In-Reply-To: <1763f668-2582-c05e-7ac8-d635bc84ef82@arm.com>
X-Cookie: Killing turkeys causes winter.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3sg9MoE27A1IvpMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 28, 2022 at 03:27:08PM +0000, Robin Murphy wrote:
> On 2022-02-28 15:11, Mark Brown wrote:

> > Well, it could also be that the clock is wired to some other clock which
> > is always on (which I guess is why the driver allows this in the first
> > place, there's a lot of sloppy code around stuff like that in the tree).

> I wouldn't say the driver "allows" it, so much as it just blindly grabs the
> first clock assuming it's SSPCLK per the binding, and thus it will happen to
> work out if the underlying physical clock is the same as, or equivalent to,
> the APB PCLK. Otherwise, it's already into some degree of not working
> properly, by virtue of reading the wrong clock rate.

Ah, the APB clock requirement is inherited from the AMBA implementation
isn't it?  We really ought to be extending an AMBA binding here...

--3sg9MoE27A1IvpMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIc7mAACgkQJNaLcl1U
h9DH5AgAggtT3JHbzSG/s7i5V/nVQjzCepMhOVGYXIkPFY2O+9m8MuXqmcrn3qaN
sUQijP+V8rxOWCaO8WHufgdvwfVr3+ESrLRLdmYDY7BakGG1p0dugXup8BtviPFh
BIrgRB+RFl0RYjfP6TKXHfo7pSw2ZFinjsTgukZPEf6R3L4THydMuAv2EbVgng+D
MSlywzM0Ax0aA2TOOGw9uYLPWgfZRh7zOYpXRljR1bz5v9wZ/T9cITmaNY6eiSVl
LT3aprK+88es9aQJcs5XDN8r6f457S9Br1+0SPwqtT+WitZuM/1XC94oIYZmJz7B
3RZSwvJJnF9+mMquDyJkY1ZXvBNnBA==
=0w2x
-----END PGP SIGNATURE-----

--3sg9MoE27A1IvpMe--
