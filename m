Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C955350AB74
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442441AbiDUWZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDUWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:25:30 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453544769
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:22:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i196so6863837ioa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VCgKHuj4/b4B8v/0JoTxDFA1GBH+X0m9XoDYHur1Z1I=;
        b=EcevrwaUPNWImMw3RWVQB4TFY4NXjAOLyftfd3coTTN6aM3THXtL0y1iUPuxmKxJU8
         jTy0SqsaBOsIHcc2sIxIJv4ybiqTGwnMt70Hu8TeT0mmvy+1i6+e+w4xSo5NJvPBJDUE
         exXV0N2SehxTJod/6UO+gtRQi8aroZzLk/R19a0dPA0u1+GnZMrQJCB7yDz8nNTh1Ub5
         Luqc9MGpzjff57hdPzVJBM4QbuiVff9nnH3bnR/vF36RxzY6L28XQeDMihSM9UTZd868
         l/F/hcd3SpitgY+j+DC6yqMrXptueCdeWBqgRUERG+H2aHjJJoUcYja57RASAWxXDtDd
         plZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VCgKHuj4/b4B8v/0JoTxDFA1GBH+X0m9XoDYHur1Z1I=;
        b=lRskLrVFVuJA7jrWBgtZpua3h3m8SiK1sheg7caglURNA10KrPeOJ0lpDo7zQEBRAS
         ur8Ja1fUCQGvrJE+jeBA62WYxfdtYOVMzpU67BeHSNtjDsIujTHej5hZOrTA4DaAk/n1
         7KnvkXtQX7/RaRUyLh6DxxgOBRIeDA91vTswbTgaFBYqIddesHDA5JrYmmDMhhDtt86r
         2DmzEXGWN9qMSndpo8HRn6W+JnIRgYso/eR4TkGmS01g8TeEXKRlWnYn1Q/wLZL7v0ad
         f8LLifiyNg1EPIiFJ1BSxJSAEucwinbO3DKMSlBjJyiL42lHG4cnYGmnbEsww9moJ4rH
         kIbw==
X-Gm-Message-State: AOAM5306wcHYJ3JkxZS5U4gpvqo5KlOieoOJ0Vj+k1xoxOofCa9X6jsc
        BGEuX/IYcOX4ruzxhw2plxmJUyk1XEWU1BXXKnQDvMgXbMd8cQ==
X-Google-Smtp-Source: ABdhPJy63Y9jRqMNO0Jhy8kSsySEBI1w7ve2fovXz2pPwycwLT5xv1YlfvgYXF3ayo73vpCsj6OD30+WyFPHKC9qH3w=
X-Received: by 2002:a05:6602:482:b0:614:b990:28c9 with SMTP id
 y2-20020a056602048200b00614b99028c9mr828356iov.6.1650579758741; Thu, 21 Apr
 2022 15:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <202204212106.9R1ylUB7-lkp@intel.com> <20220421154806.52e1992b@xps13>
In-Reply-To: <20220421154806.52e1992b@xps13>
From:   Jean-Marc Eurin <jmeurin@google.com>
Date:   Thu, 21 Apr 2022 15:22:26 -0700
Message-ID: <CAL3wywUBghrRqDgnPTe4g2XK8nkJkw+8H64f-NE6kNAwDC6JYw@mail.gmail.com>
Subject: Re: [mtd:mtd/next 10/11] drivers/mtd/mtdoops.c:244:39: warning:
 format specifies type 'long' but the argument has type 'unsigned int'
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 6:48 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Jean-Marc,
>
> lkp@intel.com wrote on Thu, 21 Apr 2022 21:22:47 +0800:
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git m=
td/next
> > head:   f812679fab605b3d5b853ed24a81dabb222ea23a
> > commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtdoops: =
Create a header structure for the saved mtdoops.
> > config: hexagon-randconfig-r045-20220420 (https://download.01.org/0day-=
ci/archive/20220421/202204212106.9R1ylUB7-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ba=
c6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git=
/commit/?id=3D0629fcef16d703d384f76cb2c2c3a119a9149a34
> >         git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/=
git/mtd/linux.git
> >         git fetch --no-tags mtd mtd/next
> >         git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/mtd/mtdoops.c:244:39: warning: format specifies type 'long' =
but the argument has type 'unsigned int' [-Wformat]
> >                                   page * record_size, retlen, sizeof(hd=
r), ret);
> >                                                               ^~~~~~~~~=
~~
> >    include/linux/printk.h:446:60: note: expanded from macro 'printk'
> >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS=
__)
> >                                                        ~~~    ^~~~~~~~~=
~~
> >    include/linux/printk.h:418:19: note: expanded from macro 'printk_ind=
ex_wrap'
> >                    _p_func(_fmt, ##__VA_ARGS__);                       =
    \
> >                            ~~~~    ^~~~~~~~~~~
> >    1 warning generated.
>
> I've dropped the series for now. Please have a look at the reports and
> propose a new version when this is fixed?

Sorry about that, I had made that change based on this suggestion
https://lore.kernel.org/all/202203310648.it4f2xXD-lkp@intel.com/ :-)

I'll send another set.

Thanks,

Jean-Marc

>
> Thanks,
> Miqu=C3=A8l
