Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A14469BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357721AbhLFPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:19:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59228 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345843AbhLFPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:12:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F5B61331;
        Mon,  6 Dec 2021 15:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BEDC341C5;
        Mon,  6 Dec 2021 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803365;
        bh=dw9XxwMU7Td04mZbDOSAvoqc7QfnAD/1a1RCoKpziy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nji2GU1IHM4eYGvBFkSGnE7BzaMtdiEJBDL4bMPpAKPyodvXf2tijBvVijiSOOblb
         8MGQXk94GUdVqTwjVsRCBdoAsEI0wyDhWI/b7bKr4vQZ7NkcL0KNwhkZwaZdQO4LTs
         QTHTfqyKGGAv0J+DprafJPZdt6/kTkFpZhFU+Q8MItAYUe+PIwxlYa3BUhOcEw5P9n
         mxdzpHELW+1VNgwdbZHCW8Y/EvM1c2FqJRXkI9Cr3K7X0Z3DVdl5VRDk0RjZUQkvbo
         /2a6VLmyIvlU5RCJrZAhhR0NUdaa98lCck5xLCmj5zjsUGDioPDf/sWsa5NQEwUlsH
         AVw6o/pLPUfJg==
Date:   Mon, 6 Dec 2021 15:09:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, swboyd@chromium.org,
        collinsd@codeaurora.org, subbaram@codeaurora.org,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <Ya4nn0/qp5El8P0L@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-5-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+vnV12gDCtia5S@sirena.org.uk>
 <d86e1a33-e7cf-58f7-d75b-23a0313ebde5@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Iup9tc3xCjeDkBkE"
Content-Disposition: inline
In-Reply-To: <d86e1a33-e7cf-58f7-d75b-23a0313ebde5@quicinc.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Iup9tc3xCjeDkBkE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 06, 2021 at 08:13:57PM +0530, Satya Priya Kakitapalli (Temp) wrote:
> On 11/25/2021 9:15 PM, Mark Brown wrote:
> > On Fri, Nov 19, 2021 at 03:12:31PM +0530, Satya Priya wrote:

> > > +		child_node = of_get_child_by_name(parent_node, reg->name);
> > > +		if (!child_node) {
> > > +			dev_err(dev, "child node %s not found\n", reg->name);
> > > +			return -ENODEV;
> > > +		}

> > This could be pulled out of the array.

> Not sure what you meant here. could you elaborate a bit?

Why is this in every iteration of the loop?

--Iup9tc3xCjeDkBkE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuJ54ACgkQJNaLcl1U
h9BoCwf7B0e5FaSpbT2g+oY0Sk9qtf9WbFJ/Q0KFdvOUFoZMbUJFU696VOd5Y7PM
E3Lv6SM02b2YHpyvMhc7ThkY76kH85jy4k2grAFyUf0g0BaUo+lqBJEZqdOftghL
13IBaJ3EYEyELFG4+pRgnipVFvWGxbwbPdKSiti0UuutznglOo5UOsSeJUZcYlF8
tkWuoKBHqHS4jwrEO0IT+HU5SOPuU7UkiJYKdD/L42vlPuBUqEKP0hYF0rirvbM+
VJ8u16+Hs6teUB8V3Iu6x0kPSQRXy4s1uEBvdFrrXLY2Glnh1OaxH53Sp9p0vc0w
XDoo1A+3CfAc4DBh3CqX6NxdKDVmZQ==
=pBk6
-----END PGP SIGNATURE-----

--Iup9tc3xCjeDkBkE--
