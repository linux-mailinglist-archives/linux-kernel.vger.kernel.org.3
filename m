Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F84E469075
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhLFGsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhLFGsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:48:30 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801E5C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 22:45:02 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 7so19669621oip.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 22:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSnHdzIbxQoy9DZyneDfB79DXsUn/RP48bNzIj0Nq7k=;
        b=I9zmJu2usP7mwYh+KzVKH5075OucDl4tCUofCiz0UWZLYDnQlXpzw1AWI9IFbeqpFl
         RE9rQyCp9zOzYo3DPJgtNtdd6NHleaCH/QzzcNUh4UFjfzOiRjeJ4rMMTOs/ETY9VO+M
         08HsqemdbwGtmdr/5TMXjW69b7IgPKNNNw6e/Fhl+vV9IuWDx7jWA0Rk00dxgY/+500Z
         4DwFjjUKDJBKQawSsBX9/yYNaGNBxvqluWTgEDHKeSmoM9K50GXi3NS0GeyVgujBtzbw
         Pi8v59YMmtF5Aq0Jbu5OrGUSq2GJ/M3f16lfO8/Hc49bKaHwhokGsYm+Ib4rAJ8XvcYV
         Zf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSnHdzIbxQoy9DZyneDfB79DXsUn/RP48bNzIj0Nq7k=;
        b=fl2I7YXlATYSijKSPnCZYSadAMjbjTGAvRTh9OJFn+FsZi/mQTIKjXTPwHYyBT8xu5
         bTQ1bZQhnPqJMaCRs7F9Q3Mb6ksLaZj4XiBmZkDvU3RDR1XgXBZkuSqqZEV9cTOxdgMc
         7R3/GP9Iq1E3QNS5od2Ss0eoEDD6nUm7ZeqKQle+zfZlqkzhCOHNhinjYATfBrYYSXeR
         QrzKthZAxGeNKah72lVRKnbtTJgkF3tYRIb1i30+r/tr0NvwHLAvoAfzLLTOj+O4IcJi
         NAx4EhYXxUzNSUuBgyOnSJJ37ETvHfHQ3uSmmxTp/w3mZ2aeQrGQXEELxaV6P/pLSns6
         z+ag==
X-Gm-Message-State: AOAM533iheT8FKKzQTNGGoGEY6OrskIHJ+b5PCqO9H/9C1b0GyQyVCNE
        BfwdDSrZJIOPeiyB4hN6B1qSmUBbd6kGwnzel/DpSg==
X-Google-Smtp-Source: ABdhPJxU8nv8sPEyVR6lzeXa0J7e4wcaquThgFhvkarHcNzUSdSWpfQ2Kak6LM6uJESzDlxRvFgrSYnZmpTZ0/N2mNk=
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr22020548oil.65.1638773101247;
 Sun, 05 Dec 2021 22:45:01 -0800 (PST)
MIME-Version: 1.0
References: <202112050757.x67rHnFU-lkp@intel.com>
In-Reply-To: <202112050757.x67rHnFU-lkp@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 6 Dec 2021 07:44:49 +0100
Message-ID: <CANpmjNNFaab-rE2zY_SXCqXsuUAxim8_OLwVT9faY5zQ1qz1_w@mail.gmail.com>
Subject: Re: [paulmck-rcu:dev.2021.12.02a 30/43] kernel/kcsan/selftest.c:172:34:
 error: implicit declaration of function 'clear_bit_unlock_is_negative_byte'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Dec 2021 at 00:09, kernel test robot <lkp@intel.com> wrote:
[...]
>    kernel/kcsan/selftest.c: In function 'test_barrier':
> >> kernel/kcsan/selftest.c:172:34: error: implicit declaration of function 'clear_bit_unlock_is_negative_byte' [-Werror=implicit-function-declaration]
>      172 |         KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
>          |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    kernel/kcsan/selftest.c:136:17: note: in definition of macro '__KCSAN_CHECK_BARRIER'
>      136 |                 barrier;                                                                        \
>          |                 ^~~~~~~
>    kernel/kcsan/selftest.c:172:9: note: in expansion of macro 'KCSAN_CHECK_READ_BARRIER'
>      172 |         KCSAN_CHECK_READ_BARRIER(clear_bit_unlock_is_negative_byte(0, &test_var));
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

Fixed by: https://lore.kernel.org/all/20211206064151.3337384-2-elver@google.com/

Thanks,
-- Marco
