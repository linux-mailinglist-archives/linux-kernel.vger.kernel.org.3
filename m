Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42750297E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353217AbiDOMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353220AbiDOMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:22:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7B051E48
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DD69B82E41
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 12:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842D8C385A7;
        Fri, 15 Apr 2022 12:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650025199;
        bh=N9FYj7f6Ma1QBx1s/ilryxyKyQaO1aVtUrA4ELWawSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qp/AV6L+C+NEsGjYWpuI/uysqD5/PFKW3lhxcYG8wD0GBqbNU33q6eklI34aZfo8c
         k/QqcgSEozKmDEj0gPJ9+UjVU/4VItmD/4j7rGofcCMyVoT3Nc9IrlEtw1mBl+Q8N6
         BQEKISZ8CLAkxPl50iUlV97yjyovRusHmZu/K+A7iMgn2M4oGb7MetOnr3X2o0ipTn
         v8UKD2sXJx4bqmboz9a8u6Bp1pAk4asCTTlmF0XcZ6UIyO37LYRqljaonJiH4XW4Yb
         0wtM9+lRA+trD2hsj7W7PXVzs/66q2WiCBqQSh5JF1V5U6cNvAXPtcgOhp7r762okG
         a+UB7tpt1CcAg==
Date:   Fri, 15 Apr 2022 13:19:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: plumbers talk on kCFI, BTI, & IBT?
Message-ID: <Ylli68QUuqpCqr9E@sirena.org.uk>
References: <CAKwvOdkyMyE0ZRUU9Rh4qTxpOseD=fydo-FB9kdd7zRo7nVreg@mail.gmail.com>
 <Ylkhgeyeolh1AO1y@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SexABKBWzJCfNss4"
Content-Disposition: inline
In-Reply-To: <Ylkhgeyeolh1AO1y@hirez.programming.kicks-ass.net>
X-Cookie: <Culus-> libc6 is not essential :|
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SexABKBWzJCfNss4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2022 at 09:40:49AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 14, 2022 at 02:28:08PM -0700, Nick Desaulniers wrote:
> > Hi Sami, Peter, Joao, and Mark,
> > Jose and I are currently in the planning process to put together a
> > Kernel+Toolchain microconference track at Linux Plumbers Conference
> > this year (Sept 12-14) in Dublin, Ireland.  Would you all be
> > interested in a session on Control Flow Integrity in the kernel?
> > Mitigations in hardware, software, or both might be of interest to
> > discuss more in person?
>=20
> Yeah, I think a session on CFI in general would be good to have.

Yup, seems like a good idea.

--SexABKBWzJCfNss4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJZYusACgkQJNaLcl1U
h9CPKQf9GUmI6aBKCUxvVDbTQR7bTi6pskY0nlKOwiPLQPcPOqfJ1doIRZhlgN3U
3Ol60uFTofpKbZJ9L/earMZhhPsp36jtyTn0keK2SyJ9BY2cmZK4iWoarvtqAibn
PVHdkjpPCZa0k/MAI8dtKsHKjYsQfyZxHnrGpNK9LBzN+Nanl7YRqy9dbYNUyjZV
8L96GoprEvmX5unonDRddKgwHBqTSjwnvuieCrmWSwpQ7pmDO8WUKlIez7HwvJqM
yspmwr76fWghwHDBUXOlda9yN/U65UCekpx/Rvu98sQaa4za2uoLOM/lnU5WaeZh
tCfiRtbR8FI6briCmnHZGLKXWs7kzg==
=qDbT
-----END PGP SIGNATURE-----

--SexABKBWzJCfNss4--
