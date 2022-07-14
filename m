Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77F57508A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiGNOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbiGNOOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:14:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876075F126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2298CB823A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D7C3411C;
        Thu, 14 Jul 2022 14:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657808069;
        bh=3U5pUDmawg5fh5XtNg3OWkORovxqkk3Pwo9z3khEo5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jpv6trEPgfmGC36CJy3x0ZXKyr9wfk11f5/5UWF9voiAoC+TaG0TauRytUkdAZV3k
         nSYh77wdGklvojYFA9MeXDpiZ6UBsf/pPQhfeSXXmTA0WTII0kYBArZyIsF3IzeB+l
         gBNmSzHXQVa7ZxQxSYHjBVcmvedUeRYOhuUr3623ovf/WABlwm+aYeUzcjV3yvr6bJ
         /J8/w6quFULTy2zWy1QnWgHEneiSrOyznsT97IrnHRLZCmqIMJDt/2lcu265jrKe5u
         M0zpsWLQapDxiJX0N3sqHAvQPDE4akV5pl8o815I0crAn6X6IiC/ffk7tALAMOqC+v
         Er2bul/vUN7Bg==
Date:   Thu, 14 Jul 2022 15:14:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <YtAkwcwXaQqZV75d@sirena.org.uk>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
 <20220714141041.GB2229197-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NamUX9WLL/FmdQby"
Content-Disposition: inline
In-Reply-To: <20220714141041.GB2229197-robh@kernel.org>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NamUX9WLL/FmdQby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 08:10:41AM -0600, Rob Herring wrote:
> On Thu, Jul 07, 2022 at 10:18:24AM +0200, Naresh Solanki wrote:
> > Add a devicetree binding for the 9elements,output-supply driver.

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - 9elements,output-supply

> Why does this have a vendor prefix when it appears to be a s/w=20
> construct?

It's a description of a power supply output from their system (system as
a whole, not power provisioned within the system).

--NamUX9WLL/FmdQby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQJMAACgkQJNaLcl1U
h9AXrQf+PzFb/xxndhAIQS6ZnUduzeEeOZ1R32ToTXClsXb1Tjh6wOVGsSJEUmiV
NARFEPK3czVMUio1uoJLGfm5hhcTcvITrokZYb+cfBqvlCQ0Lj1J+6vPYcPUzs8q
rbEBlsqFHb7eNUD7o5TN1VMX5OEJ55j8jT5/C1Cld17DKQ0P7uRCYGlTz4JiA19k
qFF3CxJpRyUjF46w0t4qkRemAvjZvQ0x5rLpK3uVq9tFMrSTBNoJDhe55l8Cv70H
Ivhnqshmos7EgY2QDa6bEEK+7aq4sek+LndXwd2YxojcK5hhpdQ6WTDhWaPkAKV6
YemDZuEAF9QQ5AQFBBmt9vsEVfLPzA==
=b5cF
-----END PGP SIGNATURE-----

--NamUX9WLL/FmdQby--
