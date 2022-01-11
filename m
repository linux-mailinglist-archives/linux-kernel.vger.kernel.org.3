Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7603348AF06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbiAKN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbiAKN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:59:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6390C061751;
        Tue, 11 Jan 2022 05:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF31BB81ACB;
        Tue, 11 Jan 2022 13:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF141C36AEB;
        Tue, 11 Jan 2022 13:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641909558;
        bh=BwyiPXEw4zt5RVrk80VtkmDX6ZMVIH2jF8JVPiiLadI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGIFLepw5b/281+u2ddmU5DwumUlyPQex7TifHtcg5mVl44P+TeVgktl3tARelokq
         zD4J2Z/yx1F6W4tKeu6eBL88OKA2RDXKNOx5Lg0YCzPNVcyMRxzKo04A5Poy593jfU
         +3/BVQlETU/Mh04vBlw5T0v8CrVojs6M4eINKDNcMmW8vCwAqUifzz76zAXYhCOx0p
         6r+5fZtCGMGnQMLoku/4DFBADTBqaU9qZE0vhldmg3My9ZzENpHDJKB1XngJC56G0P
         xB8tsUQEkwD4GBZORP3RwvB19QyLRTh3vnoTZBNyEvEW3dOefQRitMRTU5EkAOqX4x
         U+sWgt4fpT8lg==
Date:   Tue, 11 Jan 2022 13:59:12 +0000
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
Message-ID: <Yd2NMGywGq3efjc1@sirena.org.uk>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+qn2hA4MzNEqM+@sirena.org.uk>
 <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
 <Ya4UcxxEq9t+isxS@sirena.org.uk>
 <30ec6b4c-f2a8-d80e-a542-1c2b3f30c049@quicinc.com>
 <07dc5ba4-790b-0cb2-bc3e-2ce8d7e3e09d@quicinc.com>
 <YdxA5bwcwyJXcPDl@sirena.org.uk>
 <9c4a995d-2dc0-1731-cca0-a013483a4fc0@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tgB8fPgClakrhZQc"
Content-Disposition: inline
In-Reply-To: <9c4a995d-2dc0-1731-cca0-a013483a4fc0@quicinc.com>
X-Cookie: Many a family tree needs trimming.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tgB8fPgClakrhZQc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 05:45:16PM +0530, Satya Priya Kakitapalli (Temp) wrote:
> On 1/10/2022 7:51 PM, Mark Brown wrote:

> > There are some devices that did get merged doing this, that doesn't mean
> > it's a great idea though.

> In that case, it would be helpful if you could provide an example which has
> the design you suggested.

There's plenty of mfds that register child devices without using DT -
off the top of my head wm8994 or arizona.

--tgB8fPgClakrhZQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHdjTAACgkQJNaLcl1U
h9B5NQf/cAVrtJjJosTSpLQN6dewv4VRADMuwyow8h6fz/3KGfMS5EnoRcB68NtM
LrW80WT3Xhx2VBuSWcLJnD+zBqRUcHvskVNnrGo+GUHQQNDG+8xkIYBkudV5nQHv
6tan07wUQ5vbTg6Ebk0MgTBdnwsPKehQGuMcIRl0zkszK69Q72Bv+O5M0ITBMxwf
u6EDod4lJnPh41NTeZKl6S+drNkGEC3AJvYvHz7PnpN9SgqZJObpTi/lbUXvOGMj
SYTv4UXuU1EbztUBIu6e+paVodOyERylht1+y4PXkfEzrfs5WLGaEyS3rbUA/Px5
T7Armtpjqi+yJLDzQ0U47lhdPDbQiQ==
=ghdz
-----END PGP SIGNATURE-----

--tgB8fPgClakrhZQc--
