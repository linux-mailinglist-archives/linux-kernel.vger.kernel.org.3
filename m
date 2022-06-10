Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40AE546627
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbiFJL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241978AbiFJL7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3723DA66
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ADAC620EB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F297EC3411D;
        Fri, 10 Jun 2022 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654862345;
        bh=5Mr5Sik8VWTLpdnt8HV3IJSO9fv11eufUOK1EynOnpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMf3p584FFyuxNXad/BsqR0oTJxaZ5SnsOxDwYH8jmutGuvWhVGh+pje4ewHk+ou9
         cFNEiiWEluRdFdkTUS9MiX5nIvi4vLebMBJizOJmAYgOeHe8p9x77+gk8S4Ge2CNzu
         DCUyZDNZlwwNn/pkP1j3x+vXBNlxIS7/wUfpZmhh9EdS71ww06gEAS1ZQnIPZOtSte
         7fw0dxp+c3pGTTBBePiarFs3KYogtYcvXBLuOVjUHYhRBHBU+nlOVPJAa6BqBAK+ut
         CFvzykI5H2q0OTMMrsrCrkhHT2aaVt4zLuo5CQIgFI7WJ9J7y/N9X/4JEUXVTxVRqk
         UlVy6tQWQ6CoA==
Date:   Fri, 10 Jun 2022 12:59:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
Message-ID: <YqMyBFnNky7sP1dC@sirena.org.uk>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
 <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
 <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1>
 <YqB9O8HhZV2tXo8g@sirena.org.uk>
 <BN9PR11MB548315C03B09D841B6392E63E3A49@BN9PR11MB5483.namprd11.prod.outlook.com>
 <YqHH+oX/90KXv8dN@sirena.org.uk>
 <alpine.DEB.2.22.394.2206091655490.1640209@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rGCl5PdKPhlcp1q1"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2206091655490.1640209@rhweight-WRK1>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rGCl5PdKPhlcp1q1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2022 at 05:30:43PM -0700, matthew.gerlach@linux.intel.com wrote:
> On Thu, 9 Jun 2022, Mark Brown wrote:
> > On Wed, Jun 08, 2022 at 11:54:26PM +0000, Zhang, Tianfei wrote:

> > > > ...that this appears to be entirely specific to some particular device, it's got
> > > > things like hard coded register addresses and timeouts which mean it can't be
> > > > reused.

> I think part of the confusion is that this patch should have been included
> in a patch set that actually uses this regmap.  This patch really should be
> included with the following:

> https://lore.kernel.org/all/20220607032833.3482-1-tianfei.zhang@intel.com

> The hard coded register definitions are offsets to the passed in void
> __iomem base address.  This set of registers provides the semantics of
> indirect register read/write to whatever the register set is connected to on
> the back end.  Conceptually this could be considered a specific type
> indirect register access controller, but currently we have very different
> backend implementations in RTL.  Part of our intent is to have consistent
> register interfaces for our FPGA IP so multiple drivers can reuse this
> regmap.

...which is all specific to your particular implmentation of this and
not a generic thing that will work for anyone else who implements the
concept of indirected register access and happens to use a different
control mechanism.  If you have to use the same register interfaces to
reuse this code then the code isn't generic.

--rGCl5PdKPhlcp1q1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjMgMACgkQJNaLcl1U
h9BOswf+NM7CxR4noTaDr7F6YCmwh/BvL0+NAAA2LrOMx9N4jT5bGPcNEE9SHOL7
wqpxDbox8KS9d/tzEXB67Yzt8NYXztVXb1umqDqJ5q54JTRyvoiqk3wtLwQtC+Kk
yung/rVvgcPZ3NGpvsthu28fZjmSXMQrW6uD9OLmoFHXEd5tr3SnGP+rj9BSuFhW
SQFRGHOCeiSW3W7RY2/90DjOFlRH5FrZWeHwD1w1THPHcCV6TqtD0GkakoCBCIgR
OZQTCC4L2Oz9adhIoEsuAkMfmj5CrQjkYpnlWtu1xFFp82lXYHAV3z6ukiPlfMVL
n8FksWkktC/d2U2o9Hv8tC16MDkyMw==
=ZB12
-----END PGP SIGNATURE-----

--rGCl5PdKPhlcp1q1--
