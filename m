Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A048D889
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiAMNMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:12:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46812 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiAMNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:12:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8F261C50
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51869C36AE3;
        Thu, 13 Jan 2022 13:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642079523;
        bh=2qvMuUV8xfEe/5wzrqkoaNS5i0r0zXsqKgJabBS1sHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+o00Tub8uMAYeRWwU6nMs/JEW+gOu3WBDGt4P72OZUNfrerofSr8jdaEu9WaT0ry
         xRHYfNZcRlspzuNqAnWXrLGuHXlishctuP3R+fbcHlY1VzLNBqq0NklA6a6qcMjFBj
         qPSYlBjop/E1tdAYdv9bC8fgXK0kKKojSQ+YE0cp4f9TQD9Ma9xuvxbRQo2Hy7E7sO
         G1XQ8T10ku5jlUM/jEjkCOw3BmYhM9zh+IKOFPxdQ490TTzStd54qQWMm3AQXQ6bBi
         hsEi3F7hb2hkiBoJ7F4+eDTbsdTvUl/f9DzEscQRdIk5QSkSjqHsMTnVa5un/cU7CE
         f7EUN0hLeFNxg==
Date:   Thu, 13 Jan 2022 13:11:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     cezary.rojewski@intel.com, srinivas.kandagatla@linaro.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] ASoC: codecs: Check for error pointer after calling
 devm_regmap_init_mmio
Message-ID: <YeAlHjM+Cwc3ibZs@sirena.org.uk>
References: <20220113015607.1124916-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jCLPqKH0XGfYYkr1"
Content-Disposition: inline
In-Reply-To: <20220113015607.1124916-1-jiasheng@iscas.ac.cn>
X-Cookie: Slow day.  Practice crawling.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jCLPqKH0XGfYYkr1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 13, 2022 at 09:56:07AM +0800, Jiasheng Jiang wrote:
> On Wed, Jan 12, 2022 at 10:20:34PM +0800, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> I checked linux-5.16, and don't think what I said is not against the
> latest code.

No, that's several months out of date - you should be submitting against
the current development version.  At this point v5.16 is released and
the bulk of the changes for v5.17 have already been sent.

--jCLPqKH0XGfYYkr1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHgJR0ACgkQJNaLcl1U
h9DcEAf/SCgdpEXcct6/cvLyvpiX3SkY6jR5AshaV9TfWS/4p5nnVw0/5VqzX/zr
aP/AeBS+rKjxtN5pbnPIRYA3cudcQTXmdRZGEKFF9LQOSXhU9HWlEkzermiFux7a
y4o5l1TBz16IKj88SjfI0GyOiLf4xMZcfqRFoH3OvNZAZy6lHjJZXqcEjd0jKi21
nTBEjm9oSiLYfJr5NuXgIh1aGF5GljrnO6SOqeOSvJNudjvMQBUNoIVF5If/SKCo
bTSMpNFAScAIHWA0OUymoS03vG+v6kpKrh0apehCGj64yIZI1/e3Cyys1CI9x/nD
HmKuSII5/O0GbOznsTHBfGzjXTt/Ug==
=4t4L
-----END PGP SIGNATURE-----

--jCLPqKH0XGfYYkr1--
