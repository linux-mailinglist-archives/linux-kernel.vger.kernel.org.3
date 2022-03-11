Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408254D5EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbiCKJot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243478AbiCKJor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:44:47 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76B18CC0F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:43:44 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id h126so16131029ybc.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TIFu/VHHMOB76DBH3VmekrMNPHjC046YZKBlr3Q42S0=;
        b=yDo/kVojw5JfXILQOZb+2d0iyVAYnJKaRjlTcR3HrYYs523exps6sBTQU0iiynF/Ex
         fFSHZQS8K8E5JeW26GPi0dPcDi0GKiPab1PuZCjBARn6gNuo2xR6nebgQlGe8UfAJTvR
         CTVe9ksRUqHUF3nMtQRSqx5LtAkmMERp58MRCOdGot7Jq9EMgtXdfjuvnz5LH2SJemVN
         fugj6+4p8KWzHCn3e0dE7lDsngCKjxnCB+gEEAerXqz226CsDQhd36CBygZLKVQGpngw
         UqQiPIZ5WoBTKCPC6YuTcZujHoFblApvAmzNWAkyDv3+6P3qL0blAE8IKPKgVMtVS7ch
         dLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TIFu/VHHMOB76DBH3VmekrMNPHjC046YZKBlr3Q42S0=;
        b=SnsItfbXxjBCFSUa1PN4ev/vXvzOTrYoDqQr1wakC9Oj3M+hEvo7M6FVl3WbV0vQ+U
         zIRVOqAkCmLRExBmVboc1qbZ4MGRLNCzDL6dbGk2CoqH1ClSXdAKRSpCVsxSAXed0QBt
         bi78dxc+meCiFhPXOr/V3HpuauiZQkIsX+CEX4fQFZaiDCultoaRJrDNxTVX1CyqJ7K4
         klMLaIxrrroJHW3VZWnCbzPqKAkn1EEzU9tJq0wSV9pHLW6RTagD7PvwlW++K3gX1+NH
         hsOviYd4G8ZvqLEZiLNTwlHEAcnO7XiVu8C9bigSBdmobxxBglA4Ejmg9VJyX7DeSCsB
         PonQ==
X-Gm-Message-State: AOAM532U1l5M8mIT+2wRnDJHYggy51WXtayXgZbc9fo6yiyyCoEqa35q
        Mt5oHI/3Wx2+LjyxBWEhOycX6/nY+CF1l3rAfWElN83ZGsQY0kRg
X-Google-Smtp-Source: ABdhPJybv6BjNreR3Rcq9Uuz3MSOw2t7DM4faUzpVS5N9Jka0gwWccLB0/3djh4fLXQXr+8oysqkC3TNPpXprHy8F4s=
X-Received: by 2002:a25:ad07:0:b0:628:78df:ff24 with SMTP id
 y7-20020a25ad07000000b0062878dfff24mr7314699ybi.233.1646991823539; Fri, 11
 Mar 2022 01:43:43 -0800 (PST)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 11 Mar 2022 10:43:32 +0100
Message-ID: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
Subject: [next] arm64: allmodconfig: kernel BUG at include/linux/page-flags.h:509
To:     beaub@linux.microsoft.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
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

Hi,

I'm building and running an arm64 allmodconfig kernel on next.
Reacently I've seen this error below, for full log see [1].

[   56.000810][    T1] ------------[ cut here ]------------
[   56.003178][    T1] kernel BUG at include/linux/page-flags.h:509!
[   56.006291][    T1] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   56.008921][    T1] Modules linked in:
[   56.010600][    T1] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G
        T 5.17.0-rc6-next-20220304 #1
ff4358f1e97b9d4d3a7966961f455fb8cb5c735d
[   56.015962][    T1] Hardware name: linux,dummy-virt (DT)
[   56.018189][    T1] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT
-SSBS BTYPE=--)
[   56.021355][    T1] pc : set_page_reservations+0xf8/0x3b8
[   56.023655][    T1] lr : set_page_reservations+0xec/0x3b8
[   56.025976][    T1] sp : ffff80000eb37c20
[   56.027699][    T1] x29: ffff80000eb37c20 x28: ffff0000079d8050
x27: 0000000000000001
[   56.031030][    T1] x26: ffff80000a2c6140 x25: ffff80000e240380
x24: ffff80000b780f70
[   56.034381][    T1] x23: fffffc0000000000 x22: 000000000028b100
x21: fffffc000028b100
[   56.037728][    T1] x20: ffff80000e23ffe0 x19: ffff80000e23ffe0
x18: 0000000000000000
[   56.041039][    T1] x17: 0000000000000000 x16: 0000000000000000
x15: 0000000000000000
[   56.044323][    T1] x14: 0000000000000000 x13: fffffffffffe34f0
x12: fffffffffffe3498
[   56.047644][    T1] x11: 0000000000000000 x10: 0000000000000000 x9
: 0000000000000000
[   56.050941][    T1] x8 : 0000000000000000 x7 : 0000000000000000 x6
: 0000000000000000
[   56.054258][    T1] x5 : 0000000000000000 x4 : 0000000000000000 x3
: 0000000000000000
[   56.057729][    T1] x2 : 0000000000000000 x1 : 0000000000000000 x0
: 0000000000000001
[   56.061075][    T1] Call trace:
[   56.062436][    T1]  set_page_reservations+0xf8/0x3b8
[   56.064709][    T1]  trace_events_user_init+0x1bc/0x3f8
[   56.067110][    T1]  do_one_initcall+0x2ac/0x6c0
[   56.069267][    T1]  do_initcalls+0x17c/0x244
[   56.071269][    T1]  kernel_init_freeable+0x2a0/0x344
[   56.073587][    T1]  kernel_init+0x34/0x180
[   56.075614][    T1]  ret_from_fork+0x10/0x20
[   56.077655][    T1] Code: 97937293 f9401a80 91000400 f9001a80 (d4210000)
[   56.080828][    T1] ---[ end trace 0000000000000000 ]---
[   56.083250][    T1] Kernel panic - not syncing: Oops - BUG: Fatal exception
[   56.086279][    T1] ---[ end Kernel panic - not syncing: Oops -
BUG: Fatal exception ]---

Reported-by: Anders Roxell <anders.roxell@linaro.org>

Any idea what happens?


Cheers,
Anders
[1] http://ix.io/3Rkj
