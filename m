Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953BE46976C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbhLFNvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244021AbhLFNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:51:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53CC061746;
        Mon,  6 Dec 2021 05:47:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79E18612C5;
        Mon,  6 Dec 2021 13:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D854C341C5;
        Mon,  6 Dec 2021 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638798456;
        bh=1ervwJdtDJPGg/rvZhJpL4+9h2ZvVpzF/nR7EGyL3ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h/Ik77XmFqiYyQozOVZv1nh1p8saCpt4w8b6Py1m4FQl6JTEAhQlFx0oHgelZIhDu
         o9BK0Eybq6j/s/3GxapX7IhYTUapflBvswimxZp561yNt3gkstf9IDE64cKvSxUtUu
         ifJqhuSr86HtnJY0HFnIsW9sl3qcdpvk4QU4Ty5tTkxuY2kPZzbZumitn7roM1qr3y
         91b8Ppmy9cRJIxlqykNMmTPzyTUnDL/ao4gE6FKaxfBL6ZckIp7SrQbac8hq+UUdBW
         G3k/HaU89hOpiphym1OU+nqOwqqIIDhg4utecAMBS3vxKkRSvuVgGFW7WaK6/LEsvm
         1y0QVgc44i7aQ==
Date:   Mon, 6 Dec 2021 13:47:31 +0000
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
Message-ID: <Ya4UcxxEq9t+isxS@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+qn2hA4MzNEqM+@sirena.org.uk>
 <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2Y/onyCi0oqM7Zy"
Content-Disposition: inline
In-Reply-To: <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
X-Cookie: You will soon forget this.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2Y/onyCi0oqM7Zy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 07:13:02PM +0530, Satya Priya Kakitapalli (Temp) wr=
ote:
>=20
> On 11/25/2021 8:54 PM, Mark Brown wrote:
> > On Fri, Nov 19, 2021 at 03:12:29PM +0530, Satya Priya wrote:

> > > +properties:
> > > +  compatible:
> > > +    const: qcom,pm8008-regulators
> > Why are we adding a separate compatible for this when we already know
> > that this is a pm8008 based on the parent?

> For the regulator driver to be probed we do need a separate compatible
> right? may be I didn't get your question..

> My understanding is we should have a separate compatible for each periphe=
ral
> under the parent mfd node.. like gpios, temp alarm, regulators etc..

No, the MFD can register whatever children it likes without needing any
help from the DT.

> > > +  vdd_l1_l2-supply:
> > > +    description: Input supply phandle of ldo1 and ldo2 regulators.

> > These supply nodes should be chip level, they're going into the chip and
> > in general the expectation is that you should be able to describe the
> > supplies going into a device without worrying about how or if any
> > particular OS splits things up.

> So, if i understand correctly, we don't have to mention these in the
> documentation as these are handled at framework level?

No.  I'm saying you should document these at the chip level, they do
need to be documented though.

--s2Y/onyCi0oqM7Zy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuFHIACgkQJNaLcl1U
h9Bh+Qf8DxGyOs3yJmQBLpsw7yd/avRnEQw0x5C0ke/0N3cOZMaLc+Rm3NGu3u7f
DSxkpUYrbUdUy5AQLcsAFwVEF0rbEvi0QbXSbkYPxh4V/0sF5EF+dx6M6Rf7+fOY
BWTs9A83UkUUaY3jkhyjKcF2fhz2uFfMTm9p20XECVX+MHEslddV0DprWo6AWVPY
CtHx3z6ImfXWuMSIBWMo+KvtBi1Ywaw7Z6xYrY5MeSFM9RPiFYLCJVuQEWm0a4Zs
rLhh74SRXi/3670xcy/DiDyflKvfePtmlAXTFyKDyKnN6GBCv215KR8EtudIw0ZM
O8jUDRCSyVMn78Cx5FGhBPJxKJfvPg==
=+A0G
-----END PGP SIGNATURE-----

--s2Y/onyCi0oqM7Zy--
