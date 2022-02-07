Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774C64AB96D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 12:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377905AbiBGLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 06:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353048AbiBGLMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:12:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70DC043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 03:12:05 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n8so26096293lfq.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbKWNzwtzweE+tESV0+fzTxjkTTK/lxc2KgkbgEllU8=;
        b=Bqu1THJMQ0yvHj3Dre8UYh6otX0QojMqhcpvqJsKcG99JBbHgGxFC4U8wrffpFI2MS
         Sa0EOyFgLtUxjOivr0XSGw2keEcixLf6N1uIEOIQ8R5GoW7Nl07yxQSpMYNjIvVALMyC
         siU5IVpmFAJMSnAAtII7eb83o7K77CjOHcIwkTBiMtWlGbaBTrZsihxccDWhs/J+7/Iu
         6SkSTGMxOs1wan/pWtBBAh+6JPi9BO1tlnPQ3wX+d3wodY/V/LJP0GRsNeLyYGzotZQ4
         Y1w3/+1yNRXQ8YcB1dCFh/y+5aBWQwvTZuVNIi+mj7v/sxwkED8usIoP93ICIRFmGb9D
         PSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbKWNzwtzweE+tESV0+fzTxjkTTK/lxc2KgkbgEllU8=;
        b=pZuv/WnXivKnESGJjgE4HgfKMBO+4ulIbPg/8N6tYyU4hI5p9ISi0Z7zlbf+vNI/O8
         yCey6GcZusedHKqnOms1Rd4o6zjvPyZpVPngxivxDBZUMPVGDYxJn5FCuUbaIPXl82jo
         wqOmyMJ/xWokyOv6MsaZOCNhqJ6lr2swnBxiK0VnsYbozsdm/R+OHOqzltO98R7ID6Ze
         YIiNjBgZFGsS2HmJqWi+aiQvjrdSPFdFJZPXZaxF2FVBiNHjzICGvIcTdQXAI6597XJN
         mdHXkHlNjluVHvnQlIItDDXcA3JvbAWWZ72NeoYET3DOfe03bZOU063IJlvumWiuInGq
         QgTg==
X-Gm-Message-State: AOAM532DkZvlH/WPT+r224vCRdItgVyn0jrpRUZ8fBB1KxL1JzgQPdcv
        RHUMSkmbBBCBqfKPIOmgmHqqh1A7ihnLKyoix3YZng==
X-Google-Smtp-Source: ABdhPJwEVJnnNaxNKAnDxmE98KcsOO4AdVUEM4kKNPEV3/s9YO0k3TL/eLzyo53nzbo+dPK3K3FaKrFhuPiD0ba/vo0=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr8074861lfv.71.1644232323581;
 Mon, 07 Feb 2022 03:12:03 -0800 (PST)
MIME-Version: 1.0
References: <8e61aed5f64e434abc1d7b6f81859c8a@realtek.com> <CAPDyKFrLpim75nUB7ksDie2edkWsnFSq6TbFSFFpw5cY5d4y1w@mail.gmail.com>
 <fabaed5751f04105a9719c1cb0390c98@realtek.com> <CAPDyKFr3NRUgfKtkb2DBrhziekFAB0jT_X3Fsfvjk_bGZLC9mA@mail.gmail.com>
 <fa10aa1c644241808c2ad880088240ab@realtek.com> <CAPDyKFrtBKHHRgeF-JO27ANsbSmt8rdnhn-WNr5Je9okEgA29Q@mail.gmail.com>
 <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com>
In-Reply-To: <feb0c4e71e9c48a2a21f18b7d3baf135@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Feb 2022 12:11:27 +0100
Message-ID: <CAPDyKFoq_PDk_JgW4D+o4eEPdcffUq2RLbBreRDqeK47m0UnJA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: rtsx: improve performance for multi block rw
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > >
> > > > > Do you have any suggestion for testing random I/O But we think
> > > > > random I/O will not change much
> > > >
> > > > I would probably look into using fio,
> > > > https://fio.readthedocs.io/en/latest/
> > > >
> > >
> > > Filled random I/O data
> > > Before the patch:
> > > CMD (Randread):
> > > sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread
> > > -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest
> > > -bs=1M -rw=randread
> >
> > Thanks for running the tests! Overall, I would not expect an impact on the
> > throughput when using a big blocksize like 1M. This is also pretty clear from
> > the result you have provided.
> >
> > However, especially for random writes and reads, we want to try with smaller
> > blocksizes. Like 8k or 16k, would you mind running another round of tests to
> > see how that works out?
> >
>
> Filled random I/O data(8k/16k)

Hi Ricky,

Apologize for the delay! Thanks for running the tests. Let me comment
on them below.

>
> Before(randread)
> 8k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=8k -rw=randread
> mytest: (g=0): rw=randread, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T) 8192B-8192B, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>    READ: bw=16.5MiB/s (17.3MB/s), 16.5MiB/s-16.5MiB/s (17.3MB/s-17.3MB/s), io=1024MiB (1074MB), run=62019-62019msec
> Disk stats (read/write):
>   mmcblk0: ios=130757/0, merge=0/0, ticks=57751/0, in_queue=57751, util=99.89%
>
> 16k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=16k -rw=randread
> mytest: (g=0): rw=randread, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>    READ: bw=23.3MiB/s (24.4MB/s), 23.3MiB/s-23.3MiB/s (24.4MB/s-24.4MB/s), io=1024MiB (1074MB), run=44034-44034msec
> Disk stats (read/write):
>   mmcblk0: ios=65333/0, merge=0/0, ticks=39420/0, in_queue=39420, util=99.84%
>
> Before(randrwrite)
> 8k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=100M -name=mytest -bs=8k -rw=randwrite
> mytest: (g=0): rw=randwrite, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T) 8192B-8192B, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>   WRITE: bw=4060KiB/s (4158kB/s), 4060KiB/s-4060KiB/s (4158kB/s-4158kB/s), io=100MiB (105MB), run=25220-25220msec
> Disk stats (read/write):
>   mmcblk0: ios=51/12759, merge=0/0, ticks=80/24154, in_queue=24234, util=99.90%
>
> 16k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=100M -name=mytest -bs=16k -rw=randwrite
> mytest: (g=0): rw=randwrite, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>   WRITE: bw=7201KiB/s (7373kB/s), 7201KiB/s-7201KiB/s (7373kB/s-7373kB/s), io=100MiB (105MB), run=14221-14221msec
> Disk stats (read/write):
>   mmcblk0: ios=51/6367, merge=0/0, ticks=82/13647, in_queue=13728, util=99.81%
>
>
> After(randread)
> 8k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=8k -rw=randread
> mytest: (g=0): rw=randread, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T) 8192B-8192B, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>    READ: bw=12.4MiB/s (13.0MB/s), 12.4MiB/s-12.4MiB/s (13.0MB/s-13.0MB/s), io=1024MiB (1074MB), run=82397-82397msec
> Disk stats (read/write):
>   mmcblk0: ios=130640/0, merge=0/0, ticks=74125/0, in_queue=74125, util=99.94%
>
> 16k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=1G -name=mytest -bs=16k -rw=randread
> mytest: (g=0): rw=randread, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>    READ: bw=20.0MiB/s (21.0MB/s), 20.0MiB/s-20.0MiB/s (21.0MB/s-21.0MB/s), io=1024MiB (1074MB), run=51076-51076msec
> Disk stats (read/write):
>   mmcblk0: ios=65282/0, merge=0/0, ticks=46255/0, in_queue=46254, util=99.87%
>
> After(randwrite)
> 8k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=100M -name=mytest -bs=8k -rw=randwrite
> mytest: (g=0): rw=randwrite, bs=(R) 8192B-8192B, (W) 8192B-8192B, (T) 8192B-8192B, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>   WRITE: bw=4215KiB/s (4317kB/s), 4215KiB/s-4215KiB/s (4317kB/s-4317kB/s), io=100MiB (105MB), run=24292-24292msec
> Disk stats (read/write):
>   mmcblk0: ios=52/12717, merge=0/0, ticks=86/23182, in_queue=23267, util=99.92%
>
> 16k:
> Cmd: sudo fio -filename=/dev/mmcblk0 -direct=1 -numjobs=1 -thread -group_reporting -ioengine=psync -iodepth=1 -size=100M -name=mytest -bs=16k -rw=randwrite
> mytest: (g=0): rw=randwrite, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=psync, iodepth=1
> result:
> Run status group 0 (all jobs):
>   WRITE: bw=6499KiB/s (6655kB/s), 6499KiB/s-6499KiB/s (6655kB/s-6655kB/s), io=100MiB (105MB), run=15756-15756msec
> Disk stats (read/write):
>   mmcblk0: ios=51/6347, merge=0/0, ticks=84/15120, in_queue=15204, util=99.80%

It looks like the rand-read tests above are degrading with the new
changes, while rand-writes are both improving and degrading.

To summarize my view from all the tests you have done at this point
(thanks a lot); it looks like the block I/O merging isn't really
happening at common blocklayer, at least to that extent that would
benefit us. Clearly you have shown that by the suggested change in the
mmc host driver, by detecting whether the "next" request is sequential
to the previous one, which allows us to skip a CMD12 and minimize some
command overhead.

However, according to the latest tests above, you have also proved
that the changes in the mmc host driver doesn't come without a cost.
In particular, small random-reads would degrade in performance from
these changes.

That said, it looks to me that rather than trying to improve things
for one specific mmc host driver, it would be better to look at this
from the generic block layer point of view - and investigate why
sequential reads/writes aren't getting merged often enough for the
MMC/SD case. If we can fix the problem there, all mmc host drivers
would benefit I assume.

BTW, have you tried with different I/O schedulers? If you haven't
tried BFQ, I suggest you do as it's a good fit for MMC/SD.

[...]

Kind regards
Uffe
