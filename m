Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E255B20D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiIHOjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbiIHOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:39:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A214947C;
        Thu,  8 Sep 2022 07:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D6B1B8210B;
        Thu,  8 Sep 2022 14:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D71C433D6;
        Thu,  8 Sep 2022 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662647936;
        bh=zkJy6ZDifxrczbpN1YxHSf7+U9ID7HQq6uNoiW09s44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVntFHI+YilAujGA7HO3aYgSxWXYcQ1Krb+logXF/QVLl3q7bRPc4Fwu3FZhGRqGR
         7XPzScOsYqw1+s2ssfua4YktmbSrO3fBE5LrTNDu5i2x85n8nM4J14aXCXqLssydf4
         kB+vJb70I8fSZXJswOYMyjv/1SIjWBzibsF2DwJBCpGYx3ry97Bvyn+MBYc9X3CUuq
         JhTyCUpvpt8Ai9rGuRYYWHgGvVrUrIdf8zY69/lB0Wefjo/04X5yKZijOwra7eQ6qM
         3NLLrcqaXXgvVSzxGDW8TMsVgtfOpi2roZo4J+GbvvuuMyoqevNxPSx/z6iyAYsSpi
         1RfjBmhbAditg==
Date:   Thu, 8 Sep 2022 15:38:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+kernel@kernel.org>
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Message-ID: <Yxn+eieg1Xr28rEk@sirena.org.uk>
References: <20220907204924.173030-1-ahalaney@redhat.com>
 <abad381a-dfe7-9337-ff35-f657bf373d44@linaro.org>
 <CAD=FV=VmnKtx9smitqvNgmiCs-UCnLGFgbPnKd41QWeo1t3c9g@mail.gmail.com>
 <168cde58-d061-97e7-54a5-5d3cccf3ce22@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="06yV7uWbo8GNAj5h"
Content-Disposition: inline
In-Reply-To: <168cde58-d061-97e7-54a5-5d3cccf3ce22@linaro.org>
X-Cookie: Metermaids eat their young.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--06yV7uWbo8GNAj5h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 08, 2022 at 04:29:29PM +0200, Krzysztof Kozlowski wrote:

> Sorry, I don't find it related. Whether RPM has modes or not, does not
> matter to this discussion unless it sets as well allow-set-load without
> the mode... and then how does it work? In current implementation it
> shouldn't...

It works perfectly fine, if the driver has a set_load() operation then
we call that and don't do anything to do with modes.

--06yV7uWbo8GNAj5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMZ/noACgkQJNaLcl1U
h9Bx0wf+PAigqaIdz7QFPJTBe93yzoZ616tsNDeA3WX8p/6nktW3I11j14oGWJLh
7jqjEnWJWjneUo7QjjJZoOstu55fF0ftmPgi3GLYHC2cQau2UC7DY6U755N6xHVO
L+to4m0ssVkSx5hzee8SZkbxzIfllIJbUsa/BODXWoLKjP58KoroYGOFb34CMGoS
QKRD3BzCqizq7j7D1ZB3uyEhAwhpHSfXDpDUEOLrD4GeJqvkgGLll5qhR9k6AFWe
mLlcIF2wU9Ry+k9tLEfYPTKDhqUC1aoHV7C5/3oXOKq0HpOOk7z1tP3CzOkQ0zMn
7tyEjzZXo8H9dNzcmsgI6qgo3kdCUw==
=Xsyv
-----END PGP SIGNATURE-----

--06yV7uWbo8GNAj5h--
