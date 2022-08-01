Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397175867FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiHALPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiHALPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36141CE25
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F2060C24
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E3C433C1;
        Mon,  1 Aug 2022 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659352522;
        bh=Ir7MX8zgwtyV8QO9JWew7x+i5RBi3lcDrkhFzja7Kaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asjieE3y0N7OSZlRWKdh0AfmKg+qYFm+4t1flF9OR2lppfL8jx48V2NdpTQjIjBR3
         l+DpX5ONcAc26Fg70uSGQT3y0i6EH94crbx4AaO8E9lNERJ90AO6m+NSOAecTu3/XP
         nLvi9z1alc6k2wHtLnjfIk7TT/6Z9l0d9aJKwwoGDa+ZJX0+l+CT9Rqhq7J2aw+sCA
         wgwFRYrwzXdKZLDNu+lW8EaVF3QTdz3M8noPoMGeugqRr5oJ/N7prIhANpjZNfRaiJ
         kMXsq6XFzWDNwjmseDi6iPHG+fNjMAWzsOu+qNmjIJkYRHpGN9XsvG0cehXp2vcMDT
         gfmTLpHr0C+lw==
Date:   Mon, 1 Aug 2022 12:15:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com, kevin-lu@ti.com
Subject: Re: [PATCH v1 0/1]
Message-ID: <Yue1xaX7UhSR6jGW@sirena.org.uk>
References: <20220801025939.2343-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oDBfGM6p6jSuf12z"
Content-Disposition: inline
In-Reply-To: <20220801025939.2343-1-luminlong@139.com>
X-Cookie: Dieters live life in the fasting lane.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oDBfGM6p6jSuf12z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2022 at 10:59:38AM +0800, Kevin Lu wrote:
> *** BLURB HERE ***
>=20
> Kevin Lu (1):
>   Add a new kcontrol for phase calib, remove unnecessary header file,
>     make code more comply with linux coding style

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--oDBfGM6p6jSuf12z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLntcUACgkQJNaLcl1U
h9DtaAf9FgQkEWECKCuz40o6NjXZOC5eZgszuU02NrpB6HzrzlaIHxv3BDOdJ/vz
4VmaOyWEioJo4q+1b80AqUbSKJjMBclutYkE3RpSHtqiEGtZcQ4pcnRNK4dofvtD
eJBXmX/USxiaOkChrLNUaGz1HCFzdF+9K7mYsWIUMQtHjnmuMphOizpViEYI59Yv
9sbNuvQ8BYPyR4pWbDjqstho+LgRP+fV+XIbZbXRfhbhUZIwS1IV7iKucxxZTGaw
DfNDqTds7mDutI2p47ImUUvJz7gZeBxIbll91YtzBIm9XGS+qV18a8OESeIroWH+
Zz/QMPUfOA6Dp9YI3uF256IWgr/MzQ==
=uj8Q
-----END PGP SIGNATURE-----

--oDBfGM6p6jSuf12z--
