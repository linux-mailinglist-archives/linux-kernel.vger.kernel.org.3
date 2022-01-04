Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0C484ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiADWkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiADWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:40:19 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A8C061761;
        Tue,  4 Jan 2022 14:40:18 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e202so69610832ybf.4;
        Tue, 04 Jan 2022 14:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IuzlBzWwz0eLRfvlvM2fUetbXZz141+m60c5RomzezM=;
        b=UECQVv/0lVcZxyKv478waWuzwsO9RZZbTrKhLh2yQynrLSgWgi5IRRbh6/O6D0z3e1
         AjhILwq2OgKb9Xe6LXnUIGr0SUn2xXHUqyBF6984Sb0VIIvGXr694TLk/Ed23bJHw1w3
         m2qH2SjYFWwb2wPzJdXK6ZoU5y/EibVzA5sHfUn9oabYMVTgt+L2kATwJPXty6AG6zBQ
         c/Qwt3RZgzicZ4rNhUr7uatfPoZ/EeSX6EiyyvVEA5ZOz6GAg32ECG2pU2lsqVkeblID
         2xNUlhb6QkTrVCmf4TotkyDAfiOIhOme9uSTRiwul35Qg5IBMzRSYhB5WBgGi5fz0drE
         IdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IuzlBzWwz0eLRfvlvM2fUetbXZz141+m60c5RomzezM=;
        b=Ef7L7+/h1dmzIshpmLyJ11dlM6vpxk85jRwCVFZ8qhLg5+33ZOiwbzc4hOxZQObqM7
         wIAs/6MsDJ4PCOL1L5IbHh9nAEYwuqc51saGTHUa37sRkspur1kxyzoIXx8OjTgIu16R
         6ZNqep3dAtYw86PIMS2AgJAzY7L/qo1sOEiaU4am5054zGg9u5q4SVQcc7SuN0bcvpMF
         wGbHGvRPjFW3cm/5Llv2TonyiTRwPIRUCGUFQ/RT7NTccFO97Fxrv48FmVg39ESxcuoi
         klHmzUdGpaonxaUZqo3q9dazAJfbb2P77qolT0rnkwzyO2/afgkjHi71vmV+FMQ3DE3u
         rZpA==
X-Gm-Message-State: AOAM5314b9SjnE7SfMHfze23OxMwZtIFY5GYjZOJgMrVjB9XXRFrGAqk
        RKk2iiktU9AD48oYVgoBWkf+fQtW9ngocJXmZS0=
X-Google-Smtp-Source: ABdhPJzLZWUN3CMPAO74Midb2K3CbjyDC6/yWNb3ZMsD4oMIE6nQxB+GdvjSg3ty2N+awPxnaeU+0RBD7yhJqSVsDlM=
X-Received: by 2002:a5b:14a:: with SMTP id c10mr63590060ybp.752.1641336017853;
 Tue, 04 Jan 2022 14:40:17 -0800 (PST)
MIME-Version: 1.0
References: <36ec2e79-7544-ba14-8bdd-d748dfad0ea7@eknoes.de>
 <CABBYNZJwqb0xKa+iX4zOBYpZ2j0ZFbHPRztQ1z5xJL7kq6-9Ag@mail.gmail.com>
 <91bface3-975d-b79c-2da0-77e24e355fa7@eknoes.de> <CABBYNZLrXh-Zc8wHSzZkvpx0oZGLsR0r_59V2zhAmtRQXTC9yg@mail.gmail.com>
 <CABBYNZJCuUj7J=egUEc-mbHN-gcvN-wQA7a=EQrvRgWqpEEByQ@mail.gmail.com> <1a975830-96e8-92cb-560a-2c1ab41b8796@eknoes.de>
In-Reply-To: <1a975830-96e8-92cb-560a-2c1ab41b8796@eknoes.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Jan 2022 14:40:06 -0800
Message-ID: <CABBYNZ+SjQAEpEuKZLAtNS6ai1VAAKPX9iDwjEkL0y-u+4eMqQ@mail.gmail.com>
Subject: Re: [BUG] Page Fault in hci_inquiry_result_with_rssi_evt
To:     =?UTF-8?Q?S=C3=B6nke_Huster?= <soenke.huster@eknoes.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi S=C3=B6nke,

On Tue, Jan 4, 2022 at 1:31 PM S=C3=B6nke Huster <soenke.huster@eknoes.de> =
wrote:
>
> Hi Luiz,
>
> On 04.01.22 22:04, Luiz Augusto von Dentz wrote:
> > Hi S=C3=B6nke,
> >
> > On Tue, Jan 4, 2022 at 11:31 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> >>
> >> Hi S=C3=B6nke,
> >>
> >> On Tue, Jan 4, 2022 at 3:50 AM S=C3=B6nke Huster <soenke.huster@eknoes=
.de> wrote:
> >>>
> >>> Hi Luiz,
> >>>
> >>> On 04.01.22 01:38, Luiz Augusto von Dentz wrote:
> >>>> Hi S=C3=B6nke,
> >>>>
> >>>> On Mon, Jan 3, 2022 at 3:41 PM S=C3=B6nke Huster <soenke.huster@ekno=
es.de> wrote:
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> While fuzzing bluetooth-next I found the following bug:
> >>>>>
> >>>>> [   27.333034] BUG: unable to handle page fault for address: fffff6=
1a1a1a1a1a
> >>>>> [   27.333241] #PF: supervisor read access in kernel mode
> >>>>> [   27.333241] #PF: error_code(0x0000) - not-present page
> >>>>> [   27.333241] PGD 6dfd2067 P4D 6dfd2067 PUD 0
> >>>>> [   27.333241] Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >>>>> [   27.333241] CPU: 0 PID: 45 Comm: kworker/u3:2 Not tainted 5.16.0=
-rc1+ #81
> >>>>> [   27.333241] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> >>>>> [   27.333241] Workqueue: hci0 hci_rx_work
> >>>>> [   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x95=
0
> >>>>> [   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 0=
7 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
> >>>>> [   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
> >>>>> [   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: fff=
fffff834663d1
> >>>>> [   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: fff=
f88800affb074
> >>>>> [   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: fff=
fffff83487b35
> >>>>> [   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: fff=
f88800affb000
> >>>>> [   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: fff=
f88800aae0000
> >>>>> [   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000=
) knlGS:0000000000000000
> >>>>> [   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> [   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 000=
00000000006f0
> >>>>> [   27.333241] Call Trace:
> >>>>> [   27.333241]  <TASK>
> >>>>> [   27.333241]  ? wait_for_completion_io+0x270/0x270
> >>>>> [   27.333241]  ? hci_inquiry_result_evt+0x4b0/0x4b0
> >>>>> [   27.333241]  hci_event_packet+0x3b11/0x7b10
> >>>>> [   27.333241]  ? lock_chain_count+0x20/0x20
> >>>>> [   27.333241]  ? hci_cmd_status_evt.constprop.0+0x4ea0/0x4ea0
> >>>>> [   27.333241]  ? sysvec_reboot+0x50/0xc0
> >>>>> [   27.333241]  ? find_held_lock+0x2c/0x110
> >>>>> [   27.333241]  ? lock_release+0x3b2/0x6f0
> >>>>> [   27.333241]  ? skb_dequeue+0x110/0x1a0
> >>>>> [   27.333241]  ? mark_held_locks+0x9e/0xe0
> >>>>> [   27.333241]  ? lockdep_hardirqs_on_prepare+0x17b/0x400
> >>>>> [   27.333241]  hci_rx_work+0x4d3/0xb90
> >>>>> [   27.333241]  process_one_work+0x904/0x1590
> >>>>> [   27.333241]  ? lock_release+0x6f0/0x6f0
> >>>>> [   27.333241]  ? pwq_dec_nr_in_flight+0x230/0x230
> >>>>> [   27.333241]  ? rwlock_bug.part.0+0x90/0x90
> >>>>> [   27.333241]  ? _raw_spin_lock_irq+0x41/0x50
> >>>>> [   27.333241]  worker_thread+0x578/0x1310
> >>>>> [   27.333241]  ? process_one_work+0x1590/0x1590
> >>>>> [   27.333241]  kthread+0x3b2/0x490
> >>>>> [   27.333241]  ? _raw_spin_unlock_irq+0x1f/0x40
> >>>>> [   27.333241]  ? set_kthread_struct+0x100/0x100
> >>>>> [   27.333241]  ret_from_fork+0x22/0x30
> >>>>> [   27.333241]  </TASK>
> >>>>> [   27.333241] Modules linked in:
> >>>>> [   27.333241] CR2: fffff61a1a1a1a1a
> >>>>> [   27.333241] ---[ end trace 6a6825484c8fefa6 ]---
> >>>>> [   27.333241] RIP: 0010:hci_inquiry_result_with_rssi_evt+0xbc/0x95=
0
> >>>>> [   27.333241] Code: 8b 04 24 48 c1 e8 03 42 80 3c 28 00 0f 85 20 0=
7 00 00 48 8b 04 24 4c 8b 28 48 b8 00 00 00 00 00 fc ff df 4c 89 0
> >>>>> [   27.333241] RSP: 0018:ffffc900004ff9c8 EFLAGS: 00010212
> >>>>> [   27.333241] RAX: dffffc0000000000 RBX: 0000000000000022 RCX: fff=
fffff834663d1
> >>>>> [   27.333241] RDX: 1ffffa1a1a1a1a1a RSI: 0000000000000012 RDI: fff=
f88800affb074
> >>>>> [   27.333241] RBP: ffff88800aae0000 R08: ffffffff844ef360 R09: fff=
fffff83487b35
> >>>>> [   27.333241] R10: 000000000000002c R11: 0000000000000022 R12: fff=
f88800affb000
> >>>>> [   27.333241] R13: ffffd0d0d0d0d0d0 R14: 0000000000000000 R15: fff=
f88800aae0000
> >>>>> [   27.333241] FS:  0000000000000000(0000) GS:ffff88806ce00000(0000=
) knlGS:0000000000000000
> >>>>> [   27.333241] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> [   27.333241] CR2: fffff61a1a1a1a1a CR3: 0000000004a26000 CR4: 000=
00000000006f0
> >>>>> [   27.379996] kworker/u3:2 (45) used greatest stack depth: 27736 b=
ytes left
> >>>>>
> >>>>> It occurs when sending the following frame to the kernel:
> >>>>>
> >>>>> $ xxd crashes/hci_inquiry_result_with_rssi_evt
> >>>>> 00000000: 0422 24d0 d0d0 d0d0 d0ff ff              ."$........
> >>>>>
> >>>>> The bug was introduced with the commit "Bluetooth: HCI: Use skb_pul=
l_data to parse Inquiry Result with RSSI event" (https://git.kernel.org/pub=
/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=3D8d08d324fdc=
b7).
> >>>>
> >>>> That is pretty weird, the data seems to be the following:
> >>>>
> >>>> 04 -> HCI_EVENT_PKT
> >>>> 22 -> HCI_EV_INQUIRY_RESULT_WITH_RSSI
> >>>> 24 -> hci_ev_inquiry_result_rssi.num
> >>>> d0 d0d0 d0d0 d0ff ff
> >>>>
> >>>> But this should never evaluate to true for:
> >>>>
> >>>> if (skb->len =3D=3D flex_array_size(ev, res2->info, ev->res2->num)) =
{
> >>>> ...
> >>>> } else if (skb->len =3D=3D flex_array_size(ev, res1->info, ev->res1-=
>num)) {
> >>>>
> >>>
> >>> I'm sorry, I forgot to mention the affected source code, the check se=
ems to be too late. GDB says it is already happening in net/bluetooth/hci_e=
vent.c:4519:
> >>>
> >>> (gdb) list *hci_inquiry_result_with_rssi_evt+0x9b
> >>> 0xffffffff83470d8b is in hci_inquiry_result_with_rssi_evt (net/blueto=
oth/hci_event.c:4519).
> >>> 4514            struct inquiry_data data;
> >>> 4515            int i;
> >>> 4516
> >>> 4517            bt_dev_dbg(hdev, "num_rsp %d", ev->res1->num);
> >>> 4518
> >>> 4519            if (!ev->res1->num) # <- page fault here
> >>> 4520                    return;
> >>>
> >>> I just reproduced it on the HEAD of bluetooth-next (for-net-next-2021=
-12-29).
> >>
> >> That would mean there is less data than the hci_ev.min_len, but that
> >> is checked in hci_event_func prior to calling the hci_ev.func:
> >>
> >> if (skb->len < ev->min_len) {
> >> bt_dev_err(hdev, "unexpected event 0x%2.2x length: %u < %u",
> >>    event, skb->len, ev->min_len);
> >> return;
> >> }
> >>
> >>>
> >>>> These requires the data to be multiple of sizeof(struct
> >>>> inquiry_info_rssi_pscan) =3D 15 bytes or sizeof(struct
> >>>> inquiry_info_rssi) =3D 14 bytes respectively where the data left is =
just
> >>>> 8 bytes long, besides with the number of entries being 0x24 this sha=
ll
> >>>> be well beyond skb->len which shall have cause the else clause:
> >>>>
> >>>>   } else {
> >>>>       bt_dev_err(hdev, "Malformed HCI Event: 0x%2.2x",
> >>>>                          HCI_EV_INQUIRY_RESULT_WITH_RSSI);
> >>>>   }
> >>>>
> >>>
> >>> I think prior to the commit that introduced that, the check was made =
before casting it to the struct, so from the "raw" skb->data:
> >>>
> >>> -       int num_rsp =3D *((__u8 *) skb->data);
> >>> -       if ((skb->len - 1) / num_rsp !=3D sizeof(struct inquiry_info_=
with_rssi)) {
> >>
> >> That is still being checked, anyway that would cause a page fault when
> >> accessing num_rsp so I don't understand why it would cause a page
> >> fault now when previously it didn't even check if there were any bytes
> >> to be read, perhaps there is some memory alignment at play.
> >>
> >>>> Anyway the bluetooth-next has been updated since last week so I firs=
t
> >>>> attempt to reproduce with a fresh clone of it since we did some fixu=
ps
> >>>> since then.
> >>>>
> >>>
> >>> Btw, what is the best way to provide an easily reproducible bug repor=
t here, I did not figure that out yet.
> >>>
> >>> Also, when searching for bugs (to ideally provide patches), I am curr=
ently searching on the HEAD of bluetooth-next. As far as I understood it, t=
he tags "for-net-..." should be more or less stable, as they are merged to =
net-next which makes its way to mainline, right?
> >>
> >> Yep, those are the tags we sent to net-next but in general
> >> bluetooth-next shall also be stable since we run CI on every patch
> >> nowadays.
> >
> > Ive just sent a patch trying to eliminate the use of the union since
> > that perhaps cause the compiler to use a different alignment, Im also
>
> The patch fixes it, I can't reproduce it anymore and the kernel log shows=
 the expected  "Bluetooth: hci0: Malformed HCI Event: 0x22".

Thanks, would you please respond to the patch with Tested-by:

> > thinking on introducing some mechanism to our emulator to generate
> > arbitrary events in a form a command that generates an event based on
> > its parameter.
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/20220104210051.298=
2871-1-luiz.dentz@gmail.com/
> >
>


--=20
Luiz Augusto von Dentz
