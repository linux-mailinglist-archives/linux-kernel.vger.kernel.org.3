Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838514A737E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiBBOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:45:09 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:40685 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiBBOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:45:08 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5EC8AC0003;
        Wed,  2 Feb 2022 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643813107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4mbb7kF/AzGhnSoPyBUzMArPFYJPP821v155kkkR9Y=;
        b=QglS3OiIsZmuwBxVzSE3AsOCW+Gaodk+vnxhUnbt7FEP6mazyel4+LlflNSsQAOegAdFsT
        7Cbt2VVck066IRxwrsbuyqA0Lh2F9irDQ7PcXMiY3/c/C5VJ/NlmEm6CARBGtZ0hvq58/l
        JMrCo6134D/pazj7DG6C1B2yawXf8lk+reHuRrnsitvKM30Ir0dX358C3xTBpCkPGkPnKm
        oqG4i3z9NXgGOYMo9WAfd+qJbodWkNk3ex/NgSZl46sU1TBx1somISh71ch5EoRl9xQ/94
        quNvQ7Mx/lKpraqk1MVI25i/W/ZU8mQDSmxmFw217OdrjPcWkNmaOdr9x23NcQ==
Date:   Wed, 2 Feb 2022 15:45:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [mtd:spi-mem-ecc 30/30] ld.lld: error: undefined symbol:
 nand_ecc_unregister_on_host_hw_engine
Message-ID: <20220202154504.7737deed@xps13>
In-Reply-To: <202202011308.a6RlPiGp-lkp@intel.com>
References: <202202011308.a6RlPiGp-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

lkp@intel.com wrote on Tue, 1 Feb 2022 13:28:45 +0800:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi=
-mem-ecc
> head:   6d0fadec1de4434fce145b374ef25c665357fa60
> commit: 6d0fadec1de4434fce145b374ef25c665357fa60 [30/30] spi: mxic: Add s=
upport for pipelined ECC operations
> config: hexagon-randconfig-r001-20220130 (https://download.01.org/0day-ci=
/archive/20220201/202202011308.a6RlPiGp-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e=
844b69f15bb7dffaf9365cd2b355d2eb7579)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/c=
ommit/?id=3D6d0fadec1de4434fce145b374ef25c665357fa60
>         git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/gi=
t/mtd/linux.git
>         git fetch --no-tags mtd spi-mem-ecc
>         git checkout 6d0fadec1de4434fce145b374ef25c665357fa60
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> ld.lld: error: undefined symbol: nand_ecc_unregister_on_host_hw_engine=
 =20
>    >>> referenced by spi-mxic.c
>    >>>               spi/spi-mxic.o:(mxic_spi_remove) in archive drivers/=
built-in.a
>    >>> referenced by spi-mxic.c
>    >>>               spi/spi-mxic.o:(mxic_spi_remove) in archive drivers/=
built-in.a =20

I've failed to prevent faulty configurations with regular depends
on/select keywords, so I've come with a new solution which received a
successful build coverage test from the 0-day robots.

In order to still be able to use the spi controller driver (=3Dy) while
mtd is =3Dm or =3Dn, I need to add an IS_REACHABLE() check in a couple of
headers. This way we can just imply the right MTD symbols from the
SPI_MXIC Kconfig entry.

I'll send a v11 with these changes which seem to rather cleanly address
all situations. I don't think I can do without these extra checks as
select/imply will not propagate the real value of the Kconfig symbol
(y/m) like depends on does.

Thanks,
Miqu=C3=A8l
