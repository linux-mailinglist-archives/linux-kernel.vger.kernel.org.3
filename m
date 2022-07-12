Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB6757197C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiGLMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGLMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:10:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BE599EF;
        Tue, 12 Jul 2022 05:10:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81FF0B817DE;
        Tue, 12 Jul 2022 12:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD1C3411C;
        Tue, 12 Jul 2022 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657627854;
        bh=lgyRtw8slZQ2sV7mDz0Kn8deeG1+YLDoRErr4I3aKrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GkzGBi1hxa6OwrnamglljV0O5Qll2+ofRFAPdULGXAlxe9j7g6znKEa2rpnvw3lL2
         PhQzycja8l+YuE5eSJJxshavNrASZerqkCQiL9e//DE45DdzK+y/LiDhzZ3HqrqTAS
         z1zn0aOjVYWBK/oA6hCp/RtNqCqrQLy6Modp5nNmqxSy/cTKselI2LkqNmKi9cK5NL
         9REoBKjenh5eyEi0JPA/6oKBPNMncAEjtnLQgXv4xvVbLI1BS3Nbrngf3gY3Rm5i8L
         arnuRrf1BHe9giV9U7pmpR78TwsJiOKzHhCW+cFtszzC/m1O3yaXJW0gpv0csgojPU
         gCvkh4fcQWP8g==
Date:   Tue, 12 Jul 2022 13:10:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     haibo.chen@nxp.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com
Subject: Re: [PATCH] MAINTAINERS: change the NXP FSPI driver maintainer.
Message-ID: <Ys1kyVPzxWIPSV/o@sirena.org.uk>
References: <20220711160802.4938-1-han.xu@nxp.com>
 <YsxkjTbXkWr/jMzS@sirena.org.uk>
 <20220711215822.7ity2647z2hwecdv@umbrella>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FQJfqEpZTdQmLjKn"
Content-Disposition: inline
In-Reply-To: <20220711215822.7ity2647z2hwecdv@umbrella>
X-Cookie: I like your SNOOPY POSTER!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FQJfqEpZTdQmLjKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 04:58:38PM -0500, Han Xu wrote:
> On 22/07/11 06:57PM, Mark Brown wrote:
> > On Mon, Jul 11, 2022 at 11:08:02AM -0500, Han Xu wrote:
> > > Haibo Chen and me will take over the NXP FSPI driver maintainer role.
> >=20
> > Copying in Ashish just to make sure he's seen this.
>=20
> Ashish doesn't work for NXP any more.

Yeah, I got the bounce - it'd have helped to say something about the why
in the commit log.

--FQJfqEpZTdQmLjKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLNZMgACgkQJNaLcl1U
h9CcHAf+LdJjBmXH8CdKrvcRQUmT5Q7tVrE8fZ2ixhA0bjTHGWWGNbYqPThjYQtk
IKfecuT5Afocc00NOsBks0QTIxIo7Kr6Z9Fz0mlc1D2FbrVUgxbQy9QcCDcrCzJ/
KGDGGEeOd40T1QNiqt798gtx6S+eB2zgS6e44T6bjMxiMZ+NCiwi/on0JwEgSDlU
E/oKaqyH4aSkRRxkYnzGdNEJAvSM1veU2ALYUNAxK7AlINH4l5y0fWx3+e1/8bP9
PbEQJmwFMU/T/E//RSxKwXzb8D53SgzcddG3WiQlzxU9de0O9kAuFryh0JP0NW2P
7dhEBMlwivXUBg4ptdu46EWdkg1+wg==
=9cL2
-----END PGP SIGNATURE-----

--FQJfqEpZTdQmLjKn--
