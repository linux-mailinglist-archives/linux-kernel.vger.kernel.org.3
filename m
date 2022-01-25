Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03AF49B5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578157AbiAYOPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386374AbiAYOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:10:30 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F58C06175D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:10:29 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 71so8635871qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OpAweGT1e4F9ySXm4/zalgDaK2uMw0uXyEeHsUeLwk=;
        b=ZtazNy6tcImVkBZqXX8Lq1agGcBdBFsPSQwWOMOTvOwBbYtjomh+AZKX0ipRFsjZew
         PXkCAEne7pMpPw4GsvIJ7rVUefFN0eqWgEhYEEg5ucmMhSlVqLFL0weSEf3lvaHNMhWO
         QuUyctFQSexdKok7VrhPvBkyb/133NhUvNMmnqfHj87a6+yYuo5+p+JxZ0KMvCRgHlUH
         4nfyg/xK2O5RoGf1WuvC5C9pZWy+wQvraGadYeMizIdZy2PqZOhG7umx/A9jpO1Gc4E1
         oVP4YfDQVYQIViLO/jtrf7nriS+9U8+KLXI6cQ1Yj2trqtTPz0oAMUixLfdPZEMc5NX9
         GVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OpAweGT1e4F9ySXm4/zalgDaK2uMw0uXyEeHsUeLwk=;
        b=UBanI15lHVZNT/pmQvs+9qdG+TVXpvrCw8XDamIOD2Szb7AczDzPVtA+9ZWV8R1oD8
         uKzpu+gOcyeO+WwNI0GGPQc11YYp1X7NZHJq9HUgXC4RDIgIkTamP+4hn8gjg9d1xeHi
         /6c/UVaTQj8y/OW/6mjIH1/z1p4Jg/2/ABl9dNq1HEXv4JJ6r2F7l0QEyOgG4VynlIZz
         J3g+dBUA4E78omO0xHRWo84r3hlE53Ii6qKxSYYggP3Wjxu522aQbywSizfKGg58wAXa
         xEYTVhYxhWaGVnAg3QHWIDsNjNAJAUVqnBA6xELIvM3kRZHou0c3E6M1gXyQzRYWL00n
         D+yw==
X-Gm-Message-State: AOAM533fyYkQq6J5AAfsCZa2FlGSBJ8h6wOlcyMfC/eBHH4w8VL7k9D3
        /PYQ3elsCNIR7zuhbCJ6kD61Sfb60eo6SxTwKs6MR/5FyeRzyQ==
X-Google-Smtp-Source: ABdhPJwja3bpzGz4mi2snRecqF3VQUdlkQeuOPF/0gmLP6K+MsCIu+yRLJ76ppLTr0vlvA4QbQXMyhgGFoZVhnUpMeg=
X-Received: by 2002:a05:620a:40c1:: with SMTP id g1mr14861610qko.588.1643119828550;
 Tue, 25 Jan 2022 06:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20211223082422.45637-1-heikki.krogerus@linux.intel.com> <20220125140033.1403-1-mike@fireburn.co.uk>
In-Reply-To: <20220125140033.1403-1-mike@fireburn.co.uk>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 25 Jan 2022 14:10:17 +0000
Message-ID: <CAHbf0-Hzkz5Frfw43jH5ACvHAgRLZEV-yGcWQKvwKnUQGyMXfw@mail.gmail.com>
Subject: Re: 'Re: [PATCH v5 4/5] usb: typec: port-mapper: Convert to the
 component framework'
To:     heikki.krogerus@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org, rafael@kernel.org,
        sakari.ailus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 14:00, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> This patch is stopping my ASUS G513QY from booting correctly
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 116 Comm: kworker/1:1 Not tainted 5.16.0-rc6-tip+ #2991
> Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
> Workqueue: events_long ucsi_init_work
> RIP: 0010:component_master_add_with_match+0x11/0x190
> Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
> RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
> RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
> R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
> R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
> FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
> Call Trace:
>  <TASK>
>  ? typec_link_ports+0x45/0x50
>  ? typec_register_port+0x20f/0x260
>  ? ucsi_register_port+0x33c/0x700
>  ? __kmalloc+0x14e/0x2a0
>  ? ucsi_init_work+0x15a/0x330
>  ? process_one_work+0x1dd/0x380
>  ? worker_thread+0x26d/0x4a0
>  ? kthread+0x182/0x1a0
>  ? worker_clr_flags+0x40/0x40
>  ? kthread_blkcg+0x30/0x30
>  ? ret_from_fork+0x22/0x30
>  </TASK>
> Modules linked in:
> CR2: 0000000000000008
> ---[ end trace 9c7dfbb7c9eaa418 ]---
> RIP: 0010:component_master_add_with_match+0x11/0x190
> Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
> RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
> RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
> R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
> R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
> FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
>
> Is it due to the USB-C port on the Radeon 6800M?
>
> Thanks
>
> Mike

Reverting both 730b49aac426e1e8016d3c2dd6b407e500423821 and
510a0bdb2bfcff8d7be822c72adc3add7a97d559 allows it to boot again
