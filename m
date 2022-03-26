Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBA14E7E58
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 02:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiCZBJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 21:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiCZBJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:09:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D7D15AACA;
        Fri, 25 Mar 2022 18:07:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D95DB82AC9;
        Sat, 26 Mar 2022 01:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5EEC340F3;
        Sat, 26 Mar 2022 01:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648256869;
        bh=TIGvi3NJoXI4BDEsPWY9lofzwK2or8+/7/y/4eCc4hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQIdq0/fEGsYHcR5YP4RYOjabvCiuT170bwmJJdm2m9AlK07akRPdgTSF7Mr6Jpmp
         E/aV2KNE+IDpnJUigkDdDz4NgwfaiLd488baaBGkseNYhJ0PpTjdBhbvedV+Q9BqwP
         U6O7F8YPF46LlAI0c9Y757XE2fE9QW7WNdIGQVJ4U59AXflDkOI48xZknjqlV/x5Nw
         Y+8j5LUuudkGkI33GEjQ5wQrCcPX2NyQVbohgr3TOslC4CJt+X/FzNW/QqiPjrae3E
         +B3iWlC/Bh0GM/40RLbYERV0bDtAl3ylDEGCxfMQeFVrDVxFq2ponIm9oz+S+UvGGV
         5i9qTaAaf9/gg==
Date:   Sat, 26 Mar 2022 01:07:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Message-ID: <Yj5nYUeizlmlbX4O@sirena.org.uk>
References: <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
 <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
 <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
 <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org>
 <Yj3oXuijuZY1gG9X@sirena.org.uk>
 <d2f220ae-c62c-a7f7-23cc-c33956c2eeaf@kernel.org>
 <CADiBU3-3QLi5PVUymk_VCbF+-uVSqjoP9jLGL+R=PQ-S=Y=_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V/BI/lkc+CDzOVUK"
Content-Disposition: inline
In-Reply-To: <CADiBU3-3QLi5PVUymk_VCbF+-uVSqjoP9jLGL+R=PQ-S=Y=_AA@mail.gmail.com>
X-Cookie: <Omnic> another .sig addition
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V/BI/lkc+CDzOVUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 26, 2022 at 08:58:47AM +0800, ChiYuan Huang wrote:

> I tried to remove only __maybe_unused and build with x86 config  that
> CONFIG_OF=n.
> There's no warning or error message when compiling the rt5759 source code.

> If so, I will remove only '__maybe_unused'.
> May I ask whether 'of_match_ptr'  need to be added or not?

If you add of_match_ptr() (which is a little better, though it's
a tiny different either way) then you shouldn't remove
__maybe_unused - the thing here is that the __maybe_unused is
needed because of_match_ptr() is used.

--V/BI/lkc+CDzOVUK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI+Z2AACgkQJNaLcl1U
h9A8sgf+JM/GnGsh3SVVaRW5txEsbM9CDUDAOWyw0CTnyFLRdM4ufVz+2b13t9dz
NtHUqEso2RiwWuoIihvgsD9u/cpjtSumnTkL17VXjdQBkoJThnYum1kpYtTNWSgU
tjBv+dy6H6FMjkjwEwFEFpneA9bmHLM6bZbVSVFUzS4dWI8tRt8QkydAno9ZG+cN
KiKIcqHeovCLQ5rxxg7o3pruR0EhDw5+Q/XPLGVktaA0+zUczrXq8w4Yq/X9Bp4O
wFpM/viaW5t8GT6HiwXjH4yo10Mw/tBdJsZLgJdrK50QMEd+9uH+igIiphKdCfsm
zmRJTlcu86kg0NJ3izdat6MIPfZQWA==
=88Yr
-----END PGP SIGNATURE-----

--V/BI/lkc+CDzOVUK--
