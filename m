Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D594EAC58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiC2Lcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiC2Lcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D7F249896;
        Tue, 29 Mar 2022 04:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6F36134B;
        Tue, 29 Mar 2022 11:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA21AC34110;
        Tue, 29 Mar 2022 11:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648553463;
        bh=8IHBVA335z9+DxgSxrKjPerzpnuiiqAmIHJNv8kPlSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZoDhW9pWmYzO+WzHTZU6h9Ok7BIRygXS8CudgpT71Js+3AMoH6VpCVc8WvaPOA2JK
         qmjac818e0PUO6WhvFmNDP23JPWHAIiGEqZOX65jxllqSjRAByDImGWjTgrEx9ymTC
         F3pY3fhvrYyUuIKh9k+vSvIRky2HM7Hlo7a4EO00Q3MhZVI4jwHDicX1t6tFdse9OY
         szBgb5laDXTdZDUrSHtFBpmOcBaS9hBqiURtywywJ60ITAYjfRW6m7HcYkoiJHPMtE
         Rk1z5aBRMXqSh+Fb8Y8LRiz1BlvtyedctdsMR56CscAu59+rtsmFZAXCijMZIVqvdb
         wmfKt3c2OvrvQ==
Date:   Tue, 29 Mar 2022 12:30:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, thierry.reding@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        jonathanh@nvidia.com, catalin.marinas@arm.com, will@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/6] ASoC: tegra: Add Tegra186 based ASRC driver
Message-ID: <YkLt8U5MnG+0gFxl@sirena.org.uk>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
 <1648447526-14523-3-git-send-email-spujar@nvidia.com>
 <YkHX3/8BbXo4obWI@sirena.org.uk>
 <4e8bd876-48ed-8fd8-7b7b-989b45b54f1e@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V7EwDDVgYNffjf6e"
Content-Disposition: inline
In-Reply-To: <4e8bd876-48ed-8fd8-7b7b-989b45b54f1e@nvidia.com>
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


--V7EwDDVgYNffjf6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2022 at 02:02:34PM +0530, Sameer Pujar wrote:
> On 28-03-2022 21:14, Mark Brown wrote:
> > On Mon, Mar 28, 2022 at 11:35:22AM +0530, Sameer Pujar wrote:

> > > +	/* Source of ratio provider */
> > > +	SOC_ENUM_EXT("Ratio1 Source", src_select1,
> > > +		     tegra186_asrc_get_ratio_source,
> > > +		     tegra186_asrc_put_ratio_source),

> > ...the sources?  Or does it need to be configured before either side is
> > ready in which case this might be the best we can do for now.

> The ratio needs to be updated before start of the stream and this
> programming via controls is required only when the ratio source is SW.
> When ratio detector module is used (support is not yet added), the
> ratio is automatically updated by HW.

OK, that's not ideal but should be fine for now.  Ideally we'd have the
rate detector support introduced in the same release.

--V7EwDDVgYNffjf6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJC7fAACgkQJNaLcl1U
h9ANSAf+IOqA/07bEMbKWE9/DpOYo8OUux8tdLQWz4Ll7egQt8NHkvEo388AqOTH
t/y6I6zjXwXkALN/IguSFatfz11OkdNuL454wozODL795TEtdJQKTbPuTIM+NGWZ
i4tqNr/nXk9jWWBeeSK7esZIS+a3c/W6e2b54XH1+P7nCYAJoMNW0RtKWIvXWBa/
lzZACNRH6kojanb4bC/BZMIuOVoqOWxFWC5j6dVdO24Z0OWHkPZ11FN+8dp+f3nY
YkvXv2WyEsg2syC6OzZVBn/BQcWgc3p+Yks54AEsNyUdHfyefggOAQ/R3Rj4oZp/
njbYdmDQ1gNUsMD9M3IX0xhoEGkbtQ==
=dnPU
-----END PGP SIGNATURE-----

--V7EwDDVgYNffjf6e--
