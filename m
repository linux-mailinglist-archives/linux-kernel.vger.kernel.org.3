Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11AB4EBDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiC3Jku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiC3Jks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:40:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DAC4B86E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA3D4B81BBC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD20C340EE;
        Wed, 30 Mar 2022 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648633141;
        bh=sr20VZD/nipFVwn5z7LO15+xkgWkbvqc30j4YQ+hSx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGNJBlFmALAXCWLMYfs5LDnkpqqiau0njmHsp0WhVlbGidxXTHQq2GmaVedS62XER
         OQqSbdbP3zR7CTAswEvDuZ+Qur+gHovGr3RjMh8MhnncHHbBYOvHVoDsYc9+ATjCF8
         16SaZSNjTz7Yl43EfT+5opZK6TH45Qj47jwdEKeFvHUxw4LcTU0fuaqhEi1ff7F7Yz
         H2rnFIaPKxbQ7GYuw6kEfmAtYweBaDZIdn1ngGLR7Ey2EUD6x4lN+ofFfz5v0hYs/x
         dTpWOHFr+A69us/a+oQPrA8ENj2PXs7kpUUI4ImWS0k2K5lM3PhAgQZMn61OUCAYD/
         2U7OKDpbI1SvQ==
Date:   Wed, 30 Mar 2022 11:38:58 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ad1*, ada*, ssm*: use i2c_match_id and simple i2c
 probe
Message-ID: <YkQlMmQ4Dgh2kUDV@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20220325165452.1212975-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XDSWw6B0/BjqXue9"
Content-Disposition: inline
In-Reply-To: <20220325165452.1212975-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XDSWw6B0/BjqXue9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 05:54:52PM +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

I think the device tables should be moved up.


--XDSWw6B0/BjqXue9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJTIACgkQFA3kzBSg
KbZPWw//fRdPhdKZXXDCzD2xNq2LcyoA6zB8J0L2oT3skD/BOuSW71g6xTaLxK/8
J6nMxftG57tbDragyoaZjcM5rsUWPVNdJYJmrok1JqLR4pl/z8KTqzAUqEaam184
EYnTJH5IRQhq2McMgH3BBbD5QSC9fgjOA2Y7EuiKwhBKqkgU2rgnwisxhOWvNc3y
jNOj5z2rtSOXvpEf3koqe3UzcDzxnlxLQojcDGrwrkw808FenkVnYCok6ka/DasJ
/hAI6NlPu+TtGvdygTa4cHjAH1Eaw9CnbeyPdnoQ9vt6qSGCFrqnDvt6NrWVT7Q9
2gb3JcnTEoWMeea6lxNXhwzrg9yuGXOzSl4ZepdcKanYW+1aqM10YYQptA+6wPwf
4asditsswlMcYp2qNCiRzGvYKJXqIL4TDcutp+BkFwFZBSs4q27ZXgCpG+JBA5id
4bYzG0ndck//EBNH+T7Lm/oXikUJQBJ156n1Egny3mGwQ6ISZ9bIVosg5dK+X+cx
cpmFX0SJqNRUmy3Yj7KQfAhFrhrp3BgiSauqrhmhbkZERxJphEUuWk+y/HvbbXq9
lOPELeCShqAIJ0C/Ys9KAXlzBnUNcTynEF2Bp8+8X/CB+OMHz2wrbb+TBV5FYOgF
xZ4NifU5wqXU3YfpiB7Atgy6dmTG+hSARI0uORauGr9Rn7RtRnY=
=rjIJ
-----END PGP SIGNATURE-----

--XDSWw6B0/BjqXue9--
