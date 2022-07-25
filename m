Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5D558005B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiGYOFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiGYOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE4A6243
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD9C611AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 14:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD17C341C6;
        Mon, 25 Jul 2022 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658757949;
        bh=wHq74HoEAu9/EWdzqXc5E84wFTNprjsr8E+fC3OLjng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWmPs8J3euf80lZkCgOWi8vY6aiWbg14PduksljpcnL8glDODXZ4g+N5f7RAzZ0xd
         kGp+8B9PpZ8EBGkRsVgCs7ecVlhCt4m/de4HeCbkZ6BI80W6tqSPSqHE1qJUTveO/U
         TL9QLN98srS8fK80vhnuFXqhNZRnhqbFFRsZQaSHxwPrGVxbxVpHc0Ut/rxPQgt1Kx
         bV8MQTtC0QLCPD+gDmpy6xqYanjQjQSmJLXelFq5kzWu9BMHkP2g3kadFwMH8SOMUc
         qYgvUNh1uIxJq+y5Ea0Nec+622Hv28dmmIVT5MVYC+jygzwDO+m3o5wyK3/5ytsP2O
         RvfARjM6Wl8aQ==
Date:   Mon, 25 Jul 2022 15:05:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, madvenka@linux.microsoft.com,
        tabba@google.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v5 05/17] arm64: stacktrace: Factor out common unwind()
Message-ID: <Yt6jNK17LWJ8IV4o@sirena.org.uk>
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-6-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XMHcVmXSGernh5QO"
Content-Disposition: inline
In-Reply-To: <20220721055728.718573-6-kaleshsingh@google.com>
X-Cookie: We are not a clone.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMHcVmXSGernh5QO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 20, 2022 at 10:57:16PM -0700, Kalesh Singh wrote:
> Move unwind() to stacktrace/common.h, and as a result
> the kernel unwind_next() to asm/stacktrace.h. This allow
> reusing unwind() in the implementation of the nVHE HYP
> stack unwinder, later in the series.

Reviewed-by: Mark Brown <broonie@kernel.org>

--XMHcVmXSGernh5QO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLeozMACgkQJNaLcl1U
h9AelAf8CN+jflic2RTW4curxqE7B5aE0AKvQRbPZuiX0lCcnOFiF7f897pNSNFy
IozRUQi9IRjVa9vDFgPPBRRHkuFBNhnFnMxl9Gkh1BdyBJsAf8SuapeTFonxIPjh
FCjd7Nq9OcE7oV9bffe4+AyPvlzd6hR49NZUP6ED3hoyFh9P2tTKspVJUE42PLuA
CLFdi0MTHSp4B4KYWSh3TM1RU6bHq6vqRkt03sayLqMct9I0P267iTvTEGUh6Gxa
AHN0CHZ6FMaztObWGtumcqjM6H+o9oD0MeCT537iUwHEzuKKTKivIOtSmljBTqdR
0HfoD/QpY0A9FtKW5SRCCfXWFo5Whw==
=vfZh
-----END PGP SIGNATURE-----

--XMHcVmXSGernh5QO--
