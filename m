Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907D450A128
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387412AbiDUNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356468AbiDUNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:51:00 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB6381BC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:48:09 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB16A20009;
        Thu, 21 Apr 2022 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650548888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mkq8nOmP/hkj33Kz6ueYMGynBvEyRGCifdNeOr4fyAE=;
        b=R4QGnFTrYxq2ZhlwahioY4zA/zn54XYnkiaFuH80uixKudj1OZznXjurrZ/SIuJ1/Fvvvi
        KgVHJKPcS99Kxrb2DNlOJ1t3E6I7bf1NYF/bhkQbhkEjxXiRBxXZ/kdALIUvaTxTPktyem
        aevxoZDczXa4FKWy832UtfReOaMeWrFaoRLwV6rixEGekJRSdJlLCfY17VUYgEul8y15/w
        3+SCWPVSy51FHLCHyCFH19/VZrn7bKhUr7uDtGf9oWvIlA3oeF5vkkqPRk9y+OqTZ45k+w
        1w54vc1BRbeQ8BoFUdmfYrE87hlBVjv6ZLWVvjYpmXHrol2tqaNyKgFwJ4HxdQ==
Date:   Thu, 21 Apr 2022 15:48:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Jean-Marc Eurin <jmeurin@google.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:mtd/next 10/11] drivers/mtd/mtdoops.c:244:39: warning:
 format specifies type 'long' but the argument has type 'unsigned int'
Message-ID: <20220421154806.52e1992b@xps13>
In-Reply-To: <202204212106.9R1ylUB7-lkp@intel.com>
References: <202204212106.9R1ylUB7-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

lkp@intel.com wrote on Thu, 21 Apr 2022 21:22:47 +0800:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd=
/next
> head:   f812679fab605b3d5b853ed24a81dabb222ea23a
> commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtdoops: Cr=
eate a header structure for the saved mtdoops.
> config: hexagon-randconfig-r045-20220420 (https://download.01.org/0day-ci=
/archive/20220421/202204212106.9R1ylUB7-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6=
cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/c=
ommit/?id=3D0629fcef16d703d384f76cb2c2c3a119a9149a34
>         git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/gi=
t/mtd/linux.git
>         git fetch --no-tags mtd mtd/next
>         git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=
=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
> >> drivers/mtd/mtdoops.c:244:39: warning: format specifies type 'long' bu=
t the argument has type 'unsigned int' [-Wformat] =20
>                                   page * record_size, retlen, sizeof(hdr)=
, ret);
>                                                               ^~~~~~~~~~~
>    include/linux/printk.h:446:60: note: expanded from macro 'printk'
>    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
>                                                        ~~~    ^~~~~~~~~~~
>    include/linux/printk.h:418:19: note: expanded from macro 'printk_index=
_wrap'
>                    _p_func(_fmt, ##__VA_ARGS__);                         =
  \
>                            ~~~~    ^~~~~~~~~~~
>    1 warning generated.

I've dropped the series for now. Please have a look at the reports and
propose a new version when this is fixed?

Thanks,
Miqu=C3=A8l
