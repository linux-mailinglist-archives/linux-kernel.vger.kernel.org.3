Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA488546740
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343738AbiFJNSI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jun 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbiFJNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:18:06 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FE756FB0;
        Fri, 10 Jun 2022 06:18:04 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id p13so46952624ybm.1;
        Fri, 10 Jun 2022 06:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1n2jYozpLZQnwx3mJj45QZU3A4AwOVysJ3xBzSR/U4c=;
        b=tYtovsV8Iqi1Em0p+dbiEPY4i4ClaaGaZuwAUdOhMthFvJ5dDqYC4L99m2sUROyfxs
         bUdwUzvuL4cuF2flS+rbeTQxuWyzaqAIUr67rMd3nj5nmx3dyg2fTp7m0NiNuAgaOwE/
         UYltAIu/vt7Lt2gvMR0frHlcR/41t9r8/kR6gxuo5yneff8ZgVBPW68k9Ty6G40tt9q6
         FXzK/2bzYFGLr9rKfcO4aCj1+krhsVo5TqLWMZtroAmFtAjwnnw9EwksGsHZ9Bdzp0yJ
         5FMd++JcbNl2oUSYgIp9KkkyRO9kM/yKgs4HZ1x2+RpH8tAXAN4aWORwc2RYArbasOmy
         At4g==
X-Gm-Message-State: AOAM533NY2bcrpY0lzWzhkhytMz3AImVxYihvVchiGGitWf7om+iw569
        P2FOOeH8SIodI+LZJlubK6leIVZeD3fkR9DeZuE=
X-Google-Smtp-Source: ABdhPJxPdZpGROEDhuRT0A1yI5tchMcpkR1tcg0YaCWXWyyM1AsHyymecF6SgpcVqQhwd5AL8DKs89vxeGWVm6y4ZzU=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr47066326ybm.153.1654867083500; Fri, 10
 Jun 2022 06:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <1131544892.7359423.1654854725508.JavaMail.zimbra@email.it>
In-Reply-To: <1131544892.7359423.1654854725508.JavaMail.zimbra@email.it>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 Jun 2022 15:17:51 +0200
Message-ID: <CAJZ5v0jwdxOFME0NiCmTUO9pxZb5QKZ8ZAcAF10jQqzxkqpT6g@mail.gmail.com>
Subject: Re: Bug report for kernel v4.15-rc8+
To:     blinkin@email.it
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:52 AM <blinkin@email.it> wrote:
>
> hello, any news on this?
>
> ----- Messaggio originale -----
> Da: "Thomas Gleixner" <tglx@linutronix.de>
> A: blinkin@email.it
> Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, linux-acpi@vger.kernel.org
> Inviato: Mercoledì, 11 agosto 2021 16:20:41
> Oggetto: Re: Bug report for kernel v4.15-rc8+
>
> On Wed, Aug 11 2021 at 15:51, blinkin@email.it wrote:
> > 1) You're booting with an out of tree module
> >
> >   Uninstalled virtualbox, reproduced same behavior without the module.
> >   dmesg outputs attached with and without the workaround
> >   (dmesg_novboxdrv_clean.txt and dmesg_novboxdrv_irqaffinity0.txt)
>
> Ok.
>
> > 2) Please provide information what is consuming 90% of a CPU
> >
> >   top shows a kworker process consistently at 50% without the
> >   workaround, 60% with the workaround. No significant activity amounts
> >   from other processes.  Sometimes that 50% is split between two
> >   kworker processes for a short time.  CPU core #0 activity is a
> >   constant 60% without the workaround, 90% with the workaround
>
> That's broken. /proc/interrupts gives some hint:
>
> 1) Stock kernel
>
> >             CPU0       CPU1       CPU2       CPU3
> >    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
> >    1:          0          0          0          9  IR-IO-APIC    1-edge      i8042
> >    8:          0          1          0          0  IR-IO-APIC    8-edge      rtc0
> >    9:          0     923411          0          0  IR-IO-APIC    9-fasteoi   acpi
>
> 900k ACPI interrupts right after boot
>
> >             CPU0       CPU1       CPU2       CPU3
> >    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
> >    1:          0          0          0         11  IR-IO-APIC    1-edge      i8042
> >    8:          0          1          0          0  IR-IO-APIC    8-edge      rtc0
> >    9:          0    4869059          0          0  IR-IO-APIC    9-fasteoi   acpi
>
> One minute later it's 4.8M
>
> With affinity forced to CPU0 it's even more:
>
> >             CPU0       CPU1       CPU2       CPU3
> >    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
> >    1:          9          0          0          0  IR-IO-APIC    1-edge      i8042
> >    8:          1          0          0          0  IR-IO-APIC    8-edge      rtc0
> >    9:    7576456          0          0          0  IR-IO-APIC    9-fasteoi   acpi
>
> 7.5M right after boot
>
> >             CPU0       CPU1       CPU2       CPU3
> >    0:         10          0          0          0  IR-IO-APIC    2-edge      timer
> >    1:         11          0          0          0  IR-IO-APIC    1-edge      i8042
> >    8:          1          0          0          0  IR-IO-APIC    8-edge      rtc0
> >    9:   10992420          0          0          0  IR-IO-APIC    9-fasteoi   acpi
>
> 10.9M after one minute. Though the delta between right after boot and 1
> minute later is in the same ballpark.
>
> Cc'ed the ACPI people for clues.

Looks like a GPE storm to me.

I would look into /sys/firmware/acpi/interrupts/* for hints.
