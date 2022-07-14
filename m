Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49624575103
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiGNOnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiGNOnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:43:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC293ED42
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B7DB825E9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60954C34114;
        Thu, 14 Jul 2022 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657809778;
        bh=jjrMgZQq1XsJbSW7CU6liOlUgrPrHGDYv1Ifuo6HFMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gTNJmCbjBbEz2d4Lt5n4pVIsOjkdsoQ89Gy1FyiBYZ0RL1GLtvJhktLq/TV8tQ882
         fEE+v7u0qbdCAJzlJKsu+UuM7WYIqWu2LVbdLSOBt9/q78XbiatNW+mIdAl+cHHW/u
         bq9mSjDzt2gsOcHdYX5IKz1Xvs0kAyizVEEhL0uKc3XhCguL/18LjM4sgWLxqamv35
         0+LaAlTUN3YY/rZ7LIFgIOcuOYUEXNF1LsFeNGPJpCuQuL+EpAWdFduq1B9SZGMN5q
         lxG9LbnicD4ISKhdzCbKmpKgD9jJbQtCsybOTcHYT5oSq/eH2UwuQX4kthZbL7cvb1
         6F4XsZk7YAabw==
Date:   Thu, 14 Jul 2022 15:42:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <YtArbh4a40cACRMt@sirena.org.uk>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
 <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk>
 <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oQHsJMAUAz/nS20D"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
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


--oQHsJMAUAz/nS20D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 08:23:39AM -0600, Rob Herring wrote:
> On Thu, Jul 14, 2022 at 8:14 AM Mark Brown <broonie@kernel.org> wrote:

> > It's a description of a power supply output from their system (system as
> > a whole, not power provisioned within the system).

> Well, that's a better commit message than the original, but I still
> don't understand.

Consider for example a BMC (IIRC that's what their specific product is),
a bench supply or some automated test equipment.  Part of the function
for these systems is to provide power to other systems which would be
represented as a root or wall supply in the description of the system
that actually uses the supply if it were described using DT.

--oQHsJMAUAz/nS20D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQK20ACgkQJNaLcl1U
h9B/sgf9EkCm4L6tNRqrnWQ9pXqIeEHZp/FwCsI1JLpPCeXN9cQ1tg6zBjI+z3o2
gSJI6AVHux+KEsmg1rlC57g0TNcQxwJHG7ebssyICBI0FCqSdYIvL+hDksXryOzT
/CxUhcECsz9UV1qNnuE8N1GY79sN5ih9xKTf/dgSr6xH/we7mohwCTdnexqhfpY6
9RYf8W/JYpbbDDlMTuPSo7otUBJe+guwrSy3/R7+UOTo1T6xfFKGHGWV6fLhw5pP
DXq5ajHCj+N7iJerSk1/2Oj33dlDyWG0XtaAJRutq65EImskta+OdBPQm2lRAgzq
43Ms17jgbzPNB8eH+AXoP69lPGacrQ==
=VKkS
-----END PGP SIGNATURE-----

--oQHsJMAUAz/nS20D--
