Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E029B462909
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbhK3AXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhK3AXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:23:01 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:19:43 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m9so23948990iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVdnzwGGQAXYZhMMw7RdhGS83GpDEAMdHspEpAeHJpM=;
        b=JBrWP5gHT51LQzPYhdA4VAomps44xCU8LhhSK2Bx1F1tVEYFPki+zoEGaGxsBaFrNC
         d9TJX+V07TVh1euztC31OXrBSoSdF+liKsegk5taJKyExVSxUM+oCxHX22LOPitJ29vI
         6F7yHM+oPaLf7rTJZTaqpkiY4xsa+Z9uDxus8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVdnzwGGQAXYZhMMw7RdhGS83GpDEAMdHspEpAeHJpM=;
        b=L+cyngVXncmbq/dnCapePLqVEfSf2oz2aosZLxAtFy+KDga8g2+NVGLGIEAz6Q/31p
         Nnp6Gmej0yYbYSU//F0zOhEdaKAH27l5dw4T2YlbLviWJRlsBonf9W3V4QPzV3XH9Iur
         UKzzIgVy8QHZfxKb6ROkT0tSkdNAhkluA7q3MV5j7CZg9Iwz2Ctw5FvEwva8OEOuM2j+
         8T/376LXSgCmZgNolcJxJt6I+zKmbniXltEf87jZ1HvS2ceTmLf2kthLI5c3TSm01YZD
         sGUGdO7ofwsvVr8ey4EmCRs4gPWvRCuJqicxW9fj93VhE+LpuEXasBBG6XqEqkuIBuI0
         qQEA==
X-Gm-Message-State: AOAM533WvBRLqrj6B3CutktG2S+tpIfQfORFCFC6eD6bT35Fi2M+tlX/
        z9a5xkON3Rji/F9FDegKnZ409oKLEv9d9A==
X-Google-Smtp-Source: ABdhPJyx6R6ML7XL/iSseXWcOAQHuwAahj7jihdlEkXjnBlrSVnb9q1UjPPj9A/nuq0IaSWLFWWEDQ==
X-Received: by 2002:a6b:2cc5:: with SMTP id s188mr61699185ios.218.1638231582963;
        Mon, 29 Nov 2021 16:19:42 -0800 (PST)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id h14sm10061004ild.16.2021.11.29.16.19.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 16:19:42 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id x10so23860853ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:19:42 -0800 (PST)
X-Received: by 2002:a6b:440f:: with SMTP id r15mr58122525ioa.128.1638231582031;
 Mon, 29 Nov 2021 16:19:42 -0800 (PST)
MIME-Version: 1.0
References: <202111261447.lxHTeAhi-lkp@intel.com>
In-Reply-To: <202111261447.lxHTeAhi-lkp@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Nov 2021 16:19:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XZv1LuGm59vJDQKuwqO0zdFZQQthfct7Z_bPcdkm4UUQ@mail.gmail.com>
Message-ID: <CAD=FV=XZv1LuGm59vJDQKuwqO0zdFZQQthfct7Z_bPcdkm4UUQ@mail.gmail.com>
Subject: Re: drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format
 specifies type 'unsigned short' but the argument has type 'int'
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Beep> <Boop> <Bop> (translates as "Hello Mr. Robot"),

On Thu, Nov 25, 2021 at 10:44 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a4849f6000e29235a2707f22e39da6b897bb9543
> commit: c1ed18c11bdb80eced208a61d40b1988f36a014f HID: i2c-hid: Introduce goodix-i2c-hid using i2c-hid core
> date:   10 months ago
> config: arm64-randconfig-r034-20211116 (https://download.01.org/0day-ci/archive/20211126/202111261447.lxHTeAhi-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1ed18c11bdb80eced208a61d40b1988f36a014f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout c1ed18c11bdb80eced208a61d40b1988f36a014f
>         # save the config file to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/hid/i2c-hid/i2c-hid-core.c:867:4: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
>                            le16_to_cpu(hdesc->bcdVersion));
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
>            _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                                  ~~~     ^~~~~~~~~~~
>    include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
>    #define le16_to_cpu __le16_to_cpu
>                        ^
>    include/uapi/linux/byteorder/big_endian.h:36:26: note: expanded from macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
>                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/uapi/linux/swab.h:105:2: note: expanded from macro '__swab16'
>            (__builtin_constant_p((__u16)(x)) ?     \
>            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

May I kindly point to the reply I gave to the same error last month
when you mailed it out?

https://lore.kernel.org/r/CAD=FV=WkUEkkkfGa+6QJSBvj8EgVrnGYYbd6RrC_5HdTue=mDw@mail.gmail.com/
