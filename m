Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225874F472A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbiDEVCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444548AbiDEPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD03F8ED9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8908B81DD4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAD1C385A0;
        Tue,  5 Apr 2022 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649167542;
        bh=mLvsbHYwNiYZf89pICUm4u8OqvidTl/bGcsttyjqxKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3W3tyKRMH8dJXSiDyRLgs0ecSok+iTVounw+M+iMZl5VAUpyhvOW2/EAz8x3a9Ph
         lWzhVwrzDy/c3m654NWOv+TTLRUbDmI7Swc/CAkBoJy/n4lZDOzcvEzhhz4+bZATVP
         qR4Rho0i/6gG6prDeDm9JBXLfwCj81WXqKT5u0oOaOWSI63wqmmS0wgt5whfhXk1eV
         HP52xl2pYElxpdnJtQjRxC3DALbm1B+QmK+E7SnULuuO0dihly3gJdv7HBI3TD1TxX
         e9CINfLnp0koNqO3CCRKls2+8OSSvKwORDpDAk8vvgrg0kQDsj1tunZJc1IOm+ENPQ
         gvZIsxDu38M5w==
Date:   Tue, 5 Apr 2022 15:05:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] drivers/spi: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <YkxMsbRidcGaNHEl@sirena.org.uk>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-6-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sDUXE/n0DhecXB+p"
Content-Disposition: inline
In-Reply-To: <20220405135758.774016-6-catalin.marinas@arm.com>
X-Cookie: diplomacy, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sDUXE/n0DhecXB+p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2022 at 02:57:53PM +0100, Catalin Marinas wrote:
> ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
> alignment.

Acked-by: Mark Brown <broonie@kernel.org>

--sDUXE/n0DhecXB+p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJMTLAACgkQJNaLcl1U
h9CZywf8DvQ9It3zlTp1923Nk+sjayiHtSyj0NUz7v2SeU+qBDaEc6uiEV4m62om
zJ9ZCXULrZCyR8xGlxKJbcY855QVISvit0bVDXHkfh9ui7FstXphjBsPNtEkJPoi
FM8HmdCCIAT1xWWpFQlC5lIoD127dGaP1mHimjeG/AzLxDGLDaj034XJ5UxyZZa3
BXVXC3h0/INjNHcvkYLDKFOV6/K6GmFp+z8p4oAbbwjbxPbYkRli+AvpZHesm+Gj
//rAXzhnd2CRcbF2gJG9peLrLMfYvYBDxIIije9GMxfHi7sZfR+soUBjfriN5BgT
jgsXumz/fY4fChAJH/ph3U1YIC1f6Q==
=lFIn
-----END PGP SIGNATURE-----

--sDUXE/n0DhecXB+p--
