Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D296C5226F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiEJWfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEJWfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:35:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1225EA9;
        Tue, 10 May 2022 15:35:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyXtl2fHXz4xZv;
        Wed, 11 May 2022 08:35:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652222144;
        bh=hAFdnxfAhd6kOyVXWXqiYjo4AJfDV8jTaKFwXbxdwMQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UCjVbNwkydBwhDIPOre8rvXszwgrjCPe4GjNfx53mFsIwZ19lSek1fys7GkTYNw4a
         DUmKMUsx0HRUzYtfh+2ue2LQOJy9mC+6sGq+Dm+Ra2qcuQPUsjohrm8ZRnOe0urRG3
         KhYc9WBZQZAHIakGlhE+ubVrRJOVmwYqBljCh7w6ncIbgVvjgioYPsHuncEo1kYzPV
         w3+dvlodEmpRHw/MjGP7PVknBm8c18n07rVM0ClMOMn7YxdQGh1WbCpVD3ALGyVnZu
         mURi76wMxpcviKOys9UqnI7fndZKseWXfvwHmJ8RFl+h+wblwa1dvOtYPRg3EBpiG1
         bLklTD5j2/YQg==
Date:   Wed, 11 May 2022 08:35:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm tree with the mm-hotfixes
 tree
Message-ID: <20220511083542.7f175f4b@canb.auug.org.au>
In-Reply-To: <20220510095608.41b0f63a41a5e7f76c1fa187@linux-foundation.org>
References: <20220510223530.67d9a27f@canb.auug.org.au>
        <20220510095608.41b0f63a41a5e7f76c1fa187@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jsFKKXh8dxuH.v0PlMuWMoS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jsFKKXh8dxuH.v0PlMuWMoS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, 10 May 2022 09:56:08 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Tue, 10 May 2022 22:35:30 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > Today's linux-next merge of the akpm tree got a conflict in:
> >=20
> >   tools/testing/selftests/vm/Makefile
> >=20
> > between commit:
> >=20
> >   e33ebf536f3e ("selftests: vm: Makefile: rename TARGETS to VMTARGETS")
> >=20
> > from the mm-hotfixes tree and patch:
> >=20
> >   "kselftest/vm: override TARGETS from arguments"
> >=20
> > from the akpm tree. =20
>=20
> Thanks.  Let's just drop
> kselftest-vm-override-targets-from-arguments.patch for now - a new
> version is in the works.

OK, done.

--=20
Cheers,
Stephen Rothwell

--Sig_/jsFKKXh8dxuH.v0PlMuWMoS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ66L4ACgkQAVBC80lX
0Gx5zAgAk8fwlcEaVHDPJaInajjlax/pHzCRMrmLcmYkxstNf4UUouAa0W2m9ZMe
Pu7//3/ytzhTFXBGGKiAFcCcLwAxYATqqtQgt16HFV9JnUDPGWT3bwnkq5hSqEWz
d3/T0Ldyrnit9PNWNx7eXFQAI0UxLnBCVjsbMv3k3WDIJasj/0pnv4FfFyIS1Wiq
ix2GWXIbkVjHs3Q6+mS1598gLSlpeu8OKtuYgk6yzHZ37O0N11tei3fXRwBzcMxo
sIW4P5kFiDBMDa+Pd6twnUwQFMrUT9LlpJQz6chWxvZnYZ1Yoh/UN9MrHFDjHZjX
4ltnK2vAVrigMyCbXF95KtpayLW/rg==
=lxw9
-----END PGP SIGNATURE-----

--Sig_/jsFKKXh8dxuH.v0PlMuWMoS--
