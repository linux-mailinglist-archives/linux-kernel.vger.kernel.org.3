Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB4581B43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiGZUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGZUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:43:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE90437FA8;
        Tue, 26 Jul 2022 13:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E35B81A07;
        Tue, 26 Jul 2022 20:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DABC433D7;
        Tue, 26 Jul 2022 20:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658868191;
        bh=LbR1BMuEQqhXLq5Q2APJ+2Idbv50Gs/muhHzWBRIio8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L20l2dcF9z0j6fYoax/CWojKq18CPRE2Q+KeBXPaoHpBWJg0VzAlerQydOPnVOP5s
         g47HouGmQpW6E7+LgIQg7olYximmzliGrGSGPLkk2i2M6ryxb4bFDSmfXY/WwpRJyv
         FWHek4/CcIpTmUUZxmcVAvsT2MnTCXRlHfKvIppdIRpQzgepIAaYNI4m1YsMimwNCE
         wc3AIsZ1yoHZM4qkXJrUP00YZkIfXUlwRoZWOcKII5qww1nzuTZHiGfv+MuFxOPXX7
         LQmfjE38DO/oyAwHfGXqEjmsVHFDNEyDujkX/WTqQ0diJvrssljy4hwE+oH4wLPjB1
         lqBtP+WHU3e2A==
Date:   Tue, 26 Jul 2022 21:43:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Implement get_optimum_mode(), not
 set_load()
Message-ID: <YuBR2pyQE54rFq68@sirena.org.uk>
References: <20220726102024.1.Icc838fe7bf0ef54a014ab2fee8af311654f5342a@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AQDkKaq99BpwYzn6"
Content-Disposition: inline
In-Reply-To: <20220726102024.1.Icc838fe7bf0ef54a014ab2fee8af311654f5342a@changeid>
X-Cookie: All rights reserved.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AQDkKaq99BpwYzn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 10:20:29AM -0700, Douglas Anderson wrote:
> Since we don't actually pass the load to the firmware, switch to using
> get_optimum_mode() instead of open-coding it.
>=20
> This is intended to have no effect other than cleanup.

Thanks, this looks sensible.  Unless there's issues I'll apply at -rc1.

--AQDkKaq99BpwYzn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLgUdkACgkQJNaLcl1U
h9B0+gf/fsvUmerLDjmGtYJQ0RGGsAS5VyCMT1iv1slUGSny8Yha2e9ufgy8KcBJ
m2+eWmRIw9UaaN/mgiEX+0KX0+eJLsSFmhq6cFiiVVA3viIF+0fxWjcOhP8FyFuB
VUPKU2fHaK2NJfGmV4S0yRqpgPPDsFIsdqpRS2+7boylhLRiPimUe2/EJbtFdQ6U
O79Ris/aMsayFZR6cHBPvCLDZU9v71Q+YdXhKgfzMZ5bkbZhVS2cuqFDjgkGmMVx
Tmy1kLbAYnDM+D6OuuQVy1gNJb3irc14Cl1c+IRMaEqWxI7sNAFKEVcvzM2xzL6w
DGvUmhzuLXsy2265sCo0WOmOAtkvrw==
=QekV
-----END PGP SIGNATURE-----

--AQDkKaq99BpwYzn6--
