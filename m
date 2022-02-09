Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6DE4AF26F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiBINMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBINM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:12:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1FC0613CA;
        Wed,  9 Feb 2022 05:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B23D56194A;
        Wed,  9 Feb 2022 13:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EFEC340E7;
        Wed,  9 Feb 2022 13:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644412352;
        bh=cWkt5CAtLtJYiO229ax41kQjdnyh3HcJOnSxlXQjmO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyQ+FP6EwVfT+k+6zNxC1CVyR8NqghLmzz+6NC6B7ZfnJpoNJbAcfnzScg51cJ5WK
         gBP+pVPpo8n+oDxv/le3j/KnmQCiMA5BXwPepoAsW54mSoaZ+Nz42Q3qZdBfN5d8h3
         Sh205gigyOhOs60MvktC7a2zQWTOTiUfPfnig1sBZJcs/tmXCTvxptDKqpI5M7uyQG
         GTni2KVbUAZTaGJgBNV/4VvCA4AdbXS05V2JSsWBco8Vg9Drh/2Hs4MZuA26M2BR0T
         CqYomFC0Rcbj9c0mVMWWpKuNi1X6KACeSlhdZBpeeXVKC/5TMD7cuTlzXIsd7DOkr/
         aLpm8TaE1DmXg==
Date:   Wed, 9 Feb 2022 13:12:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tejas Prajapati Rameshchandra <tejaspra@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "moderated list:ARM/S5P EXYNOS AR..." 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org
Subject: Re: [PATCH] spi: spi-xilinx: fix for_each_child.cocci warnings
Message-ID: <YgO9uo1etPr+pCQr@sirena.org.uk>
References: <alpine.DEB.2.22.394.2202082148490.52266@hadrien>
 <CAPybu_30=ua4emx3hP2eFeJ4gtoOncah+X+NmsBdQq7cTuqZ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KSvbXx2/FIuv+9D7"
Content-Disposition: inline
In-Reply-To: <CAPybu_30=ua4emx3hP2eFeJ4gtoOncah+X+NmsBdQq7cTuqZ+g@mail.gmail.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KSvbXx2/FIuv+9D7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 09, 2022 at 11:33:34AM +0100, Ricardo Ribalda Delgado wrote:
> On Tue, Feb 8, 2022 at 9:51 PM Julia Lawall <julia.lawall@inria.fr> wrote:

> > Fixes: 3973536c4560 ("spi: spi-xilinx: Updated axi-qspi controller driver")
> > CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Julia Lawall <julia.lawall@inria.fr>

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

That's not what Signed-off-by means, you should only be adding a signoff
if you're forwarding on a patch or you wrote it - please see
Documentation/process/submitting-patches.rst for details on what this is
and why it's important.  You probably meant an ack or a review.

--KSvbXx2/FIuv+9D7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDvbkACgkQJNaLcl1U
h9A70Af/VTsZEKIBkL/dr0x1V4cWskJo+0BJJecpWn+bkAz6z1Eu3J+SvBzuByX9
bSD5VIUqmHx6bU7V97v4tro6qx2YwesLU7WUaATiF/VwqHZ99Ea0H1XIYkFGCLDg
geEWc23edUaH39Xwbdi6bJBFFGMDeNsuNU3zcUHezyBFZqWygJEl0oxg8/tmCY7T
EVqJqd7j+DpmUnR+kXmcr7+OBYvT3oVj0ykGouylHyGH9cSg6FZ14gaUjbGb9U61
GPqOpdWX+0mRcBUL9sQ9DIjoGRRrp0dWZCG0wfb5ybeysPzvV+TaCrjSyx6/vbGS
TasgyNZ+gl048iv/8U7mWsAZMzRR3Q==
=8OCa
-----END PGP SIGNATURE-----

--KSvbXx2/FIuv+9D7--
