Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22864559940
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiFXMLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiFXMLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:11:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB613D0F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:11:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5648AB8286B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC866C34114;
        Fri, 24 Jun 2022 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656072711;
        bh=pc8UKkAsxy+drOm1cyl5G/M+G6/DZKYcpaz2NiSvhus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJFZhNsHRCx+tt7sQyaHgNTcYU/Bkf5NfV4m7tHwREnoX0WZWtLWu1pk0W5I81dKn
         g93b2w2FBjHs8svq6rMNkFrr2QhcJJergMqYOIJSy7Lp9GZPQvFumuDA666kMehpty
         syJJVFYU9YyV6454aIxMeom0ZXBartCRGvnMmq9/3mq8UkHdK24E61ltkyQPV1oiuv
         pwii1BXXhy3WCYp+AN4EBjuMrhD4Rjs6v7BPuhi36nc7d/DbhwCxTAZRSu4g1FuEcI
         Z06Sd65E63QVuSApVyzv9hbefV5kx03ZoaxpARCun73sy7jfQ/pMXTjOIcUBtf2yVw
         ojv9qcYJjxOww==
Date:   Fri, 24 Jun 2022 13:11:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] regmap-irq: Convert bool bitfields to unsigned
 int
Message-ID: <YrWqAqGUuy8Z0F3x@sirena.org.uk>
References: <20220623211420.918875-1-aidanmacdonald.0x0@gmail.com>
 <20220623211420.918875-2-aidanmacdonald.0x0@gmail.com>
 <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="osEfMfwMbAxYt41i"
Content-Disposition: inline
In-Reply-To: <CAHp75VfTqTfMsrdqyqRj61JAAJ4a_h3rrFriY2d+rrqpVviy=w@mail.gmail.com>
X-Cookie: Help!  I'm trapped in a PDP 11/70!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--osEfMfwMbAxYt41i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 11:26:10PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 11:13 PM Aidan MacDonald

> > Use 'unsigned int' for bitfields for consistency with most other
> > kernel code.

> There is no point to convert the fields you are about to remove.

> So, either don't touch them or make this patch closer to the end of the series.

It costs us nothing to convert them, this isn't a difficult or hard to
understand refactoring - the patch is fine the way it is.

--osEfMfwMbAxYt41i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK1qgEACgkQJNaLcl1U
h9DQIwf+JUtnYNjNB+6OTI9aVmigcYZIo5nLXj/pTVpyA8qZWNI2zC62X5FaXZNT
KwQfbMYZ7GTc2r2P73Fl/5Lf+jdIgYGXLxQnY/ZRqm++erZuJ1fqI/a/e68CXVO8
lB/3EKX9siLMfaDtuYcH6vlN6J0ZOjoOqBQpLyW4z/hrJrn9cFUtruyGgKraax+v
ZdOwahlPCCbQdeKEitkd3IoVsR5c5tNXYHU8of82McniQWeJQ3vtUjGchASv6Wvg
wvVBu/q+BmxfmPzOpMeHFtTPbdWvhg1C/cQ92vpw+CEn12Jk4uZTe0Sj1zVbESAZ
lxWZY6Wk/xRUJder8cLX4ag2Boxidw==
=RP1q
-----END PGP SIGNATURE-----

--osEfMfwMbAxYt41i--
