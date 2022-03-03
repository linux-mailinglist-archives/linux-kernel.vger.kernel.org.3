Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39DF4CC23C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiCCQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiCCQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B45163D59;
        Thu,  3 Mar 2022 08:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CAC260F9A;
        Thu,  3 Mar 2022 16:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7871BC004E1;
        Thu,  3 Mar 2022 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646323481;
        bh=6L8zOZXZctmifksigQVWJGA10UZJrchUv7KfDwywyGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DviB5D6c2tev6CIoUAuuF4k9dryg2aXriin6IA8PAXF+GiaHFWTv0yeVDS7QUTinO
         FY2h6QOExuRxXB6Ka7S9yRaaomEw5brEPvlzGM6Kmbw4+wKaUm6R9HPE6BU7oECN0w
         hCJvttMq3J+FxPfyFRnIdo+IkTul6wv+jhUPI7wvplyhI/J4dNj+JqOnVqI4HTponW
         K/EkQaFc72GfgBZvN4rTGaBbL1O/FMTZ2+jH3y/DcuhicFyiBRwP0lyH9RXDiRQPFO
         fyk5t8fXuQmimEpTHOz8E491CNaHsNoOwpTvmfvCavwhlgCXggheHnElRmsuCjg+KV
         C8VmtrQMmwQYQ==
Date:   Thu, 3 Mar 2022 16:04:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH] dt-bindings: spi: Update NXP Flexspi maintainer details
Message-ID: <YiDnFEcpx5OiNMaj@sirena.org.uk>
References: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uXeOiHaSv6LxWVmE"
Content-Disposition: inline
In-Reply-To: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
X-Cookie: Password:
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uXeOiHaSv6LxWVmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 03, 2022 at 12:59:15AM +0530, Kuldeep Singh wrote:
> Add Han Xu as flexspi maintainer.
> Also, update my email address as previous one is not working anymore.

Han, are you OK with this?

--uXeOiHaSv6LxWVmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIg5xMACgkQJNaLcl1U
h9BEggf/SXdNZCewgPKc5SJn1HsSbGDOcAzaGIchn9ibTXibgA+WjeX3Mxb69n5N
NY5kleQIJGm7hJbS+WYFFaqc/P8s6IU/3SA/2vHCmjUpVZgnBJO9PmHZOmT/8iha
4DQ55rR9cFj6FEU8TR/B+sWa2x2RUszldZAjijLFiiuUHXz7XgIORCgDTSt5VLOq
nXtZwiYcS6yuVj7vEIOCjZCLN9NRonzNIjaSLY7pzdF9R70wpD9UYJ7o+x+bzy2M
6R4Ezj/Yp0CRqv+KYC/FPE9+HwHuLV15mNukIS3UWx29DA3MTjHJZM5PvXkmnD5Z
dsMc9+ys7+2S37DzCMKWS17tAlid1Q==
=mnnK
-----END PGP SIGNATURE-----

--uXeOiHaSv6LxWVmE--
