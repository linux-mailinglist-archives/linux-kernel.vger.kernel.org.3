Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9CC58265C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiG0MZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiG0MYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0F4BD3F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9544D60E92
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 12:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFED2C433C1;
        Wed, 27 Jul 2022 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658924682;
        bh=tgr9vu7Qy97JGQaPLpU0cHT1c8Wg6XMcuOwhabrCXSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXVn3/nVa5nuG9VUzpC907NJhkP4zVnx5/WGNkSjNJpLmss/EYIT1wZsgUZJNAH2T
         6ydUtcOsBowfO2mak9A6RgzwUl0ZvZ0QhmbOBxK5ftGO0BjJbWWQUKMjYsEFMsUZgD
         6r9J89gLwhu1KO2kVXKxpuv0+5HVqpNGCG0JVX67mQE7zA0zjISkgKYNV1b27sPloA
         QzLk1gq0GVwk63/bruLaQquVhJxSHHjfs5hx+LvPkM3ntWu7HUFp0BAlL9YdTng8RX
         fIs7RkeCx9JA3cxRQOVVXG+/nBhTauq8QcmkA/RzltP55vMpWZsQx7FtoX5BNy7azK
         c86LK7x7+KhMQ==
Date:   Wed, 27 Jul 2022 13:24:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH RFC] regulator: mt6380: Fix unused array warning
Message-ID: <YuEug/OV9H0DKnmZ@sirena.org.uk>
References: <20220727132637.76d6073f@endymion.delvare>
 <YuEpGTD/DbC1T9Z0@sirena.org.uk>
 <20220727140809.0951b72d@endymion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IrK3sxxWYqfC4Njx"
Content-Disposition: inline
In-Reply-To: <20220727140809.0951b72d@endymion.delvare>
X-Cookie: No motorized vehicles allowed.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrK3sxxWYqfC4Njx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2022 at 02:08:09PM +0200, Jean Delvare wrote:
> On Wed, 27 Jul 2022 13:01:29 +0100, Mark Brown wrote:

> > It's helpful to keep the build coverage high.

> OF does not depend on the architecture, anyone can enable it. So I
> can't see any problem of coverage with making drivers depend on OF.

It still reduces a barrier to entry.  It's also that it's easier to just
prefer the conditional compilation pattern rather than either check to
see which cases is needed or have people copy an example that doesn't
use it when they should.

--IrK3sxxWYqfC4Njx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLhLoMACgkQJNaLcl1U
h9CtWAf/WXQJMmNCCRSTl7w68FGnmuXW/Q96sMMgLKKFdJpsEV2dQ4xz2rK+Tf2P
aluA40nhXCF/2fZGiKjhE1fmQR9UCrPvvO2mOr9DYarsuxKPo89nH8eNxXpseF78
5PIjBIv5DhM4mMD+4utbceGm4uSK3BdCEU9k6jRJ3fQHPlZiS0YT/rUQG3UH+grs
5n+w29BGDEZmbsJoc0/+utzjt68ysKgZNetC5F72J2YLB1geS7gsLVDNP6NjcDw5
TlDcRUSgYSc60XPe7L+LfwNCU/LPm2H7NvV4c7PV6gYY1eBd5Wef1avp6ZT/Bqyt
n7k2aPvx+9ZGoUxXgLPwAOV4TZxv0A==
=Elcv
-----END PGP SIGNATURE-----

--IrK3sxxWYqfC4Njx--
