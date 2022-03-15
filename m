Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64534DA44D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbiCOVDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiCOVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:03:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFEE5548A;
        Tue, 15 Mar 2022 14:02:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KJ5Sm0Hjzz4xQv;
        Wed, 16 Mar 2022 08:02:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647378137;
        bh=Gm2eAN7xlsgYpEui8WvbndX2aWAB9/rz42dMesvEeB4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjdO5JcjDd9mq4GPHK2V5zY6q6bi/By6OxBxGEsLuRTibCb9GDqWFSpKIgJH/0z03
         6AFDQj+w75zChe0+7gXu/eFDQztp+84zjs+PK9lmOQ7bTxt8X+cpUDogaiv4sRtOS2
         Q6CHv5IAlLv7B2FocXHDJYFN0H50/JWr8I5HjwuVnKR3OVJraA3gl4pX9CZttGrxjS
         DxOm16kGscx+T33f7uqwxLBMLoDC6LgsQ2Zehv20k+hUYF/XYnorA3r80C1xDEKxYf
         gQhTgcmDimdRm7CWGZ2VBYx2G5L6n5adjbzBkzTv2/Ng1pzJrVguQesoFc/49HQELU
         qLY+T4382avEw==
Date:   Wed, 16 Mar 2022 08:02:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhen Ni <nizhen@uniontech.com>
Subject: Re: linux-next: manual merge of the sysctl tree with the tip tree
Message-ID: <20220316080215.46eb8cd5@canb.auug.org.au>
In-Reply-To: <YjD0Z7UQ0psJT7b0@bombadil.infradead.org>
References: <20220315201840.6146f234@canb.auug.org.au>
        <YjD0Z7UQ0psJT7b0@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2s/VgC65/hy.AlCy7EIlsbf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2s/VgC65/hy.AlCy7EIlsbf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Tue, 15 Mar 2022 13:17:43 -0700 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> On Tue, Mar 15, 2022 at 08:18:40PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the sysctl tree got a conflict in:
> >=20
> >   kernel/sched/deadline.c
> >=20
> > between commit:
> >=20
> >   eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")
> >=20
> > from the tip tree and commit:
> >=20
> >   ebb891f03580 ("sched: Move deadline_period sysctls to deadline.c")
> >=20
> > from the sysctl tree. =20
>=20
> Peter,
>=20
> to help avoid conflicts I spinned up a sysctl-next tree to collect
> different cleanups going on kernel/sysctl.c. I can drop=20
> ebb891f03580 ("sched: Move deadline_period sysctls to deadline.c")
> but I think we'd still run into conflicts as other sysctls are
> trimmed out. Would you be OK in me taking in eb77cf1c151c
> ("sched/deadline: Remove unused def_dl_bandwidth") to avoid this
> conflict?

Its really a trivial conflict and just needs to be mentioned to Linus
in the pull requests.

--=20
Cheers,
Stephen Rothwell

--Sig_/2s/VgC65/hy.AlCy7EIlsbf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIw/tcACgkQAVBC80lX
0Gypagf9H/tgOqzqZsyB29ooKqHda7RDR4QQF2XjVQx/AoeL/IVHJ50YQdgGfLdS
SyDz7+mNHDTswwwKxg+WF8VKQeixDQXuTun81zpPgoT1F4aUVWZbEt9JtkHxqB/J
sEtQYOE2NT4yuvWdI6Jv/6IDm8q2shazTtZpg8GH8LGkk4zgHGy0AQHch668j/WA
6lvCNvlp2WuVDHSXB05sKw0CAGxpNI61LJ3ZxuxDuRfMAv6Szg8x1L+iEY9x1PrS
C3lWv4qXgerLZxOGzQ1gONTGtiFSHpmOlVMxsDmyw4Xt1MrTFaw6NFJtdvTp9T4k
9xuxn5AZzcqdtZl6FhQoUbYe1FxsYg==
=wzXP
-----END PGP SIGNATURE-----

--Sig_/2s/VgC65/hy.AlCy7EIlsbf--
