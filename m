Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FD94DB6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357609AbiCPRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241750AbiCPRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AE46B3E;
        Wed, 16 Mar 2022 10:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ECCC617D6;
        Wed, 16 Mar 2022 17:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C11BC340E9;
        Wed, 16 Mar 2022 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647450315;
        bh=VAILIcNcuve6zwpUMsnMu0YRMMRvlJ0yTNICt6G+urY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGjbGSsKOjHVfjg1RR8nfoszypmTCfGdpKLHPee9b+vpktXhKcY08NcuM7VSJdw/W
         H1TKpfpI6sJQJeM7khd9G9np+PTzUUGtGITTDWAnga5DSuINGkRQPIX6BmuDMzCpH+
         AS157Qbhb4Zc5QBo46Y/v5ZEvqHzIGHKzkddsyi+vUFRqjxfEVR+HnSw5vavXW1O9V
         lZPWgVe017c8UqzlaQVxtO/8pUD8Ut2gwoHzPMIvtUxWm1JCdRzuo7ifXuxnEe5vz2
         OE8/sTFKzujkz89zwZVg4gYp7/Ov+cMoElPEveLaZgpVeuCO02q6nGpeCkG6ZHaEpP
         DYC5vDC0r6Vzw==
Date:   Wed, 16 Mar 2022 17:05:09 +0000
From:   Mark Brown <broonie@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Subject: Re: [broonie-misc:arm64-sysreg-gen 6/9]
 arch/arm64/include/asm/sysreg.h:125:10: fatal error:
 'generated/asm/sysreg.h' file not found
Message-ID: <YjIYxWkVzT0/XYf+@sirena.org.uk>
References: <202203160508.k7vz4ZxC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47OylaR+d6CbicYl"
Content-Disposition: inline
In-Reply-To: <202203160508.k7vz4ZxC-lkp@intel.com>
X-Cookie: Androphobia:
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--47OylaR+d6CbicYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2022 at 05:56:39AM +0800, kernel test robot wrote:

Not deleting context for the benefit of the kbuild people I just CCed...

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git =
arm64-sysreg-gen
> head:   72b2ee21681c0c515c6a8bb62bd289766ce324a1
> commit: caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff [6/9] arm64/sysreg: Enab=
le automatic generation of system register definitions
> config: arm64-randconfig-r006-20220313 (https://download.01.org/0day-ci/a=
rchive/20220316/202203160508.k7vz4ZxC-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2=
f50fb47da3baeee10b1906da6e30ac5d26ec)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.gi=
t/commit/?id=3Dcaf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff
>         git remote add broonie-misc https://git.kernel.org/pub/scm/linux/=
kernel/git/broonie/misc.git
>         git fetch --no-tags broonie-misc arm64-sysreg-gen
>         git checkout caf0e02eaa9ed9bfa50642f0bc2ee008b1c138ff
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Darm64 prepare
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from kernel/bounds.c:10:
>    In file included from include/linux/page-flags.h:10:
>    In file included from include/linux/bug.h:5:
>    In file included from arch/arm64/include/asm/bug.h:26:
>    In file included from include/asm-generic/bug.h:22:
>    In file included from include/linux/printk.h:9:
>    In file included from include/linux/cache.h:6:
>    In file included from arch/arm64/include/asm/cache.h:8:
>    In file included from arch/arm64/include/asm/cputype.h:173:
> >> arch/arm64/include/asm/sysreg.h:125:10: fatal error: 'generated/asm/sy=
sreg.h' file not found
>    #include "generated/asm/sysreg.h"
>             ^~~~~~~~~~~~~~~~~~~~~~~~
>    1 error generated.

This looks like a kbuild thing which as far as I can see only exists for
O=3D builds and possibly only with bounds.s - if I look at the full log I
see that we correctly generated asm/sysreg.h:

  GEN     arch/arm64/include/generated/asm/sysreg.h

but that's only passed to CC (at least for bounds.s) via an
-I./arch/arm64/include/generated so won't be found with the generated/
prefix.  While this can be avoided by renaming the header and not
referencing it with the prefix I do see a bunch of other headers
throughout the tree being included with an explicit generated/ prefix so
I'm not sure this is what's supposed to be happening, it does seem like
a landmine somehow.

>    make[2]: *** [scripts/Makefile.build:121: kernel/bounds.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1191: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:219: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>=20
>=20
> vim +125 arch/arm64/include/asm/sysreg.h
>=20
>    118=09
>    119	/*
>    120	 * Automatically generated definitions for system registers, the
>    121	 * manual encodings below are in the process of being converted to
>    122	 * come from here. The header relies on the definition of sys_reg()
>    123	 * earlier in this file.
>    124	 */
>  > 125	#include "generated/asm/sysreg.h"
>    126=09
>=20
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--47OylaR+d6CbicYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIyGMUACgkQJNaLcl1U
h9BGYAf/a5rGPjpj7U3tRYQ0COopaqhrMs7opcgx61qiaTZcuQ5SXro1NBErX1wG
CvLTBLPSvdgiwuGPMgENDQp+rucshqYV5L6hY1E2FT0zKlViYN11HPEpGK+NBWUK
FxkLP8AHVmPu13JPyj2cCNDHG9GVsOTjvsC+NWUOkMVA0/sPm1MDHUptOx83B9Hn
t1JCAFZsdxQRc/9Imjl1yK26sy9OfN21H9OHDbcM239xCKbh4dWjLSCyYlhAtLJI
7XthTpsa0fm8Xu/mYHb6Gigi+C+w8N6ZMd7bMkWaE246rrrUmnZG9pT0l86B3NMx
E2ABvY6aKb1jnFPf9wtrPpMmYu5BMg==
=NUi8
-----END PGP SIGNATURE-----

--47OylaR+d6CbicYl--
