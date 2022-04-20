Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0855088BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378742AbiDTNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352604AbiDTNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:07:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2415A13;
        Wed, 20 Apr 2022 06:04:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E8BB81F0D;
        Wed, 20 Apr 2022 13:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF021C385A1;
        Wed, 20 Apr 2022 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650459869;
        bh=xWASg+ifbn2uVha8nfvnCveQNEqoOf0q74ePOsRwNE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGh9s/mBegJmMEJbl/CbemQQcdqWqduGRlNe8NolJJusCEepEAGhP4EIUYzP/EgAC
         GmuHVNPpK+iY7/laRC1PcOFQ8cpjNFtqmpzHDe3CluEkHLai1DAEMoDTuFedKXwv4n
         02rUGQNbuCh5T+gfrxsgqLHPaWEkhxiINgl1ZtLap/qWGm68arBvMRzcquZsz27pN2
         DcLj2pe6sdgfrFoRCEz59tymcpcqYvFc+3wd7pHxzlVmvsDX1rT78GZyPxJ+vATnrp
         ShoPqO+kiXzVLoocs7Sam6hHnvymZNhWjD4zIoSYhPvjV7aSln8ZYv562U88W/ebiG
         DJeBzBek6avpQ==
Date:   Wed, 20 Apr 2022 14:04:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-mem: check if data buffers are on stack
Message-ID: <YmAE2IVRgPyWxmbn@sirena.org.uk>
References: <20220420102022.3310970-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aiCEfvR0m8oWhfqc"
Content-Disposition: inline
In-Reply-To: <20220420102022.3310970-1-p.yadav@ti.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aiCEfvR0m8oWhfqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 20, 2022 at 03:50:22PM +0530, Pratyush Yadav wrote:
> The buffers passed in the data phase must be DMA-able. Programmers often
> don't realise this requirement and pass in buffers that reside on the
> stack. This can be hard to spot when reviewing code. Reject ops if their
> data buffer is on the stack to avoid this.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>=20
> Changes in v2:
> - Include task_stack.h. It might not get included indirectly on some
>   platforms and can cause build failures.
> - Add a WARN_ON_ONCE() for debuggability.
> - Add Mark's Ack.

Since this is now an isolated patch does that mean whatever meant that I
acked rather than applying this patch has gone in and I can now apply it
directly?

--aiCEfvR0m8oWhfqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgBNcACgkQJNaLcl1U
h9AVUAf/Thouk4ikZ3+sC6mFcLBnUb0rdoYUyN/9GyPZwVx0Bu6Bj3KLvfMdR2HI
+tn5BCsE8epyRgcCG0tiCfD0Mmv/CV68z8GPMnDdQGtvnMVRSKy9VsBhAuzvy68x
e9lQdmScs6JUJezqCJIGHW+ElYAGR8lymrCHbfFsI1/0+WTj6LueWOAR4m4e3F9P
KNkk50p8ulvfQBu++34jUgHOOJF1HktB5DfqpY4UabmP+iUMvm10Cj6WytRZoztG
CcpugWP1yiqoiLjEQQal8tYvLMIWMmSlGPYl2nylVGxGCzf07TZNtk17R1CIGQjN
zMcrx5SUsSY7THkrvpdybENmrvUVow==
=CnG+
-----END PGP SIGNATURE-----

--aiCEfvR0m8oWhfqc--
