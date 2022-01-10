Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938B489B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiAJOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:21:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50904 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbiAJOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:21:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E11CB811EC;
        Mon, 10 Jan 2022 14:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C098DC36AE5;
        Mon, 10 Jan 2022 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641824491;
        bh=CSoMuGzkJ+TOL2oH/IXDb1JVobsttswFZJ+HvUGnneg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNkHrpOr2VrlyCJo+Ghe0PZAXb5ivXNmYKpI1uhe48kqxR0bDG9SobuKO8w5KR3Qw
         0JyBTZirXreOLlNTupqDpRb+jVd35xLfbAgsv7hQt0tWIssna0VcjrnuGJiebJnSFF
         UHnkFBtNPYSdvBhHqG7Z8owDUXIrbV6GWz2Y/eSLO8TFpF+5ClsLhZXQBygyYe/9aP
         waNz+2Xj49jP9XNoIeLSY+YNFH59QUJLacL2DwfSm8EVscFE2Xqim2gijySbdCZF/w
         BDGbyDxUuXUWVBpwjiNr5NSWv6hMyUXiPu0bSqReh5XT5Hw601I8bpgJqYuxoN7ou9
         E3KRUlQAO87bg==
Date:   Mon, 10 Jan 2022 14:21:25 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, swboyd@chromium.org,
        collinsd@codeaurora.org, subbaram@codeaurora.org,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
Message-ID: <YdxA5bwcwyJXcPDl@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+qn2hA4MzNEqM+@sirena.org.uk>
 <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
 <Ya4UcxxEq9t+isxS@sirena.org.uk>
 <30ec6b4c-f2a8-d80e-a542-1c2b3f30c049@quicinc.com>
 <07dc5ba4-790b-0cb2-bc3e-2ce8d7e3e09d@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xt65ruTatPFVTIhX"
Content-Disposition: inline
In-Reply-To: <07dc5ba4-790b-0cb2-bc3e-2ce8d7e3e09d@quicinc.com>
X-Cookie: Do you have lysdexia?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xt65ruTatPFVTIhX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 10, 2022 at 06:42:08PM +0530, Satya Priya Kakitapalli (Temp) wr=
ote:

> To understand how other upstream mfd drivers are handling this I've gone
> through some of them. Taking one example, mfd/stpmic1.c is a pmic=A0 mfd
> device which has a regulators sub-node with separate compatible, and has =
the
> parent supplies listed under the regulators node.

There are some devices that did get merged doing this, that doesn't mean
it's a great idea though.

--xt65ruTatPFVTIhX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHcQOQACgkQJNaLcl1U
h9AcAgf/aAfps0Xv/1N167UQgoR5118bDWCVmsdfpk0/agFWosdoXzOJ/Bf6boYz
fZzlKOe7PU9UWOhOKBxwE12hlMsaspuGSVQQABUAVh6ebEwQZrQg3UzL/ND/sJua
cgSTkV6/zTVYbxgdkjDd4eDaStZ7mEFWm0OSI63Ki61gqOlB7WrCcz1zzNij4NSS
5QdGIo8h+6R5aqvO7dZ6QRjpihfjNrexmxb/BSET1sFGtcoGMOtgyOc6mkrrak/z
gzjB7qtrh2p4hhrVYAa07r/06tw87xBJOv+bswsCQDF60YiGdpUu7d5YEE5GdV4a
KPSDyUHnWlCkDQF4s5SwH0je4RzivQ==
=dbCf
-----END PGP SIGNATURE-----

--xt65ruTatPFVTIhX--
