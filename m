Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52DD4AACC7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 22:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359668AbiBEV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 16:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiBEV7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 16:59:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B00C061353;
        Sat,  5 Feb 2022 13:59:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so3310157pjv.5;
        Sat, 05 Feb 2022 13:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PWXw56wMSVUiQo+0Y/X1ZEc8HwPwp/sCbKGTlf6LMjs=;
        b=akjLYJsZTcN5ZzBMtnld1Izt5WF6Pacjnxu649A2A34JBhKdoWD0qdk0G2DxkdH930
         sWwEuVv7ldvooEhDVXBqvE/hPzyAsIorqDfQf9Y9Whdi/w+RTKvj5PD+BKVOH9/moJc9
         Os3dgxRTGCSzVc/4SsVQGgMtZsCUXUY1TSV5Zr5YjWEoasYoYdpepnGCAPzxU+GtpldA
         +QPrQ9nVvE//sBu/vf4BaRAE7iLhi38L/WNUwHA60Ag/kAhNqRvkl7cbEgZj9CV2nrkU
         2IuUTRiTsT+JMaToV/giN+oFjjmwBXNekLrsqHJEuOAPZc0MdYCI/Bbd/Gn0uBnT1r44
         W2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PWXw56wMSVUiQo+0Y/X1ZEc8HwPwp/sCbKGTlf6LMjs=;
        b=J3d1r2OpRnvt3NX2lJmWa9Xpcfsgt9fjueLWupQdQIMnjxlAQGqO/mdDqP0Be5JdEe
         FVSqCKTzbdfkDKuoL3kdB1Y49Il8expDdXFbIFqA/EffQi/NbUzd4w7P4+xuXefFDoSV
         T+M8nCjfD6caJ5n1kNyzE69w4HwNhkWbTP7/tg+C4uqIv8Jx65n+8onhJ0rIrCCYvOOn
         t3y1aK11OjIuONI2eL664UcRvpqpyLWF6KYWCrIT2fdkl2AG2NQL8tj7x22ofL51cvOR
         KgKh1eH9WqxgxCPwUewopSVQYKgEtUSxjJAvFUOIJFXr7uwHcfjHmsiJBc9zSKliULbQ
         QVcA==
X-Gm-Message-State: AOAM530EJqjMilZwEgxITV/tQ5dcmWzgniK16LJ4VVRuwl8TzBcWy+eS
        WINphj4NtlyMgUDuCGMtMoKl3ZCITQk=
X-Google-Smtp-Source: ABdhPJzX5yjwAdDFdotVdtPaI3Ecrj5KkR50/7owTP98UVyuhWA/p5XLhclwXNQNWdHJIve3p5BDUw==
X-Received: by 2002:a17:902:e88b:: with SMTP id w11mr9531591plg.153.1644098354413;
        Sat, 05 Feb 2022 13:59:14 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id lp17sm17664003pjb.25.2022.02.05.13.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Feb 2022 13:59:13 -0800 (PST)
Subject: Re: Regression in 5.17-rc1 on pata-falcon
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220128173006.1713210-1-geert@linux-m68k.org>
 <63c80eba-7c55-2a92-8078-c63cec3c9efb@gmail.com>
 <8913a0a2-9496-143c-18c2-f3023fd37ba0@gmail.com>
 <8d215dab-cd0f-452b-281b-f67c9324b53b@gmail.com>
 <CAMuHMdVnkvSCHKt5ouZP7HrMBg7nPg7fjiio-KVJ7dehA=FwyQ@mail.gmail.com>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Jens Axboe <axboe@kernel.dk>,
        Laibin Qiu <qiulaibin@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <eb5fc9ae-45a7-44d3-0238-5cdaa1ae3558@gmail.com>
Date:   Sun, 6 Feb 2022 10:59:07 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVnkvSCHKt5ouZP7HrMBg7nPg7fjiio-KVJ7dehA=FwyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert, Jens,

thanks for the hint - applying 10825410b956dc1e on top of 5.17-rc1 does 
indeed fix the issue.

nr_tags == 1 on the Falcon may explain why I ran into this. Oddly 
enough, I have the same on ARAnyM. Adding a second 'disk' there does 
reproduce the issue on ARAnyM though. nr_tags == 1 && nr_disks > 1 
appears to be sufficient to reproduce this.

I surmised I couldn't be the only one to run into this, but hadn't seen 
any other reports yet.

Cheers,

	Michael


Am 05.02.2022 um 21:31 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Sat, Feb 5, 2022 at 1:04 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> commit 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32 (blk-mq: fix tag_get
>> wait task can't be awakened) does cause a regression on my m68k hardware
>> test rig (m68k Falcon030, IDE disk attached through pata-falcon driver
>> which does use polled IO instead of interrupts, so may be a little on
>> the slow side).
>
>> Bisection between v5.16 and v5.17-rc1 points to
>> 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32 as the culprit, which is
>> corroborated by reverting that commit in v5.17-rc1 and booting as
>> rapidly as before.
>
> Now you know the culprit, it looks like several other people ran into this.
> Does this fix help?
> https://lore.kernel.org/all/1643040870.3bwvk3sis4.none@localhost/
>
> It is commit 10825410b956dc1e ("blk-mq: Fix wrong wakeup
> batch configuration which will cause hang") in v5.17-rc2.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
