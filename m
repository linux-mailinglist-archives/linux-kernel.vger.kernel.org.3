Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607950DAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiDYIVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiDYIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:21:24 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147BDDF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:18:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D033460002;
        Mon, 25 Apr 2022 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650874695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUCFqZtEvrVs7Fx/crY2Dz8HfkvrR/d4IUi8U+8pLkU=;
        b=O1J+Nn31pRNFQ7WJhWgfcJ2mPKDVdj6fsFZBhF8QQm4xkrzY7P3ocMlkW0ANhIlOZOy2Y1
        4GrIqjQvnXYCGG7knPU6MjxOMlcf/4ID0tiSCfS7YJbSMUCHl51q4r/6oYiW/xP5Z060CC
        VI2eG+vzC3stq1SlCe5dR4h+pf6r9CQd2snn+1miNiM8rX8YRwyrNwHw31UyamvsiyEDbP
        KvMKiIirFI9VlDc/zLbR33fJO9LNNTUZDaMvah3FmhedaHi1RY0loUW7eGrjq86aI6Zqqj
        FEpEEriuPamXsOevuRQ4jeIbMPwuLJfXtJb62Gkh4AU66YVnMAeY2TMCRb5+3g==
Date:   Mon, 25 Apr 2022 10:18:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:mtd/next 10/11] drivers/mtd/mtdoops.c:244:39: warning:
 format specifies type 'long' but the argument has type 'unsigned int'
Message-ID: <20220425101813.141844d7@xps13>
In-Reply-To: <CAL3wywWoTkd927n7Uuc6KSxqUGcDZmx1+S+3cBEVXD6kdnFPUQ@mail.gmail.com>
References: <202204212106.9R1ylUB7-lkp@intel.com>
        <20220421154806.52e1992b@xps13>
        <CAL3wywUBghrRqDgnPTe4g2XK8nkJkw+8H64f-NE6kNAwDC6JYw@mail.gmail.com>
        <20220422111755.6b26ea9e@xps13>
        <CAL3wywWoTkd927n7Uuc6KSxqUGcDZmx1+S+3cBEVXD6kdnFPUQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

jmeurin@google.com wrote on Fri, 22 Apr 2022 12:10:13 -0700:

> Hi Miquel,
>=20
> On Fri, Apr 22, 2022 at 2:17 AM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Jean-Marc,
> >
> > jmeurin@google.com wrote on Thu, 21 Apr 2022 15:22:26 -0700:
> > =20
> > > On Thu, Apr 21, 2022 at 6:48 AM Miquel Raynal <miquel.raynal@bootlin.=
com> wrote: =20
> > > >
> > > > Hi Jean-Marc,
> > > >
> > > > lkp@intel.com wrote on Thu, 21 Apr 2022 21:22:47 +0800:
> > > > =20
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux=
.git mtd/next
> > > > > head:   f812679fab605b3d5b853ed24a81dabb222ea23a
> > > > > commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtd=
oops: Create a header structure for the saved mtdoops.
> > > > > config: hexagon-randconfig-r045-20220420 (https://download.01.org=
/0day-ci/archive/20220421/202204212106.9R1ylUB7-lkp@intel.com/config)
> > > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-proj=
ect bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > > > > reproduce (this is a W=3D1 build):
> > > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/ma=
ster/sbin/make.cross -O ~/bin/make.cross
> > > > >         chmod +x ~/bin/make.cross
> > > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/lin=
ux.git/commit/?id=3D0629fcef16d703d384f76cb2c2c3a119a9149a34
> > > > >         git remote add mtd https://git.kernel.org/pub/scm/linux/k=
ernel/git/mtd/linux.git
> > > > >         git fetch --no-tags mtd mtd/next
> > > > >         git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
> > > > >         # save the config file
> > > > >         mkdir build_dir && cp config build_dir/.config
> > > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All warnings (new ones prefixed by >>):
> > > > > =20
> > > > > >> drivers/mtd/mtdoops.c:244:39: warning: format specifies type '=
long' but the argument has type 'unsigned int' [-Wformat] =20
> > > > >                                   page * record_size, retlen, siz=
eof(hdr), ret);
> > > > >                                                               ^~~=
~~~~~~~~
> > > > >    include/linux/printk.h:446:60: note: expanded from macro 'prin=
tk'
> > > > >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__V=
A_ARGS__)
> > > > >                                                        ~~~    ^~~=
~~~~~~~~
> > > > >    include/linux/printk.h:418:19: note: expanded from macro 'prin=
tk_index_wrap'
> > > > >                    _p_func(_fmt, ##__VA_ARGS__);                 =
          \
> > > > >                            ~~~~    ^~~~~~~~~~~
> > > > >    1 warning generated. =20
> > > >
> > > > I've dropped the series for now. Please have a look at the reports =
and
> > > > propose a new version when this is fixed? =20
> > >
> > > Sorry about that, I had made that change based on this suggestion
> > > https://lore.kernel.org/all/202203310648.it4f2xXD-lkp@intel.com/ :-) =
=20
> >
> > Did you verify with
> > =20
> > > > >         # save the config file
> > > > >         mkdir build_dir && cp config build_dir/.config
> > > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.=
cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/ =20
> >
> > That the errors were actually gone? You seem to suggest that you didn't
> > :) =20
>=20
> I did run it. I believe the issue is because the field is a size_t so
> when building 64 bits like the first bot on v2, the %ld suggestion
> compiled but then it failed the hexagon build (which I'm guessing is
> 32 bit).  Using %zu in v4 builds both versions (ARCH=3Dx86_64 and
> hexagon).  I should have double checked the bot suggestion and noticed
> this was a sizeof / size_t field, sorry about that.

No problem at all, it often happens to me as well.

Thanks,
Miqu=C3=A8l
