Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFE46E978
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhLIN5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:57:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238239AbhLIN5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639058052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SJcvFXbLt/1N/cu3WH2HFBeJgUGrbfAyaue7HyTHXs=;
        b=IfIjomyCjKqjMdgzQ7iAVeTpfBKMm5pkzNPAUH97EcuHG/Zjmnvw2mCYhkJxnTHoWgkWPR
        eyE7+OmOGa1eOWfX1XRQPYsWu1k1a7BYQmaTkKTpH4BLSNirbmmo+fJa5v0Li0xOjiizvH
        TJsqXyxPo9aallwXqTZOrBfwWONZBt0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-S8HD7wpqNl6Cz6N30EhWgw-1; Thu, 09 Dec 2021 08:54:11 -0500
X-MC-Unique: S8HD7wpqNl6Cz6N30EhWgw-1
Received: by mail-pl1-f198.google.com with SMTP id z3-20020a170903018300b0014224dca4a1so2410469plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 05:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SJcvFXbLt/1N/cu3WH2HFBeJgUGrbfAyaue7HyTHXs=;
        b=jchwnARu5UPXF/7qiMnrCFjZrujev4NqmBDc2aVFuUTG3IXt5m1j/3P501Q9nXi/5W
         KasJvwU390/6uOQWx4T6l/l2GWBrA97zQejD8Saz7k2jbVLR760Qp3yvJOn7AsxSSOV6
         ngb5S3p64X1bTT3fiX/GV9ruGSJLLgFZmgINY1eDWrRrK8pz23ysq+toRpGq24b07CVD
         BvOHeJSUyfNmuo2x1YVQxyhOcaSOfORSpJBq61cwkKxfa+dczCQuh9KOHcXf88izl7bd
         +i9CvdUj0jcIBa9Z/QPtkNA3lH3hFyQMW3HF9nN5OIOmYmSstm+t3oENFK+Yd21AIaYs
         FnsQ==
X-Gm-Message-State: AOAM531+HwqK26VxsrZegmTcaNGIsk0VjyDyvKn6AY345+oFhEssWps4
        mMz71UlRVD9vpx3MmAwsR5EUTAdu0lBzhNzxGtO8JtcOx+I+8DIRy851TtkcTwsd/XKmu9XwsgP
        yhQbnV8/3wz6eIgayWRhqgIvzxMY4VLrwunQ5zo/3
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr15620967pjb.113.1639058049543;
        Thu, 09 Dec 2021 05:54:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJDGtXZ21z7tKi4eDiKQQnml7qEXENr1qMMeG+/gNH4Kz+ux1z4W8UZ3IVQE3ikOHbVVuPxz/hEvaE06HFt5E=
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr15620902pjb.113.1639058048946;
 Thu, 09 Dec 2021 05:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20211126130141.1811848-1-tero.kristo@linux.intel.com>
 <CAO-hwJLq6Jnvos=CR_-D6FD-7W56q2eYRVyRMbmE5NFaXLHrng@mail.gmail.com>
 <4c87f439-f6d0-97e7-156e-90e9baab4b01@linux.intel.com> <CAO-hwJ+Vt81ZKR0Ywa5ffDW1R586dDcPQgOoe8awUOdYWV0Y7Q@mail.gmail.com>
 <fa6b6276-8afb-521b-889f-1a9c63379b17@linux.intel.com>
In-Reply-To: <fa6b6276-8afb-521b-889f-1a9c63379b17@linux.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 9 Dec 2021 14:53:57 +0100
Message-ID: <CAO-hwJJzmp1E0YeJO8971tArFMzt28MzRbfnFUEv7j_k2MVUog@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 9:56 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi Benjamin,
>
> On 08/12/2021 16:56, Benjamin Tissoires wrote:
> > Hi Tero,
> >
> > On Tue, Nov 30, 2021 at 5:13 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
> >> Hi Benjamin,
> >>
> >> On 30/11/2021 16:44, Benjamin Tissoires wrote:
> >>> Hi Tero,
> >>>
> >>> On Fri, Nov 26, 2021 at 2:02 PM Tero Kristo <tero.kristo@linux.intel.com> wrote:
> >>>> Hi,
> >>>>
> >>>> This series is an update based on comments from Benjamin. What is done
> >>>> is this series is to ditch the separate hid-driver for USI, and add the
> >>>> generic support to core layers. This part basically brings the support
> >>>> for providing USI events, without programmability (patches 1-6).
> >>> That part seems to be almost good for now. I have a few things to check:
> >>> - patch2: "HID: hid-input: Add suffix also for HID_DG_PEN" I need to
> >>> ensure there are no touchscreens affected by this (there used to be a
> >>> mess with some vendors where they would not declare things properly)
> >>> - patch5: "HID: core: map USI pen style reports directly" this one
> >>> feels plain wrong. I would need to have a look at the report
> >>> descriptor but this is too specific in a very generic code
> >> Relevant part of the report descriptor is here:
> >>
> >>       Field(8)
> >>         Physical(Digitizers.Stylus)
> >>         Logical(Digitizers.Preferred Line Style)
> >>         Application(Digitizers.Pen)
> >>         Usage(6)
> >>           Digitizers.Ink
> >>           Digitizers.Pencil
> >>           Digitizers.Highlighter
> >>           Digitizers.Chisel Marker
> >>           Digitizers.Brush
> >>           Digitizers.No Preference
> >>         Logical Minimum(1)
> >>         Logical Maximum(6)
> >>         Physical Minimum(0)
> >>         Physical Maximum(255)
> >>         Unit Exponent(-1)
> >>         Unit(SI Linear : Centimeter)
> >>         Report Size(8)
> >>         Report Count(1)
> >>         Report Offset(88)
> >>         Flags( Variable Absolute NoPreferredState )
> >>
> >> To me, it looks almost like it is a bug in the report descriptor itself;
> >> as you see there are 6 usage values but the report size / count is 1
> >> byte. The fact that there are 6 usage values in the field confuses
> >> hid-core. Basically the usage values are used as encoded content for the
> >> field.
> > It took me a few days but I finally understand that this report
> > descriptor is actually correct.
> >
> > The descriptor gives an array of 1 element of size 8, which is enough
> > to give an index within the available values being [Digitizers.Ink,
> > Digitizers.Pencil, Digitizers.Highlighter, Digitizers.Chisel Marker,
> > Digitizers.Brush, Digitizers.No Preference]
> >
> > Given that logical min is 1, this index is 1-based.
> >
> > So the job of the kernel is to provide the event
> > Digitizers.Highlighter whenever the value here is 3. The mapping 3 <->
> > Digitizers.Highlighter is specific to this report descriptor and
> > should not be forwarded to user space.
>
> Yes, all this is true. I also see you re-wrote this part a bit in the
> series to add individual events for all the different line styles. I'll
> give this a shot and see how it works out. A problem I see is that we
> need to be able to program the pen line style also somehow, do we just
> set a single pen style to "enabled" and all the rest get set to
> "disabled" under the hood?
>

I think we need to have a parameter `PreferredLineStyle` which can
only take the values from the array above.

If your API provides that, the rest is implementation detail.
Assigning a value to it will by definition invalidate the old value.

Of course this means that the evdev approach is not suited for that,
which makes me think that is probably not the best option.

>
> >
> >> Alternatively I think this could be patched up in the BPF program, as I
> >> am modifying the content of the raw hid report already; I could just as
> >> well modify this one also. Or, maybe I could fix the report descriptor
> >> itself to act as a sane variable, as I am parsing the report descriptor
> >> already?
> > I couldn't understand the fix you did in the BPF program. Can you
> > explain it by also giving me an example of raw event from the device
> > and the outputs (fixed and not fixed) of the kernel?
>
> The fix in the BPF code is this (under process_tag()):
>
>                          /*
>                           * Force flags for line style. This makes it act
>                           * as a simple variable from HID core point of
> view.
>                           */
>                          bpf_hid_set_data(ctx, (*idx + 1) << 3, 8, 0x2);
>
> After that, the pen line style gets forwarded as a simple integer value
> to input-core / userspace also. raw events did not need modification
> after all, I just modified the report descriptor.

Right. So you are stripping away the actual meaning, which is report
descriptor dependent.
This is not good because a HW vendor might decide to not order the 6
possible values by their HID usage but put the `No Prefererence` first
for instance. There is also a strong possibility a HW vendor decides
to not rely on the PreferredLineStyleIsLocked and gives a choice of
only one possible value (though that would be mean as this is a per
stylus propriety).

>
> >
> >
> > Talking about that, I realized that you gave me the report descriptor
> > of the Acer panel in an other version of this RFC. Could you give me:
> > - the bus used (USB or I2C)?
> I have been using I2C in all my testing, the controllers I have access
> to are behind I2C only.
> > - the vendor ID?
> > - the product ID?
> > - and the same for the other panel, with its report descriptor?
> >
> > This way I can add them in the testsuite, and start playing with them.
> Attached a tarball with both descriptors and their corresponding IDs
> (copied the R+N+I data from hid-recorder.)

Thanks!

> >
> >>>> Additionally, a HID-BPF based sample is provided which can be used to
> >>>> program / query pen parameters in comparison to the old driver level
> >>>> implementation (patches 7-8, patch #8 is an incremental change on top of
> >>>> patch #7 which just converts the fifo to socket so that the client can
> >>>> also get results back from the server.)
> >>> After a few more thoughts, I wondered what your input is on this. We
> >>> should be able to do the very same with plain hidraw... However, you
> >>> added a `hid/raw_event` processing that will still be kept in the
> >>> kernel, so maybe bpf would be useful for that at least.
> >> Yes, plain hidraw can be sort of used to program the values, however the
> >> interface is kind of annoying to use for the USI pens. You need to be
> >> touching the display with the pen before anything is accepted. Maybe
> >> writing some support code to the libevdev would help.
> >>
> >> The hidraw hook is needed for processing the cached values also, USI
> >> pens report their parameters with a delay of some few hundred ms
> >> depending on controller vendor. And in some cases they don't report
> >> anything back before forcibly querying the value from the controller,
> >> and also the write mechanism acts differently; some controllers report
> >> the programmed value back, others keep reporting the old value until the
> >> pen leaves the screen and touches it again.
> > Hmm, not sure I follow this entirely. I guess I would need to have one
> > of such devices in my hands :(
>
> Yes, it is kind of confusing, I was also trying to figure out the
> details with a remote proxy (someone telling me how things behave) until
> I decided to order a second chromebook that had the same controller. I
> can try to provide logs of the different cases if you want though. The
> quirks I know of at the moment:

I'll need more clarifications (and getting logs might help me
understand better, yes, please):

>
> 1) controller does not immediately report "correct" values when pen
> touches screen (ELAN)

I assume this is in the input reports, not in the feature reports.
What happens in the hovering case (not touching)?
Do we get fake values easily identifiable or are they just as normal
as the correct ones?

Anyway, considering the use case, this might not be an issue (I was
re-reading the HUT and this is only an indication for applications).

>
> 2) controller does never report "correct" values when pen touches screen
> (must do a force GET_REPORT) (GOODIX)

Again, Input reports?
What's in the hovering state reported?
Is the GET_REPORT needed against the feature report or the input report?

>
> 3) controller does not report "correct" values after SET_REPORT
> (reporting old value) (ELAN)

Am I correct?:

- Pen is hovering/touching
- controller is reporting correct current values in the input reports
(following the 2 cases above)
- host sends a SET_REPORT on the feature
- controller is still sending the old values in the input reports

What happens if you issue a GET_REPORT on the Input?
On the Feature?

>
> 4) controller responds with bogus data in GET_REPORT (does not know the
> correct value yet) (ELAN + GOODIX)

I assume that's when the stylus is not in proximity, and when you
issue a GET_REPORT of the feature report, not the input, correct?

If so, this is something I would have expected, given that those
properties are per stylus, not per controller.

>
> I believe other vendors have different behavior with their controllers
> also, as the specs are not 100% clear on multiple things.

Well, depending on your answers above, we might have a common set of
cases we can use, or paper over it through bpf if there is a strong
need.

Also, a few more questions:
- have you tried those cases above with the same stylus, or is it HP
controller - HP stylus /  Acer-Acer?
- do these pens have physical notification of the style/width, or do
they just store the data in their memory?
- what are the chromebook models (if I need to eventually expense one)?
- to me, the Goodix report descriptor is bogus in the feature reports.
The Usage Page is stuck at "vendor defined" when it should have been
reset to "Digitizer" before the report ID 9. Is it just me and my
tools or am I missing something?

>
> >
> >>
> >>>> The whole series is based on top of Benjamin's hid-bpf support work, and
> >>>> I've pushed a branch at [1] with a series that works and brings in
> >>>> the dependency. There are also a few separate patches in this series to
> >>>> fix the problems I found from Benjamin's initial work for hid-bpf; I
> >>>> wasn't able to get things working without those. The branch is also
> >>>> based on top of 5.16-rc2 which required some extra changes to the
> >>>> patches from Benjamin.
> >>> Yeah, I also rebased on top of 5.16 shortly after sharing that branch
> >>> and got roughly the same last fix (HID: bpf: compile fix for
> >>> bpf_hid_foreach_rdesc_item). I am *very* interested in your "HID: bpf:
> >>> execute BPF programs in proper context" because that is something that
> >>> was bothering me a lot :)
> >> Right, I think I have plenty of lockdep / scheduler checks enabled in my
> >> kernel. They generate plenty of spam with i2c-hid without that patch.
> >> The same issue may not be visible with some other low level hid devices
> >> though, I don't have testing capability for anything but the i2c-hid
> >> right now. I2C is quite notorious for the locking aspects as it is slow
> >> and is used to control some pretty low level stuff like power management
> >> etc.
> > As a rule of thumb, hid_hw_raw_request() can not and should not be
> > called in IRQ.
> > I tested your patch with a USB device, and got plenty of complaints too.
> >
> > I know bpf now has the ability to defer a function call with timers,
> > so maybe that's what we need here.
> That sounds like something that would work yes, I did use workqueue
> before when this was a separate driver instead of a BPF program.
> >
> >>> "HID: bpf: add expected_attach_type to bpf prog during detach" is
> >>> something I'll need to bring in too
> >>>
> >>> but "HID: bpf: fix file mapping" is actually wrong. I initially wanted
> >>> to attach BPF programs to hidraw, but shortly realized that this is
> >>> not working because the `hid/rdesc_fixup` kills the hidraw node and so
> >>> releases the BPF programs. The way I am now attaching it is to use the
> >>> fd associated with the modalias in the sysfs file (for instance: `sudo
> >>> ./hid_surface_dial /sys/bus/hid/devices/0005:045E:091B.*/modalias`).
> >>> This way, the reference to the struct hid_device is kept even if we
> >>> disconnect the device and reprobe it.
> >> Ok I can check this out if it works me also. The samples lead me to
> >> /dev/hidraw usage.
> >>> Thanks again for your work, and I'd be curious to have your thoughts
> >>> on hid-bpf and if you think it is better than hidraw/evdev write/new
> >>> ioctls for your use case.
> >> The new driver was 777 lines diff, the BPF one is 496 lines so it
> >> appears smaller. The driver did support two different vendors though
> >> (ELAN+Goodix, with their specific quirks in place), the BPF only a
> >> single one right now (ELAN).
> >>
> >> The vendor specific quirks are a question, do we want to support that
> >> somehow in a single BPF binary, or should we attach vendor specific BPF
> >> programs?
> > Good question.
> > The plan I had was to basically pre-compile BPF programs for the
> > various devices, but having them separated into generic + vendor
> > specifics seems interesting too.
> >
> > I don't have a good answer right now.
> At least for USI purposes, ELAN+GOODIX controllers have pretty different
> quirks for them and it seems like having separate BPF programs might be
> better; trying to get the same BPF program to run for both sounds
> painful (it was rather painful to get this to work for single vendor.)

The more I look at the 2 report descriptors, the more I think that we
should be able to have a common code in hid-input for dealing with
input reports, and then have specifics as bpf programs.
As mentioned earlier, I think Goodix needs a report fixup for the
features, and we might want to change the reported values for Elan
immediately after we issue the config change.

It seems very much that we are in the same situation as Windows 7
multitouch screens. The spec was not restrictive enough that the HW
makers were not very careful, and we added multiple quirks for them.
I would prefer to have a common minimal hid-input handling and defer
the quirks in a BPF program :)

> >
> >> Chromium-os devices are one of the main customers for USI pens right
> >> now, and I am not sure how well they will take the BPF concept. :) I did
> >> ask their feedback though, and I'll come back on this once I have something.
> > Cool thanks.
> >
> >> Personally, I don't have much preference either way at this moment, both
> >> seem like feasible options. I might lean a bit towards evdev/ioctl as it
> >> seems a cleaner implementation as of now. The write mechanism I
> >> implemented for the USI-BPF is a bit hacky, as it just directly writes
> >> to a shared memory buffer and the buffer gets parsed by the kernel part
> >> when it processes hidraw event. Anyways, do you have any feedback on
> >> that part? BPF is completely new to me again so would love to get some
> >> feedback.
> > Yeah, this feels wrong to me too.
> > I guess what we want is to run a BPF call initiated from the
> > userspace. I am not sure if this is doable. I'll need to dig further
> > too (I am relatively new to BPF too as a matter of facts).
>
> I could not find a way to initiate BPF call from userspace, thats the
> reason I implemented it this way. That said, I don't see any case where
> this would fail though; we only ever write the values from single source
> (userspace) and read them from kernel. If we miss a write, we just get
> the old value and report the change later on.

Yeah, I understand it works, it's just that you can not initiate a
bpf_hid_raw_request() call from a raw_event callback. You are in an
IRQ, and we need to run things as fast as possible.
So either we defer, or we find another way of contacting the stylus
outside of the IRQ.

>
> To initiate a BPF call from userspace we would need some sort of hid-bpf
> callback to a BPF program, which gets triggered by an ioctl or evdev
> write or something coming from userspace. Which brings us back to the
> chicken-egg problem we have with USI right now. :)

I am thinking of adding a new syscall hid_bpf_run() that the userspace
program can trigger. Otherwise, it seems from a very rough overview we
could hijack the bpf_test_run() syscall, but that would not be very
nice.
Initiating an event from evdev is not very compatible with the BPF
approach because you'll need to also open the evdev node, which you
don't when you run a BPF program.

Cheers,
Benjamin

>
> -Tero
>
>
> > Cheers,
> > Benjamin
> >
> >> One option is of course to push the write portion of the code to
> >> userspace and just use hidraw, but we still need to filter out the bogus
> >> events somehow, and do that in vendor specific manner. I don't think
> >> this can be done on userspace, as plenty of information that would be
> >> needed to do this properly has been lost at the input-event level.
> >>
> >> -Tero
> >>
> >>> Cheers,
> >>> Benjamin
> >>>
> >>>> -Tero
> >>>>
> >>>> [1] https://github.com/t-kristo/linux/tree/usi-5.16-rfc-v2-bpf
> >>>>
> >>>>

