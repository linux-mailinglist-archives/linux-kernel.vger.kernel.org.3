Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546EE4AC9FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiBGT43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241619AbiBGT4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:56:07 -0500
X-Greylist: delayed 439 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 11:56:00 PST
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B829C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:56:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0B5BA32021EF;
        Mon,  7 Feb 2022 14:48:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Feb 2022 14:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=qdPXUDXW0aWei852djVIbEVF7fBHoOacUefmwT
        P0fCc=; b=bi/WHUxYvVRZjQyTlknYCHJeQMVWYxRb/Q7v1d5jNgl8PMPLZnN+oK
        PZHcJZB0W+rJlmgOXXrZKZSGHgvSWDrSGJg7LwTjpMnvqpsu4HF+qpe5YGpgf+YU
        vU4vId0T+Tu7hrix4zNsThBb0a1AqOZxHGqDW68tZOP0jM41SMikxS0ROl7KG/0m
        DcFVYlpo4012Zk3GrYh3QYmMkaTqI0+M15x1IaX+YyJzikP3+rNTCAbEtlI/SDSS
        RdVte8p3PWRvw4wdMaiPjA2MrPLgTtrRwZRR2wSWmV4hzPz9Ld5NmEGSPfo4lrpm
        g5TKMyWJT2axAIMQpiJ2nnzZvGoXjmPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qdPXUDXW0aWei852d
        jVIbEVF7fBHoOacUefmwTP0fCc=; b=X8oxJSUyDYqjyPsclY8hXODNNK7GNG/j8
        8uwEFOkjA/bFxuwIoLsmJmeHOjGijvMYDe4Qtqy62H/yDAL452HA8WNVPj+MnBJM
        willU6XxPgsm2wvF2z731SkDXnJZtUaMKLxPvkI2yFBChBdUhPjvipnPPLqgEFqy
        P+EYmx112jHIILKtFWt6uTwdrNaFWL2Lys7Xbc7TA2mnrhtRJxHQgPOUUX399cIq
        7HV4ibI6ID3nBULOBw3/hsvfIzfE5mWchUiCCiC8KN71kLIBl1VjvRQk+0yIqFnR
        x88koNgbNpXu5XmxbpOIZ+srGVlVH/+fQSz0nMPIEK0qTkQCcoIeA==
X-ME-Sender: <xms:lncBYhudkACCwopqxxvI-RF1RDk6crTe4RXjDl6jW-01Umpc7wHJQg>
    <xme:lncBYqdCk7FlZmRRcln65BKvjYzvzBA-WWQrNiGpLfHbMTPmOxitB9N0Umn9QRgJW
    UlH07az-CflUs91QY4>
X-ME-Received: <xmr:lncBYkzD6SRY47uMdnyPlGgHFRR0B-jFNzpfeWAQBo2gUXQNVwKyeRK4E-4t12hrhSUdUHTnCXyhuYJ9CthcAtRmsP-Pr4VEBZFhNTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheehgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepkedutdelhfeijeeuudetgfdttdeiteeiuddvtddutdeitefgheeiffdvvefg
    tedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusg
    hushgvrhgtohhnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lncBYoPb8fOzA9_92AYWo-ncaXGSEkWzqC8LpNcTxHHtvYalityakA>
    <xmx:lncBYh_tOVw1s1c115aCyYmDs6cQG9DaUr3AS0xxx5ia8tOVUASlJA>
    <xmx:lncBYoVsLkuLwbaQJ-PFOh-DOkrSk1sYdd32HRiy2eh66EqQ5hgetA>
    <xmx:lncBYjLfAyHCYQB8xfHFmQQZgFHhtcw_ZFXuFKQT-R9iqdmnvDP2LA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 14:48:37 -0500 (EST)
Date:   Mon, 7 Feb 2022 20:48:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     kernel test robot <lkp@intel.com>
Cc:     Samuel Holland <samuel@sholland.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [sunxi:sunxi/clk-for-5.18 2/2]
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h:6:10: fatal error:
 dt-bindings/clock/sun6i-rtc.h: No such file or directory
Message-ID: <20220207194835.tsxmhaibya3kbban@houat>
References: <202202072224.hjVEpIij-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stq24hziqrn6og6t"
Content-Disposition: inline
In-Reply-To: <202202072224.hjVEpIij-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--stq24hziqrn6og6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 07, 2022 at 10:47:22PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git s=
unxi/clk-for-5.18
> head:   4f88abd86756e574c733d2ca14676be335cc0058
> commit: 4f88abd86756e574c733d2ca14676be335cc0058 [2/2] clk: sunxi-ng: Add=
 support for the sun6i RTC clocks
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/202=
20207/202202072224.hjVEpIij-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git=
/commit/?id=3D4f88abd86756e574c733d2ca14676be335cc0058
>         git remote add sunxi https://git.kernel.org/pub/scm/linux/kernel/=
git/sunxi/linux.git
>         git fetch --no-tags sunxi sunxi/clk-for-5.18
>         git checkout 4f88abd86756e574c733d2ca14676be335cc0058
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.2.0 make.cro=
ss O=3Dbuild_dir ARCH=3Dpowerpc SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from drivers/clk/sunxi-ng/ccu-sun6i-rtc.c:18:
> >> drivers/clk/sunxi-ng/ccu-sun6i-rtc.h:6:10: fatal error: dt-bindings/cl=
ock/sun6i-rtc.h: No such file or directory
>        6 | #include <dt-bindings/clock/sun6i-rtc.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    compilation terminated.

I've dropped these patches for now

Maxime

--stq24hziqrn6og6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgF3kwAKCRDj7w1vZxhR
xdnSAQCaVOCYToJfqw3QTOuUdyxnRGuSxI1ewUGBJiv3+KKkYgEA68loh+EJyzml
P3VWzq6xeFWP7fLMxPjw37+zqurzLQ8=
=aDZc
-----END PGP SIGNATURE-----

--stq24hziqrn6og6t--
