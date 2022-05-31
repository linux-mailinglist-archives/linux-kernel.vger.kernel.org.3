Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282A539157
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 15:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbiEaNGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 09:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiEaNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 09:06:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C4E272;
        Tue, 31 May 2022 06:06:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C139FB80FAE;
        Tue, 31 May 2022 13:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E99C385A9;
        Tue, 31 May 2022 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654002396;
        bh=CUlX+9z8cfAhEXvA+cWNMHHopVVQF0wsmaL19jamKuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWC/CiPCADCJ6kefLyjARmREtOnWV+fbhBHIDASIWVmi8Bp27I0V1nbrW/xYBsDcw
         99RsF9I4hOAsh3TXzFqRPSEncZ+8c0cJRb9/aEoGh1OKeT6v28TNSnWFa38di80MKx
         IowrMNRrVQBr28ICDqepU7RuuO0ufWLJKByhwBkioBw3BgFK9lacmHLfQH3Ls30Yv0
         ngAFa18bHmnaTCbLAcfu/bA/dVzKgvrwUzwKKT1hs1bPY+wZZbnxveRuWcNMVrvxDk
         xSh7QKU5ToBWxP+OGHCAPAdnRPEVYjIThVnzpifUterxL5nL3VO4jYA8cyL2kG8HL4
         H8oY6IWcQEd7Q==
Date:   Tue, 31 May 2022 15:06:33 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/7] dt-bindings: regulator: Add binding schema for
 mt6357 regulators
Message-ID: <YpYS2e1uGmoJGWxr@sirena.org.uk>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-4-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ES4vVuyUeavLpiLg"
Content-Disposition: inline
In-Reply-To: <20220531124959.202787-4-fparent@baylibre.com>
X-Cookie: May your camel be as swift as the wind.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ES4vVuyUeavLpiLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2022 at 02:49:55PM +0200, Fabien Parent wrote:

> +    properties:
> +      regulator-name:
> +        pattern: "^v(core|modem|pa|proc|s1)$"

This is a standard property which you shouldn't need to describe
and should not be imposing any constraints on, the property is
there to provide a system relevant name to the supply provided by
the regulator to aid diagnostics and association with schematics.

--ES4vVuyUeavLpiLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKWEtgACgkQJNaLcl1U
h9BPxAf+OS9V2/7UbTz61u9a3et3gJurNEsT8gJJVwGGyIHKaLsHpArDO6nNUgzZ
jWMDBk5KAhW8aeF4+eV1A1kyAfVNakRnkKose6A7sXZT5UPCFImND6jnXfvXmWla
x6NO+B2a+aBrP9BJ6DW8OFf1CRpf+o7HQAw8Cai4Qad+1icFQ9A3y9k/JjjQewSX
y0g4EhuK5DiakAE4f2Wbk3qX30mFY/xaz/k9GOmLLqqjjDDD0N6f6Cj8j7eKDz/G
A/VUC1NivcsWuHCvioNMGY7soxNBWanVtm4z9q4Y7I9rv5A5lez0rawWkFIMRpug
t0eGypEI+DYyO4/pTt4vzBOZNgkqrQ==
=joEQ
-----END PGP SIGNATURE-----

--ES4vVuyUeavLpiLg--
