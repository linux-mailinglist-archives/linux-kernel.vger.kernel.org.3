Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B1D51860C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiECOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiECOIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:08:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C521274;
        Tue,  3 May 2022 07:04:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m20so33617722ejj.10;
        Tue, 03 May 2022 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXCKqvLKkB4bXBbfle8OmINHHiIG/p2IXITk55h5KgU=;
        b=nS+pd5b5Y8vYmII3eSWJN2Lpt8idlIk6j+bktKQncl+ZLXprPbsMVnULqAOu0yGVpX
         Dkxw++aKU56zFZI8aK1HjXdgl98htcgKcO9k0IP+QQUDb5xbIoh0QnYXE3Ncmx4drsZB
         PSeTk5h8k6bRoJwUEoZV1JVbDGMXuj9D/h3wUXN1DS/XCXb6z8xT0Stf4/EqFW/UKUmJ
         gssnq9PSR1r34wW/lnkXyUoNvXLZ94idCNt6fY5daulany5zr+YXzrCm7GoH6bLNhDJ8
         WRJJINiS/bevITBjvgGsPBPhY0tDuBE8K8R3xzAe7vavl8X+SHxMjwirDdk6ALYhcAJG
         6NVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXCKqvLKkB4bXBbfle8OmINHHiIG/p2IXITk55h5KgU=;
        b=DEbN9EaP1P6bjv3F8b/sJ6q2Ye9JSj6LBHa9Ge9DYEeWA2L8rH2Sj2K4+cRFq57vSB
         DwZ54PlaPh8JmnVQVf1qegj+gZZZYlGMQJaaH8Y3ENCVJw7OwE6981bujBEbcBt9JYyc
         CLtED2gtwTx/VfEFtWeQvjR4b6hoca6PeT57x7F653ISbZ5Dk6Eaz/kKJ4dIm2SQ2Gat
         IxyapqyCdmWomDQOgu1gDo7seak9w1W/VNKxcUhlrFOJgp6pErrc1aea6jb/1VkfKzXE
         tjsKfq8/v7WPUPhvyU6iZBlO/Pvez7uOpqkZZ5IzkajLZUcGyjXqrAA2SjML/YF8/l6G
         BPPw==
X-Gm-Message-State: AOAM531D1jaZo2v+lzZr/r3E0auAhZLAKj7LDBECzvOfi6LCGVFSw7Pb
        vEQ6nZiYxvOR8cohV/Z9ZlrllwsA9G6VPLJ5Gd0=
X-Google-Smtp-Source: ABdhPJw5mejn9tBEu18+E0KV5pNN9CQoBPtNOkfQWMp7usK7nHOEoSTTKL2x2iKOTKRWcwLyBQHb6j5LAIQF+H9Y42w=
X-Received: by 2002:a17:907:86a1:b0:6f4:63ae:768 with SMTP id
 qa33-20020a17090786a100b006f463ae0768mr7442763ejc.639.1651586682466; Tue, 03
 May 2022 07:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-13-andrea.merello@gmail.com>
 <202204271554.EiuIRNPI-lkp@intel.com> <CAHp75Vc34K=5U=kMCqtDm_h3VBmqyCqcWr0em+8fZBiM2n76rA@mail.gmail.com>
 <CAN8YU5OeYjf5pikMuLXyaYTO1bsArdFOQf3M6tYMNubeZxqe7A@mail.gmail.com> <CAN8YU5PNUn9oVz9dRZ7BLzZmqfNpTehJp284ou+Y7-e4XgK7_Q@mail.gmail.com>
In-Reply-To: <CAN8YU5PNUn9oVz9dRZ7BLzZmqfNpTehJp284ou+Y7-e4XgK7_Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 May 2022 16:04:06 +0200
Message-ID: <CAHp75VeEzuQS5rOK7t5Lyq1wQKVQLNoU_W1K1M20Jx=a5U96TQ@mail.gmail.com>
Subject: Re: [v5 12/14] iio: imu: add BNO055 serdev driver
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 3:30 PM Andrea Merello <andrea.merello@gmail.com> wrote:
>
> Il giorno mar 3 mag 2022 alle ore 09:48 Andrea Merello
> <andrea.merello@gmail.com> ha scritto:
>
> [...]
>
> > > You need to add a C-file with the only line
> > >
> > > #include <..._trace.h>
> > >
> > > And drop that include from the _core.c.
> >
> > Hum, I'm a bit confused here: the bno055_ser_core.c file explicitly
> > looks for that tracepoints (e.g. it calls trace_send_chunks() and
> > friends); dropping the include prevents build here because there would
> > be no definition for those tracepoints.
> >
> > There is already a C file bno055_ser_trace.c that just contains the
> > said include and it defines CREATE_TRACE_POINTS; I see other drivers
> > like dwc3 do the same..
>
> Oops.. it turned out that I just had this almost-empty C file as
> untracked in my git tree, and it ended up not being included in
> patches also. Being it laying in my src tree caused the build to
> succeed.
>
> I have been misled by the other problem I (still) have (below); I was
> focused on the wrong thing, sorry.

So, there are two reports:
1) missed C file;
2) possible missed prototype.

To solve 1) you need to add the C file to the patch.
To solve 2) you need either declare it static or put it into the
header file (I haven't checked deeply which one is your case).

> > But my problem is that I cannot reproduce the issue found by the bot:
> > the compiler that is downloaded by the script doesn't run on my build
> > box because it wants a newer libc (I was hoping that those compilers
> > were statically linked, but they aren't), while any other attempt I
> > did with other older compilers resulted in either successful build or
> > failed with other weird, apparently unrelated, errors about relocation
> > issues (of course I tried with the arch and config used by the build
> > bot).

You may use compilers from kernel.org that don't require any libc at
all (only good for kernel compilation).

> > Is there any build farm publicly available or something like that?

Not of my knowledge.


-- 
With Best Regards,
Andy Shevchenko
