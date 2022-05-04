Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F399F51A3CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352417AbiEDPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352309AbiEDPYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:24:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8984504E;
        Wed,  4 May 2022 08:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F15E8B82577;
        Wed,  4 May 2022 15:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875CBC385AA;
        Wed,  4 May 2022 15:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651677645;
        bh=uSRT9TT40g2mc7fJtjGOYIkn9JajbEXDHdNZ3BlhJM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3cbOZVGidkfkFpOzCbx9cIJ4onYvPy7EL2N/Gyis6ae/Ds1Yd0y1FdQhosNAh+sl
         fVdqUFFXS6WjF/BqNbCOgxYmP1AlM0SgY+GkPnJe4ulonv0mn+PDKTu8o9OoQ8XWH4
         OZhfdOldDCpwEDYorMut1k6l8SihpQX+H/gbwRHPvB+i1RULqWlbtBixaxLulq7R53
         tuT9Qh/dHVApga2TPsCt1ww6oW6/yOiBSQKIqINfzAA/mv2TD0e/qXYG1w7ZpoK2lo
         Tmi/uSDIOvUlj757wCOhNk2DFqBAnllV2hBsyI0OhbWzmeiZcOISraaqnwwq6yYwxf
         Q9zlsj8RMZ6fw==
Date:   Wed, 4 May 2022 16:20:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: qcom,spi-geni-qcom: allow three
 interconnects
Message-ID: <YnKZyCogvngR7zfc@sirena.org.uk>
References: <20220504125119.190526-1-krzysztof.kozlowski@linaro.org>
 <YnKVLxmz0hhQGNzI@sirena.org.uk>
 <cfba178d-ff36-910b-3067-ce32b701b643@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YBOfv8KL6MSYdhjS"
Content-Disposition: inline
In-Reply-To: <cfba178d-ff36-910b-3067-ce32b701b643@linaro.org>
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


--YBOfv8KL6MSYdhjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 04, 2022 at 05:14:19PM +0200, Krzysztof Kozlowski wrote:
> On 04/05/2022 17:01, Mark Brown wrote:
> > On Wed, May 04, 2022 at 02:51:19PM +0200, Krzysztof Kozlowski wrote:

> >> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come with three
> >> interconnects.  This fixes dtbs_check warnings like:

> > This doesn't apply against current code, please check and resend.

> Thanks Mark, but as explained in commit below "---" - this is a fix for
> commit in Qualcomm/Bjorn tree. Could you ack it instead?

I was expecting this to be a fix for some change in the DTs in the
Qualcomm tree.  Why is there a change to the SPI bindings in there?  I
don't seem to have reviewed it...

--YBOfv8KL6MSYdhjS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJymccACgkQJNaLcl1U
h9D7bAf+PFPeIWb+e/4IYQW+dqHjAocqb2u1PfWlz6tbtBUUSNu9PFA95jrYF4AL
4KdnoDeTfyuthCxzW4q4Np5u9FZMdc93nTT/3LSjonuzPr5O7QktowRlHwS/eZvM
SVTqtemG8x1udnsaOrE3FAr5d3zv3TuPa8rM3VXgWxD8PMnwTFQzmNmF7VvgD8UR
5vP8tzmXTArqQCrgeovKwe0uBQ9yzeOmyzDC7A0PB+DvAYzXIrQXM0cCzU8uDKO+
ok/b1TAfvwE7n09omLqhHOVJhH7f+YVoiNyNvK3yGrANCb23K08aycGR+qCJv3Xm
JGJTgxOx84fyI2OL/ctJfD4kRL+XHA==
=X7pn
-----END PGP SIGNATURE-----

--YBOfv8KL6MSYdhjS--
