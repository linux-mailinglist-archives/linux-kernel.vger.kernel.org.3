Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C0C5148BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358841AbiD2MGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiD2MGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:06:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CBC6EFF;
        Fri, 29 Apr 2022 05:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51F75B83466;
        Fri, 29 Apr 2022 12:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B3AC385A7;
        Fri, 29 Apr 2022 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651233795;
        bh=ytyjAxLH3gz2/+/Nvl7NSG5DpaklWaIPupUTXXz4Z6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3Kft7g64LMqPsBtPppqKDSqU2/JwxE6tj9ZgKi7eNrTAgJY9NH+trStdssuA61RR
         GDtaGqaf/2jfPvXkpL9hLc2toOdMdtgPlLUvu8GG34/rrreGSDFLIO1RXnEjS9gYdw
         h/MY72M6UYx0zaVrev6GwWCW4n3c7Ns2AYlYLGYBaNIdDWCyFWp7eNWDINaIZynqhv
         /RI11TfnHO4oomloq8xvKG1fcTV3oD8YpHpC0bTx9LBYmTV1JTmUvFGNmbFAPsWuXf
         rz0CSFaRKA4hWRbXasbSYjh8imH7N7eknZJaf9EVzfBadftLWVKZYI0Vl9XyDvTnK8
         fIePNVgw/hYsw==
Date:   Fri, 29 Apr 2022 13:03:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/5] dt-bindings: regulator: Add bindings for Silicon
 Mitus SM5703 regulators
Message-ID: <YmvT/LL+1jB8xK77@sirena.org.uk>
References: <20220429113927.5145-1-markuss.broks@gmail.com>
 <YmvQhpO8dg6VLHNP@sirena.org.uk>
 <2a18073b-974f-00d4-5811-8df577e943a8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sXfYcVX2i2N4NMSP"
Content-Disposition: inline
In-Reply-To: <2a18073b-974f-00d4-5811-8df577e943a8@gmail.com>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sXfYcVX2i2N4NMSP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 29, 2022 at 02:51:03PM +0300, Markuss Broks wrote:
> On 4/29/22 14:48, Mark Brown wrote:

> > As Rob said please send an incremental patch with any fixes needed.

> I'm sorry, I didn't understand it correctly. Does "incremental patch" mean I
> should send a separate follow-up patch with those fixes?

Yes.  It means on top of what's already applied.

Please also don't label patches that aren't part of a patch series as
though they were in a series, it just creates confusion.

--sXfYcVX2i2N4NMSP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJr0/wACgkQJNaLcl1U
h9AxeQf/fsN26iHbjaWq030/gMA7pkIRcKce/G0iIcxx5adMpYB85hZF85tzX9WF
YqJ9haQgJNOJd73UpiJZ7YSaehjMFNY6DW7bB3z1euU5YqHPV1lBdWaQhCXmKt0S
ghGZZvoYqL20iizrBMP6GQR5NJKj1LrohhhhhMOODnxNIbJKazkhjhnGS0LwyNXo
7QsNmOXjiW83nPYA7+x1YeyhHXP6rCJTchISj3rn3tabrYYMD9z4v55OWtHLVN/J
bmqlixvWYrAoJho9Urnj/tvaQBo1XlBuggJ2vXzg9ItRLJMpOJam4Jlw5yOYyn7H
zkrbR8aE6f7AkG/fkQMrPAhj/Y3s6g==
=Lsum
-----END PGP SIGNATURE-----

--sXfYcVX2i2N4NMSP--
