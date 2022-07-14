Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E457523E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiGNPyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiGNPyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:54:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C18D43E64
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:54:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC5161FB9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D015BC34114;
        Thu, 14 Jul 2022 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657814061;
        bh=p7q0chEWumnzGCV61v3bgjFVo8nbHS4r71uV2a7TbYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tiREy890JfxPAfdy/ZjGgFxKUqWXltB0FLC370y9gfgG4HeIdUWqkIXQwlecOhvhR
         HSxHJc8ujI0ze81hnjfk2jTorUkY4B5ViWM9O0Y786nt80Yl20QlxTOzZDFjWuYEbn
         xhR0BAj/fsaddNxkHxIrMNbE/eL18D+l2WlUULbq6PBbty5z0MasCSwhPCCts+cTp1
         dcbRoaz/AA6kSf8wrk34NTaB/sqUB4piSegbw0WiODDqAD333e/UpxNUE/DxdxdsZC
         5wPxuxPRT2virDqY/IzU7KVTD2FIQyFXrdR1CYasI3cnw73x1KEpkgfWExQIf7C1AW
         Cv19Nwh3LbT+g==
Date:   Thu, 14 Jul 2022 16:54:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: regulator: add bindings for
 output-supply
Message-ID: <YtA8KOLDIsEH+okf@sirena.org.uk>
References: <20220707081826.953449-1-Naresh.Solanki@9elements.com>
 <20220707081826.953449-3-Naresh.Solanki@9elements.com>
 <20220714141041.GB2229197-robh@kernel.org>
 <YtAkwcwXaQqZV75d@sirena.org.uk>
 <CAL_JsqKu_HCDoPBTcVdVV2JyD_8p3+cbrNC0u6VrK85vWZmt3Q@mail.gmail.com>
 <YtArbh4a40cACRMt@sirena.org.uk>
 <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vDAwXomrZWqeNwU5"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+KRyE3i3CkPKopGgFvL+h0pT3R-d3aZNgVmKyiTy3gjw@mail.gmail.com>
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


--vDAwXomrZWqeNwU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 09:07:49AM -0600, Rob Herring wrote:
> On Thu, Jul 14, 2022 at 8:43 AM Mark Brown <broonie@kernel.org> wrote:

> > Consider for example a BMC (IIRC that's what their specific product is),
> > a bench supply or some automated test equipment.  Part of the function
> > for these systems is to provide power to other systems which would be
> > represented as a root or wall supply in the description of the system
> > that actually uses the supply if it were described using DT.

> Didn't someone else have a similar use recently? Controlling some
> supply external to the system. I can't seem to find it now.

IIRC that was an earlier iteration of the same thing - it's been round
the houses a bit.  extcon seemed like it might be a home since these are
external connections from the system but in the end people didn't think
it looked like a good fit.

> In any case, it's not for you to describe, but Naresh, and in the
> binding and commit messages. But first we need to overcome proper
> usage of get_maintainers.pl. In response, to my first reply on v4, I
> have a second v4 sent privately today (and still only the vendor
> prefix). Sigh. AFAICT, for v1-v3, the only thing that made it to the
> list was the cover letters. Bottom line is this series has multiple
> problems and shouldn't have been applied yet.

I can drop it but I do think it's reasonable to be adding a vendor
binding for this, we don't seem to have enough people engaged to scope
out a generic binding confidently and TBH I've got a feeling we might
want multiple application specific generic bindings when we do have one.

--vDAwXomrZWqeNwU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQPCcACgkQJNaLcl1U
h9DEBgf+J/Y7dk8DEHrQJtFF/LnqsspefWNtDoCzk9605TE7OMkEN/DoMoPx3MGI
PquGaO4PeX3aaafpU8nZcyigot08jWuyxErEpSqZ0yslmNJEUMonozfsN/Gq8u0V
Xf0BdyAK3o84Pw8qL5TFW0HUiTNo7R3eeqyD4lQMWFbeXMdfg3xXdyaIR4FvM43a
kgHOwGQD5qRHTsvcc8ygqPD8iuk/Q6Ibrpx8BkGcXuItdocOoGILYKjrtQTX6UE9
Yf8AqAauqnSs8tklzuWJqJeUCGc6XdtTcM1H2fZruFPXd/O8lAwgH3//3ELOQHJb
3DET4qkGY9ewa4aoDGZ4nA2L2ZGg6g==
=QhX7
-----END PGP SIGNATURE-----

--vDAwXomrZWqeNwU5--
