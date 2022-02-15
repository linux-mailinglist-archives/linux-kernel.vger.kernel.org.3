Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9604B60B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiBOCEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:04:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiBOCEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:04:32 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178CD246;
        Mon, 14 Feb 2022 18:04:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id b5so17211353qtq.11;
        Mon, 14 Feb 2022 18:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RY3hPu0eYznmJ1wv60D8yqIoxL5AcD8VFfxgkL4Y/Fo=;
        b=J1N+91krUrrbs2vmM/dl9OLcuxIrdwW15uOPD4fXjHLn7gT+z7qMpxkI7gP9pz1RjX
         ONF6sNw7QyBT/gc0yA57fImANC+JXUT5rqdIog7gTMKX/tp5eOQTGWhDaKxWEtQg/hjg
         rWSQyN+TlSL719hxVuSZCRXKlQOl0FBhJs78VFDbF/IG4enTQDSr38qu/Qoy0cjRzr4w
         DZhVxvZKFYEjP2sJ+tM53JWYJ3HnR17USJt25+4G6+GJ/sLF+oZHG1gHoRoh9WBmzXwj
         wGIIUlvvZ9y0azqY0muaCAsrA3fq926RlDIbp6oWj9/xb8e2JXSsC1piCqYTa6VwXrNo
         GXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RY3hPu0eYznmJ1wv60D8yqIoxL5AcD8VFfxgkL4Y/Fo=;
        b=u5UXnYDwIwEcsv56Lt8QtuwaHnp2wiVncFH+bjAccIxKOBSavuaHwiEBM5Y6JESz1G
         xHoj/bIy5vPMIVYxdoK4b7gCrL0ENrlX7rhDYKwSZcIzVjz2pJNCqiP7Ldpes+sm83JR
         0kvCgAmXTGzeaEW43D9fAgdqniy5XWGwUDHrwu5Zx7B3EFdq/Aedu8kbSGjhjou7zThj
         R4wp6/2XORmsSMKJFYE3L6R3RYA/zDuy8B0G+lQlSV1jl8iwHZBOxuQUhWj7PG0G9+GB
         VJMDRHGAdXd8MOM1Dbk5bAbBju8tJES7hoZl5aflu1fgPsTAXYvhvq4P9atguxxrjF2u
         4vtQ==
X-Gm-Message-State: AOAM532KOo4g8u6snKiuRDBpNZjgJGHDF5JYDfWkjE/uU4Au/+fgCK1M
        w7PPRdIHCTtx0jGoqaP9Uf4mx95+z40kjs00vxVl8P9M
X-Google-Smtp-Source: ABdhPJyHb+9vNUNBrn9tP3r5axEzGzX4CFU+9PXTEvYEwXnN432HeGIRlNUBhhg6WeJoh29FZkYnpaUsEhXU1oOoWNM=
X-Received: by 2002:ac8:5708:: with SMTP id 8mr1288562qtw.668.1644890662050;
 Mon, 14 Feb 2022 18:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20220203143226.4023622-1-benjamin.tissoires@redhat.com>
 <20220203143226.4023622-11-benjamin.tissoires@redhat.com> <CAF8JNhKbEWj1b4o2Uv7snXa_JGt0bk5wyUGP4_77aHTLhPRT3w@mail.gmail.com>
 <CAF8JNhLeOn==FhaujjYY7o+f3J7xQcitdUUUJOOeZL1QEGKhRA@mail.gmail.com> <CAO-hwJ+NVb=Z0=1jeLuCFjGPAXnjn6hgHDjWx0+ETcE3uQhhzQ@mail.gmail.com>
In-Reply-To: <CAO-hwJ+NVb=Z0=1jeLuCFjGPAXnjn6hgHDjWx0+ETcE3uQhhzQ@mail.gmail.com>
From:   Ping Cheng <pinglinux@gmail.com>
Date:   Mon, 14 Feb 2022 18:04:10 -0800
Message-ID: <CAF8JNhLUWJXbWG2rsYZvemm+3LbHA0QwAND05h9oM74LKDAfLA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] HID: input: remove the need for HID_QUIRK_INVERT
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Jason Gerecke <killertofu@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 2:23 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi Ping,
>
> On Thu, Feb 10, 2022 at 6:44 AM Ping Cheng <pinglinux@gmail.com> wrote:
> >
> > Sorry for the noise. Hit the wrong buttons...
> >
> > On Wed, Feb 9, 2022 at 9:21 PM Ping Cheng <pinglinux@gmail.com> wrote:
> > >
> > > On Thu, Feb 3, 2022 at 6:33 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > HID_QUIRK_INVERT is kind of complex to deal with and was bogus.
> > > >
> > > > Furthermore, it didn't make sense to use a global per struct hid_device
> > > > quirk for something dynamic as the current state.
> > > >
> > > > Store the current tool information in the report itself, and re-order
> > > > the processing of the fields to enforce having all the tablet "state"
> > > > fields before getting to In Range and other input fields.
> > > >
> > > > This way, we now have all the information whether a tool is present
> > > > or not while processing In Range.
> > > >
> > > > This new behavior enforces that only one tool gets forwarded to userspace
> > > > at the same time, and that if either eraser or invert is set, we enforce
> > > > BTN_TOOL_RUBBER.
> > > >
> > > > Note that the release of the previous tool now happens in its own EV_SYN
> > > > report so userspace doesn't get confused by having 2 tools.
> > > >
> > > > These changes are tested in the following hid-tools regression tests:
> > > > https://gitlab.freedesktop.org/libevdev/hid-tools/-/merge_requests/127
> > > >
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - rework the entire tool switching, this makes the processing
> > > >   slightly more complex but is better for existing userspace.
> > > > ---
> > > >  drivers/hid/hid-input.c | 98 +++++++++++++++++++++++++++++++++++++----
> > > >  include/linux/hid.h     |  6 ++-
> > > >  2 files changed, 95 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > > > index 61d91117f4ae..9f8853640648 100644
> > > > --- a/drivers/hid/hid-input.c
> > > > +++ b/drivers/hid/hid-input.c
> > > > @@ -63,8 +63,11 @@ static const struct {
> > > >   * This still leaves us 65535 individual priority values.
> > > >   */
> > > >  static const __u32 hidinput_usages_priorities[] = {
> > > > +       HID_DG_ERASER,          /* Eraser (eraser touching) must always come before tipswitch */
> > > >         HID_DG_INVERT,          /* Invert must always come before In Range */
> > > > -       HID_DG_INRANGE,
> > > > +       HID_DG_TIPSWITCH,       /* Is the tip of the tool touching? */
> > > > +       HID_DG_TIPPRESSURE,     /* Tip Pressure might emulate tip switch */
> > > > +       HID_DG_INRANGE,         /* In Range needs to come after the other tool states */
> > > >  };
> > > >
> > > >  #define map_abs(c)     hid_map_usage(hidinput, usage, &bit, &max, EV_ABS, (c))
> > > > @@ -1365,9 +1368,38 @@ static void hidinput_handle_scroll(struct hid_usage *usage,
> > > >         input_event(input, EV_REL, usage->code, hi_res);
> > > >  }
> > > >
> > > > +static void hid_report_release_tool(struct hid_report *report, struct input_dev *input,
> > > > +                                   unsigned int tool)
> > > > +{
> > > > +       /* if the given tool is not currently reported, ignore */
> > > > +       if (!test_bit(tool, input->key))
> > > > +               return;
> > > > +
> > > > +       /*
> > > > +        * if the given tool was previously set, release it,
> > > > +        * release any TOUCH and send an EV_SYN
> > > > +        */
> > > > +       input_event(input, EV_KEY, BTN_TOUCH, 0);
> > > > +       input_event(input, EV_KEY, tool, 0);
> >
> > Took a while for me to find the right device and setup the proper
> > system for the testing. This block missing the serial number:
> >
> >         input_event(input, EV_MSC, MSC_SERIAL, 0);
> >
> > Without this line, the next tool will not get its serial number.
>
> I am tempted to simply disregard this request. It has been known for
> ages that the evdev values are cached, so if you do not have the value
> you need that means that the value has been sent previously (or you
> can request it upon start with an ioctl). So in this particular case,
> I don't really see the logic in forcing the SERIAL into the TOOL type
> when the tool is clearly unrelated to the serial.
>
> My fear here is that by linking together too many axes, we may enter
> in a state where we can not untangle them when needed.

I see your point. We indeed added those ioctl's in the X driver to
avoid missing the initial states of some of the key events.

> >
> > > > +       input_event(input, EV_SYN, SYN_REPORT, 0);
> > > > +
> > > > +       report->tool = 0;
> > > > +}
> > > > +
> > > > +static void hid_report_set_tool(struct hid_report *report, struct input_dev *input,
> > > > +                               unsigned int new_tool)
> > > > +{
> > > > +       if (report->tool != new_tool)
> > > > +               hid_report_release_tool(report, input, report->tool);
> > > > +
> > > > +       input_event(input, EV_KEY, new_tool, 1);
> > > > +       report->tool = new_tool;
> > > > +}
> > > > +
> > > >  void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
> > > >  {
> > > >         struct input_dev *input;
> > > > +       struct hid_report *report = field->report;
> > > >         unsigned *quirks = &hid->quirks;
> > > >
> > > >         if (!usage->type)
> > > > @@ -1418,25 +1450,75 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
> > > >         }
> > > >
> > > >         switch (usage->hid) {
> > > > +       case HID_DG_ERASER:
> > > > +               report->tool_active |= !!value;
> > > > +
> > > > +               /*
> > > > +                * if eraser is set, we must enforce BTN_TOOL_RUBBER
> > > > +                * to accommodate for devices not following the spec.
> > > > +                */
> > > > +               if (value)
> > > > +                       hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
> > > > +               else if (report->tool != BTN_TOOL_RUBBER)
> > > > +                       /* value is off, tool is not rubber, ignore */
> > > > +                       return;
> > > > +
> > > > +               /* let hid-input set BTN_TOUCH */
> > > > +               break;
> > > > +
> > > >         case HID_DG_INVERT:
> > > > -               *quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
> > > > +               report->tool_active |= !!value;
> > > > +
> > > > +               /*
> > > > +                * If invert is set, we store BTN_TOOL_RUBBER.
> > > > +                */
> > > > +               if (value)
> > > > +                       hid_report_set_tool(report, input, BTN_TOOL_RUBBER);
> > > > +               else if (!report->tool_active)
> > > > +                       /* tool_active not set means Invert and Eraser are not set */
> > > > +                       hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
> > > > +
> > > > +               /* no further processing */
> > > >                 return;
> > > >
> > > >         case HID_DG_INRANGE:
> > > > -               if (value) {
> > > > -                       input_event(input, usage->type, (*quirks & HID_QUIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
> > > > -                       return;
> > > > +               report->tool_active |= !!value;
> > > > +
> > > > +               if (report->tool_active) {
> > > > +                       /*
> > > > +                        * if tool is not set but is marked as active,
> > > > +                        * assume ours
> > > > +                        */
> > > > +                       if (!report->tool)
> > > > +                               hid_report_set_tool(report, input, usage->code);
> > > > +               } else {
> > > > +                       hid_report_release_tool(report, input, usage->code);
> > > >                 }
> > > > -               input_event(input, usage->type, usage->code, 0);
> > > > -               input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
> > > > +
> > > > +               /* reset tool_active for the next event */
> > > > +               report->tool_active = false;
> > > > +
> > > > +               /* no further processing */
> > > >                 return;
> > > >
> > > > +       case HID_DG_TIPSWITCH:
> > > > +               report->tool_active |= !!value;
> > > > +
> > > > +               /* if tool is set to RUBBER we should ignore the current value */
> > > > +               if (report->tool == BTN_TOOL_RUBBER)
> > > > +                       return;
> >
> > This case should return before HID_DG_INVERT is checked since we may
> > get TIPSWITCH bit before INVERT. In fact, the device that I tested
> > sends the tipswatch bit before the invert bit. So, I alway get a PEN
> > in and out before I get ERASER events, when I bring the pen in with
> > the side-switch/invert bit pressed.
> >
> > However, we know not all devices support INVERT. We probably have to
> > keep the invert quirk to decide if BTN_TOOL_PEN should be set here or
> > wait until HID_DG_INVERT is reached.
>
> I am under the impression that you completely missed the point of the
> patch series. This series re-orders the processing of the events, and
> if you look at the very first hunk in this patch, you'll see that the
> new processing ensures we treat INVERT and ERASER before TIPSWITCH, no
> matter the order of the device.

Yeah, I read that part of the code, more than once. But, my evtest
gave me an extra set of TOOL_PEN events before TOOL_ERASER. I was
confused too. Then I thought maybe the code still relies on the actual
order of the usages. Anyway, we've done enough discussion and testing,
let's move on. The patchset is:

Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>

Thank you for your effort, Benjamin!
Ping

> So when we process TIPSWITCH here, we are sure that if BTN_TOOL_RUBBER
> is set, either INVERT or ERASER is set to 1, whether or not they come
> before or after in the report.
>
> >
> > If you are interested in the evtest output, please let me know. I'll
> > share it with you offline so we don't abuse this list...
>
> evtest is the output of the kernel, and it doesn't give me much more
> than "it's broken". However, if you can give me the hid-recorder
> outputs, I'll be able to reproduce locally and compare the output as I
> fix the code. Of course the best would be to add test cases in the
> hid-tools repo, but I'll need the hid-recorder anyway to understand
> what is failing and to be able to write the tests.
>
> Cheers,
> Benjamin
>
> >
> > Cheers,
> > Ping
> >
> > > > +               break;
> > > > +
> > > >         case HID_DG_TIPPRESSURE:
> > > >                 if (*quirks & HID_QUIRK_NOTOUCH) {
> > > >                         int a = field->logical_minimum;
> > > >                         int b = field->logical_maximum;
> > > >
> > > > -                       input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
> > > > +                       if (value > a + ((b - a) >> 3)) {
> > > > +                               input_event(input, EV_KEY, BTN_TOUCH, 1);
> > > > +                               report->tool_active = true;
> > > > +                       }
> > > >                 }
> > > >                 break;
> > > >
> > > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > > index eaad0655b05c..feb8df61168f 100644
> > > > --- a/include/linux/hid.h
> > > > +++ b/include/linux/hid.h
> > > > @@ -347,7 +347,7 @@ struct hid_item {
> > > >   */
> > > >  #define MAX_USBHID_BOOT_QUIRKS 4
> > > >
> > > > -#define HID_QUIRK_INVERT                       BIT(0)
> > > > +/* BIT(0) reserved for backward compatibility, was HID_QUIRK_INVERT */
> > > >  #define HID_QUIRK_NOTOUCH                      BIT(1)
> > > >  #define HID_QUIRK_IGNORE                       BIT(2)
> > > >  #define HID_QUIRK_NOGET                                BIT(3)
> > > > @@ -515,6 +515,10 @@ struct hid_report {
> > > >         unsigned maxfield;                              /* maximum valid field index */
> > > >         unsigned size;                                  /* size of the report (bits) */
> > > >         struct hid_device *device;                      /* associated device */
> > > > +
> > > > +       /* tool related state */
> > > > +       bool tool_active;                               /* whether the current tool is active */
> > > > +       unsigned int tool;                              /* BTN_TOOL_* */
> > > >  };
> > > >
> > > >  #define HID_MAX_IDS 256
> > > > --
> > > > 2.33.1
> > > >
> >
>
