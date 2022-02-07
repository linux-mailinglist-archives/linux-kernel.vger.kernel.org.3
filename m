Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82014AC5A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379368AbiBGQaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382027AbiBGQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:25:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F489C0401CF;
        Mon,  7 Feb 2022 08:25:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A431FB815A1;
        Mon,  7 Feb 2022 16:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AF5C340ED;
        Mon,  7 Feb 2022 16:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644251147;
        bh=Po5zzXhM3H2VRRrgUYmkOzuBy24D0xZJqJLFuYQbONc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUQxOX8WiVyCPUcoBdwOf/RKIN8EUZqlTEexoGm+eco/yjlhBXd3k3cQEgdApr2HQ
         Q/BiAVHpMIrhFsK7cYx1taUeH6e0BpiV/YtRmQZ9ZNOUukeorlYb+2q9pqSy2II76D
         lXDpma6Xx9o4QCVevLmttCNHmM2C5pZDKr3wql9wYMbamhNbaf7lbHJb5LiPNy5I/j
         Ns0u44JSOukIr2up9Z3GnvglC5UKqaGSX9sGTZ+ftCU8zJ3tKXku2dscRhLpRKEFq8
         A8doGyolvMnswR98Tpgvmmlx1z+Y6qwqlPZEtFsiJM8626K7QXN+smY94tWjMAeLQg
         iJcVjfFBHEOcQ==
Date:   Mon, 7 Feb 2022 16:25:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 0/5] mfd/extcon/regulators: max77843: add
 dtschema/bindings
Message-ID: <YgFIBitnI58GcUqn@sirena.org.uk>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
 <1bebedb9-644f-783d-492c-84a5de91720d@canonical.com>
 <YgDnUNCNCO+JLyHU@google.com>
 <88fcdbe6-5fef-d9cc-a645-69e35230cdeb@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KBz1n8ADvAMSR+61"
Content-Disposition: inline
In-Reply-To: <88fcdbe6-5fef-d9cc-a645-69e35230cdeb@canonical.com>
X-Cookie: Never give an inch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KBz1n8ADvAMSR+61
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 07, 2022 at 10:47:00AM +0100, Krzysztof Kozlowski wrote:
> On 07/02/2022 10:33, Lee Jones wrote:

> > Are the subsystem maintainers not going to review/ack?

> Would be nice to have them, but maybe since these are dt-bindings maybe
> they were skipped? Or maybe it was the end-of-year holidays?

You've been sending out a large number of very similar serieses, each of
which is going through multiple revisions - it's hard to keep track of
what's been reviewed, what's in a state where it's useful to review

> I can resend hoping it will trigger more acks. Do you wish me to resend?

It's probably going to add more noise, on the other hand some things
might've been dropped on the floor due to the similarity and whatnot.

--KBz1n8ADvAMSR+61
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIBSAUACgkQJNaLcl1U
h9DwvwgAgkkHxISpzmEcV84UV6esjAsYC0OmdQG59utyC9wrPYPXJSX2HsJ9h1WX
OapwjnmYK7Y4bxqXVEoCFpKIgS6a6u7h3V/bshsbDXyPIvEXh6/H4FOp7d+peSyl
XeLkT9/RU5kUVijJFrazOWyN7mknEA/kRuuDfx/x7dBF7IBgY8cJqd4dfER7Lx9D
7M707ahSnhnHW2Va3j3AYM10ezIQ4jP82z/6Zyc01xZcdv8rquPz74O4d3kDjdxD
CfbBDQpt4WSMofbFf7RDjje/T/zchnt2K/8Xn2HGcTKuA0be1iqSutInQ9yALLqq
PoEiTFWrIRncUIRrV8qNoSe1KxgJPQ==
=0liH
-----END PGP SIGNATURE-----

--KBz1n8ADvAMSR+61--
