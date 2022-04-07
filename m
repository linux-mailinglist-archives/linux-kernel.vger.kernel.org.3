Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6480D4F889A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiDGUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDGURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:17:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF12DCCA8;
        Thu,  7 Apr 2022 13:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EE93B82989;
        Thu,  7 Apr 2022 20:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A593FC385A0;
        Thu,  7 Apr 2022 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362469;
        bh=VAe4f8woe+oOvEao0tOm8tWrif27cNn6I2hPfNOSIRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hn3IJwhz7whA82PH78dNop3SRZpPGYtcotoPuz7FhS17+7iQnVY0qHZ+u1PlCA1vL
         D6Z9F8ukM/140n02Afmg6Y38iv9AxGJJiM055+y0lsoyIY9ZhHMUxjb9PJNkWiJFeK
         fuEN8HgzPHWm/wTC4TN6QZWDo8huOj+GgOmcSV/BQvQC7Lnx6S9xw3+3rlGGr5SLuI
         5Qny1/NSuMkAxZoM91jhsi+UVd3aJ/zSkl8kKM4Ly/0Lxu/hiGQ/BbBQF1TnR3/zOM
         9IvrsKSe5e7QbVmv2gumSCcTE+aMnC8A5joydfx2Aepn5xprYElt/rH68kFdEytbir
         xrpxliLRo2wiw==
Date:   Thu, 7 Apr 2022 22:14:25 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/10] clk: max9485: use simple i2c probe function
Message-ID: <Yk9GIVlPk+WaxaE6@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-5-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GW6ZZYSWduuWngtR"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-5-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GW6ZZYSWduuWngtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:25PM +0200, Stephen Kitt wrote:
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--GW6ZZYSWduuWngtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRiEACgkQFA3kzBSg
KbY0YhAAoOwXGBf6vyw4CmIfGgTTl8gW8Edu86MycfVI5cTvb/AnvKXEvTQuum7s
B96TOT9URGi/DFlpSfHPAVlM1M6u4FrpWVf2f3z+X7h5jNRnThZI7DO7twmd28nb
OWcwU5kUriiozDCwKAPE0TgibCVThQV+U2Fp4NC7S4LI5hikNqle0inCpqcwRA4H
yGsoeTK7xIi478uBWy55CtVHtpk9cuO1fy/z1jzmZmnb1ziKSpB6bdpdqIhs7CQc
xPNi7CgWjAOLTEG/GDkeql+wti7f5pJIcBwNBNuemRUEbH0WY1uZdSGMTTx8UGj+
B/OYKRu/zgsUtAQwMl7CbRhVJQqlrBwGG7aFkjARQBu+QIgwnowS/Fr3Wgni1hWE
h17bZyJAN14eSJba9x9YyfO2rRbKAMG98FInwUNBghoF0fybDoe8aS+SY7QipXe+
lac7r742cB5Mp8wtyaThWMHn8WumLzjefuzFAyUb4k+Qm+Ev4SQQqg50x04OETOE
OkTFj0s/k6A26xV4RQCbQBk1PPzDq049ujR0GeZjU5SbhW9d7E2xSfFYe8v3lSVV
xCkB0PrJWPHO62F9rZF7LRevWQhdQ1+9mCdpnRDpyoWgVKk+lNaddnFLz+TBcB+Q
iVwy77DqjCeshgBnY9kvS/23+BBiq4Xhwiya2tM1+mtdYCGPTC4=
=VnKf
-----END PGP SIGNATURE-----

--GW6ZZYSWduuWngtR--
