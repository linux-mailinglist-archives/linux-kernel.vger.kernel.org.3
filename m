Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA45558919C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbiHCRkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbiHCRkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:40:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4BF03;
        Wed,  3 Aug 2022 10:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1BB1CE2412;
        Wed,  3 Aug 2022 17:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AF4C433D6;
        Wed,  3 Aug 2022 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659548409;
        bh=xi7sXuEFe3u+/S4uAzEU87tLshUsu0UZUIQfM21EItE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZFc5ep3XmbXLmXFBY0JcTP/fXQ3YHNw+IjW2KNOG1Ty4DVyP+ADiRODy4eQh84mO
         dHnJHkkFznq4+99q7cyrZOe4hOVc+bRiHyAe8HeHM2X19S3kZiZWfj6zqaRwfz+jQW
         G/Xs6acONhYGIhoqXQ5xC5y3RrM0MWSXZ4zAr/1kcykNHg5k5AKEIiRUfpaPPX/Jnb
         LXs4Lmfrc1St0CdjXkTkyfqVsgnBEDM9kXMF1aTeNZBO+G90utLDeZxcshxLIRu98L
         0fs8Gi7YSUeCqVWZMtrllMb12omHd1yJmKYPtwIrnZq7g722a721ulwcgemJtOIADX
         UJ0vO3G8z+Ogg==
Date:   Wed, 3 Aug 2022 18:40:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeegar Lakhani <jeegar.lakhani@sifive.com>
Subject: Re: [PATCH 01/11] spi: dw: define capability for enhanced spi
Message-ID: <Yuqy8wJyHASPdIBG@sirena.org.uk>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-2-sudip.mukherjee@sifive.com>
 <YulxX3Zo168cWhwP@sirena.org.uk>
 <CAHyZL-dA+mFW6Jcvpds69f-9iJf6nk7PCpO6S2Au+ugSZMgisw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jZMkXTlYS07CDysu"
Content-Disposition: inline
In-Reply-To: <CAHyZL-dA+mFW6Jcvpds69f-9iJf6nk7PCpO6S2Au+ugSZMgisw@mail.gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jZMkXTlYS07CDysu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 03, 2022 at 06:34:53PM +0100, Sudip Mukherjee wrote:
> On Tue, Aug 2, 2022 at 7:48 PM Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Aug 02, 2022 at 06:57:45PM +0100, Sudip Mukherjee wrote:

> > > +#define DW_SPI_CAP_EXT_SPI           BIT(2)

> > This isn't at all descriptive, it'd be better to have a capability bit
> > for the various multi-line data modes (or possibly individual bits for
> > them, though board setup will stop us using things that aren't supported
> > in a given design anyway so it's a bit redundant) - that'd be a lot
> > clearer and avoid confusion further down the line when some other
> > feature gets added.

> Do you mean to add separate capability bit like:
> DW_SPI_CAP_DUAL_SPI
> DW_SPI_CAP_QUAD_SPI and
> DW_SPI_CAP_OCTAL_SPI ?

Either that or some rolled together capability with an at least somewhat
descriptive name.

--jZMkXTlYS07CDysu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLqsvIACgkQJNaLcl1U
h9DprQf/XGCUL1mxeHLklmE3hgniURrGWqNZYSIf6026+k1AkgHvDbsJr3quML+K
s+H33prL2d4toIr5ZhZJeA0jll+G2v4WAp7hCCsRGBMhb2tY19Edgm7zZphukyPG
P53vdY41sOL1WFjhQCXmV+vSCs2Qg6bUQJlHo9+VKySbw0xIcllzJg9ntdWiI+qA
WYUMInBgHwzRO0JP48FKyL9/5fMTdDLFPTKgqcjrRySUb3tqjQgFWan+BvxppV6N
9smJiCSytcYfGQe7W5Ez0VjLmchdWA+p46NzDbzqluw+TnQDkFWYG3cTtkPOEJ6d
tdHO5maeeA3V83N5WlLrwiurXMudow==
=8Pn4
-----END PGP SIGNATURE-----

--jZMkXTlYS07CDysu--
