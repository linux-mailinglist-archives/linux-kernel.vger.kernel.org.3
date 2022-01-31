Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862234A47A7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbiAaM7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378006AbiAaM7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:59:05 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134CDC061714;
        Mon, 31 Jan 2022 04:59:04 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id i62so40091966ybg.5;
        Mon, 31 Jan 2022 04:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InIT7e5sFjYCe8zq5a/i4pLqMB2jT9u1LGZEZm0evPs=;
        b=dbw5zLDsiECQGvigQuV3Kz0S/5Cl4P62hvPQ6hPeSx0fz8w4h09E3UYKQeBWgT9uWV
         JvC9ei1cx7+LwaGt4AKCEE8GbgCWV0Wn7d4sKEP4aNJxZKK1oICIYi+HEwUSzPnd8iOp
         RY+oVSqBv0D+0RPIvtoT0A27+Maqzu0njQqtGEuhowvbDYNmvPHLvQbf32ihBttdpo8G
         T4BD8hPfxP53yu6mDLbAqFEChre13xuaI6ltIdj+DachImfwRlsolNQBQfToOcCJtvs/
         AXe9PmabQvmPX44K5XUnvL26/tLBfCpDfIurlRU86dmTWjw/U3mLugSDMQnZ1YNbYcal
         owjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InIT7e5sFjYCe8zq5a/i4pLqMB2jT9u1LGZEZm0evPs=;
        b=53KuaFguGTD4qLJS3zOin8m6C3jchNHtDxnUNvSWaFuCofQQe6meVZRUmlCcbO+I4i
         cd/GkZu8M/FH5KKrUXdVuuaqmjHa/uQCLomv2VRwodnbYIN4H56vY0R1cH72UoY5WSM0
         MoSlKJc3A3WJ8dW3H5C4Ir7QEnHYueZksNSxM5fAztX7s400ry4GCflTivDDvUTilXdv
         FAw4U0f2VboihxhCQI12y/CSBr7k0sMLFd4nMCKo+6dDcxbBF5nfv2Gr2VG6524+qYSu
         QkpKCwBZfCzUeLzMAOFl9OwWgYZx3KyIzHidOx7crqJzdl/6WSFaCpT68fVM9tEws+Hc
         3Eew==
X-Gm-Message-State: AOAM530Vz/VuWh4iHysJrXSWNySbur3u+8YzoXcB1IWNy0BYfVXSxXQz
        vJFKYRhNBvib6wczD1QKJwJ444lHIaSFPaQjJ7qpQBpr3io=
X-Google-Smtp-Source: ABdhPJxEV6XfFqeB7qv8A/LMjexHNkkX+WcwYj87dKbD2/AN8Ird4zYeHbiVht5lA86xLhOPsN3IJfN9DsNOpoCP2lY=
X-Received: by 2002:a25:b950:: with SMTP id s16mr27145694ybm.748.1643633944152;
 Mon, 31 Jan 2022 04:59:04 -0800 (PST)
MIME-Version: 1.0
References: <YfMpk7DM9zA7NfmI@debian> <CAAq0SUnNtS8b3419egw-WVH8ic+MxH8oQELm1K0s4iqt8pYKnQ@mail.gmail.com>
In-Reply-To: <CAAq0SUnNtS8b3419egw-WVH8ic+MxH8oQELm1K0s4iqt8pYKnQ@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 31 Jan 2022 12:58:28 +0000
Message-ID: <CADVatmM5=sZLaT8SWcvmFtcMhVJsuVCu66nCnhL6i2p062ZhXA@mail.gmail.com>
Subject: Re: Regression with 5021d709b31b ("tty: serial: Use fifo in 8250
 console driver")
To:     Wander Costa <wcosta@redhat.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

On Fri, Jan 28, 2022 at 12:31 PM Wander Costa <wcosta@redhat.com> wrote:
>
> On Thu, Jan 27, 2022 at 8:24 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > Hi Wander,
> >

<snip>

>
> Thanks for the report. As Greg said, the patch has been reverted. In
> the meantime, could you please apply this patch and report if the
> problem still happens:

Thanks for the patch, and I can confirm after applying the patch the
problem is not there any more.
Log at https://lava.qa.codethink.co.uk/scheduler/job/602


-- 
Regards
Sudip
