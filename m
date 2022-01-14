Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16F48E4EE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiANHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 02:42:48 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26211 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiANHmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 02:42:47 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 20E7gPrK029622;
        Fri, 14 Jan 2022 16:42:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 20E7gPrK029622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642146145;
        bh=RxR9Y1aTYNqyuNReGQsyWHu/YEKX916U6bg7bx8cfMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1QRAJd4MK6p5BZRpNhiJu7l8p64NBV+z0YrZKt7P6GzY39c3/xOqdF3tA+F3B2aSm
         5Gi/I8GfMuv0j2+OH9kTzB0Fj9O8/AoXfRlSufXoVZcMibEaLceO1xCaiZqwGxUuDo
         HZSgc7POrgqhADZlrpSofynYabDPC2m6Xz8wga51jWysjeFv898T3ZDzrN5qeA+QcK
         cFP5FsL8uiYv+adX8ffNNBbBva4GCkCJwEDSWuA6i71xdULoXwmSQmRRYeTT5nUfRK
         SHa2RUmCRhYwd9xI/PU0la3D5FLn+YboReUoU0i461ALUf/LERPY4Rbs5FZ0pIQj3Q
         CB0YJPXLUmLOA==
X-Nifty-SrcIP: [209.85.216.42]
Received: by mail-pj1-f42.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so21243718pjj.2;
        Thu, 13 Jan 2022 23:42:25 -0800 (PST)
X-Gm-Message-State: AOAM5328nUuCSjP7/FRuvEFzvFGEUvJW8tuJqTkX3eZzgJP+zcfXvBR6
        l7J4O/Ouys7KaUvrZ6H7SrsFjQPbyD7gt/jYd40=
X-Google-Smtp-Source: ABdhPJz6Q+5waUCDmsuRFyx7DQVb9WOx45g+eteK7BGVCCaBu5mmDaYRiLIWykVJzQ/vQA0wMQa31velzFok4yz6uCY=
X-Received: by 2002:a17:902:b206:b0:149:3b5d:2b8b with SMTP id
 t6-20020a170902b20600b001493b5d2b8bmr8319177plr.162.1642146144581; Thu, 13
 Jan 2022 23:42:24 -0800 (PST)
MIME-Version: 1.0
References: <1B559478-D266-4D77-B9D5-F6F21D9EFB83@gmail.com>
In-Reply-To: <1B559478-D266-4D77-B9D5-F6F21D9EFB83@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 14 Jan 2022 16:41:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAg6HcTaswa03w=RR3jRbuP32wxRdcFsXEUcFgggfv2A@mail.gmail.com>
Message-ID: <CAK7LNATAg6HcTaswa03w=RR3jRbuP32wxRdcFsXEUcFgggfv2A@mail.gmail.com>
Subject: Re: Missing closing files in linux/scripts/kconfig/confdata.c
To:     Ryan Cai <ycaibb@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 12:11 PM Ryan Cai <ycaibb@gmail.com> wrote:
>
> Dear Kernel maintainers,
>
>           1. In linux/scripts/kconfig/confdata.c (conf_write_autoconf_cmd), the file opened at Line 946 may not closed when going to Line 981.
>           Location: https://github.com/torvalds/linux/blob/e851dfae4371d3c751f1e18e8eb5eba993de1467/scripts/kconfig/confdata.c#L964-L981
>
>          2. In linux/scripts/kconfig/confdata.c (__conf_write_autoconf), the file opened at Line1081 may not closed when going to Line 1095,
>            Location: https://github.com/torvalds/linux/blob/e851dfae4371d3c751f1e18e8eb5eba993de1467/scripts/kconfig/confdata.c#L1081-L1095
>
>            I think, the fix is inserting fclose before the returning. Should it be a bug? I can send a patch for these.
>
>
> Best,
> Ryan
>
>

Can you send a patch,
or do you want me to do it?


-- 
Best Regards
Masahiro Yamada
