Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9534D03D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiCGQRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiCGQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:17:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA8645AC9;
        Mon,  7 Mar 2022 08:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A45A60BAD;
        Mon,  7 Mar 2022 16:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE714C36AE5;
        Mon,  7 Mar 2022 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646669785;
        bh=8tjddFmERVub+eJeodtYbStmrrQSVt5R8T5mKB/8hxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t7xUG4JaGuaEIgWxfFOunf5ycNgeq7Zdo4Yvt8CDhYQt91/PFY0sE17x7YrnNnYCN
         /1ZTy7VQREK8Tig2yKhrsLU9aE+NbthGUC0KmrQUVFvpHhKvKG+uHWhyhAqZ2xpkyj
         FKbBIMOePuBO0thU4zG9Fk4BvRWQRrDydLJkqA3ZmvzHlQ+2Wz3SjgF5XcmnLavP53
         CFyAmzGCxwXxasc85l334HJTdkxByQVj3Qc7OlfWXyshcfqKhD2Zoc0b2MZ8InLQ/s
         Ed7TpFuOFBWnPjBqnzHAeEdObsuNTJUL3YIGJjSgcNmFVwoV2r1QhLqlaFgXUOcsG7
         IthLpKFApUKZg==
Date:   Mon, 7 Mar 2022 16:16:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alifer Moraes <alifer.m@variscite.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, eran.m@variscite.com,
        festevam@gmail.com, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        patches@opensource.cirrus.com, perex@perex.cz,
        pierluigi.p@variscite.com, robh+dt@kernel.org,
        shengjiu.wang@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Re: [PATCH 3/4] ASoC: wm8904: extend device tree support
Message-ID: <YiYv08yef4eIbAXz@sirena.org.uk>
References: <20220307141041.27538-1-alifer.m@variscite.com>
 <20220307141041.27538-3-alifer.m@variscite.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9yotZ5uYT3fHlEJd"
Content-Disposition: inline
In-Reply-To: <20220307141041.27538-3-alifer.m@variscite.com>
X-Cookie: Whatever became of eternal truth?
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9yotZ5uYT3fHlEJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 07, 2022 at 11:10:40AM -0300, Alifer Moraes wrote:

> +  - num-drc-cfgs: Number of available DRC modes from drc-cfg-regs property
> +
> +  - drc-cfg-regs: Default registers value for R40/41/42/43 (DRC)
> +    The list must be (4 x num-drc-cfgs) entries long.
> +    If absent or incomplete, DRC is disabled.

What is the purpose of having num-drc-cfgs?  We can tell how large
drc-cfg-regs is so it just seems redundant.

> +  - num-retune-mobile-cfgs: Number of retune modes available from
> +    retune-mobile-cfg-regs property

Same here.

--9yotZ5uYT3fHlEJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmImL9IACgkQJNaLcl1U
h9D0nQf/e94yrWlNJbnJEWkZM5yQ9NWqCSnHkn9vGfNqeP08qmHuPx5rKMPsJlQE
U3iaSMsrPstH1JbpQM4gp9uh+Fg6VvM5/qWyJo1MgSaaMV90p9JUzhnyWGx4JiHq
/i7xUGfwLOBdC3jP7IxCeDnXlTfgdp/4XgTTzjlS1iOnQbnFUCV1LBCFf4KF02/5
F74oQX80r26mdT9BlqXSM9FpuiVJq3E7Ckzo6ilYR1u5C8MCtzZmR0LGnb3mihWs
f46WBAlRgZqIWd56ISFJlOyCuM8oXNikquhN20NGRraagoxbvQQeC7zvBIDAMuZE
YK+1RvyQrlT86QdGrRg9lBdvKY+14w==
=gOHh
-----END PGP SIGNATURE-----

--9yotZ5uYT3fHlEJd--
