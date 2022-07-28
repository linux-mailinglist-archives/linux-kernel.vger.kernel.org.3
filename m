Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0B583CE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiG1LLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiG1LLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:11:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3E664DF;
        Thu, 28 Jul 2022 04:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC52FB823DB;
        Thu, 28 Jul 2022 11:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B66C433D6;
        Thu, 28 Jul 2022 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659006675;
        bh=uatBAKo4u4baHcP13PJdONgrgJTyUoamsnl4XzGT4l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YayZKOUj3bS7fL8u56pHciHDpbF2c0PaViOBhYZ5tEXuQQcZpZ+VX7wgyB0J17hl3
         +dFT+tVRbRRZui7gHYS1mboUtlE+DHLIrgwsQ8WlLgbJURZK+T1XsCTsRl3HqIZd3t
         Qn2BZSBb8OsRl5yOx8pMc8PNJj+vHMtph9iEGuGBV1OBvx/0mJ+0yc9hFQBTtNstid
         p0ckptTrnBCzzk5mURjq9xfdZ5ZuvT0t4XGfE+4SYKWRfioP8tqmynlGanPeVzX0Aq
         ivjO8/QN15pxT09unQPhECkjEgdKr5Zg4a7VDhvY8Gjmr2OfZSnlzcHLXE5duZlQM+
         afiTO69BmYPDA==
Date:   Thu, 28 Jul 2022 12:11:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/5] regulator: qcom_spmi: Add support for new
 regulator types
Message-ID: <YuJuzNiQczaYi1og@sirena.org.uk>
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-4-iskren.chernev@gmail.com>
 <YuEoLteLBgd+b8sg@sirena.org.uk>
 <79077e08-4bd8-6967-748d-876589ef978e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dHyoJ979ZanZg/3g"
Content-Disposition: inline
In-Reply-To: <79077e08-4bd8-6967-748d-876589ef978e@gmail.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dHyoJ979ZanZg/3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2022 at 02:14:10AM +0300, Iskren Chernev wrote:
> On 7/27/22 14:57, Mark Brown wrote:
> > On Tue, Jul 26, 2022 at 09:11:31PM +0300, Iskren Chernev wrote:

> >> Add support for some regulator types that are missing in this driver, all
> >> belonging to the FTSMPS426 register layout.  This is done in preparation
> >> for adding support for the PM6125 PMIC.

> >> +	.set_mode		= spmi_regulator_ftsmps3_set_mode,
> >> +	.get_mode		= spmi_regulator_ftsmps426_get_mode,

> > Why are set and get asymmetric?

> Because the get method, only uses AUTO and HPM, which have the same value
> for ftsmps3 and ftsmps426 (so there is no need for a new function).

This needs at least a comment.

> >> @@ -1473,7 +1557,7 @@ static const struct spmi_regulator_mapping supported_regulators[] = {
> >>  	SPMI_VREG(LDO,   HT_P600,  0, INF, HFS430, hfs430, ht_p600, 10000),
> >>  	SPMI_VREG(LDO,   HT_P150,  0, INF, HFS430, hfs430, ht_p150, 10000),
> >>  	SPMI_VREG(BUCK,  GP_CTL,   0, INF, SMPS,   smps,   smps,   100000),
> >> -	SPMI_VREG(BUCK,  HFS430,   0, INF, HFS430, hfs430, hfs430,  10000),
> >> +	SPMI_VREG(BUCK,  HFS430,   0,   3, HFS430, hfs430, hfs430,  10000),

> > The changelog said we were adding support for new types but this looks
> > like changing an existing type.

> The code, as written now does a different thing for BUCK, HFS430 (on
> mainline (ML) and downstream (DS) linked in the commit message). Since DS
> only supports newer stuff, to be on safe side, I kept existing behavior for
> rev 0-3 on BUCK(3)+HFS430(10), so at least DS and ML agree on pm6125
> completely.

This needs describing in the changelog, probably you need multiple
paches here since you are making a number of different changes each of
which needs some explanation.

> The commit [1] that adds support for BUCK+HFS430 might be wrong, or it
> might be right for the time being (i.e initial revisions had different
> behavior). I'm CC-ing Jorge.

If that's the case perhaps part of this needs to be sent as a fix.

--dHyoJ979ZanZg/3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLibssACgkQJNaLcl1U
h9DhtAf9HGZVngmsBVdOb9tNCdFljmfOsvAGJxBUsuxZAG3q0GSPUYdYI0sS27ZR
vlacNM7KemWnRIqdWg4lmM2ZMO08Hzf3gztF2f5k1A1E75qKruOW8H4TH1YAfV9z
qXh96eYpcX3Zqois17zzTkVStKOuhlBOhsjj45upZQ6UQ767rwHJFjRtD2lGDd6i
QwHJsFRD+YIj/0c8z3P8UyuPAddsEhdKBEGR7oyH7vgpUJRdCJaGokayCP+WYET0
UH+G0GAyemvHvT/R6BkBf3KExigjchYj4wvQZ2+lmIXIZlm4thM790vc5kB2hVfv
XhMEs1adyGF8yEiOW4YCqtYQKBD18g==
=Gp6n
-----END PGP SIGNATURE-----

--dHyoJ979ZanZg/3g--
