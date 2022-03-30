Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA54EBDE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiC3JoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244960AbiC3JoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:44:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD16266B6E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF170B81BBF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18679C340F2;
        Wed, 30 Mar 2022 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648633348;
        bh=5cA4GmdK65b305zw+ajua6M96gSCQpZ0zZIcuz26oBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NL6Dq4sPVaBVbBVNB+GtI4w1ruwLz77WavceJQNdAZ0de8In4P0GnxYl3HJMV0dAX
         ljzap916oIBt9ZSrI8Kk6rbLphmyhgrzbzxmMU6W7KE+L531YsWQDay3NCW7SeW7Yz
         LlmtcpHc5UcTJPeBlxjlabhUo2QPdykSmxf552baiKfXP9V1ZtP3ok5a2WwxTRwrML
         2Ip05bx947k1e+gZFdCpGzobk09dmUI4LrjTLqDH+hGyFoTLHyCX6vAMoc/eUzZ+v1
         FoQFmYVYyFKLimjdfQapGgbyNy+nKwzBdlPr3gpIWCrNxzC5lJCUtbj9KN78coNWtK
         UApNEo17s4cWw==
Date:   Wed, 30 Mar 2022 11:42:25 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da[79]*: use simple i2c probe function
Message-ID: <YkQmARTOWPvUq9jX@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
References: <20220325171243.1218003-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kHA7UBVeWhf4Bcfp"
Content-Disposition: inline
In-Reply-To: <20220325171243.1218003-1-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kHA7UBVeWhf4Bcfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 06:12:43PM +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Looks good and builds fine:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--kHA7UBVeWhf4Bcfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJEJgEACgkQFA3kzBSg
KbaINRAAsBUDOCxS11oDJOOttlLJDlwvYtSJB54vE9hW5AN+qyAmOEYSMpllB+Dk
mbmq3IKo2OilLeljj9r+qogH4GPfTd0MNt/3QQMusZptmML6AzZmJDcR6jnosqxP
xdvQk1d5cBNiuq1NIhIXT6On3i8VnTCs2Lo0/hZAqyDHMmPsltJ98Dc+p8W2BVyu
Gh/VKBb1ssrC4ubZ0dkTQztXiHPbANmCUvpGbeGVllljNiWUX9d/DzktO4LG7O6N
Rq3xyhjYw8ldpd8thKeNenoWWluAV/tRseggBbLF1hq0Y4uJDDpXXEE9gY5+ACF8
9i5cnnT1cZRtFJb+hOdwIAJ4qxENO4IPTTMSylLioI324WdlN4g1Xh3ywf1pL/fZ
i1og09uENTyv27S00wZG4bwI0fpeu4G6qLX999Xfjk3EarJPoQGvxM0bab0eidsu
qeK1zlxMZYrWZooupbso71CBbSpBoeGSlH0l0BR0b3RLKQsnyaKqDG+7RMhNpRIx
f1fkuJ0Lc/1TdZxaFvaGDi9Tk1eX+eekT8FK0WIeNYP7skPMb79gk0yTqqaxvb1n
DjxWUAC2K2IOXH7ZP6C/TCM0Q8Oc2LnJxNRjVRyFvVGjG8R/RbmWG+V0FLtrcWFB
3PcrOmkat4R9tsmrR28H3y0ksKQAqxmR2R/SqBE4O729vWix3ug=
=Gwdq
-----END PGP SIGNATURE-----

--kHA7UBVeWhf4Bcfp--
