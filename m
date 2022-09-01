Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F325A9900
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiIANgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiIANfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:35:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801766262;
        Thu,  1 Sep 2022 06:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C163B82622;
        Thu,  1 Sep 2022 13:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533DAC433D6;
        Thu,  1 Sep 2022 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662039221;
        bh=X05rer4E7Vrs6fmpGuILpb3YeS1Pl/B7CuPAsThsJlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvCWq4/PpnS3BKsuQFnijcM2qQ5+1M5XiW6pL9G3Vg+nvaO+1kHPoQVxWgP3QJ6Dc
         tQ6HM6XZJFK+PyMRcF2yD2iN0WlHErtq8WOfKdqyhro9q85xHzfcq5hCli0t4Z5BY+
         03xcPvl11GtoEUO93ND6OYfZFkB9B2n9KCMWEl5mpRwA7sYLQBy0xYMaw8fS2geWgF
         GrNDWp7dfqO3JiquEDNxcJUOum5sM6ILnLIgC6hmHksm0kqKo69Ht9KHWxW/LLBIZP
         8bSM7HgwPDCxu3rbHXbdmPkYItCiqDVGg7AGFyrTQ/OVowZqioRr9aAYp79CP3u9hY
         bFuD+EGigh0LQ==
Date:   Thu, 1 Sep 2022 14:33:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        leo.yan@linaro.org, john.garry@huawei.com, catalin.marinas@arm.com,
        will@kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm64/sve: Add Perf extensions documentation
Message-ID: <YxC0r6RCffBXXllT@sirena.org.uk>
References: <20220901132658.1024635-1-james.clark@arm.com>
 <20220901132658.1024635-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1A0ScQ3wnA1aHvzl"
Content-Disposition: inline
In-Reply-To: <20220901132658.1024635-3-james.clark@arm.com>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1A0ScQ3wnA1aHvzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 01, 2022 at 02:26:58PM +0100, James Clark wrote:

> Document that the VG register is available in Perf samples

Reviewed-by: Mark Brown <broonie@kernel.org>

--1A0ScQ3wnA1aHvzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQtK8ACgkQJNaLcl1U
h9BVKgf/eYlwFhdS4iCAem8v1b27aPMGcA20gbkv0QPE1EOEANQSFXHqASc892k2
HILdKyxxXbwDdeEySiiVquI1vYeZPTlRp7uoj3ZkxvwfLIJFoT4yuLOBf6Nz8Pwi
pgG9hnHG94O8dvJp46fxyawg0OJC28OGhO2SziYNRW4HDLKvMdQcnOhWi7+G4g3Y
/XjjtzafhmqW6L2Su0kc5+Gqoyt3PdLVp2boeZLpp0DMoJd7XSITOO/1VQWN4RJF
kwq+n9oZFQF7sDZo/RdbB7BnYTTifNruOqTj5saKwPUEn2hOOocvtjPF62jyQ584
PS/n+8PfRLuqK3vqsdpHjIu+cENLGw==
=S2Mp
-----END PGP SIGNATURE-----

--1A0ScQ3wnA1aHvzl--
