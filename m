Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837D24F7EE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbiDGMZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiDGMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:25:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526375419A;
        Thu,  7 Apr 2022 05:23:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KZ0sp4k4bz4xcZ;
        Thu,  7 Apr 2022 22:23:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649334223;
        bh=QasKlTaVbpI730es6A/xIsqvcHBYKj5COcg2FGq6uhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQZLg4gFIizoJUaJ+VjCvw5x1VFXohXYnjTONxp3NRn8FaVUkt8EuMiYxD6wm4xlM
         kr00iC8d+QZemjEMI3gXspZZ0uClT5Y1aC6guaYc4N5yXsO0r/1UvK4mUqdWFRT5Qj
         PvSpoX/XpIrldXG7XRsd4TbwPQPGJDTmnloNwJWGFRDvnnDuqTJRblCWgKm9JHWiGH
         rSaEPJP9aKl6vImRW+SskAXtXEDOkgGFPzfsauPh1S/rneME5j1LzEQXI/+LD6luzR
         wFyLffKLbSagb7ZGUxcO6Vv8R+Nv+vu1ectwVn2Y6Ui/yggyxZ6yoNaZlPHXyW7juJ
         98QPFQEGa+5Sg==
Date:   Thu, 7 Apr 2022 22:23:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        perf-users <perf-users@linaro.org>, lkft-triage@lists.linaro.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        NeilBrown <neilb@suse.de>, tanu235m@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        mgorman@techsingularity.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [next] perf build failures: libbpf.c:10946:50: error: format
 '%li' expects argument of type 'long int *', but argument 4 has type
 'size_t *' {aka 'unsigned int *'} [-Werror=format=]
Message-ID: <20220407222341.626d8377@canb.auug.org.au>
In-Reply-To: <CA+G9fYvdH87k2sSy6g3ehkqE8W94wdg-ww9-wS_t9w48Sp55PQ@mail.gmail.com>
References: <CA+G9fYvdH87k2sSy6g3ehkqE8W94wdg-ww9-wS_t9w48Sp55PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rw3NTfOGqReGPhMMpOdJFXU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rw3NTfOGqReGPhMMpOdJFXU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

On Thu, 7 Apr 2022 15:46:53 +0530 Naresh Kamboju <naresh.kamboju@linaro.org=
> wrote:
>
> perf build errors on i386 [1] on Linux next-20220407 [2]
>=20
> usdt.c:1181:5: error: "__x86_64__" is not defined, evaluates to 0
> [-Werror=3Dundef]
>  1181 | #if __x86_64__
>       |     ^~~~~~~~~~
> usdt.c:1196:5: error: "__x86_64__" is not defined, evaluates to 0
> [-Werror=3Dundef]
>  1196 | #if __x86_64__
>       |     ^~~~~~~~~~
> cc1: all warnings being treated as errors

Caused by commit

  4c59e584d158 ("libbpf: Add x86-specific USDT arg spec parsing logic")

>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/values.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/backward-rin=
g-buffer.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/sdt.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/is_printable=
_array.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/debug.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/fncache.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/tests/bitmap.o
>   CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/util/machine.o
> libbpf.c: In function 'attach_uprobe':
> libbpf.c:10946:50: error: format '%li' expects argument of type 'long
> int *', but argument 4 has type 'size_t *' {aka 'unsigned int *'}
> [-Werror=3Dformat=3D]
> 10946 |         n =3D sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &of=
fset);
>       |                                                ~~^          ~~~~~=
~~
>       |                                                  |          |
>       |                                                  long int *
> size_t * {aka unsigned int *}
>       |                                                %i
> cc1: all warnings being treated as errors

Caused by commit

  39f8dc43b7a0 ("libbpf: Add auto-attach for uprobes based on section name")

> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 2e9a9857569ec27e64d2ddd01294bbe3c736acb1
>   git_describe: next-20220407
>   kernel-config: https://builds.tuxbuild.com/27SL0lCnWoPP04Jn8zKQ5nEEX7i/=
config
>   target_arch: i386
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> --
> Linaro LKFT
> https://lkft.linaro.org
>=20
>=20
> [1] https://builds.tuxbuild.com/27SL0lCnWoPP04Jn8zKQ5nEEX7i/
> [2] https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/2302706=
510

--=20
Cheers,
Stephen Rothwell

--Sig_/rw3NTfOGqReGPhMMpOdJFXU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJO180ACgkQAVBC80lX
0Gwg0QgAlO/RQPm5kj5MwdctsdoMWBee9belDyZWV4sZvoToMlncDeyGATTg0XEa
zB75m9NUEjgOLooNvLNWVC8HaXiODJTIh9rQfxAbMenQGnLQGK8lH37C6pZ4K0Ri
brAyt5MdXr1N2PmHCzH9ULjX5lXMhIy/BETu29PMsqlhuzBdgLhJjuO/eV8ewLJH
Siz0fTcQtjCK8uHH0wu5XYTGHm/ovTmDc4b/O8T9ToZWI/QQSF77bnBzxnI9DBI6
4HIrlzwYHLolKqMP8RxePGMg4DiAxwC70wKGvJSNmG9aoEl2zd5fzMCVU3KjyRjf
Ga+uU3PCwpSPryo8qn2DfJ6EB2Xrrg==
=JNGK
-----END PGP SIGNATURE-----

--Sig_/rw3NTfOGqReGPhMMpOdJFXU--
