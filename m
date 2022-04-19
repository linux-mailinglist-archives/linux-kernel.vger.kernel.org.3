Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12C5079FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357545AbiDSTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357541AbiDSTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:15:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3303DA6B;
        Tue, 19 Apr 2022 12:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC84E61607;
        Tue, 19 Apr 2022 19:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C4C385A7;
        Tue, 19 Apr 2022 19:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650395553;
        bh=RyOybfu5X9K8DF20Kj1+gX0qpPmThYKU0IY2XowwxmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIfHW4dEkv9NFu9z0tTiCKIMtwPuzQWfbb5dyj3l7n9MmeZlf9DMCP3dadOVLdlCa
         gHxarQPZv/Pcoa2K6QGwsCqLvkNuwVlBZ1viOwFV8XB5ayyayBAeOzYTzMF8g15Eys
         hXUH91FMFfPZUrNPXcfczJIVo9DG9F54lh8h+0FOx0tXOihRvJVuGg99sUmv/S+iiF
         z62Pj/K+G4HcvN8I1IiJjABLcGFVPoMxKXj4npdX6nwFtXhQ9IJA3tNgdhbz+Vovnx
         4FTc4DnMxtJR66Tb5+p+pwGJD3eoHAkgts7BfSXxThd4S9NwpYLcmozXEV0mP8E6ML
         wozwOX7bF7s8A==
Date:   Tue, 19 Apr 2022 20:12:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Message-ID: <Yl8Jm9XqR3YTrW9Y@sirena.org.uk>
References: <20220419160058.9998-1-markuss.broks@gmail.com>
 <20220419160058.9998-2-markuss.broks@gmail.com>
 <Yl7pqgjza/ZfajyM@sirena.org.uk>
 <0599e7ac-bd06-8d56-b510-0f27f4cc6790@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kBKUCAm8/+PdtSlQ"
Content-Disposition: inline
In-Reply-To: <0599e7ac-bd06-8d56-b510-0f27f4cc6790@gmail.com>
X-Cookie: That's what she said.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kBKUCAm8/+PdtSlQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 19, 2022 at 08:45:07PM +0300, Markuss Broks wrote:

> I took an example from the rohm,bd71847-pmic.yaml MFD binding, they have
> regulators at a separate regulators { } node, with a separate dt-binding for
> it. I'm not sure what should I do, I'd be more than happy to follow a better
> example if you can show me it.

Basically either just remove the compatible and have the MFD directly
instantiate the device like sky81452 or put a separate node for each
regualtor like wm831x does (but without any DT support).

--kBKUCAm8/+PdtSlQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJfCZsACgkQJNaLcl1U
h9D+Iwf/fOnvSE5bXAsc7/ve+dvtqCmygIBO3LUlGExMkKkaoeDotUxWWD+zcbHy
kCAkMK+NEEZe3fvWIiJ8pldgPM7I1ynR2HNsDkP67JtbF+5KXL9KOJO4tufA6+Eg
SbGFLngPeTytekRhVsgvUou8lzoxrim9lTtXjcF2LXPvILgHiH1g/AT9AOMDykVb
GRGswwPo3yFCrG+NGzuTN2MFti5cUxrcpsDDxBYyepx3kaazbEK+v/wlBnAi2vvX
dEXjjRAxscGjb/5LX7lJi77F/l8eY2XQIbZ0dBHOedAz0jaXvdi++IWzk6wrghRw
id79/7rUqeAfUw4PDWeEKQZ5okRHiw==
=iucX
-----END PGP SIGNATURE-----

--kBKUCAm8/+PdtSlQ--
