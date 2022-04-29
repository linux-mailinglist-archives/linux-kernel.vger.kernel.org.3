Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DF35149C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359472AbiD2Mu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359485AbiD2Muz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:50:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2157C9B74
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881DCB8327D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44F5C385A7;
        Fri, 29 Apr 2022 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651236454;
        bh=l/ZXIC0BCgutI+C22NZVWcDfaMSWrQgzViGseNxj74A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqBY/U2kPgctQjMbW7NYk09e+E6gjTLk27xNt9PBseyjFJEBFaYP693SiHoDnTu13
         CojqRn0cz2h4rZiomocJVYg38i4Ls2QLCIPWtRF5Hqj0AxzWLY27VT2x8jIs04Xroe
         7LIXp6SUXjLUwi2HP6m0Rxf56oZ+SaFA6/wSIFd5YzGjG6Oxi6p2XBPLERnZchCyWS
         BT8wYrRCMWw1TC/c4gtD6gmJKznP7rfbOrUC+Y7xX6tDm+ZKi1omHOhlOfXXYloM2Z
         oaSfy5cXhTzG7Qp/P1VeLqlalcSRjwPmP5i6NJmW5Jsx2JnZmIZjrA+ov1Fz1+tlz0
         1mEumpFxTP/vA==
Date:   Fri, 29 Apr 2022 13:47:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, tabba@google.com, surenb@google.com,
        kernel-team@android.com, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] KVM: arm64: Compile stacktrace.nvhe.o
Message-ID: <YmveXly9117jbWKr@sirena.org.uk>
References: <20220427184716.1949239-1-kaleshsingh@google.com>
 <20220427184716.1949239-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y3YSke25lSrZY+/w"
Content-Disposition: inline
In-Reply-To: <20220427184716.1949239-2-kaleshsingh@google.com>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y3YSke25lSrZY+/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2022 at 11:46:56AM -0700, Kalesh Singh wrote:

> Recompile stack unwinding code for use with the nVHE hypervisor. This is
> a preparatory patch that will allow reusing most of the kernel unwinding
> logic in the nVHE hypervisor.

This is substantially more than just the build change that the changelog
would seem to indicate...  it would I think be clearer to split this up
further with the code changes separated out and explained a bit more.
It's not just recompling the code for nVHE, there's also refactoring to
split out changes that don't apply in nVHE hypervisor like all the task
related code which is needed but not mentioned in the changlog at all.
Possibly a patch or two for the code motion then a separate patch for
the ifdefs and build changes?

I *think* the code is all fine but I'd need to go through it a few more
times to be sure I didn't miss anything.

--Y3YSke25lSrZY+/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJr3l0ACgkQJNaLcl1U
h9DBXAf/cLhAZeKbkJs3LEkvnKGiulU0FIY+O9WBWvNL1mfn2AlN4TJrfv6vBsg9
DvcKZBSqLs1cPow78FoQoKxyhXLW93diLBiFnHQbRSpxTRDJNv5dln5BApd/rX1x
UGKUFo2BXhBdes9xUpXQcnbVp3uLHWA7T3kzsr9yz5idTnhWd+51DLQYLHvJRo/n
byZODs7JPbiSyB/28DKkQy+/gVSj9vP+gOsXDRBNDECWr19FDcbXje2TYWfV6aUK
3COthbPNESl1tPvLfUuDTCjPTOhaKCAkIIXt7uDk5ofr74AHqR2r05Tfz+R0o6SB
OMVfgIypmtPQ2B246uUEOGwDwJAJYQ==
=vcwd
-----END PGP SIGNATURE-----

--Y3YSke25lSrZY+/w--
