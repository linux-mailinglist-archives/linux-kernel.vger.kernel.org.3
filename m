Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DBE51AC75
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357985AbiEDSNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376717AbiEDSN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:13:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646CB5B89D;
        Wed,  4 May 2022 10:32:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C07BC1C0BCC; Wed,  4 May 2022 19:32:36 +0200 (CEST)
Date:   Wed, 4 May 2022 19:32:36 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH V4 0/4] Add PM8350C PMIC PWM support for backlight
Message-ID: <20220504173236.GA8725@duo.ucw.cz>
References: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1645509309-16142-1-git-send-email-quic_c_skakit@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series depends on [1], which adds driver for Qualcomm LPG.
>=20
> [1]
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=3D615848

Thank you, I added 1 and 2 of the series.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnK4tAAKCRAw5/Bqldv6
8jYeAJ9Fzqbb3LiztndHby6NFpeqAvotPQCfUsKmBx9AzEGthW+cMnk/R5xefY4=
=/ZCF
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
