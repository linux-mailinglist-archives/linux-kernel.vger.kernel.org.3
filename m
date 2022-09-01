Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0105A9174
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiIAIAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiIAIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:00:26 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBEE2C132
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:00:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E61685C01B1;
        Thu,  1 Sep 2022 04:00:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Sep 2022 04:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1662019221; x=
        1662105621; bh=iG4eLXzfInXJuN/7urMofEeliFQ2j21OIzQVyB2YobY=; b=K
        3nfxrrPnNhiT1iYyfh/QLPUEno88cvBUO4vWo1IERkjzJzyWgztgMEZw4AndTF5D
        ng2n5v/J2X+Mdk2n50uRj6gamc+XZnxCoqpQehn5b4QEhnNMYJ5SoJt8bPb+NzZ9
        Uz0VsBONBAAET11S+Rr5Sz/3GUsPKloc0StTZNHuaPIoURv2gQXlUUROy4HG6OL5
        CX5BsUxgR+cLKgSSX4vDzHb8gBd1bMsMg4kyxX1AU22FsFo8Wz9UleeVnvxEfC6a
        6f/QfRJGRrlBu2f112CTwFaZpZL7Zmj6XwMjmDeGAA23dQ7xtDeghl2Cuj4h2UgW
        Tanqi1JKHZNEo0knzs+nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1662019221; x=
        1662105621; bh=iG4eLXzfInXJuN/7urMofEeliFQ2j21OIzQVyB2YobY=; b=Z
        +c58WhPwmU2lc8RjwiadNrZD2Cc5uzRytEadt2qVOOKu4/+O8ZRNphZ5t5+BEtMn
        5zOkp/Bz25A0JZyHtMNZ67q7LYla8xJOnCL+GUtmp7MECLzsQm0UP8HmgcxAPP/m
        5LR7uIpK0vHfyjJEFw0bzPMxpsqBBBnLrDmnk9FxmrCdSgAPDSehW07I5qiBIwl+
        m3njuXm8Vo7jg5D/cPlxXmUDxZFhpFEFSv1scZQ+4So8lvrqTbKPAM8HsfZdXjgZ
        kesI6Qsd9TTjoq+qckl0y8aP2RbXSxrd4iylwBgFQ1eVwFsm9k8gsNiMauMME5hY
        bgZKTNOV83vjegHh4TSFA==
X-ME-Sender: <xms:lGYQY58wTX38bZL-wZLUXRudPvhgKVrlyFTZ3ondLXBryK8ihTH4tQ>
    <xme:lGYQY9upFrCLi4bLRGxFa9IOihzNLZkNlDGd7BcaUh8xZwcMAhwq4RPoQhf_8K_Z7
    E4ahgekTX2aIDQTgFM>
X-ME-Received: <xmr:lGYQY3Bshc3C8Aq9AyyzJ69dBPtw93zaw5qtsO4INKMHF-SSDEaILxDTfKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpefgheelleehudfhkedvgfejfedufedtteefudeujeeuveehveevgedv
    gfeukeevudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddtuddrohhrghdpghhith
    hhuhgsuhhsvghrtghonhhtvghnthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:lGYQY9c3X73_yvbc37ix_Da6vgzgjkp3IWR4ov0cHWTE3286wCGkZA>
    <xmx:lGYQY-O0LVY4y8d9IM6MC3I0fjjnYW0lQ6jEVKZN8I3vmBy0Ly5Oyg>
    <xmx:lGYQY_mSJN5v1IpG64DYTKye7bQhQve-Ehjgilc7-UR_ph_mm_bO-Q>
    <xmx:lWYQY7owJ88gc98AXSUUQe5GQc3o3lwso0dCxeO7Xm-KeU2sFaI7gw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Sep 2022 04:00:20 -0400 (EDT)
Date:   Thu, 1 Sep 2022 10:00:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     kernel test robot <lkp@intel.com>
Cc:     "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [stable:linux-5.15.y 9126/9999] ERROR: modpost:
 "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
Message-ID: <20220901080017.fe4bx2ywuafry6ie@houat>
References: <202209011256.zvBzxcpP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202209011256.zvBzxcpP-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:51:57PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le.git linux-5.15.y
> head:   1ded0ef2419e8f83a17d65594523ec3aeb2e3d0f
> commit: 3d722c01d628d17a37cf2820195f15cfc9a6a332 [9126/9999] drm/vc4: Use=
 of_device_get_match_data()
> config: parisc-randconfig-c034-20220831 (https://download.01.org/0day-ci/=
archive/20220901/202209011256.zvBzxcpP-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git/commit/?id=3D3d722c01d628d17a37cf2820195f15cfc9a6a332
>         git remote add stable https://git.kernel.org/pub/scm/linux/kernel=
/git/stable/linux-stable.git
>         git fetch --no-tags stable linux-5.15.y
>         git checkout 3d722c01d628d17a37cf2820195f15cfc9a6a332
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dparisc SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> >> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] =
undefined!

I think this is due to stable having backported 87ea95808d53 and
a43dd76bacd0, but missing 59050d7838482

Maxime
