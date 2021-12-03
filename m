Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE2467BCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382181AbhLCQyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382155AbhLCQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:54:27 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC624C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 08:51:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z7so7887667lfi.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 08:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=7RLzTDUv8VPQuKAQO1KOPoH9Ek4D8djGLZsWCJ50TtY=;
        b=Ohb/WTE+9mg38iGsHSTOTqZQROPWbE8bhZLP4szo39azWsx5AYdjtKltOkM9FzZfvG
         jORep8blrWOXxLKjrGWbzSrMhqmylGXdrCzAF1bPIFP9ROsB8RtN2HWEXsX57YRo+FJY
         lfiwy5/FSZd+VTjbrouNjyhCni17EeEH1l85qPErCxXXCoLDDFJiG0xV4zG86Yn43ax7
         vq1fbLt36ucMnIQe7gzercxLh0uCpuFI5Et5pyjGWLDWVHEDzC6UbhnooeJ1MFpz07AW
         DN6c30yXL8nPxQFGnzvamm6R3v6LGbx5Q8SXBGX3JxCRaXQQ9pmnVQcgr9XHIbv9S0/K
         qabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7RLzTDUv8VPQuKAQO1KOPoH9Ek4D8djGLZsWCJ50TtY=;
        b=p8Rvib+/LPAjy2Gx6gR7vdud3T4LI9s5wbtvCFCXwIZjhIcNI8MKz2b1sQeWOOwS3Z
         pjNRWXHZi0NEDlKdHElv+KeZ0BPEtK/c2g/twQRnKdK+roQjNTcuVW6IBp0JBKekbQYY
         4qX2X60SG8wEg500nzPlBAOwYkpPundtdFx5X83mvRXAn/2pzYL0huYbINqTjGBgLOJf
         T0SHXGHu5meXiBg1AlUyOq3hexTNhKxGC7wGuALy+eATTkXC3eiW0QPY/ZAvOJO4mT5C
         0PGM235gUCH97T13MLHwfgrkyM0jJiKklkc5MHW6z6eDJ6YYpKm3AQ0RwO7dWjOvfMRk
         meHQ==
X-Gm-Message-State: AOAM530T2E9AQJ0jOQzU3QSwk6Vsl0pD75W1LixpiwpZh35DwOqRYdTS
        jw8sTBUes9wnk73+Wv+MtEarLR/UP9vEHtGbHtjLjaPfzhE=
X-Google-Smtp-Source: ABdhPJzG0dliDruLNZB8XZL0qzWtA1j0lMcS883TkAfSwf23n7ngGui8NYoA71pCTj/w0AAZXwb597hyEVXwq/543rM=
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr18858989lfr.348.1638550261111;
 Fri, 03 Dec 2021 08:51:01 -0800 (PST)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 3 Dec 2021 22:20:50 +0530
Message-ID: <CAHhAz+jpmksehY4BSH9jJPYuY+jykSHtx9TNiG-gAkq10zaXSQ@mail.gmail.com>
Subject: Time: new clocksource
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have a Digital PLL with 64 bit timer counter hardware and the
counter is accessible from the CPU over the PCIe bus.

Is it possible to add this timer counter hardware as new clocksource
driver? To do this, can someone please point me to the existing
reference source code(or patch) for this task.

Suppose if it is possible to add a new clocksource driver for this
hardware then does any userspace get_timestamp* API would get the time
from this new hardware?


-- 
Thanks,
Sekhar
