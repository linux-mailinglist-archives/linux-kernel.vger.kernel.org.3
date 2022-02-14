Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB04B579F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356792AbiBNRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:00:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiBNRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:00:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8EB65158;
        Mon, 14 Feb 2022 09:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C7F36152F;
        Mon, 14 Feb 2022 17:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73894C340E9;
        Mon, 14 Feb 2022 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644858002;
        bh=iw+OtuZ1cGatRJTbS1i0AXz0nK9HVNfG9k/cuXgPjNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhEdNC4vYAaQreLPqoMq1PZm1IjC6JGk1rwJiAvayc3tQYvb6mnFA3Pi2nDwZbW/A
         bTzXWp8IiTXkO50nL7hEbojkvkeQUBG+vEyiH3MaUZz941vQwB4aFP/T0Qq32dSTqm
         jBeaXD3K1PyHmd2JWrKcCyIkT86WKTdUr7ySr8TmCSVNrZi/cgqQwVHhBWXGqKgD/S
         O2WCW0GfBgTgI8oa7uAfAiQtGg8/Zyw4pIdURozu1a2LVS2S6Q9EaVAGN9M6ANCOSm
         3uYPdYFaB6hTdLvihEMfMjKr2R01yhW9aayiPmdtNhdcdmiVZba8kTWUaAUs9WzIiO
         HDT7BJAUzNERw==
Date:   Mon, 14 Feb 2022 16:59:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] regulator: dt-bindings: maxim,max14577: convert
 to dtschema
Message-ID: <YgqKix0h7T9ME/ub@sirena.org.uk>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
 <20220111174337.223320-4-krzysztof.kozlowski@canonical.com>
 <YgqGy7a/kq2+jZQm@sirena.org.uk>
 <79ecad6e-d9c9-c798-0933-43da4dff9dd6@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6jSsSafiLC+c6OC"
Content-Disposition: inline
In-Reply-To: <79ecad6e-d9c9-c798-0933-43da4dff9dd6@canonical.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6jSsSafiLC+c6OC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 14, 2022 at 05:54:01PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2022 17:43, Mark Brown wrote:

> >> +    required:
> >> +      - regulator-name

> > Why is regulator-name required?  While it's a good idea for users to
> > document names for supplies on their boards it shouldn't be a
> > requirement or something that a driver would care about.

> Indeed, there is no need for requiring the name. I guess I copied it
> from other schemas.

Those other schemas should be fixed as well, if this is required for
anything then there's a problem - this is purely diagnostic information
for users.

--z6jSsSafiLC+c6OC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKiooACgkQJNaLcl1U
h9C97wf/Xc1JiXCZsIYcE313qe2WSWazKL82R8dw274uuIkWfCXRI1yVpZeNiHt1
mVR5T6qrMt+pJH0mvzl0n5oriUjlvhR08bzY2BPDqf0oNJb+RKeCLiPoVkodVv3v
AMem3im9/7k/iGoQXjAIqlLvR3iEe9I+1FxkZYYo+Z7z/18x00eI8/2UEzsQRTDh
iXK1bBAs5kGubx+4Gqgzz3JNkEv5A5xoIxwr9aPlxdesDXg1TUe6CGed863D6lpc
oAP8HgGpmoOCMCjXDoWW6KT5o5TmBnkMQYWk/O8/wcFRfsXtZ4vBJn4AtpKHpXCj
L8gPGPZLF/a9N3uWhBdXM7RPbTKoOA==
=Wp9Y
-----END PGP SIGNATURE-----

--z6jSsSafiLC+c6OC--
