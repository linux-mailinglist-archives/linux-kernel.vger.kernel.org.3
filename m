Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8557654E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiGOQaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiGOQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:29:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBC63D59A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:29:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA19621FC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF5BC34115;
        Fri, 15 Jul 2022 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657902595;
        bh=b+jtvTOz7oqT34ApAzNVxtGMJmDAMluL+3xOy4XNbdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sFQbcqN+aA4ECw0IOGayRM12VcFpMTk3NRc6xGABBJphOhftRClJt4/lLcNWM6JVY
         oObrPAV6teFFAY/mZBBWOddBr1EbVeOb+8GPLJqoguvW0GvPNc0KS2XTSMqzDiIE5T
         jUXGcURzf4hzjA1iHiZNZomatQbUDBxE9DMPDvifVJjo0dtfVTPaNub+OElB8dLF8K
         2bTNOaNzcvAofgkn7oul+fEo2aaY+rYxYdWrbC6NXGc/fV0MWJJLALBPu1XYuCR/jL
         pkqz4m5zKehuO/kYOAabRCq180Q6zmVQjpFZmdiv4RhcNdPNYY32yXcMBfhgVg/rkp
         dm+E8xWsV5mPA==
Date:   Fri, 15 Jul 2022 17:29:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, madvenka@linux.microsoft.com,
        will@kernel.org, qperret@google.com, tabba@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, mhiramat@kernel.org, ast@kernel.org,
        drjones@redhat.com, wangkefeng.wang@huawei.com, elver@google.com,
        keirf@google.com, yuzenghui@huawei.com, ardb@kernel.org,
        oupton@google.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        android-mm@google.com, kernel-team@android.com
Subject: Re: [PATCH v4 03/18] arm64: stacktrace: Factor out
 unwind_next_common()
Message-ID: <YtGV+uS84iGXiVky@sirena.org.uk>
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-4-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQRAZMV6dDRdJcTB"
Content-Disposition: inline
In-Reply-To: <20220715061027.1612149-4-kaleshsingh@google.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQRAZMV6dDRdJcTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 14, 2022 at 11:10:12PM -0700, Kalesh Singh wrote:
> Move common unwind_next logic to stacktrace/common.h. This allows
> reusing the code in the implementation the nVHE hypervisor stack
> unwinder, later in this series.

Reviewed-by: Mark Brown <broonie@kernel.org>

--hQRAZMV6dDRdJcTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRlfkACgkQJNaLcl1U
h9BRdgf/WGznLdXBmkPr3BXfleflXq0WsgCfJAyd1GcJyuDPbIM6UHY07F4799px
Q+6OmFSTkbsc9IbNxNi3Bse6btyrCn6YDytEiNckAybB+71pDwixovWlcV0SigGA
eG1lzgKp7Xhlte0PdzuIsztVOuKvscn6umieTJxPlkwjZ5Uzxo8ryrJb9tgP3ZE5
C9pDGBg/1Y6+sNCA2FbhRaBQwnkCaU6kK+IhdLN24M/wLRhuDDlbmeL4zXZmpdXB
LGSu2Vmvl8XV0rrw0WeUeLsk9sk2zkJ9OAEjOUI2RMCg4A2DeYnyhdMeJF6NtiCS
9n5x8AkhzEeTXjnfvtHapkHs+hpwAQ==
=BScg
-----END PGP SIGNATURE-----

--hQRAZMV6dDRdJcTB--
