Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8857C983
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiGULFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiGULFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:05:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2582471
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39FE4B823C8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F476C3411E;
        Thu, 21 Jul 2022 11:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658401532;
        bh=l7E5l4c+Ygm6fPaYzwHXDYWSIV1KuaMsb151szj2Syw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLn/H8QWqn5kYjgT8FnRomo0986UKMgm4Ad3XBBlX0JVLUC3ZyTm0fZekkleVM0/B
         kk46+eODylPqrHMRiiL5TVPyBDWlcAtPLtXNpo6E+MqLizKolwAVGD/tI0iKtINYrc
         6TVOt1MeruUisBo3MdXzARFyozazq0ceDre8CF1ZxiTFEY2lnKvbEglce0p2oIniJZ
         gk2HMpB1hnGwOGIUbe2+dVSGj3AT5nZsQqFhs7EIn/h43kEg2rr/O9TT4Vz4fggsrB
         3h7vZ3OqAom1tYShkieDC5SMsFNIxtLqkLaP/FZAQVQJWaQMOwFVs1M3dVlAE1IhhR
         iNuQxK1Ev7mKg==
Date:   Thu, 21 Jul 2022 12:05:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Rob Herring <robh@kernel.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <Ytky912vo1HmEWkd@sirena.org.uk>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
 <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk>
 <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
 <YtArbh4a40cACRMt@sirena.org.uk>
 <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
 <YtA8KOLDIsEH+okf@sirena.org.uk>
 <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
 <YtkPUOh5XiQyGLxw@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b0S5Jq2JCjyLZwLX"
Content-Disposition: inline
In-Reply-To: <YtkPUOh5XiQyGLxw@hatter.bewilderbeest.net>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b0S5Jq2JCjyLZwLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2022 at 01:33:20AM -0700, Zev Weiss wrote:

> A question for Mark though -- in one of my earliest stabs at this I floated
> the idea of using reg-userspace-consumer for it, but was told in no
> uncertain terms that that driver was for testing only and should under no
> circumstances ever be instantiated in a production system.  Has the thinking
> on its usage changed in the last year or so such that this approach was
> deemed okay?

I was talked around after some discussion of the use case.  It's still
not a great API but for at least some of these users it'll do.  It's
important that it not appear directly in bindings though.

--b0S5Jq2JCjyLZwLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZMvcACgkQJNaLcl1U
h9AJTAf+LXFZPSqos9tHTiRzoxXmVCnmp/OSMKlH9+KnBbU+K6Ytd8IZrv3oqZU+
haHZScqVjWuYHlro6TOSBS6ZqGggc5R4btpe9TFPNAIEvDTYg+YXk6zeeZWyhAZg
W552I0rDqoEgyxjZ08F2FVlzV/U0LddQopLHj/Ur8sdmKOV6v/NcznLPTmmdJ/ev
6ux8LxvHNoVLzbUgW47YHa00JNCUWKrB6z5Lf3eRao3O6hs7J7RH6GejMbpyPnx9
rlIG9+JUlTVURFNnYEzLaX+kV9GlEQAAiKC++IEu2/InSDMvIa5sEkUEtWD7u6Lf
Pmbzfnrml0Y/vF7BnT2K7/pf4jR4zA==
=bvLv
-----END PGP SIGNATURE-----

--b0S5Jq2JCjyLZwLX--
