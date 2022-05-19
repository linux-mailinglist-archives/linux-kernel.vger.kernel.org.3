Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD40152DB75
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiESRkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiESRkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A26A30A2;
        Thu, 19 May 2022 10:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D58FE618BF;
        Thu, 19 May 2022 17:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FE1C385AA;
        Thu, 19 May 2022 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652982015;
        bh=i/bU0bfDloHPKyvRxaGvTgWbXFe6z6JQWAGN/Vhk5Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYCOpnXonTOfbFrdBJXmWTXnceJ1NnUiYoMMrqYMLyx6p0mcgHx+HL0vo0uj3chWc
         QHUAhqTuYbHGquSQEmorV6HW2ryh0cafLQyNUV/izbDSihgLlTHn1+FWINl0lM9K+E
         4DPCncvaZ1Ms5uHtVp/0kLGnyG7V/SJG8i9+d3Qt3wppTRRfR8qhQ9ckQswZzx0xwU
         bbKS5eTxGO6XzSMXCF9PurXELsoX/kMEtfIgXXFx5Nts3sFnUTGSWtPUyMTtPK7Kjg
         8zIq61piE8HgJ8G290KIDTFO89v2Cm4OW9uejsaNwydpYHlvfP6zvetlhxO1Hhvx8p
         ik2i5vAvRAUXA==
Date:   Thu, 19 May 2022 18:40:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sameer Pujar <spujar@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, perex@perex.cz,
        tiwai@suse.com, jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] ASoC: tegra: Add binding doc for OPE module
Message-ID: <YoaA9ob5CRxyA+fD@sirena.org.uk>
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
 <1652895372-29885-2-git-send-email-spujar@nvidia.com>
 <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjIce6nHQZ0dcLVK"
Content-Disposition: inline
In-Reply-To: <049173a1-0fa6-510b-9169-ebe869b8a3b3@linaro.org>
X-Cookie: Some restrictions may apply.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjIce6nHQZ0dcLVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 19, 2022 at 01:40:54PM +0200, Krzysztof Kozlowski wrote:
> On 18/05/2022 19:36, Sameer Pujar wrote:

> > +title: Tegra210 MBDRC Device Tree Bindings

> s/Device Tree Bindings//

> and then you have enough space to de-acronym this MBDRC.

I suspect people rarely expand the acronym when referring to this device
so it's probably clearer the way it is.

--xjIce6nHQZ0dcLVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKGgPUACgkQJNaLcl1U
h9CIUQf+J47qRJ1T/hXpo2PrxjE+DAy/H24LMvtJ0gv6tuwLslEqSPmvNnX5AQ8H
XredwBG+ouBdkkVKEx+kVbnClXuFSrGX3YxzBTxcHsbOXUGgvIbYSoKaDloX+N1H
v1nVvsh1/6viUNyeS8W8sRjQtDSP8mE3GtyWnoTt59Xmrg39ub/QekuPfNBOeXaR
/uyMAFxZKmLaM+VnQKHXHXJgdeRbwWXjnZNTnz8ncGcs/Augj/dJoaHRaOArirDw
2kWSvFv/hxoJWI0tKtq6F2uI1Dk2CODyHCaDcyEuclATNmqH48SVFqwVyBDxA639
6WOmhU7cAmme7vmLkJ+Q3NhA8Gd5Cg==
=T8z4
-----END PGP SIGNATURE-----

--xjIce6nHQZ0dcLVK--
