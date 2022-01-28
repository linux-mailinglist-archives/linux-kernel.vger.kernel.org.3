Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68549F66A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbiA1JcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347649AbiA1JcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:32:07 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDBCC061749
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:32:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c190-20020a1c9ac7000000b0035081bc722dso3621293wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nQwmdL4iIAPOtT1oQnhBLytjcYLn22xr3bBplEiS/dA=;
        b=ib/enw01yTD/U3y5Ojj5qGRrugNZ6dbVMHr6dYT4JPA78ehfcxpoUlmBMeswIweKRq
         LS0iyBu/KhkWWw82loxolh3xXyB40Fu90y7t5mCyqrFFlDmw1LT5KKHKXcDeh2i3jtco
         /cHHeec7awyRvrKZzGB7l8VGottWNIZzvTa11+uiHrD1HbmTH5CMrfH58rT8NcMnsaRu
         R/zvDUa5CqYeYyshtVZ/yOxJ5dds1nzofLLHLaEz474vNr3CVXXV9/A5FQGPhOEuR1V4
         sxrLSEXmkFsfJzHGrpDZSTBTK+jSv8ZooNnkfb3WRGcaIRaBKopaweIkBtk7q765reIC
         oOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nQwmdL4iIAPOtT1oQnhBLytjcYLn22xr3bBplEiS/dA=;
        b=nlEmrO8340S2Sg4Fls/e7gD6YkC40CkX24aMYDkWkZe1GZ5Bq6bQqKYutcBdlLLxT9
         S/bFHgDTdGP5ZxZSf51M+rbg913YtSTs4oIaM9lpzZ94Bg7aNViiLU9AUjjBqdY8tCQ9
         iMJ5JycG5XEhUjiF7iQpFjjKHHvm0QZ8xe2/HqCd7z1TnMCnJnbN4aDArWepsX9dms1w
         cfkVGfp2fIE8dSYI2D+vcGcHtbAeFW1mBTWS4b6DGo7F43SVQGZpFYb00cgo5WMYhHxR
         aPJ/KoZ3zjyGybOWWmkyM7rTBgOOZZ/CpxLfoLDfqR/WXTEoGHEvv7J4a4L6jwnAYomU
         jl5Q==
X-Gm-Message-State: AOAM532Bg8Fxg6n0FM4Aib+LrgABZLjY8JDtzK3bKPK3U29EhvsLjASS
        n2tFJUXfbstB/Eos4z63Tq0Pag==
X-Google-Smtp-Source: ABdhPJzDu6NhXgIuruOD3ice3oH9wMNl+cyTdrfGgFS6E2NmXZlZvG4XF0cFjjnK65GOjBpUy3ZMyw==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr15290707wme.10.1643362324104;
        Fri, 28 Jan 2022 01:32:04 -0800 (PST)
Received: from google.com (cpc106310-bagu17-2-0-cust853.1-3.cable.virginm.net. [86.15.223.86])
        by smtp.gmail.com with ESMTPSA id l39sm1540154wms.24.2022.01.28.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:32:03 -0800 (PST)
Date:   Fri, 28 Jan 2022 09:32:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zichar Zhang <zichar.zhang@linaro.org>
Cc:     gregkh@linuxfoundation.org, john.stultz@linaro.org,
        krossmo@google.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        nayakvij@google.com, pavel@ucw.cz, rafael@kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] [RFC] wakeup_reason: Add infrastructure to log and
 report why the system resumed from suspend.
Message-ID: <YfO4EV2+aWYilUg8@google.com>
References: <CAE9iGoiCZZBkyX9ZWnhSDMjWmucOmybCOp=XTr6Hz5rN9GNyrw@mail.gmail.com>
 <20220128045522.3505336-1-zichar.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220128045522.3505336-1-zichar.zhang@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a little surface review.

I'll let the big people (SMEs) do the technical bit.

On Fri, 28 Jan 2022, Zichar Zhang wrote:

> When optimizing for power usage, it's useful to be able to track and
> log each time why the system woke up from suspend. This is useful as
> it helps us understand why we might be seeing more wakeups then we
> expect. For a while now, Android has carried the "wakeup_reasons"
> patch which provides this to allow developers to optimize battery life
> on devices.
> 
> This patch tries to provide a simplified version of the
> Android wakeup_reasons functionality. It tracks both software
> wakeup_sources as well as IRQS that brought the device out of suspend,
> and exposes these values as a string via /sys/power/last_wakeup_reason.
> 
> This differs slightly from the Android patch, in that it doesn't track
> the suspend-abort reason logging, the misconfigured or unmapped IRQS,
> the threaded IRQS, and time spent in suspend/resume. But it provides
> an initial simple step to add a useful portion of the logic.
> 
> Here is the requirements from https://lkml.org/lkml/2022/1/10/1134 for
> "wakeup_reason" with line head "[Y]" and "[N]" to notify if this commit
> meet the requirements or not. And if it is not, the detail reason is
> right behind it after "--".
> 
> * wakeup IRQs, including:
>     [Y]* multiple IRQs if more than one is pending during resume flow
>     [N]* unmapped HW IRQs
>     [N]* misconfigured IRQs
>     [N]* threaded IRQs (not just the parent chip's IRQ)
>     -- If we do these things, the additional codes should be added in
>     interrupt subsystem or some interrupt controller drivers. These
>     codes are no relationship with the interrupt subsystem or the
>     interrupt controllers. And we can't distinguish these IRQs from
>     "non-suspend" environment, even the "Android patch" can't do that.
>     So it will make the things complicated.
>     -- If these IRQs do hanpen, the code in this commit will catch
>     them as "unknown wakeup reason" and suggest user to check the
>     kernel log for more information.
>     -- I think We should cooperate with interrupt subsystem to log
>     these "abnormal" IRQs. And it could be several additional
>     commits to accomplish this work together then.
> 
> * non-IRQ wakeups, including:
>     [Y]* wakeups caused by an IRQ that was consumed by lower-level SW
>     [Y]* wakeups from SOC architecture that don't manifest as IRQs
> 
> * abort reasons, including:
>     [N]* wakeup_source activity
>     [N]* failure to freeze userspace
>     [N]* failure to suspend devices
>     [N]* failed syscore_suspend callback
>     -- These codes are "intrusive" to kernel (suspend/resume).
>     -- These "errors" are already printed in kernel log, if we add
>     these log to "wakeup_reason" either, it will cause double
>     "log string" in section ".data", which just waste of the memory.
>     -- As mentioned before, if these "abort action" happened, you
>     can catch string "unknown wakeup reason", and check the kernel
>     log then.
> 
> * durations from the most recent cycle, including:
>     [N]* time spent doing suspend/resume work
>     [N]* time spent in suspend
>     -- Just separate these from "wakeup reason". It should be done
>     in another commit.
> 
> This patch can be tested in Android using the following change to AOSP:
>   https://android-review.googlesource.com/c/platform/system/hardware/interfaces/+/1958666
> 
> And there is a stress test code for the interfaces in kernel:
>   https://android-review.googlesource.com/c/kernel/common/+/1958189
> 
> Any feedback or thoughts would be welcome!
> 
> Signed-off-by: Zichar Zhang <zichar.zhang@linaro.org>

You should probably tip your hat to the original authors at one
point.

> Change-Id: Id70f3cbec15f24ea999d7f643e9589be9c047f2b

No Androidness please.

> ---
>  Documentation/ABI/testing/sysfs-power |   9 ++
>  drivers/base/power/wakeup.c           |   6 +
>  include/linux/wakeup_reason.h         |  35 +++++
>  kernel/power/Makefile                 |   1 +
>  kernel/power/main.c                   |  11 ++
>  kernel/power/wakeup_reason.c          | 183 ++++++++++++++++++++++++++
>  6 files changed, 245 insertions(+)
>  create mode 100644 include/linux/wakeup_reason.h
>  create mode 100644 kernel/power/wakeup_reason.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index 90ec4987074b..e79d7a49a24e 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -182,6 +182,15 @@ Description:
>  		to a sleep state if any wakeup events are reported after the
>  		write has returned.
>  
> +What:		/sys/power/last_wakeup_reason
> +Date:		Jan 2022
> +Contact:	Zichar Zhang <zichar.zhang@linaro.org>

Are you pledging to be the official contact for the foreseeable
future?  Is this okay with the original authors?

> +Description:
> +		The /sys/power/last_wakeup_reason file shows the last reason
> +		causing system "wake up" from suspend state. It could be an
> +		interrupt signal, a kernel "wakeup_source" or just some other
> +		reason logged into this file, and shows as a string.
> +
>  What:		/sys/power/reserved_size
>  Date:		May 2011
>  Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 99bda0da23a8..a91ee1b8c0df 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -15,6 +15,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/debugfs.h>
>  #include <linux/pm_wakeirq.h>
> +#include <linux/wakeup_reason.h>
>  #include <trace/events/power.h>
>  
>  #include "power.h"
> @@ -924,6 +925,7 @@ bool pm_wakeup_pending(void)
>  
>  	if (ret) {
>  		pm_pr_dbg("Wakeup pending, aborting suspend\n");
> +		log_ws_wakeup_reason();
>  		pm_print_active_wakeup_sources();
>  	}
>  
> @@ -947,11 +949,15 @@ void pm_wakeup_clear(bool reset)
>  	pm_wakeup_irq = 0;
>  	if (reset)
>  		atomic_set(&pm_abort_suspend, 0);
> +
> +	clear_wakeup_reason();
>  }
>  
>  void pm_system_irq_wakeup(unsigned int irq_number)
>  {
>  	if (pm_wakeup_irq == 0) {
> +		log_irq_wakeup_reason(irq_number);
> +
>  		pm_wakeup_irq = irq_number;
>  		pm_system_wakeup();
>  	}
> diff --git a/include/linux/wakeup_reason.h b/include/linux/wakeup_reason.h
> new file mode 100644
> index 000000000000..8d6e7a0e0bad
> --- /dev/null
> +++ b/include/linux/wakeup_reason.h
> @@ -0,0 +1,35 @@
> +/*
> + * include/linux/wakeup_reason.h

These have a tendency to go out of date.

> + * Logs the reason which caused the kernel to resume
> + * from the suspend mode.
> + *
> + * Copyright (C) 2021 Linaro, Inc.

You can't just take Copyright{ed,written} code wholesale.

You need to keep the original Google one.

> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Replace with SPDX.

> + */

[...]

> +++ b/kernel/power/wakeup_reason.c
> @@ -0,0 +1,183 @@
> +/*
> + * driver/base/power/wakeup_reason.c
> + *
> + * Logs the reasons which caused the kernel to resume from
> + * the suspend mode.
> + *
> + * Copyright (C) 2021 Linaro, Inc.
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

As above.

> +#include <linux/kernel.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/notifier.h>
> +#include <linux/suspend.h>
> +#include <linux/wakeup_reason.h>

Alphabetical.

[...]

> +ssize_t log_ws_wakeup_reason(void)
> +{
> +	struct wakeup_source *ws, *last_active_ws = NULL;
> +	int idx, max, len = 0;
> +	bool active = false;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&wakeup_reason_lock, flags);
> +
> +	if (!capture_reasons) {
> +		goto out;
> +	}

Over-bracketing.

[...]

> +EXPORT_SYMBOL(log_ws_wakeup_reason);

wakeup_reason_* might be better/clearer way to namespace.

> +ssize_t log_irq_wakeup_reason(unsigned int irq_number)
> +{
> +	int len = 0;

Smaller data types (int, char, bool) usually go at the bottom below
larger ones (struct *).

> +	struct irq_desc *desc;
> +	const char *name = "null";
> +	unsigned long flags;
> +
> +	desc = irq_to_desc(irq_number);
> +	if (desc == NULL)

if (!desc)

[...]

> +ssize_t last_wakeup_reason_get(char *buf, ssize_t max)
> +{
> +	ssize_t len, size = 0;
> +	unsigned long flags;
> +
> +	if (!buf) {
> +		return 0;
> +	}

Over-bracketing.  I won't keep reporting on this.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
