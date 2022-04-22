Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A450C064
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiDVTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiDVTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:31:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F648265442
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:10:42 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h83so9592346iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ec/PY5VodnHtIzxqjsjWB1b7cgZkCmMj5BqpmccvF5E=;
        b=gvjf82/mJf1N5xoxK5mfSuqBgpZam7/3aH1gBiDZ+ppLRa8VLollsGMXfs3FoesHSS
         fRoZ3ZNjcijiEQAl7Eb2vi6gKR4D/O7PA1mm9PjxibbHb8c8IAUtU305p3DOPhW7hDE4
         qFg4CwiQ4VH21WmseBmhMi7XFR2sx1o1lCi/xVK036lGNsxYQP7H1ltPzM4ynq9tF99/
         1ycqXz9BYeFCeov8ITsDmBTCE86QkUrWx8takmxWVabsCKhZTp5XEGjOlYjoGgRw84T/
         k+rvqOe9I0kfqYkMjt/4kPBH+1rtwORaIwEmXTYx4npOlNdeLX+LnHbXW+4evHpPIZpZ
         yKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ec/PY5VodnHtIzxqjsjWB1b7cgZkCmMj5BqpmccvF5E=;
        b=u62TTDB5mSw9B93Ko6xx7nhHQMasIrhU+6TZRGplwbbGrQNSnQO5JCtJgMX6s0hi6R
         0HXpHZgGVJkfkOyyWjVXnyyowaNr/UA5ZIlOpFuspOADNWmkhQzElGD30470Wb+5mRzd
         sKTdJucB3tu+gsrVLSk0fMJWphDGBxin7aIBU8iv8dNhmCNTS+NUAZYYF9YZKP94lBNv
         +aNyyAEw6PfFPWwisJSBCHjQmq5nY8W6CJSAH8a/YHxA/N08ET8amvwhxGQnsnjv2k8P
         WRz6/AXah2w70x13er3fpsU9GRksIr3c5JwYtV7Hb5TWaS6KM59DXH+umRwnj5Os09k3
         H3yA==
X-Gm-Message-State: AOAM5309PU/ZWRuV88smfTWQ/c7D+ozsny6vLGg/PP8+oEJBC534SDyJ
        8V6deuvEh8bwdnn2Qs0GYODRrQBCBgXBlsX8KGLvgQ==
X-Google-Smtp-Source: ABdhPJzY6+LXalRhLK+mNipcIkrMJMk1Ri+O+34W2ha8SqVOXaQIYF0gkrmmkqtqRb+XihkVK3TcMfvatdi5G3rXHDs=
X-Received: by 2002:a02:a384:0:b0:327:baaa:8dc0 with SMTP id
 y4-20020a02a384000000b00327baaa8dc0mr2858326jak.158.1650654624545; Fri, 22
 Apr 2022 12:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <202204212106.9R1ylUB7-lkp@intel.com> <20220421154806.52e1992b@xps13>
 <CAL3wywUBghrRqDgnPTe4g2XK8nkJkw+8H64f-NE6kNAwDC6JYw@mail.gmail.com> <20220422111755.6b26ea9e@xps13>
In-Reply-To: <20220422111755.6b26ea9e@xps13>
From:   Jean-Marc Eurin <jmeurin@google.com>
Date:   Fri, 22 Apr 2022 12:10:13 -0700
Message-ID: <CAL3wywWoTkd927n7Uuc6KSxqUGcDZmx1+S+3cBEVXD6kdnFPUQ@mail.gmail.com>
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

Hi Miquel,

On Fri, Apr 22, 2022 at 2:17 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Jean-Marc,
>
> jmeurin@google.com wrote on Thu, 21 Apr 2022 15:22:26 -0700:
>
> > On Thu, Apr 21, 2022 at 6:48 AM Miquel Raynal <miquel.raynal@bootlin.co=
m> wrote:
> > >
> > > Hi Jean-Marc,
> > >
> > > lkp@intel.com wrote on Thu, 21 Apr 2022 21:22:47 +0800:
> > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.g=
it mtd/next
> > > > head:   f812679fab605b3d5b853ed24a81dabb222ea23a
> > > > commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtdoo=
ps: Create a header structure for the saved mtdoops.
> > > > config: hexagon-randconfig-r045-20220420 (https://download.01.org/0=
day-ci/archive/20220421/202204212106.9R1ylUB7-lkp@intel.com/config)
> > > > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-projec=
t bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
> > > > reproduce (this is a W=3D1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/mast=
er/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux=
.git/commit/?id=3D0629fcef16d703d384f76cb2c2c3a119a9149a34
> > > >         git remote add mtd https://git.kernel.org/pub/scm/linux/ker=
nel/git/mtd/linux.git
> > > >         git fetch --no-tags mtd mtd/next
> > > >         git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > > >> drivers/mtd/mtdoops.c:244:39: warning: format specifies type 'lo=
ng' but the argument has type 'unsigned int' [-Wformat]
> > > >                                   page * record_size, retlen, sizeo=
f(hdr), ret);
> > > >                                                               ^~~~~=
~~~~~~
> > > >    include/linux/printk.h:446:60: note: expanded from macro 'printk=
'
> > > >    #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_=
ARGS__)
> > > >                                                        ~~~    ^~~~~=
~~~~~~
> > > >    include/linux/printk.h:418:19: note: expanded from macro 'printk=
_index_wrap'
> > > >                    _p_func(_fmt, ##__VA_ARGS__);                   =
        \
> > > >                            ~~~~    ^~~~~~~~~~~
> > > >    1 warning generated.
> > >
> > > I've dropped the series for now. Please have a look at the reports an=
d
> > > propose a new version when this is fixed?
> >
> > Sorry about that, I had made that change based on this suggestion
> > https://lore.kernel.org/all/202203310648.it4f2xXD-lkp@intel.com/ :-)
>
> Did you verify with
>
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cr=
oss W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash drivers/mtd/
>
> That the errors were actually gone? You seem to suggest that you didn't
> :)

I did run it. I believe the issue is because the field is a size_t so
when building 64 bits like the first bot on v2, the %ld suggestion
compiled but then it failed the hexagon build (which I'm guessing is
32 bit).  Using %zu in v4 builds both versions (ARCH=3Dx86_64 and
hexagon).  I should have double checked the bot suggestion and noticed
this was a sizeof / size_t field, sorry about that.

Thanks,

Jean-Marc


>
> Thanks,
> Miqu=C3=A8l
