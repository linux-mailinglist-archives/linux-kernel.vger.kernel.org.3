Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA16486955
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbiAFSB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbiAFSBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:01:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6118EC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:01:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 8so3236358pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XgTsSDw/cwN0SZ5s5fkZLZ3uXbTWYqRAbY7QRxHVY18=;
        b=8JVlsFdlqxOaS82s31Ts55+GXRP8BLCxJJgLC9uDmZ4opT+mG0Jzng218K3mB+rZRZ
         cilULMNS51t5yA/qi20o6ha5xXhwRk6k1VhWaaKxwW9TBYySNmC3rfQmamPTmO/JIsPI
         spQGwdlmCY7JEvXEBOeYnJORd7X8klyiUimItQ4tZgdKcpwdVknPK6Eah/OMHavBIyqt
         tOK8+uTnaXF9JflPvbX0hOr5y2T1VVxjRPtLka3jxwWkG07iFgMnGCU+I9cYXwnjDOTy
         JC/EdA2QACjR1vT9FER48Bl4XuVmrl5tCiLnrUP6xtzDcRiNrYZoAXsJPmyTS6eeZjDk
         wj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XgTsSDw/cwN0SZ5s5fkZLZ3uXbTWYqRAbY7QRxHVY18=;
        b=ZH6rByCQ1txXYwJ2zDEtXdtaa94g2B4CmLLXM4sKmETEdTDTqZ/qzh9leNz+9b57rv
         6zYBdFPEY3YbRd7A4SoHMoL86mK2XmhqpAd/BwT1Ys1OO2obtd40S7/1UF3T/pUcAsuj
         fCXt0SUS744yl2tGuNUathx026r56tbd5uNjLIy2wGwDD/NlGHukSWmc8fyddZHUglhP
         OdNzs+OwgmBMafTFmLxGrvUL/Y+dM8+xdPKTkyH8hJSC2OMbSvtUPyhijRuKqqX49sBp
         +wmtIUSYrXxdGXm2GtQ+3xKbqoBCKfexzLeVfFSctYHnjulYQ9ayQZY2JKJLN/zlhx+J
         vNhA==
X-Gm-Message-State: AOAM531FNXfuSTIsa+xVbS5gHMEn2hFwk6+v3pdka9QN7ysoS/CLR987
        lTfpGEECKXihRop8UcpGPxSUKA==
X-Google-Smtp-Source: ABdhPJwT1LjozBUHdb4tR7Ch6r8coyZ3NWcoe4v9PJh1J2xlNchg8+tOBsAnqgBCccZL2ctKWhCpuA==
X-Received: by 2002:a63:43c6:: with SMTP id q189mr53653779pga.424.1641492114780;
        Thu, 06 Jan 2022 10:01:54 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z13sm3123044pjq.0.2022.01.06.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:01:54 -0800 (PST)
Date:   Thu, 06 Jan 2022 10:01:54 -0800 (PST)
X-Google-Original-Date: Thu, 06 Jan 2022 10:01:12 PST (-0800)
Subject:     Re: [PATCH 0/12] RISC-V: Clean up the defconfigs
In-Reply-To: <CAEUhbmWP_e3_UWf-mO8AFwECw5Li0L=4Ywjb00jUHy2J1RX5Yg@mail.gmail.com>
CC:     anup@brainfault.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        heinrich.schuchardt@canonical.com, bin.meng@windriver.com,
        sagar.kadam@sifive.com, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, atishp@atishpatra.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-b74a848e-3cd7-4cd9-8831-d66c12b41aae@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 18:45:24 PST (-0800), bmeng.cn@gmail.com wrote:
> On Sat, Nov 20, 2021 at 12:32 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> On Fri, Nov 19, 2021 at 10:14 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>> >
>> > It's been a while since updating the defconfigs, so I figured it would
>> > be good to go through all the diff to make sure nothing was lurking.  It
>> > turns out there were two minor issues, which I've fixed with the first
>> > two patches.  The rest of these are just cleanups that should have no
>> > functional change.
>> >
>> > I don't have a K210 (I might somewhere, but I've yet to boot it) so I
>> > can't test this to make sure, but I think patch 2 is the reason we have
>> > a special !MMU PAGE_OFFSET config.  If someone does have one it'd be
>> > nice to be able to remove that special case.
>> >
>> >
>>
>> Using savedefconfig, I used to always get a huge diff so thanks for
>> doing this cleanups. Going forward, I suggest that we insiste everyone
>> to always use "make savedefconfig" for creating defconfig patches.
>
> Yep, using "savedefconfig" is always required by U-Boot maintainers. I
> thought that's always the case for the Linux kernel but it seems it is
> not the case.

It's actually a bit more complicated than that, as the results of
savedefconfig change to track Kconfig updates.  I'd mostly been running
savedefconfig and tossing the extra diff for people, but that led to a
bit of a mess here.

There's no way we can require everyone to run savedefconfig on our tree 
(and even if we could, it'd be a merge nightmare).  IIUC what most folks 
do is regularly re-spin the defconfigs, now that they're clean that 
should be easy.  I'm going to start doing that, the best I can come up 
with is in the second week of the merge window -- that way we'll have 
both fixes and for-next based on the newer defconfigs, along with all 
the WIP branches that folks base on rc1.  If anyone's got a better 
scheme then I'm all ears, though.

This patch set is on for-next.

Thanks!
