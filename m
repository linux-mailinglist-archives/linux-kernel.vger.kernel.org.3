Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C933520113
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiEIP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiEIP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6A92B3F50
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7229160C7A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B98C385AE;
        Mon,  9 May 2022 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652109861;
        bh=LEm6HgVppnlZQISFT+9HHMdM02TVToh0/TmdUIV0sOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1VA/KljPkrbN3E0VrXXWDAy85QXkbsJaVBAQiOF4F8Q5WDODiEjAoXQwzcENK7tN
         RzwmvpGgOcIbQ/Qy2a8jDuwRxGxHHf2vWRg3iR2QQxh2QGmvYOho/wWRTO+Wy1atUE
         ZyS+mZZBqXMm8+O1ruKF5FCPJf7VwS4d5aUDngSzTfTDj63nL0OlnAWtYux1vzy++8
         Vg+BM7BsoUDdeYa/So4urPkvgeLL1H8gZ9HP1MnQ1mQk3tYAFss1M2qSbvhuG/SKps
         IaQaM78dqK/jfp2RuYx2KXRAQrmm4kzq9QNiy0CfJTluGQkJK9u46KrXlsiVPsdcs7
         dqBHERaC60cvA==
Date:   Mon, 9 May 2022 16:24:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] extcon: Add extcon-regulator driver
Message-ID: <YnkyIBh2HnXXLHw3@sirena.org.uk>
References: <20220505232557.10936-1-zev@bewilderbeest.net>
 <20220505232557.10936-3-zev@bewilderbeest.net>
 <e27ff1b2-c82f-8335-340f-ae1fa914ed30@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WO/WlJ02k/DBZ1pO"
Content-Disposition: inline
In-Reply-To: <e27ff1b2-c82f-8335-340f-ae1fa914ed30@gmail.com>
X-Cookie: Boycott meat -- suck your thumb.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WO/WlJ02k/DBZ1pO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 09:24:39PM +0900, Chanwoo Choi wrote:
> Hi Zev,
>=20
> I checked this patch. But, it doesn't look like the extcon provider
> driver. Because basically, extcon provider driver need the circuit
> in order to detect the kind of external connector. But, there are
> no any code for detection. Just add the specific sysfs attribute
> for only this driver. It is not standard interface.

OTOH it's something where if I look at the physical system with the
hardware there's a clearly visible external connector that I can point
to - it just happens to not support hotplug.  It's not clear what other
system it would sit in, and it seems like an application that displays
external connections on a system in a UI would be able to do something
sensible with it.

--WO/WlJ02k/DBZ1pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ5MiAACgkQJNaLcl1U
h9Bq8Qf+JNTLnMxAchMYbqY4M85vtiwxg4q/j0UC05QW3qbi2AF/jyk5zShlky7a
GUigz1AJUhq85ujG2dmNJTHX+rgGpDEbY1rl6Bw1Nl4XqKwGikC3HkSY+YS6DoA+
Mtz+7rc0NpPRlf6QqSTJDhag0sNf9ZMWbnY6uf5N2ORkKnqTxapInPGtFZRoLy4t
FYFnBcwnhsrmnDJmZnywyXY4sE2iEZ08C8Try6RE7KHQp2O6xTmB529/a1GwnrSb
3uzdV+52H4s/+2+yiEYC3kIDpjH6P5heCbT345RN9hOW7H5v1yBPD8K5c66cL8+7
6AWmwJPpjq37H7gG88KCZOS4EJfzGA==
=+dcY
-----END PGP SIGNATURE-----

--WO/WlJ02k/DBZ1pO--
