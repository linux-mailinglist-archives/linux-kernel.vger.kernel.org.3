Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7F4F6A4B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiDFTsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiDFTsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8B2BE95A;
        Wed,  6 Apr 2022 10:27:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E8E619B0;
        Wed,  6 Apr 2022 17:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A0C385A3;
        Wed,  6 Apr 2022 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649266070;
        bh=KkbMhLobN1kUPbYF3z6kvOiUl+FffGQ29J+yE6RzbfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KpOqj/1sc8kVfifET6SQ+laj1UNM5oR9gU7nJO8IZecB3y9chc9k7RSuHPvHf4Oa8
         weuLl/40Cer9aqaBip8lU19AfVifuiUbLIMJTke2I86xckNhCqaKY38HoZegEdVcHN
         4SI09GeOgWj8ljB5tS1phi+NEuldGIJu+biGg01FJns73NDJ05xtJdS3qz5Sti7SFU
         r6w1dY/TRs/UXk+1U34lBW9yhdlmy+eIiNf1ZNdbFo+fKZsrZHpA0mLLqagAHo49bQ
         DnZKdqHQOekVYmq0dDmOnoso3I/iiGS7P4YHgDau1fIPAzNenLwFCLgB4W1i5quJgY
         M+QsqS3bu429g==
Date:   Wed, 6 Apr 2022 18:27:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <Yk3NkNK3e+fgj4eG@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com>
 <Yk1B4f51WMGIV9WB@sirena.org.uk>
 <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
 <Yk21pdu16lyR8jXm@sirena.org.uk>
 <CAE-0n50C8khP2x4sgNP5xnfLVMRQj2=LChyWWx1BWL+Xgecgyw@mail.gmail.com>
 <Yk3Bfnxe/meBYokp@sirena.org.uk>
 <CAE-0n53O23=N0zkZpg87Q3EyKquLe3WLNJT8qnZz4WEor6QK7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="004SQJl7509giZyq"
Content-Disposition: inline
In-Reply-To: <CAE-0n53O23=N0zkZpg87Q3EyKquLe3WLNJT8qnZz4WEor6QK7A@mail.gmail.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--004SQJl7509giZyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 06, 2022 at 10:21:01AM -0700, Stephen Boyd wrote:
> Quoting Mark Brown (2022-04-06 09:36:14)
> > On Wed, Apr 06, 2022 at 08:51:48AM -0700, Stephen Boyd wrote:

> > > My guess is that this is one IC that responds to multiple i2c address=
es.
> > > The "main" qcom,pm8008 address is 0x8 and that supports things like
> > > interrupts. Then there's an address for regulators at 0x9 which contr=
ols
> > > the handful of LDOs on the PMIC.

> > So it's like the TI TWL4030 and Palmas - in which case it should
> > probably be handled similarly?

> How did those work out? I wasn't involved and I don't know what you
> mean. Do they have multiple i2c addresses they respond to?

Yes, exactly.  The main device uses i2c_new_dummy_device() to
instantiate the extras when it probes.  See twl-core.c

>=20
> > Note that the original sumbission was
> > *also* a MFD subfunction, but using a DT compatible to match the
> > platform device - this is the first I've heard of this being a separate
> > I2C function.

> I'm mainly looking at the dts file now. It clearly has two i2c devices
> at 0x8 and 0x9. Maybe the regulator driver followed the mfd design
> because the first driver for this device is an mfd.

I'm guessing from the naming that they're also externally described as
the same device - presumably it's two dies shoved together in the same
package for some reason without being otherwise joined up.  Is the
second device geniunely regulators only or does it have anything else
bundled in there?

--004SQJl7509giZyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJNzY8ACgkQJNaLcl1U
h9BXDQf9HHPmN8O2BxmVgWl0924qhTw/rou4mgZ3GdP/YtQLxAe7A2e6GzabQjKE
M/82tK6k4zp0QJtXTHsqRgdpAYintpwbabCQKzku1DHfNTFSivLhouIiFPqO+qlT
3X6zsi8OwWHjJs7CZxJ4SeFNQ1Nwn63W+BMqeGl6K775QQ2JgRc1Qit42PZl/6SA
nLAnL5p7F4a0WfKdw/HOWjhmjhwdI1OauB8lYVBgOWrZburTbeR9sWmnrLRYtoyI
FHDIxwhCcM1YEj1tqxpoNuaYzWxbBY3afPPNLsGJgM20OPUlD+kDmhunV7LyidxW
FW5Yp0vrMvbtBr9VGmtDahPoxpdO8Q==
=qZSa
-----END PGP SIGNATURE-----

--004SQJl7509giZyq--
