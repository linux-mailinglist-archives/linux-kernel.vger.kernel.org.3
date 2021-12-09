Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FF46E2BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhLIGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:45:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45096
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhLIGpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:45:50 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 42B7E3F1E6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 06:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639032134;
        bh=swq1AZoSp309wm9xlRcH11OjSaJoIt0KLT1/rOpQAug=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q30DPhVMIF4bGYTAFcMYpEsfXn6qmvQWJn3NzVzrx1ObZ51xCnbNJ/O3ADJk2TI5B
         I6efV2giAwjeLoAyQ/j0iPNJuXf060kwm1FEfXskRabZjayVLr4Pnr1C/tjJQmgvu7
         ooy/AljeuND507bylxh89VhORIFFviXnyi49KfbnN/X1lXqWaZXXHsIvb4Ye/6HeIE
         4lQlUu8vPwv/040I6XK3kEaTap8ZygscHcXm6f1c0Ukdlb0Y3YYJBYiykC9A5Zys/3
         y4PDk6mH+ZmVyZcX1T1fdMkLB7orN/y/Tq1OxS3Ltv6tzwvbGGTQJV44TNfpjfSTRi
         c1v+UCZOA1X1g==
Received: by mail-oi1-f200.google.com with SMTP id 6-20020aca0b06000000b002bcd1c33ae3so3260961oil.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:42:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swq1AZoSp309wm9xlRcH11OjSaJoIt0KLT1/rOpQAug=;
        b=qcGk55f9NCQyAPi7cc28BZRT+vQeFZlTl5ugMqJEj/a4qZdMajN8d2OTbCy3MBy3e5
         tdtysnFFu4uOvkwpSVFaAF4wFbz+uxiaorEkZprOvFpGgw+l98D/d68YPo7YRjqA83EU
         CBTDTZjO9AYc3AxHMmbSexbXu9t3NGpvqX6bwSuUc3E7dQMP2fu652/ab5t1pBM8KG4r
         ENioM1cN/K1BUTe44K66Hcvoezwgt48BM6o6fYmBgrwiWjtTOz3494ptvOFdimViHQWK
         93eoMpbw0vb3LTprcYnz0ru65LgZAabpJ6D1WZETKmVzeqWzMbMhWVdQA3XTtQhQFWSR
         qt6g==
X-Gm-Message-State: AOAM533J+62C9Ds/Rn2Zvkhm8L67aLgzujzzRBeGxHaPQFW5EqCrEZpx
        KGJ3jL5JgleaG+62I9e2uAsCKbPzKggGLBtqJEc3C8/QvjZpe3UxTyOsQTmCdBsr7gQM4D9enTw
        c6vZSUfpAX3mjPUBM+yJ+sfsDxohf1OGRbMRU2bLvt+5aqDcMW3GN7MXp0Q==
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr3702680oti.269.1639032133092;
        Wed, 08 Dec 2021 22:42:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzhJUNvWgAvt+t1/ayz0t4Vsm8y2saeIO3zTHINIXSFcSwNlALtVza1YQ6qO965CyMeBtgSauTKiASFAQoPuI=
X-Received: by 2002:a05:6830:1d87:: with SMTP id y7mr3702664oti.269.1639032132812;
 Wed, 08 Dec 2021 22:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20211119092628.677935-1-kai.heng.feng@canonical.com>
 <CAAd53p4CpEQR0Y5XDN5E7xZ-iw2GG=gGMSm2Vd=V_M1LLEuuCA@mail.gmail.com> <b7595524-1041-8b8b-dc61-9ee0acbc8307@linux.intel.com>
In-Reply-To: <b7595524-1041-8b8b-dc61-9ee0acbc8307@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 9 Dec 2021 14:42:00 +0800
Message-ID: <CAAd53p4OOyrLJYbhYVqJSJ2NukmhM26GEf7rM7cV0=6_djhpxw@mail.gmail.com>
Subject: Re: [PATCH] xhci: Remove CONFIG_USB_DEFAULT_PERSIST to prevent xHCI
 from runtime suspending
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 5:00 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 1.12.2021 2.19, Kai-Heng Feng wrote:
> > On Fri, Nov 19, 2021 at 5:27 PM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> When the xHCI is quirked with XHCI_RESET_ON_RESUME, runtime resume
> >> routine also resets the controller.
> >>
> >> This is bad for USB drivers without reset_resume callback, because
> >> there's no subsequent call of usb_dev_complete() ->
> >> usb_resume_complete() to force rebinding the driver to the device. For
> >> instance, btusb device stops working after xHCI controller is runtime
> >> resumed, if the controlled is quirked with XHCI_RESET_ON_RESUME.
> >>
> >> So always take XHCI_RESET_ON_RESUME into account to solve the issue.
> >>
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >
> > A gentle ping...
>
> Thanks
> Adding to queue

I haven't found this patch in your repo. Can you please push it so I
can backport it to downstream kernel?

Kai-Heng

>
> -Mathias
