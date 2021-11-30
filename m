Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB84636FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbhK3Osb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235434AbhK3Osa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638283511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N/D4Uh2tQePJy9ISUxPytT0nz40Sq7tw+TN3bITgjmE=;
        b=a1Tpq51B3rWmi0FOuHhYcz7YPxbgsAqOgD8aHPELR6x0HT3UDucNZauTsnn9I04TbMafgJ
        O6B5NTtnCuNo/02yNF8cKx7jFapPbguc//QG2O9+K7flGakPfb5G218JJT/DoSGtp+Efdn
        bDHH4fbO5pOS52UnTvo69VVpbVcSxXE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-zjFMEXhYMTyy-JDKsWPrdA-1; Tue, 30 Nov 2021 09:45:08 -0500
X-MC-Unique: zjFMEXhYMTyy-JDKsWPrdA-1
Received: by mail-pj1-f72.google.com with SMTP id x6-20020a17090a6c0600b001a724a5696cso9925164pjj.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 06:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/D4Uh2tQePJy9ISUxPytT0nz40Sq7tw+TN3bITgjmE=;
        b=SzfmyRaILVaqgIvVNikCCK8Ekych7rQ7TzWqz95y+DcPDPzQvQuqRG/vdYrWRefp7v
         vxLoiwYlAWo3fhaev1xP04FCy8y+9fsZUr2Bu9RAexjqBDfxuPsAX773UqiNfhpFnk2n
         6FVLIk/ACSiCaK8ktiUE87xqMTC7++xcbM3rnslHVpF+SpFzi5tUBpAI2H3MrsVwtbRG
         Ky+CY915nglWIkGt8+aRnMwDOK7uKksPQZIjY3kBku//F+YyMDkq9jcNkl5uuop9nu81
         c8v13kBLyBkA1EdCwf0gpHVjOGjgR8WtZDmjyiKd6a/aYznOWU4D9OIiVtfhuUH2xZ7i
         n82Q==
X-Gm-Message-State: AOAM530y+N38GawB5vwX64DZG6zdm7ENSLxp3bA7mERKbRyUc4WSldII
        zeAAI/e9ToPPr6ecAA9bWRPEKTBFm/9+fAO7XncPBEYhvYa/bRzi4F7BXui6WZmUNuMs+FqqmFk
        87jbRGFXwTday7B8lajl4uwVeDQ8eoMWRiP3UQ6SV
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr6565510pjb.113.1638283507716;
        Tue, 30 Nov 2021 06:45:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/GbMjaHEEpyrXrYvb0pycmTGPDKLSCBDVw5H6za5zXROyd/rafwD0byS0pSYtAcTrnS01FdaeQMM0I0ClGUc=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr6565466pjb.113.1638283507426;
 Tue, 30 Nov 2021 06:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
In-Reply-To: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 30 Nov 2021 15:44:56 +0100
Message-ID: <CAO-hwJLq6Jnvos=CR_-D6FD-7W56q2eYRVyRMbmE5NFaXLHrng@mail.gmail.com>
Subject: Re: [RFCv2 0/8] USI stylus support series
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tero,

On Fri, Nov 26, 2021 at 2:02 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi,
>
> This series is an update based on comments from Benjamin. What is done
> is this series is to ditch the separate hid-driver for USI, and add the
> generic support to core layers. This part basically brings the support
> for providing USI events, without programmability (patches 1-6).

That part seems to be almost good for now. I have a few things to check:
- patch2: "HID: hid-input: Add suffix also for HID_DG_PEN" I need to
ensure there are no touchscreens affected by this (there used to be a
mess with some vendors where they would not declare things properly)
- patch5: "HID: core: map USI pen style reports directly" this one
feels plain wrong. I would need to have a look at the report
descriptor but this is too specific in a very generic code

>
> Additionally, a HID-BPF based sample is provided which can be used to
> program / query pen parameters in comparison to the old driver level
> implementation (patches 7-8, patch #8 is an incremental change on top of
> patch #7 which just converts the fifo to socket so that the client can
> also get results back from the server.)

After a few more thoughts, I wondered what your input is on this. We
should be able to do the very same with plain hidraw... However, you
added a `hid/raw_event` processing that will still be kept in the
kernel, so maybe bpf would be useful for that at least.

>
> The whole series is based on top of Benjamin's hid-bpf support work, and
> I've pushed a branch at [1] with a series that works and brings in
> the dependency. There are also a few separate patches in this series to
> fix the problems I found from Benjamin's initial work for hid-bpf; I
> wasn't able to get things working without those. The branch is also
> based on top of 5.16-rc2 which required some extra changes to the
> patches from Benjamin.

Yeah, I also rebased on top of 5.16 shortly after sharing that branch
and got roughly the same last fix (HID: bpf: compile fix for
bpf_hid_foreach_rdesc_item). I am *very* interested in your "HID: bpf:
execute BPF programs in proper context" because that is something that
was bothering me a lot :)

"HID: bpf: add expected_attach_type to bpf prog during detach" is
something I'll need to bring in too

but "HID: bpf: fix file mapping" is actually wrong. I initially wanted
to attach BPF programs to hidraw, but shortly realized that this is
not working because the `hid/rdesc_fixup` kills the hidraw node and so
releases the BPF programs. The way I am now attaching it is to use the
fd associated with the modalias in the sysfs file (for instance: `sudo
./hid_surface_dial /sys/bus/hid/devices/0005:045E:091B.*/modalias`).
This way, the reference to the struct hid_device is kept even if we
disconnect the device and reprobe it.

Thanks again for your work, and I'd be curious to have your thoughts
on hid-bpf and if you think it is better than hidraw/evdev write/new
ioctls for your use case.

Cheers,
Benjamin

>
> -Tero
>
> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
>
>

