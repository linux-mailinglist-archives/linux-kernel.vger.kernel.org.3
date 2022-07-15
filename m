Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D46576511
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiGOQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGOQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D442FC8;
        Fri, 15 Jul 2022 09:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C6636216E;
        Fri, 15 Jul 2022 16:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66131C34115;
        Fri, 15 Jul 2022 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657901017;
        bh=jrlFeUIlmq6USCDUyOFysJvOq822JHFZZ7Z40MxY9qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dadoHH8CNpbJL21+f44Epd5J674JaHKpzitYi5Yt6EmFV684hfkDRo+FU0AUmtQqS
         z1+Hz1CQ6Pw7Y+OIeVoXKvDwcNmTI/60tTPCQ8DFUG/j8lkQnjDvcE94j18yHU/By2
         Phhwo4EiJ/3/rQz9AuknKwC9JQR0+oZh5Yls6JEYUch/QOKB1zjBpeTlsPpc3MAnEK
         WQ1wuH8tWlBKZemmAsiWSaQW3jCKJAkMbHD6WfEpsc7lryOKiga4QG0/3uAqnFeGgF
         pKQuDymcNVqLw8AZQNAgogELOmcLaCvQoV/n3JomfnruEUbYSGz9jwTWulu9U4d4yp
         ETqG4+zPC0Crw==
Date:   Fri, 15 Jul 2022 17:03:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Message-ID: <YtGP0+7TPGdcPTEM@sirena.org.uk>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <40110ff8-5c19-bc54-759b-a51a919788eb@xilinx.com>
 <Ysw5MpvjKM5LKvWd@sirena.org.uk>
 <DM6PR12MB2809BA6D4F94EA59E76E6576DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DxORmGk94Y1lYeUm"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2809BA6D4F94EA59E76E6576DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DxORmGk94Y1lYeUm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2022 at 03:36:23PM +0000, Mahapatra, Amit Kumar wrote:

> Thank you for the clarification.
> As per my understanding we would not be needing a new DT=20
> property for expressing multi chip select support in the driver.
> We can use "num-cs" property of the spi controller for=20
> broadcasting multi chip select support of the driver.
> If "num-cs" value is greater than 1 then the driver can support=20
> multiple chip selects.

That's true in some sense but not in the sense of being actually able to
use more than one chip select for a single device.  If the controller
hardware manages the chip selects it may not be physically possible for
it to control more than one chip select.

While it's not an issue for the bindings even hardware that can
physically do it is going to need a driver update (in the core for GPIO
stuff) to do so.

--DxORmGk94Y1lYeUm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRj9IACgkQJNaLcl1U
h9ASdQf/ca/l2sFbQii/WohGkZhhQqY8tP78zj73reO3O08IgMatkP91Qg1cm/g4
C9lTmIC/jAtn3id4aXNkli7H7ZJhq8dOfzd+O5T32FIULoAvLJUnyw6roTsncRul
RUooo3/llgKSEX9sZ3w/nfOoyBg49Sj/n6hkxuvIIj33Cys2E8y5JzXiVbEyFCkh
Q9amQxSAa4p+jyDj4zQ1MtY4J58LsepXJkU+E1F/8HuJHieKxChblZKC4LCGwZ2k
UWVdCUxSTg25IpkLJLrjbJBRuwuwJl9ZGTeDj78Sf9OM/x1vbkgKPwk5RVGioKMV
vWkEa2d0/0ioERCpoUjzCYH27X8bxg==
=AYb4
-----END PGP SIGNATURE-----

--DxORmGk94Y1lYeUm--
