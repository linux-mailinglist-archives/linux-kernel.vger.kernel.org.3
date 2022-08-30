Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7A5A60BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiH3K1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiH3K1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A661A07C;
        Tue, 30 Aug 2022 03:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C98614CC;
        Tue, 30 Aug 2022 10:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F40FC433C1;
        Tue, 30 Aug 2022 10:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661855253;
        bh=NzwhEaBJ4IOFNkpz7IFnyFmSrONqw0D+AKDzNV7uN/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNm5r1x0PvLchegLQEwxCiIPruSdG/UMoKKhhCZi8yphv4z0yGEDjOYJaEzknqiOL
         LK/XFJgEnb9waGQAsKmhTpsEE7VobsC2ynAdxk8/EvXPI06MKnyBriQotuh97CJyo/
         NR6/ChInRbVRQbznnE4lzxHGV7NxUZmWWQG2hiO/CHEaL7Ak2mCY5BfFNAf2/IbQSG
         zqcU0mdD0aBrAsXG6dk/jjGPwVbO3G10KhVANqqBZ6ujB8azOx0XDCMMKHPz72L3si
         7TeecoVWs5P0wLPZwjvDSAtvkUojVkBDxFLn7PTUg6OPShZdIdufqgkuqd0yCXCZH1
         iV1k0gcMyOUJg==
Date:   Tue, 30 Aug 2022 11:27:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 3/4] spi: mockup: Add runtime device tree overlay
 interface
Message-ID: <Yw3mE1UX1z/fGSBL@sirena.org.uk>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-4-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wxSWXB32qDsSatsV"
Content-Disposition: inline
In-Reply-To: <20220826144341.532265-4-weiyongjun1@huawei.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wxSWXB32qDsSatsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 02:43:40PM +0000, Wei Yongjun wrote:

> Add a runtime device tree overlay interface for device need dts file.
> With it its possible to use device tree overlays without having to use
> a per-platform overlay manager.

Why would an entirely virtual device like this need to appear in
DT?  DT is supposed to be a hardware description and this clearly
isn't hardware, nor is it something we're providing to a VM.

--wxSWXB32qDsSatsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMN5hMACgkQJNaLcl1U
h9D/Bwf/aef79RHV/G5TkjWiI1kbn0b9uY3uoZKV9xk9eBNMXd13sjvf6WhmtUmz
KCG7q3O7XpyseM6HiReyzkMHaYPxrv7KaO6i8FUJgkhF/TFoe6s+IQXNu5M1pRhp
x+t85j49FlEwb6Z3/pjN0EBibcabsngLlCmDft6H73doof+BQqOVBJbIVyPjBrFd
FNcadq56ZGwYLHAXl/lBL/y1G2Z6eJxkcoXPNaYF9NEraCEgd11rdFkF+vXUy/16
mUR6go79EsBPw37/QeSi3WCkajG8YJG+6/sdM5icdW6yp9w6afsDB5gZpy+eGvCd
JD8Xd1s5I17XCn2fktJDBzjwEs8HCQ==
=aD7p
-----END PGP SIGNATURE-----

--wxSWXB32qDsSatsV--
