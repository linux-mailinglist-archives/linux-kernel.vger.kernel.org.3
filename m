Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DE6519FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349775AbiEDMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349731AbiEDMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:39:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD32FFF5;
        Wed,  4 May 2022 05:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F0A2B8239E;
        Wed,  4 May 2022 12:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B56C385A8;
        Wed,  4 May 2022 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651667772;
        bh=HzGvB9CCpC11C8Cqx5ROkgu5ak8t8rYI3wecQARRh6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poc+PVxBbj4u1k6ULEs5eDwAqQ0b3vkXKzN21uf55zgCMYaK8iP45Mb/Dxw5wuL5/
         T7KXxBzq6/o4W0EamSWmTt7VWBQv/P7nBJJZbJO9V+iXyWGMdiXCyA03zc3YLMKVxx
         cGSzw0TzVpS6BjulxoCpz2Hrk0WJUFxwZAoUqzgOnv29y03Pohfz/xU5Wh9duy40C2
         llKVCiK23dcgLXjCHRr7p8jiISl6QHccQ54Pwvb+7yC9vq31Mml6v/dM59YArf8XR/
         +OaKYRn+6A6zy3IalreBpn7gkhaFDS5mXLksecyq0zK4HkW5CQddo0jyRCZ9Xiaips
         Q6rON2+a8mHDg==
Date:   Wed, 4 May 2022 13:36:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 1/6] dt-bindings: regulator: Add
 regulator-external-output property
Message-ID: <YnJzNoM17ZLoQJdk@sirena.org.uk>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dHNaXTnT9yGpJ6h3"
Content-Disposition: inline
In-Reply-To: <20220504065252.6955-1-zev@bewilderbeest.net>
X-Cookie: Mother is the invention of necessity.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dHNaXTnT9yGpJ6h3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2022 at 11:52:47PM -0700, Zev Weiss wrote:
> Some regulators do not provide power to anything within the system
> described by a device tree, and simply supply an external output.  The
> regulator-external-output property can now be used to mark such
> regulators.

Why not just add a device representing this output?  Presumably it has
some other properties (eg, labelling for a connector) and may need some
integration with some form of control mechanism.

--dHNaXTnT9yGpJ6h3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJyczUACgkQJNaLcl1U
h9DONgf/TnKauW2D2FMve+R72GPbx65yXEI1OuQ2PY8lehkxxXbA8NB22x892fZ5
evHWspiwPjOpdJ/Rlos9hs8jMgjue6BdSOPIGvzczXAM5PtOpZ8CrklZuiDgxMzu
SqmK5y15AG73UhkQ8uzoCRXIRgUo4JldAYNe9v1/Eu6RCoxQfJSaR21hLNgbDq0e
Z1ij5rG8dQe48v9u+VfEhVV1UpG+TQKHrBm+j/V6JS5QVfHcxMXPspi29FehOlOo
7PGhjjyCxwu121HD6ehHuHQM1LDIEgPNEZYi4b8KtKXjth08Z/hz9GiXRpduCmTr
yxUyqqpfHogr6Vp9jKJdfvB6UKcXuQ==
=gOK4
-----END PGP SIGNATURE-----

--dHNaXTnT9yGpJ6h3--
