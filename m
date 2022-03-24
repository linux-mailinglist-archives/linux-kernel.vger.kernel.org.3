Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254704E6AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355576AbiCXXB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiCXXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:01:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA57BABBB;
        Thu, 24 Mar 2022 15:59:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPgfB73YQz4xQv;
        Fri, 25 Mar 2022 09:59:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648162787;
        bh=YrHyKn8sq8oIQQutKg3Fk3b8qE0ama8/ojRfwNGRp1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xz5zvf74L2q37jM1mZsCsT6WWlg+fe0Ju4IleVZMrNqd3RgYzFBTOyw/ZV/w8SFzx
         GLDoEXpeE/0BO1SiwYqkXZjDmmDnwUAd3wHybDwBAi7U1DgI/6hl+x4jHHfIGFlOVL
         qQgepxjOar9vfNH8GxleM7jOE5BK4iBjlL+0uRkaFBRse51No8zy96IKeXkNZaJ/vP
         hJc6VJ7Xqqx+GDKogesHxflMqZKarxSpkJ1CuYuDIYf2Qr5r3cb1g4tuYOEyhIa6hi
         F24Yy0fKjn2EODNzIJiG5X0rsQwvwR9jK8xy96gtApwQeFVtkiKgiYLE3V3j/dcHAw
         Nh5Rv1oZSJg7Q==
Date:   Fri, 25 Mar 2022 09:59:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alan Kao <alankao@andestech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the userns tree with the
 asm-generic tree
Message-ID: <20220325095945.28cf4f6b@canb.auug.org.au>
In-Reply-To: <20220315184840.506dd8bf@canb.auug.org.au>
References: <20220315184840.506dd8bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PPxsHubqPi7tRD4uqx+aBmk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PPxsHubqPi7tRD4uqx+aBmk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 18:48:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the userns tree got conflicts in:
>=20
>   arch/nds32/include/asm/syscall.h
>   arch/nds32/kernel/ptrace.c
>   arch/nds32/kernel/signal.c
>=20
> between commit:
>=20
>   aec499c75cf8 ("nds32: Remove the architecture")
>=20
> from the asm-generic tree and commits:
>=20
>   153474ba1a4a ("ptrace: Create ptrace_report_syscall_{entry,exit} in ptr=
ace.h")
>   03248addadf1 ("resume_user_mode: Move to resume_user_mode.h")
>=20
> from the userns tree.
>=20
> I fixed it up (I just removed the files) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

These are now conflicts between the userns tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/PPxsHubqPi7tRD4uqx+aBmk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI89+EACgkQAVBC80lX
0GzXfQgAicz6BMGFFrNEXIe3VOvc0e7gPOqUvLhIueywQFWglzPm3unv5J+EXMQT
uRj9Nyx14U2Viysot4e/wvKfdFjySyHVQAjvM/NF3RY9IiqmJp50969Bpl3EU0sV
rozsGE3WEtVEkRFzHDN0XbukZ154MUT9y2+qxQ+lg11n2cWb9VeMgijco1YKeK29
GZKjmuVglXmI7j03dqjPUr/bCBM6S5nNetk9Yhy+AimO6nP/hKFdPP/FMcQDEmKy
CU24ep6bzQONhyZJJUyokFVJeJNOKmQeMcg/kKZq+fnQkK3PGJTqI0OKl11u84Xy
osJHAc2GsppBOk/S4KQlS2Xfh/ZL9A==
=ozKz
-----END PGP SIGNATURE-----

--Sig_/PPxsHubqPi7tRD4uqx+aBmk--
