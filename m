Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E22575441
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbiGNRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGNRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:50:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099BB48CB1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B944B82855
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA61BC34114;
        Thu, 14 Jul 2022 17:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657821055;
        bh=16aXI89gsw3z352KW+b0/UQ6aOAyMgZfCmtTZe+JBZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kQ3uN9bvPGOcwILnKtp8ftSlJhZ70/SvLEvwGbqHTzgMYg18TNXLmftWxOp038EXh
         mIP593XYTjJQmhLthsAzw0l6xhx/A8/8hX1Ao/R1vfFUixX46zhkq5gA1xPp6txJHf
         bp1V14SYqp3MV6nUQoY/37g/l4EtsqosTQThtVAL8sjUCyMFkqScyv03bf0mOVkjVB
         NHybTgQy2ZQJjbCvna3mnc20OgLbL9bIQJnaVkC9rBAtov/5wxpa898nq0vchHpfkH
         8a2UkGJPiHFREID2cul3lzZ/hu9mXm+D0Z94NhWG4ENVEqZov2DeuoS6zTdujJfYIf
         5UqiDoXIJRPcg==
Date:   Thu, 14 Jul 2022 18:50:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <YtBXeo9aLGNkWwrr@sirena.org.uk>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
 <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk>
 <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
 <YtArbh4a40cACRMt@sirena.org.uk>
 <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
 <YtA8KOLDIsEH+okf@sirena.org.uk>
 <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MIWTgVDH19FHOA2e"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKCByvNASAxRWV3bcjFSBjXZUQf0Xvv_dCZ0z1CRCcOKA@mail.gmail.com>
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


--MIWTgVDH19FHOA2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 10:59:48AM -0600, Rob Herring wrote:
> On Thu, Jul 14, 2022 at 9:54 AM Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jul 14, 2022 at 09:07:49AM -0600, Rob Herring wrote:
> > > On Thu, Jul 14, 2022 at 8:43 AM Mark Brown <broonie@kernel.org> wrote:

> > IIRC that was an earlier iteration of the same thing - it's been round
> > the houses a bit.  extcon seemed like it might be a home since these are
> > external connections from the system but in the end people didn't think
> > it looked like a good fit.

> Found it:

> v1: https://lore.kernel.org/all/20220504065252.6955-2-zev@bewilderbeest.net/
> v2: https://lore.kernel.org/all/20220505232557.10936-1-zev@bewilderbeest.net/

> v2 was the using extcon version. v1 looks pretty similar to this one
> though anything that's just a compatible plus supplies would.

> But AFAICT these 2 submissions are completely independent.

Yes, I think so - I'd misremembered as being the same thing due to the
serialisation.

--MIWTgVDH19FHOA2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQV3kACgkQJNaLcl1U
h9CJlAf/V4ugCYyMgNc6wLld7Yt0+wJ58TafyASZQuXMTAq+z/kg1OAA246tXv5A
1mFXsubx0SdiUD11LK0ScMPCBVjO88Ezr7aT25s1IKUXgQojxovXwanCP0EsS9ha
aJSD0qol5UIcheiAsP04p6xZBUEp/v7Bl86fcIxVQtl2Gp9RVyhCBcGuU9v4Kb0l
mbS28dBX8+C2YfR9iM+zq2EkLTDW3M0dIZnZjrkymJGqHlWIKBgGJ2bfNhnekuWm
X+TG4KbZ4N917LFBSjzTK2LU/3rGk5EahgHGmV9eOG79MnhqQgFtsf+McXLEZrAI
vahXsM4lGYDM9XMXXJWhX5++3jM1Zg==
=wh7R
-----END PGP SIGNATURE-----

--MIWTgVDH19FHOA2e--
