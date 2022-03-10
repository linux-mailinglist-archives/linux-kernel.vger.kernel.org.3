Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4C4D4696
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 13:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiCJMP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 07:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbiCJMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:15:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C69B0A4E;
        Thu, 10 Mar 2022 04:14:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E796B825C0;
        Thu, 10 Mar 2022 12:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54F1C340E8;
        Thu, 10 Mar 2022 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646914495;
        bh=B6BrRQD3ZTTLbmmHSlvJm/hOeyFv+SySQaOcK/p+kto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBdaUjWDopJugOHDSHQS0/gLeNX6iShEkyeRrTN6idhfqrrf/4Lom26b565uxuFU8
         drmFj+B211vVjteVkgHqymrn5FnhkZIqMlesjNTrjZkAzFM9LbFP00HmZ81DfwXN+R
         ZdqftweNwRlKpmsiwcORKRhgFWGP0omGhHdYz9xRUyZuD03AK+jN9/xnrzIypixgSa
         tYfRyyyi1Yp0FeM8F3r8CTdUeocxMJUV7w0Skys7hTAVhHcilZfIiAN92HaLBDMJpx
         GCBVGJt4xmSTYq6RRTbdlWoZFtACaMGBJLHavIthcXSRU9oMCY5FTmFxfXQULe3rcT
         qEpvUTM4cLyLA==
Date:   Thu, 10 Mar 2022 12:14:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        oder_chiou@realtek.com, robh@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] ASoC: rt5659: Expose internal clock relationships
Message-ID: <YinruZXrpP2bu7lZ@sirena.org.uk>
References: <1646912477-3160-1-git-send-email-spujar@nvidia.com>
 <1646912477-3160-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RbIkZj8XkghnrROK"
Content-Disposition: inline
In-Reply-To: <1646912477-3160-3-git-send-email-spujar@nvidia.com>
X-Cookie: Package sold by weight, not volume.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RbIkZj8XkghnrROK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 05:11:16PM +0530, Sameer Pujar wrote:

> This patch uses standard clock bindings to establish the codec clock
> relationships. Specific configurations can be applied by DT bindings
> from codec device node. The codec driver registers PLL and MUX clocks
> to provide this flexibility.

Doesn't this need a binding document update to document what clocks are
being provided?

--RbIkZj8XkghnrROK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIp67gACgkQJNaLcl1U
h9DL+wf3Z3U8/29vdxWuirNmVvUzPVbbp55Sdn8XMw7blcG1nwBhdFeefVRwHTAz
T6Y0it7q8AhBNOx0SteVUUR+CHQAmo2whuYT2mIRj+c/OQKeESYE5Yid3TJ97XQD
hXh7RoVAZ997G1keyCmJtjXo1wTp/A9zP/Dc+QCfTZ/N1IFNmZN5AXm278Qd3kh0
4gRJefyPTzk4hPYkeYRlI91wssEKgqNjVgX2nxg7JoFTrZ9NDgU6Dw+67yqgRyiO
I1pmyEQ+DQPXUUfkylHlaWmvf6DMxX9mX3TXeKAVOC03FofPnxsM2TIOwIsZoFgb
0cinj4IIRsNnoeIcnRBroMkH/FHy
=Uftl
-----END PGP SIGNATURE-----

--RbIkZj8XkghnrROK--
