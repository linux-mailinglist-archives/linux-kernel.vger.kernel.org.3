Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B8589B82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbiHDMNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95C51A0E;
        Thu,  4 Aug 2022 05:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68CF461797;
        Thu,  4 Aug 2022 12:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D843C433D6;
        Thu,  4 Aug 2022 12:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659615185;
        bh=u0yXAdhznzENR2Rh5ZJuwu1c8iJvOQRGuTTVrkrfFbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQQRLWFaFPFoVjLvsVyIllnW560gJJRODSVk5pzGIRXTCYJwAM543MiFOYrmQCyYo
         EK3dyhODg/h6NyUBJuyNmM0lm+TyUodhj4KexUkpEfrzhYPQrS4P6NYFPD9bxtc5Mt
         xrYeeEEqJaddOht7kKp5/e13Gicq8OsbV+YrTSAAmjsKmK2wXXKioojNlJ57adcM58
         e7NMWUHz5IR9/DT1MhrOlY/BQqTl/9V+5ldWXt0hbcNX7tls7F9khWFfcPIzGffJSB
         Kzb5/3w+t7XLuEHNYzXEMfjhdipH841RzjYnOSc6H8F6SqopzzwSJMWePvc0tdPItw
         nNGKhFyy3FpmQ==
Date:   Thu, 4 Aug 2022 13:13:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor.dooley@microchip.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
Message-ID: <Yuu3zKmFZm+BJpGD@sirena.org.uk>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com>
 <6d36b192-9e63-ec13-5583-22b81c99c18b@linaro.org>
 <Yuki3jpCSJDdXcWA@sirena.org.uk>
 <dc7bca02-5eb3-3b33-8911-a950b630f197@linaro.org>
 <Yup4JLh00HZxFQLc@sirena.org.uk>
 <b9cc3290-f0cb-0423-7ff0-dae40b52a379@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oc7VtuM/urxzgPrY"
Content-Disposition: inline
In-Reply-To: <b9cc3290-f0cb-0423-7ff0-dae40b52a379@linaro.org>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oc7VtuM/urxzgPrY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2022 at 01:31:34PM +0200, Krzysztof Kozlowski wrote:
> On 03/08/2022 15:29, Mark Brown wrote:
> > On Wed, Aug 03, 2022 at 08:11:03AM +0200, Krzysztof Kozlowski wrote:

> >> Then it should be explained in title/description of the binding, not in
> >> compatible. This is the usual way of providing some text description,
> >> not for each compatible by repeating the compatible text.

> > I'm not convinced this is a useful rule to try to enforce, and I'm not
> > sure how well it will work if the same IP is used in several different
> > places.  It's not clear to me what the benefit is intended to be.

> First, the description here is really not adding any useful information.

> "description: Microchip's Polarfire SoC SPI controller."
> Microchip - already in comaptible
> SPI controller - already in compatible and in device description

> The only useful piece could be extending pfs to Polarfire SoC.

That was the main bit I was thinking of TBH.

> into double-sized oneOf with additional descriptions each one explaining
> "mpfs".

>   oneOf:
>     - description: Microchip's Polarfire SoC SPI controller.
>       const: microchip,mpfs-spi

If the YAML binding format is hard to read when people add comments that
does seem like something that should be addressed on the format side
rather than the binding side TBH.

> Just keep it simple and small. We all have too much code to look at...

Excessively clear documentation hasn't typically been our issue.

--oc7VtuM/urxzgPrY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLrt8sACgkQJNaLcl1U
h9DluQf/YAkSGaRAZLWH3G/bCn9GTaS7y/oVsHeo+hQHX4HQi9fH9rkMsY7n8tKC
rbkmQxpusAu5ego6WE5WTSQQoUhT+UeJHCQyS6Z+/n08nuFiiIYQvvL0cbO1vn1s
ZXhREzwodm27kZRlzzD6s6/fHJygu8HqSinjLXQNvHF1wcZPdFxBKDIOna7cgt/E
ZSNnH6WMv3HR3HVauJ4zYSSsYsVoLjIl0YOa9c7HWllwpgnWahUnM8in1goj+zEc
TrJvFpXz6RH5Yo43UswX6W0Nlgr/brH4o96gxsIRYS0qzSOrfFJrGM5Bfz7tOr1y
6e1QaMU/pUUdOh9Ptq12INY6ejqE8Q==
=cTgr
-----END PGP SIGNATURE-----

--oc7VtuM/urxzgPrY--
