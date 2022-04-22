Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAE750B3E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445935AbiDVJV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445954AbiDVJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:21:04 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122AC333
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:17:59 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE9851BF210;
        Fri, 22 Apr 2022 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650619078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mggckCRdpCTXoS+dTfsucqDXNXyDRQ8YZv/6KdqwEIg=;
        b=Kk8Iry75zaOxB17Jq27o7MNFhFlbkbHcrrqiZmQ/SUFEt/TK4mfpuDFelRuZ7zu8o3SzC1
        ZDtjqR23mMttEFOH7FPmjcRjcO7GJOG4RdG0ULM8O5jkK1cvcoxR05IpdPFvPjhMrqGkxv
        Qk4UEPBOIOg36422Turvr2z14jOiV86x4kU7T1NRCZMkvMuKWpgv7JEnvm0EVP09nuCrD1
        dCm8El4vmBYYhhiblNqlCmXcF2I1bf4dVNfugSWmadC2dxX7s7+H+dImdKj7iIJRVXPF9t
        ZLTj8okONZagu9gR6G4zebAnRiPRrOA8sRE0grdfP/nXZcY0VtLTHHI8X/eAQw==
Date:   Fri, 22 Apr 2022 11:17:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:mtd/next 10/11] drivers/mtd/mtdoops.c:244:39: warning:
 format specifies type 'long' but the argument has type 'unsigned int'
Message-ID: <20220422111755.6b26ea9e@xps13>
In-Reply-To: <CAL3wywUBghrRqDgnPTe4g2XK8nkJkw+8H64f-NE6kNAwDC6JYw@mail.gmail.com>
References: <202204212106.9R1ylUB7-lkp@intel.com>
        <20220421154806.52e1992b@xps13>
        <CAL3wywUBghrRqDgnPTe4g2XK8nkJkw+8H64f-NE6kNAwDC6JYw@mail.gmail.com>
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

jmeurin@google.com wrote on Thu, 21 Apr 2022 15:22:26 -0700:

> On Thu, Apr 21, 2022 at 6:48 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Jean-Marc,
> >
> > lkp@intel.com wrote on Thu, 21 Apr 2022 21:22:47 +0800:
> > =20
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git=
 mtd/next
> > > head:   f812679fab605b3d5b853ed24a81dabb222ea23a
> > > commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtdoops=
: Create a header structure for the saved mtdoops.
> > > config: hexagon-randconfig-r045-20220420 (https://download.01.org/0da=
y-ci/archive/20220421/202204212106.9R1ylUB7-lkp@intel.com/config)
> > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project =
bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > > reproduce (this is a W=3D1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.g=
it/commit/?id=3D0629fcef16d703d384f76cb2c2c3a119a9149a34
> > >         git remote add mtd https://git.kernel.org/pub/scm/linux/kerne=
l/git/mtd/linux.git
> > >         git fetch --no-tags mtd mtd/next
> > >         git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cros=
s W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>):
> > > =20
> > > >> drivers/mtd/mtdoops.c:244:39: warning: format specifies type 'long=
' but the argument has type 'unsigned int' [-Wformat] =20
> > >                                   page * record_size, retlen, sizeof(=
hdr), ret);
> > >                                                               ^~~~~~~=
~~~~
> > >    include/linux/printk.h:446:60: note: expanded from macro 'printk'
> > >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_AR=
GS__)
> > >                                                        ~~~    ^~~~~~~=
~~~~
> > >    include/linux/printk.h:418:19: note: expanded from macro 'printk_i=
ndex_wrap'
> > >                    _p_func(_fmt, ##__VA_ARGS__);                     =
      \
> > >                            ~~~~    ^~~~~~~~~~~
> > >    1 warning generated. =20
> >
> > I've dropped the series for now. Please have a look at the reports and
> > propose a new version when this is fixed? =20
>=20
> Sorry about that, I had made that change based on this suggestion
> https://lore.kernel.org/all/202203310648.it4f2xXD-lkp@intel.com/ :-)

Did you verify with

> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cros=
s W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/

That the errors were actually gone? You seem to suggest that you didn't
:)

Thanks,
Miqu=C3=A8l
