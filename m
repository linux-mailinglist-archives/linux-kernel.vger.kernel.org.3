Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E700357C30B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiGUD4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiGUD4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:56:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8613A13DC9;
        Wed, 20 Jul 2022 20:56:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpJdT6nSJz4x1f;
        Thu, 21 Jul 2022 13:55:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658375758;
        bh=oCw4rq7rV+d5RgeMCOO0dArP9hoiuggzKZ0+9UlgMS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bhnGvf8v7wcdTV5AF+5Dab1MjPWixSfkziR4xYPgBy7NKLFCU7ByeV5Bz8L59unVJ
         2jXTbWtzArlNQc04yuv9/Tqw9DVVefXG3Yq3T8SJ06Ppd1adbyxPF/MGWMISmx4gHL
         BWWwb7pCbpsyhnE+nb6/nEYqbDUrS3Kdi85h9INO48paeT5/N4WxJL/wJwKSYYqmNo
         eqYn6sK2F6+5PLcyazyoQ4K70AE4Df6upP1cf7/oIvYtV8JXap8HRk+YpG2OkUBiVS
         N9elGwbRT5/eoYRYSwQ93UuM0TSXhUhX7oa2RIGgZR5/XgapQ0kWN68nBgXyHdggFn
         wAbooRdNlxsxA==
Date:   Thu, 21 Jul 2022 13:55:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20220721135556.5443eff4@canb.auug.org.au>
In-Reply-To: <CAP-5=fV+Oo+__sWTgfqyVKwyr1FxYYSv9H6H72CgdQN_Jv1ZAQ@mail.gmail.com>
References: <20220721090500.35774b43@canb.auug.org.au>
        <CAP-5=fV+Oo+__sWTgfqyVKwyr1FxYYSv9H6H72CgdQN_Jv1ZAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/O_X7/Xi47tA.=fV6/QdQ3MC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/O_X7/Xi47tA.=fV6/QdQ3MC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, 20 Jul 2022 19:35:45 -0700 Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jul 20, 2022 at 4:05 PM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > I installed python3-setuptools. =20
>=20
> Thanks, could you give more details? Are you overriding python to be
> an older version on the command line? What does "python --version" and
> "python3 --version" show? Installing python3-setuptools should be what
> you need, but I'm not sure why that's not working for you.

I am not doing anything unusual.  What I meant was "To fix this, I
installed python3-setuptools as I did not have it installed before".
It built fine once I installed that.

--=20
Cheers,
Stephen Rothwell

--Sig_/O_X7/Xi47tA.=fV6/QdQ3MC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLYzkwACgkQAVBC80lX
0Gy/aAf+KvIuifloYzJdYBPYpGHusJrcEs5S1RsjvMMyTjBU/sXOFyZ5FdCVnIfU
HCMri+qzaZHsVAQF/poJAltYCwerVEO5KuKamTIyuoYLLyNiL+eTloyIgjhQ7FGv
IupPvfoH+vWqQQZ129MnodvWLs+Z0Zh/4sOVL8k8kFLbujuDiTvyeZlc2ZOy20x4
xbUjlXpJnQZq849FKLDmhf1fXfSUzg0NCyeaiXqt8u7OW1lB2tmxdZvRq5z9ZpOZ
+d9uVMuWrBCri+AlWp00lFrcS588dwzX2NxbLnDGEdXUQQp7NfRZk4Epb5wOHQzj
zPieCmFpfn8y4MhCrNkSRDshnTJ2TQ==
=rjjd
-----END PGP SIGNATURE-----

--Sig_/O_X7/Xi47tA.=fV6/QdQ3MC--
