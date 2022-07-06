Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7155687CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiGFMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGFMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8C2408D;
        Wed,  6 Jul 2022 05:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E6161F31;
        Wed,  6 Jul 2022 12:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6035AC3411C;
        Wed,  6 Jul 2022 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657109392;
        bh=qGwN/Osl4fxpIQQvZpgh3wCz7h3Up/LNCIfiPY3lvlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9f+BFkFSrsHBFx0v8VZqSzNQYlAOXxYuLu1/pIFEq1YuzFxpVyQRQ1aryj2VAHLU
         p0CvDGuSExAcrJc3StcW2DKOB5FfJ1TXLSUWB0oFubdoxktCJa+X7krMUY3sc9Gcx1
         /wKNooJrw4iWvi1xhPHjtLFMtaafmISpi3vuXGS+n9rK1foIEIk563Zx9rSpni/wso
         s0FIe/YIh8MqsyTNpYvwC1AmQ82cModgaAq8kWTBLkxYZD+hRRXEWZLYOTBqWRv2rA
         5nXrEQsDT5IfV0qdUsM+nVNj1cKU6/W4u4gb7Tt6pA+2KMROzoEvOmYty3B32dAZx4
         1UGYdC7iSK29Q==
Date:   Wed, 6 Jul 2022 13:09:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <YsV7jC2eoEx6G3qH@sirena.org.uk>
References: <20220706115529.7deea289@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="196TmJSXXeN3u3L9"
Content-Disposition: inline
In-Reply-To: <20220706115529.7deea289@canb.auug.org.au>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--196TmJSXXeN3u3L9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 06, 2022 at 11:55:29AM +1000, Stephen Rothwell wrote:

> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:

Which toolchain do you use?  I've been using GCC 10 since it seems to be
what Linus is using, anything else I try has tended to get spurious
failures in from his tree.

--196TmJSXXeN3u3L9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLFe4sACgkQJNaLcl1U
h9CCfgf+Mwj55S0OYiY53YIzPMbl3WtAcnQDUXM8MemEx4kCMT51geLasqc67gwE
XiDlL6GKXMC84VBfyyIHV+KXXMop5OlJJPN7zktS8DKH5rBWrWINpaZDEHkBbmYI
h/cKWMQIx9VveKMYmq/gRaQ9/4r4qVEgvtuwQGVtrpIfhnJBrpVUnyHSC67MZwlZ
uTqKJCcNhhNMrqVs8DZlW8BagRMb7U1syMPtPULT5uYuowzQLETnesLApXS9vqtV
wPx52a0dXeodISAWRKyxdLyU0Jlr2HwmNS8rzOMGRpLL/DDr2sHtJaVwz/c8Fywv
u4yg+jRrV8tUBJBQq2bTcTCQrxqBww==
=k4c0
-----END PGP SIGNATURE-----

--196TmJSXXeN3u3L9--
