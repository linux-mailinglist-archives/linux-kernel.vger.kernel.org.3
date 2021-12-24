Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A3847EEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 13:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352646AbhLXMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 07:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhLXMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 07:09:41 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBDC061401;
        Fri, 24 Dec 2021 04:09:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so32689736edd.8;
        Fri, 24 Dec 2021 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MiMXbgOIp0SVuHAYNLqtLbjj/zPi/YpQLt8sEUphp+4=;
        b=jLENgQqi0no/dZEXnAKsJ2z1g99Rhxy6jHlIV7wSERdGdYye0MkOnLfMFPwh6lRjcb
         2mslvZtHsbOZJpZpDHtVNPvLqT40+qXvhPYJKQI51dRIkiba5Ymr52w+db7d0Kj+9H8v
         i+wV1zMNFmCrevcyVIRDlPLh1BIrRlQl6eT66s1CGRrXYVJTy+8kDHLeaI+aJHF1imiK
         GL7tbNc8MVrTmNkef7dL4mFd/AkSH+/rTM3/d4gpLg1E7zwtFKA4/Hw/p81X/P0YiKOw
         nYo6g5wJ6AdYiVtWJQao4F8DaadiNX11Qoa9KfZ9E22oS91OLEQ8mdmicn32WPyyC5zE
         Cx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiMXbgOIp0SVuHAYNLqtLbjj/zPi/YpQLt8sEUphp+4=;
        b=tICwhg1FFzlVNkpvEBEfw1YJ7rsWkdVJ2mqShltZI/AsRL4dqaI6N1R+IvHtI8YtyE
         pvnAsMXvZVPWBXZ2n8iKad1MQoAYyq7yo3sn2WWMRNL9ncDUF683Ss6Ff/JxRUMn218z
         Dc9GDbNGhS/NdYeC8Toz8YWdmQOvA4CKOCtFUaBcd//W7ssBdzoc837X0UcRr+ufTBtU
         qK1CvZwEppdNi1icsnOzWTfnK2NzSA462J5jeVbwDWSx/VQL63dOpXlDISYMO7JspuA4
         AElLQf8bNZKQ/eof8fWtSCoVUzcuBtwdYLBKCCsfwZlHgKjr+fXvxeXAGzPTg5t8bfnj
         cZPQ==
X-Gm-Message-State: AOAM531n7LXgdMA1hPrWbYBoIdhmX2MEBXumAi2A5fBb9dJfbgDhw2Wf
        x4btTDnufjA5QzsUozDOVlJtxppX5q9/1pz1F3U=
X-Google-Smtp-Source: ABdhPJxtlyzC5rs1/oMbGTnC43dJAQLxjW7WhWwQsQunbsjtMx5IexRP5EYp5YUQWrgVKHcj2qlmB/cu290g9TPAAAM=
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr5704494edb.318.1640347779006;
 Fri, 24 Dec 2021 04:09:39 -0800 (PST)
MIME-Version: 1.0
References: <202112061844.RuSQXzxk-lkp@intel.com> <CAK8P3a0wboR0evmNGL_VEsNNdLd9x_v8k3APH70t5gfu9D=A6w@mail.gmail.com>
In-Reply-To: <CAK8P3a0wboR0evmNGL_VEsNNdLd9x_v8k3APH70t5gfu9D=A6w@mail.gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 24 Dec 2021 04:09:27 -0800
Message-ID: <CAMo8BfKa8xNEWdaeZCbLbyQ2ZgmNaLeNE8uB7Hntj9op0fTQ_w@mail.gmail.com>
Subject: Re: ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Dec 6, 2021 at 3:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Dec 6, 2021 at 11:30 AM kernel test robot <lkp@intel.com> wrote:
> > First bad commit (maybe != root cause):
> > commit: 570a82b9c36f76a5959b5e47900629b0d413931d media: i2c: select V4L2_ASYNC where needed
>
> Right, that is clearly unrelated.
>
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> ERROR: modpost: "__divsi3_table" [lib/lz4/lz4_compress.ko] undefined!
>
> lz4 was recently updated, and apparently now does a 32-bit division. I
> assume this
> is the decompressor, as arch/mips had similar problems.
>
> The possible fixes are:
>
> - disable lz4 compressed kernels on xtensa
> - change lz4 to not perform any division
> - change the xtensa decompressor to include the divsi3 helper code from the
>   main kernel, see fbf3bce45821 ("MIPS: boot/compressed/: add __ashldi3 to
>   target for ZSTD compression")

I couldn't reproduce this on xtensa with 5.16-rc6 and I don't think there
is such issue with xtensa because it has config-specific assembly
implementation of __divsi3 that doesn't use __divsi3_table.

Also the report is against nios2.

-- 
Thanks.
-- Max
