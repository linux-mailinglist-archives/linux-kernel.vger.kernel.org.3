Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E0253F609
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbiFGGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFGGZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:25:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3E60B85;
        Mon,  6 Jun 2022 23:25:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LHL1s4qR0z4xDH;
        Tue,  7 Jun 2022 16:25:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654583109;
        bh=TTib3E0eOcKUl5ZzrnNNt+rXzLxviuC4W+trHxRy5Ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iizM41FD4imLMhvx5n8bAh/9TnVK21QSe7Mvb5zdjKXSJ6YIKdZQxx5RNCpC+PmZH
         DVdn7GzyJHS2R8SQ4ubO140yTLkM34lIyLT1TNf0kfQyRn3LSNamnaSxDUtNOwV37d
         3M5e5OMeK+DUWyD+vCg/aCHw5cSIFnkHL9pKK8pyrCN6azYAQYh6uQPcpXeV6cpacr
         ParSo65A57hrRc+/balMOlTpjaq5sNMeVBb6l9h95sTZ8RRgBX9/xSJl7G9Vh3HOWO
         0j7P3eQSPsSzgwTDVB5nTVIawk/98zrvBVW6A3sBoL8fkwhmIKWJyZV1OMw6WfUcFR
         hnyzjgIbAm9LQ==
Date:   Tue, 7 Jun 2022 16:25:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Raghuram Thammiraju <raghuram.thammiraju@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vasily Averin <vvs@openvz.org>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [next] arm64: boot failed - next-20220606
Message-ID: <20220607162504.7fd5a92a@canb.auug.org.au>
In-Reply-To: <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
References: <CA+G9fYv7fESqpGoeKmHoJsst6wfRNMi2wQLGm+PsjbLDuDjdMQ@mail.gmail.com>
        <CA+G9fYsJThWFAxXTbAcJmjshx+oYxVVd+gMM680hS0X1z37+FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DRSjkCly1lHAR1PZNg3poEP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DRSjkCly1lHAR1PZNg3poEP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Tue, 7 Jun 2022 11:00:39 +0530 Naresh Kamboju <naresh.kamboju@linaro.org=
> wrote:
>
> On Mon, 6 Jun 2022 at 17:16, Naresh Kamboju <naresh.kamboju@linaro.org> w=
rote:
> >
> > Linux next-20220606 arm64 boot failed. The kernel boot log is empty.
> > I am bisecting this problem.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > The initial investigation show that,
> >
> > GOOD: next-20220603
> > BAD:  next-20220606
> >
> > Boot log:
> > Starting kernel ... =20
>=20
> Linux next-20220606 and next-20220607 arm64 boot failed.
> The kernel panic log showing after earlycon.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Can you test v5.19-rc1, please?  If that does not fail, then you could
bisect between that and next-20220606 ...

--=20
Cheers,
Stephen Rothwell

--Sig_/DRSjkCly1lHAR1PZNg3poEP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKe70AACgkQAVBC80lX
0GzJhwf/fg3MZsNBiav8tAOZc8t4jMCOWqorUXeJ83jXOMTTQ2zvWrii6uTUo9Xd
wybSgw08J6x1PyE+1GH/oNLSpMoyzkomnfRUlpHVTq2oARH6tjzRWyVB0e/8GFgS
oChUxkr9hz8UBBrV5yj8adSclwyCTMS869R7CkO/g9/ouidyWGGmlLpE+KBb4EUY
RxM501ieFo4Goyh9kWe7sUqqx+iCfcMo1lwyd2QYf4Z6BzmDAYA0490AL9Kl+Cdf
Slj2Bim1wm8d3Ou8aX9tQRp3G3ZRsolm8+hOhA/BRHiPYETJ/N0KvTqoIa+VXEr1
bgS2E6WIit0Fw4PX9jesiKHmFYPthA==
=m7Ts
-----END PGP SIGNATURE-----

--Sig_/DRSjkCly1lHAR1PZNg3poEP--
