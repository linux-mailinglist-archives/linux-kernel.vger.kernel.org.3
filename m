Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18806587CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiHBNR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiHBNRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:17:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21AB12D19;
        Tue,  2 Aug 2022 06:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B345B81EF3;
        Tue,  2 Aug 2022 13:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3833C433C1;
        Tue,  2 Aug 2022 13:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659446271;
        bh=p4m28G7V5HhenGiD2H4zOI1QhZVoWGXr14bSJRSRAdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFXQbQPz1/L9eDzHSURbtzxxo3qdNlR+j2Fxcv8i/YkMjW80rur039virDvzrjCQt
         7wbJawZkiTY9bGFbkjWmxkqbBXJJIlkygGCk+/MQ3wa7tMw6M5CzJtX2gfH7pOfocZ
         fY2AFs7BiDwWiutDOasuNvlzogaKtRaFe2gkZZWb4Tp3xNZVvOfA/lcWWNd0F/h7pG
         HVtafQyh7mmzugH4aCjIWzgvA7Ys3WfibMfMmXQRtfV2rl/Bc1Oo1NdyS3M1dior20
         6bW+NAdletbIl5XB/HzrwQVM+tQzMYtXqYQJqUFSY4Ax4AJb9WeJoZSR1+d9ARkOdH
         eOQnyY+qcd7ng==
Date:   Tue, 2 Aug 2022 14:17:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>
Subject: Re: [PATCH v3 05/13] regulator: qcom_spmi: Add support for new
 regulator types
Message-ID: <Yukj9bjX+O0Yab3q@sirena.org.uk>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
 <20220731223736.1036286-6-iskren.chernev@gmail.com>
 <3f56541a-29c1-af76-0de3-b20eb81a5fa8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TszTQpVlg1sWIkv4"
Content-Disposition: inline
In-Reply-To: <3f56541a-29c1-af76-0de3-b20eb81a5fa8@linaro.org>
X-Cookie: Stay on the trail.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TszTQpVlg1sWIkv4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 02, 2022 at 12:46:48PM +0200, Krzysztof Kozlowski wrote:
> On 01/08/2022 00:37, Iskren Chernev wrote:

> > +/*
> > + * Third common register layout
> > + */
> > +enum spmi_ftsmps3_regulator_registers {
> > +	SPMI_FTSMPS3_REG_STEP_CTRL		=3D 0x3c,
> > +};
> > +
> > +
>=20
> Just one blank line.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--TszTQpVlg1sWIkv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLpI/QACgkQJNaLcl1U
h9CIzQf+NuTTebaileZ8U06bnAkY26XDIkyB3jsbaiecRfzdZzXZw+icUg3nKpAG
eZhtg6qhX9zUSrvy0e2yjmXuvfplFxgRM1kk+YNe4vUJ1NEn+K5Rq71mgUJP5djN
vetDDdZmJ78dSTNPLLZNpNnPR2fkzFKdeBjxs2I/4N2Ci3MaGol+Tse41H34lGQX
myMJ9KHpGHKC8I/s8rBporzSxK4L/q60srqhutdJIcOT4lyqumKbSzLBfEZwRfFv
EWDyr0ea9Qs9RHtEVOag5+DDRqXTV40iK756MlRQic9a4ngw1l6SfB92iwalC5pV
KKk62Ean6wM2YOVdq5jLxaTbVY0zKQ==
=HoLP
-----END PGP SIGNATURE-----

--TszTQpVlg1sWIkv4--
