Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865B5A925B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiIAIsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiIAIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:48:45 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39A41314FC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:48:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CAE25C01B3;
        Thu,  1 Sep 2022 04:48:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Sep 2022 04:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662022117; x=
        1662108517; bh=l2iVpNcckBloZiYPxiEHdOZw0tm4eADgBiJaKSqaraY=; b=p
        yV5b9uU27wvovs8MXLl5F+nTQPP5t5ry8Y0ZwsSov8b7Rl1MuaOnyThDenQd9oWZ
        KFxmdBfYGGeYhWHEWjNd3I+78iZVlsD/kpSPPChcMHdJyoSZLu1qpff1+dHikXBB
        ffuTE2IzxQsSpXRm6il4I51PbdeZ5OZd8U4TqYWuahSq79d1lYekS+2oZ6A+NeHU
        vUkf17BhFOu8Madqu8vFjZhg4WHDt+RJOqF4wc2iWsO2hFHDnoBCttxk3ARTxtEF
        FyqkqDbmK7HhPIeSy2Al8KMrBRuW5dd/PHkA3hmJhq1xSX0d2dvqrF6bA82PJjyC
        lPjq+ZLMAqMEh88z8romg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662022117; x=
        1662108517; bh=l2iVpNcckBloZiYPxiEHdOZw0tm4eADgBiJaKSqaraY=; b=I
        A0heguE6IEVOKY+7iwefJzG2eqCmNGx+1nuznbZWYZA46A8liCwfsZM9He4xSOLY
        wvlO6wFtRCmw6NRqwI3r1GVpnfgkjZAc1in4J+4xy4CAE7igWOUlklSbPGUU8HtQ
        gVHrbhK7lahXpSTOf9P1gkbHtR7zTf93xzvcP2xFjc7hGHarWpSfXeAKGcgT0+Cg
        TjXos0U2yfj1qaTUSFgawwamnagHck27/pByB+5SPzodEvBv22lnBp4lQky+1SR6
        adWxXVOcfw3JO6oNYeyYwpiRJlxIqi6WwkS8IYQbUxkjZw8a3y5OgSLU7jWcWEBO
        R2jy5PW+iy/+eXmxHkaTQ==
X-ME-Sender: <xms:5HEQY2chM5ODqvnhzXP9ZIL1R0II1xvOudmjKXq2LxOgsYhHDklWnA>
    <xme:5HEQYwPfsQEJ2kzUmT6tmQprwyl3Y_-wBKdyTTAGFK_nBLniDL4FlvP8mQS-O6Uqc
    -2xp2OSOsq0a13WeaE>
X-ME-Received: <xmr:5HEQY3j-PK_NezsNY21hsuQNLxrIJ--bUPcdDyL8NNEutMllQ19YSyTa2X8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepgfehleelheduhfekvdfgjeefudeftdetfeduueejueevheevveegvdfg
    ueekvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthh
    husghushgvrhgtohhnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:5HEQYz-VG1W0lzYyMizqEw9tBLiRNXIbJ_mFD6KUek5g4xPAqW8wzQ>
    <xmx:5HEQYyvqLHkGRZdRgxaFCmHzYUw_k1O-9hNZ4GzJOKftA-oXcV--VQ>
    <xmx:5HEQY6HyDJ33oqAZS3xoczvb034jrRCGDMTqdosOR8pB9MYZGYU2vw>
    <xmx:5XEQY0KksNuNLZ63YA6icr8Ety-hwNeD5CrN6GO__8X0gg5Ilolz0w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 04:48:36 -0400 (EDT)
Date:   Thu, 1 Sep 2022 10:48:33 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [stable:linux-5.15.y 9126/9999] ERROR: modpost:
 "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
Message-ID: <20220901084833.fupxbfutuz6yqoqo@houat>
References: <202209011256.zvBzxcpP-lkp@intel.com>
 <20220901080017.fe4bx2ywuafry6ie@houat>
 <YxBvyDBxtP57MULl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YxBvyDBxtP57MULl@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:39:36AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 01, 2022 at 10:00:17AM +0200, Maxime Ripard wrote:
> > On Thu, Sep 01, 2022 at 12:51:57PM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-=
stable.git linux-5.15.y
> > > head:   1ded0ef2419e8f83a17d65594523ec3aeb2e3d0f
> > > commit: 3d722c01d628d17a37cf2820195f15cfc9a6a332 [9126/9999] drm/vc4:=
 Use of_device_get_match_data()
> > > config: parisc-randconfig-c034-20220831 (https://download.01.org/0day=
-ci/archive/20220901/202209011256.zvBzxcpP-lkp@intel.com/config)
> > > compiler: hppa-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=3D1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x-stable.git/commit/?id=3D3d722c01d628d17a37cf2820195f15cfc9a6a332
> > >         git remote add stable https://git.kernel.org/pub/scm/linux/ke=
rnel/git/stable/linux-stable.git
> > >         git fetch --no-tags stable linux-5.15.y
> > >         git checkout 3d722c01d628d17a37cf2820195f15cfc9a6a332
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make=
=2Ecross W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash
> > >=20
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >=20
> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > >=20
> > > >> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.=
ko] undefined!
> >=20
> > I think this is due to stable having backported 87ea95808d53 and
> > a43dd76bacd0, but missing 59050d7838482
>=20
> I see no such commit as "59050d7838482" in Linus's tree, what are you
> referring to exactly here?

Sorry, I meant 59050d783848, I'm not sure how the final 2 ended up there

Maxime
