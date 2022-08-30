Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE195A6C00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiH3SVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiH3SVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504F17050;
        Tue, 30 Aug 2022 11:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E4F615F3;
        Tue, 30 Aug 2022 18:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F0AC433C1;
        Tue, 30 Aug 2022 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661883696;
        bh=hEcJQgeqsw3y9ftigfqvc55T9IiJXbNXceyR/L9Nq0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loFc3EhNodztGhZZnDSkOIIofEmmsyLTZ+gj6nyBikvbzRCuWpufEA1qJcpzlg0Mf
         W0IO+ZQLmFvFUWTUURFsgj59PGoMOX5mKMbjR1t9FvxLoj1WnJ//jwsTD3Lxa2SM5I
         AHiyGZSN8pAiUS0Zqfv8BVig7hMh2pMDsN44huYkvSpB9CDfN2kh9pawD9IsrYioTl
         A6/u/S7Z+kylHW2/uS4TygaLKU2+fGMT6yeD36wofmDyWcnWmzixcMF9ddJMIZRBXl
         m+tE8zc2tERLx8tpZrdsaO1k6PGA7mzTpXmAT6FYWrd9Sb/w1rm9U+IZObS6zk2Sfr
         f5MLNiqCg3f4g==
Date:   Tue, 30 Aug 2022 19:21:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH -next 4/4] spi: mockup: Add documentation
Message-ID: <Yw5VL2MsJ4L6vLRF@sirena.org.uk>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-5-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TvtZemuiz5sCf+Us"
Content-Disposition: inline
In-Reply-To: <20220826144341.532265-5-weiyongjun1@huawei.com>
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


--TvtZemuiz5sCf+Us
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 02:43:41PM +0000, Wei Yongjun wrote:

> +The typical use-case is like this:
> +        1. load this module
> +        2. use bpftool to load BPF program
> +        3. load the target chip driver module

This needs to go into a bit more detail on how one is expected to
obtain a copy of bpftool I think (or point to some good
documentation, I can't seem to find any in tree right now),
things may have changed since the last time I looked into this
but in the past the userspace tooling for BPF had some extremely
ambitious build dependencies which would be a fairly substantial
barrier to entry.

> +Compile your copy of the kernel source. Make sure to configure the spi-mockup
> +and the target chip driver as a module. Prepare a dts described the spi-mockup
> +device.

As I said in another mail the DT part of this appears to be
inappropriate, the driver should just allow the creation of
virtual devices.

--TvtZemuiz5sCf+Us
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMOVS4ACgkQJNaLcl1U
h9Cq6wf9GYh8XeiXuu/caGDq8OMy5MOOjg5WDignKSUxW2jhdMl45BWR9uCfHO/C
oGs5x4l1eLMq9NQ2Z7tOCf78/7XEMwjQ1dBySk89/MvkL2L6fsWOXc44jvkvygR3
rFMJrxDLDW114l7IsLebsctZ2Na7nbjt1tz+ZyfpMF05grdcR1G/ygU/eiJQ4cP5
Mn2vMw34d+UfEMC15ZMzTDfKusk/Z+VbBhBSyDJVROpgNoLAVHPGXnqUfqkuT+s8
z1bGuvyop0hN/e0STh7Ssws0g8bVgBblXGd/Dwr2RYkBMepZVE5gmyIHOfN68g4N
RQfBF/0jr82w58GLL56bT+cjhDzD2Q==
=4dZD
-----END PGP SIGNATURE-----

--TvtZemuiz5sCf+Us--
