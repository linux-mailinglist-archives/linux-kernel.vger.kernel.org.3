Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239E6574E90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiGNNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiGNNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:04:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBA92AC53;
        Thu, 14 Jul 2022 06:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D21D8CE273D;
        Thu, 14 Jul 2022 13:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C97C34114;
        Thu, 14 Jul 2022 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657803836;
        bh=VrZxJeV9/aLFojPs64zCqrd01nxrrRn5D4ej8oJMXFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqDFhG/3d2mocDuOtWDe3vJTS0uOiBLyO/G3pnXat9/WDubNnby5WLCrotoPIEx/Q
         b1tbKGCd7EMSDzbYCeZknBrFdQMmRifvDVn0Dixc2JhYE35p/dPMl26OkkdtvVZKVg
         Km8N7/i4R3cZie8S8dwhMepdqORjAvGMKcCO9MDYj76REZ8N4iJM/ROGur+UsTDVmt
         OUV6FgUBB0rjrwL44aMVgx/jVk+TqQgcVC/sc3/7lBIVr4UeYB0iThRzXiuQ/xfq+G
         zt+ShlmaKNcjeFvQj+RflhF0UMCXC9zFfJlW/57CzGMC45CIaDW3jBGbC7VjIJrN5O
         fmXWmxmx5SOxQ==
Date:   Thu, 14 Jul 2022 14:03:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 8/8] dt-bindings: regulator: pwm: Update Lee Jones' email
 address
Message-ID: <YtAUN7yFFWTU5cpZ@sirena.org.uk>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-9-lee@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yvg+JLXlPyqENGR5"
Content-Disposition: inline
In-Reply-To: <20220714112533.539910-9-lee@kernel.org>
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


--Yvg+JLXlPyqENGR5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 12:25:33PM +0100, Lee Jones wrote:
> Going forward, I'll be using my kernel.org for upstream work.

> ---
>  Documentation/devicetree/bindings/regulator/pwm-regulator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Do you also want to update the comment and MODULE_AUTHOR in the driver
source as well?

--Yvg+JLXlPyqENGR5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQFDYACgkQJNaLcl1U
h9Angwf+JCGE7zN+F5uiPcX+i+Cl98OLiAbl8LJHJcV94RJxmYYD1C5bQ/9BnB+P
tRM9pXJToDA7knELPW/teo2rnnVI704DIUQjq69IH5do8qEsxLgccyZ86BDyteD3
Gd3ulIooQ7Zs0FLJ2FLBqRERsQ0ktfmc1uKsk203ms1KmiNhg2qURkd2q+iKuOds
u2Y2QsDWbA+xu6fGS9yqC/uFIWv8BJ6SV8O6O2eq1tv7iuLHOpiMQsdBnPsa+s9O
OGAH/Ce8yoWeVGZC1zm4nHytGMAlVJpvjlkdTmtcDTV3iw8AKbBsIrVF3rop7G8h
ymMHajfK9F5HQnbHmnWUlXtJKu26gQ==
=WaBo
-----END PGP SIGNATURE-----

--Yvg+JLXlPyqENGR5--
