Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21C53EADF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiFFJBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiFFJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:01:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B112D11
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:01:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7475D5C00A1;
        Mon,  6 Jun 2022 05:01:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 06 Jun 2022 05:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654506094; x=1654592494; bh=KmUEnrHf+o
        GOuY+Xvakm6L4Zo3/Ea+eM9/DA5uFudkY=; b=rCWtGLL6Iu/ZnCom744WZU1x7k
        WuHyF5YZCXN90nVnHwJyQ3jvrjT+Sw1STF5/A6Uec7WZ+Cnaa/IfXBj3Ga1njgM2
        O2ZQcG91cbGMIGBdQNAZVVJmXPdm3yq+qw7yuny2M7FeDtCpm1ooU0ffHkaZYU6z
        MKJSy2eBLuRivoMfyoM3Q/WN9lGvYwqgbhR7bgCeqCpMj9HqUludzlvPhP6vAwdF
        XSg1hfnf+SZ+FX5Rp0+94m83J+vsX9pwy515dQbcwhxOewFelr6WgscA2eq0riXB
        vZ0/p9rAdMqrJPdG/+XsAt43tlKjn7J9yFSursDpkDfj+dAMdvtHbdz0my4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654506094; x=1654592494; bh=KmUEnrHf+oGOuY+Xvakm6L4Zo3/E
        a+eM9/DA5uFudkY=; b=oULOGo5cddjw63j71RFECI1sLvIK3lCDex4rzqZ6dbKt
        GkADHMKVqWI3UufCLVDWKGLAiezEbpkRcYadcBzCPkRxXMldOlmd8vSLBuzSwFsi
        XX0e0MkvGPxGZcsm7uQsnSnuCTaMF5nmVSzGkh/XExaLjb3xSuTZik0kbioHkOC1
        JxbLTpr68KUKay8+y0K7upNY+2Y8PcQhQuexP6D1Xzu7iAWXRgLZbaoNy4u9+Hrc
        gU5kJHi2rkDeg90jF3X0hE48HE9ArEBlLF+5Z1cZJIvTEQ9fotzII38UdHM8T/1o
        fMaxXTCw33fzJEZrHzWJ93DzmMspVOI+8Fi/vWVbUw==
X-ME-Sender: <xms:a8KdYlKBWa3UJ4NS08ntsE3zZmL0Y2TzSloHSXkgEk4WcmZjy3Dlhw>
    <xme:a8KdYhLY2dQk0cAmHjK78z-IYSO6emPPdnle4LYztnqYeH_X32SyXmLS-UdrESus0
    qFEDcb8qEhBmeR-z9E>
X-ME-Received: <xmr:a8KdYtuD2Rx6OEygLXyIlRFFAq3kZFVvmrm1ujB-nCU0ZGHD7znX3W6BUTdEFRiTd82P70MKZ-OAIaXa8k2-XLMnsOVTGS02omNiwsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:a8KdYmZS23Gs5UU-hzrjJpc6lNNQcqsh7PwI9iiT2mjeblQFDDYfDg>
    <xmx:a8KdYsZ9tSxi9OJooqSyoOtek41gJpOBiUSFVSBkc04C8wRj1qpMbw>
    <xmx:a8KdYqANtT-1pAjs3zvvzWroLtYscdaSzZzY4gLrOhnLmf11qrszQA>
    <xmx:bsKdYsJkIobMQ7FUDeX37llie5znXiD3s1PHy9oYe-pLI9bwpANZEw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 05:01:31 -0400 (EDT)
Date:   Mon, 6 Jun 2022 11:01:29 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: gcc-12: build errors: arch/arm64/kernel/setup.c:225:56: warning:
 array subscript -1 is outside array bounds of 'char[]' [-Warray-bounds]
Message-ID: <20220606090129.mpidmwwobgkcfc2v@houat>
References: <CA+G9fYts-KH-R5EkBpz2u6H_Cx6YTXus1JKJS6yBxGhb0O2qQQ@mail.gmail.com>
 <CAK8P3a3QKWxqGore3+_DJnWo7bJgvDhkZjtkyg5EUg4_D=mE2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsirw27bcrup6k37"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3QKWxqGore3+_DJnWo7bJgvDhkZjtkyg5EUg4_D=mE2w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsirw27bcrup6k37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 03, 2022 at 09:40:07AM +0200, Arnd Bergmann wrote:
> On Fri, Jun 3, 2022 at 4:03 AM Naresh Kamboju <naresh.kamboju@linaro.org>=
 wrote:
> >     inlined from 'setup_arch' at arch/arm64/kernel/setup.c:350:2:
> > arch/arm64/kernel/setup.c:225:56: warning: array subscript -1 is
> > outside array bounds of 'char[]' [-Warray-bounds]
> >   225 |         kernel_code.end     =3D __pa_symbol(__init_begin - 1);
> >
>=20
> Is this the only warning of this type that you get for arm64?

In that function, both kernel_code.end and kernel_data_end show a
similar warning in 5.19-rc1

> I think the easy fix would be to reword this line to
>=20
>        kernel_code.end     =3D __pa_symbol(__init_begin) - 1;

Doing this for both fix the warnings.

Maxime

--tsirw27bcrup6k37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYp3CaQAKCRDj7w1vZxhR
xSNxAQCcTzhzMOxcDL9WGAwz0vVmy99JZhx9Udyas1PPaIoBcwEAyh5jqqVu2smB
yLg+OIxwEhblK6XNPX6hyeOfhD412w0=
=6RO8
-----END PGP SIGNATURE-----

--tsirw27bcrup6k37--
