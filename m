Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD3A554338
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiFVGeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiFVGeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:34:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63035344E6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:34:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3tw2-0000qx-2q; Wed, 22 Jun 2022 08:33:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3tvx-001yd1-8h; Wed, 22 Jun 2022 08:33:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3tvx-000MTk-AP; Wed, 22 Jun 2022 08:33:49 +0200
Date:   Wed, 22 Jun 2022 08:33:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?6JKL5YGl?= <jiangjian@cdjrlc.com>
Cc:     jic23 <jic23@kernel.org>, lars <lars@metafoo.de>,
        ardeleanalex <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "antoniu.miclaus" <antoniu.miclaus@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: magnetometer: hmc5843: Remove duplicate 'the'
Message-ID: <20220622063349.njjnkzuxzp3tqoo7@pengutronix.de>
References: <20220622035925.5008-1-jiangjian@cdjrlc.com>
 <20220622054927.u7im55jm5ya3n43l@pengutronix.de>
 <tencent_4A8F2A14242D4AE12AF9EFA6@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2n6gntqnbw5r2slz"
Content-Disposition: inline
In-Reply-To: <tencent_4A8F2A14242D4AE12AF9EFA6@qq.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2n6gntqnbw5r2slz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 22, 2022 at 02:05:03PM +0800, =E8=92=8B=E5=81=A5 wrote:
> Yes,the tool found the issue.&nbsp;
> I am a&nbsp;beginner for this job and don't&nbsp;
> konw how to write the commit messgae=EF=BC=8Cbut, you are maintainer, so =
i copy the
> suggestion.&nbsp;
> &nbsp;
> &nbsp;

Another thing you should do to not annoy the people you communicate
with: Fix your mail agent to not use &nbsp; instead of spaces.

Best regards
Uwe

--2n6gntqnbw5r2slz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKyt8oACgkQwfwUeK3K
7AlTmgf/WkmSUWgXBDa/ZGcbep9ZD0Skn52FyryvdYfM+xdPNMlF3VC5CA+mA0am
VMqrIrF9vqRRpO7v9KrJ99bs2X4RrtNDe+8TVUVHUyLkv3yJOHdhX28OI6FEtQN5
9UIFiVog5ACx0wcwjzaRHfu8zi57PrlQfsNX/1KZTvyMQKMSFjq9/kwlxSRArcUm
F88ZVswyLuAp7plD5w2JuIAA26ahOKEEbwm+PHcYxXYYOagrRfxXRo7YRoe11RHf
JnKG8CR+nSDVZH554pNMYey2i06wdKxlJ5u+0qs+tk7qKfGfoT+KzxctVgN+xUsf
3e7QCziM3IBZw1WOE5rauMdnq2R5mQ==
=Gg+E
-----END PGP SIGNATURE-----

--2n6gntqnbw5r2slz--
