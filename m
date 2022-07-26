Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6CC5815B3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbiGZOtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbiGZOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:49:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B12D1F7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46048CE19A1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FE2C433D6;
        Tue, 26 Jul 2022 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658846950;
        bh=6qe77S7H9yLJcTguoEah7bWjYEDj8Rr8Be/b5etbPYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsYX4Uq4Hm49BLpGwC2L0jCbnphx9BSNKb1oJefNVr103LWLNFo2dJEUpOspPNmR8
         mo0mnGe6xOSqBAP4hmQWMfHjtB+wulW4SvebGSs6OAo5T+OumbOsHNfeWQWI4BngWz
         LNJNU5gsiAH5WXPvmVH3jxR2SLAaZgk5HfglW3X9nhxCCpPtFMeRX4tWbM+G960/Bx
         RQnef+RP5z3YY27ojllPVSKfq/zV8p5KuZ9GS8yQGfEYfP9jtzpb+rfkgOM8QiBwAB
         en/N94oNvsM6VLT9UaARuZwAcxkPMuRoGfgR03fKl2ediKrsArE8/8fziGoG+kFKm5
         SCOwm9X/qVK2Q==
Date:   Tue, 26 Jul 2022 15:49:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, madvenka@linux.microsoft.com,
        tabba@google.com, oliver.upton@linux.dev, will@kernel.org,
        qperret@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v6 06/17] arm64: stacktrace: Add description of
 stacktrace/common.h
Message-ID: <Yt/+3qpSqtntXzpY@sirena.org.uk>
References: <20220726073750.3219117-1-kaleshsingh@google.com>
 <20220726073750.3219117-7-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VvhY7zJe39DOaRz/"
Content-Disposition: inline
In-Reply-To: <20220726073750.3219117-7-kaleshsingh@google.com>
X-Cookie: All rights reserved.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VvhY7zJe39DOaRz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2022 at 12:37:39AM -0700, Kalesh Singh wrote:

> Add brief description on how to use stacktrace/common.h to implement
> a stack unwinder.

Reviewed-by: Mark Brown <broonie@kernel.org>

--VvhY7zJe39DOaRz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLf/t0ACgkQJNaLcl1U
h9Dq9Qf+M8Vw3uujBFIzWTDAk2o46YySw1X4f/3zirbpelSLiA92qxcFQx6PGkJX
DEX9sfHtytc3vnSGvG/Xnsp+AKHSq3l6ON9FYvU3wJRTRPRnkuz4UPHydRipyjsm
eFp3c8+crrbRjcShB8nckslrRtberLCJDMKeVXoN9m0x3dXaBqkaYgiM1NyhCPZa
3YNRCGE0zGsqVxPW3fRCW0SQY2mrpjBZC/sE4Xg805v8hgXqhNb656/EUhSOUC4P
YWixP6TJUIf/hqhckzlebKuYc64LpI07KIsv4hmG7S/T8SxqxGATDQ1Rg3y7ySZ7
Zs/RPpBZPRgr7ZgrOqBKLdMg1QDXLQ==
=AZ9B
-----END PGP SIGNATURE-----

--VvhY7zJe39DOaRz/--
