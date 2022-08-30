Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB4A5A6B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiH3SCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiH3SBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:01:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593D59D129;
        Tue, 30 Aug 2022 11:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAEA06152A;
        Tue, 30 Aug 2022 18:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B6CC43470;
        Tue, 30 Aug 2022 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661882490;
        bh=0OojOeWriYciWCW7CDS3kKn+DRlqDdnrnDF91OklMPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Khk4T1th+i44VfKwq3RXJb2dAxxojnHAhA3FXFkECpPxArX7mK7MdWrJmw7PrZIr7
         5WgTA8clP9BzfH4tkxD6Q/SVIyA4AhRw6JUi9GASBU7ncgcIFEM2QswBwfyLbmLjWH
         dyuFyI2dCF5s2exJ+dhPiujDAPdT0ouEkwMAbyZSqbghWUE1MO8SiJlHnuWQ2dwmKg
         JH+AajuHyEbHQIDWLNZhz5AS2dEHdn2HfrBEgJK7w2aJYk5BBbvlzEl8rY1Rwg8ZMN
         zaNbOiRxVEjCsQrizFGs++vjbsRLgY53n9k18worQpDE47g3RX8DyLz0bY11w/4XQv
         Tz0HzYeF2iv3Q==
Date:   Tue, 30 Aug 2022 19:01:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings
 for DMIC controller
Message-ID: <Yw5Qd7ZNPIc/o7+6@sirena.org.uk>
References: <1661872039-40174-1-git-send-email-fengzheng923@gmail.com>
 <25072fba-64e2-df11-c8f0-a274037141f0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dVf75fQWW/SwR7TB"
Content-Disposition: inline
In-Reply-To: <25072fba-64e2-df11-c8f0-a274037141f0@linaro.org>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dVf75fQWW/SwR7TB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 30, 2022 at 08:35:09PM +0300, Krzysztof Kozlowski wrote:
> On 30/08/2022 18:07, Ban Tao wrote:
> > DT binding documentation for this new ASoC driver.

> > +properties:
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    const: allwinner,sun50i-h6-dmic

> Put compatible first in the list of properties (also in required:).

Can the tooling be taught about this?

--dVf75fQWW/SwR7TB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMOUHYACgkQJNaLcl1U
h9CT4Af4wwvuSIZlXbwZfwgqtydzN1X3EMrS86L2JcV+PzlV4zr+e35HOC7vomxq
fbSFJAddJVWTYKIAfu0PpX6ZBO7S+w6/0BBJpk45sQmz7mLgZMOFSnYCcunwBJA1
3JxBST9Jf764020OPDnnWzzWH/nl6cB3B3pqBTXkYQbHB19qfWyRzPepYcuxX41X
NGZRFEs4K/gnyRovZ/8eX570MMdjCkuvFK2B5rdrGrZqk6TRfgyZ1b2a6B9luCy2
/Zn8EyqHOEqDCVZ39gXyRbY3U+kl05pRbtiYAVHC0gLGkf4vc4A88si+W+sRDZEx
E3I4eExDAgQnQKh4Mq9ye3CbGNKq
=QqUt
-----END PGP SIGNATURE-----

--dVf75fQWW/SwR7TB--
