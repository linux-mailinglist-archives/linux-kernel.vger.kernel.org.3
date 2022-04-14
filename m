Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F53B500CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiDNMFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbiDNMFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:05:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F5B1DF;
        Thu, 14 Apr 2022 05:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D557DB82930;
        Thu, 14 Apr 2022 12:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B367FC385A8;
        Thu, 14 Apr 2022 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649937762;
        bh=8YmqxUbtiJbDtgg9GE40m6V0ysQjrfb2uFIJyqmLqcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aKValRNE2RLplvHpyVdwwRamA2mKT9aTVateGdX2HoLuZagE+G5FXLXpoloKmXPbc
         KVcuRq8V300NSWnoEGf6cvmsE4BqP1NXaJByx2krhez2MA1Oy7bAm75yZfWB6aBzDC
         hhTt2T3U6iFMcRW8C0KqLm7viGUqoODEvf7GHSHHB70Y4oBfWnXE21MP0EgUdIP12l
         zXMikHwRkRM686lIKdSKRHxDwSm3ecQ8kQUCDJ64PrExOI/5gRyhSpZx9AmsODJr59
         8hzn2ih++hcfstxAffxw1tsagWoKan4Zd9IgQPztZOtsq1V897DYuz9fXnw14X+Dfn
         B3o36TDjK/DLw==
Date:   Thu, 14 Apr 2022 13:02:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Add hwcap for Scalable Matrix Extension
Message-ID: <YlgNW0/ji6KlkyZo@sirena.org.uk>
References: <20220414115544.36204-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+rYMHzJdtMjheiS/"
Content-Disposition: inline
In-Reply-To: <20220414115544.36204-1-tianjia.zhang@linux.alibaba.com>
X-Cookie: Available while quantities last.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+rYMHzJdtMjheiS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 14, 2022 at 07:55:44PM +0800, Tianjia Zhang wrote:

> Allow userspace to detect support for SME (Scalable Matrix Extension)
> by providing a hwcap for it, using the official feature name FEAT_SME,
> declared in ARM DDI 0487H.a specification.

There's already a hwcap for the core feature and all the subfeatures
added as part of the series I've been posting for SME:

   https://lore.kernel.org/linux-arm-kernel/20220408114328.1401034-1-broonie@kernel.org/

Why add something independently, especially given that there is no way
for userspace to do anything constructive with the feature without the
rest of the kernel support?  Any attempt to use SME instructions without
kernel support will trap and generate a SIGILL even if the feature is
present in hardware.

Do you have a system with SME that you're trying to use?  Review/testing
on the current series would be appreciated.

--+rYMHzJdtMjheiS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJYDVoACgkQJNaLcl1U
h9C6fwf/dCBmg/zhXRJuqkE6TkDJhHFIVir86wHs+dD172jNkEN03cI131CuQrlc
rot+y4RI9226F9cCcLAdUmywlicGsMbHujJyKF2C0oG5MoKZ6FuiR4Z3RNymubzE
oE7BQZ7iHR3hHZF1mkH9pYkuUm4by/jnGwurrxN5oUpum1p1+CsyWWPuytdMRfBh
n3vf+v1Su7WvNZCmwOu7geR+JysQnVTOEzgU9VSnkUU2sDLUaADc1LXEvNGl3Wmr
6i8V27uiy3DmzdNH7PU4J7m/Uv3ANOS4K+mkzS0SOkEa0MmvgxIiJtgDQupe6XsG
9B+81gF30PY0rmuIQe2l3iG91D1BPg==
=dqIZ
-----END PGP SIGNATURE-----

--+rYMHzJdtMjheiS/--
