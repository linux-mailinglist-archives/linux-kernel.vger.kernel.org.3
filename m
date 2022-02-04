Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4864AA2AE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbiBDV6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBDV6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:58:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FCC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:57:59 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o12so23109173eju.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4ry+6xT/5Q2RE5BmaT6rGkA3Wtas/JKbSMIBj1k8UiY=;
        b=CVusU5U6nDWS1JVb0PZvHpmocDCcQhArtVdyzZqA414Xb7FGrqrjH2WoXceqJvju8P
         DbLvfLlrYLVeStDKM6EmvIYLppiIy4xIIC5aSPIOyAFbClI46pTs5NFtRrbrdcQztdOg
         Z23r4oLHWDJZ4OZ56ZKPu82iD03qkoLF9CiCG2+mKL02p6AFz1E9JyGjczVCE4LgXZHq
         e+WV4blAji5axR7MV3E2YpopTBy6ADV87QR16w7z0n3vcHqfr78Q0gwp8VVDrtFFd6fh
         eiy2/XB4tiV/ZIyRHwNR5ZiSxmqR4GCOejClHPcQdETqcfNR7EQ5GdOQVAR5VhPf2pK/
         95pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4ry+6xT/5Q2RE5BmaT6rGkA3Wtas/JKbSMIBj1k8UiY=;
        b=Kpt7ytTzftgNI/r1nKyYL/DmklDhipQEiUjt8Tsmr5KW7IXoy36yJubKjhLKYtuR3P
         H6UymivTrozTLv/Y8M5Zo7Hph7x+B3FDnP0Lnx7+dIqqK0qcFAAo+Jz2Rhb27H4SOi2q
         n8ul7vBqPTZEug4ZZj7eKyyVn+lgMZSLhB2tZ8P+KmhME/itm4/5vJh4MHPD5uraXz4v
         2bzDqiQAY7XAJS6Ru3Rd+wW+SRsZlqf9r9PK/OpNT9gqZYjvGyZsjfOox7GJwZwT45Hu
         j/2mZXu8HhoHTNvkIaOrtBN6CPflM7aZneJJSNaLfvs4TylWmdr7SsZE26++RU17bwLG
         nEuw==
X-Gm-Message-State: AOAM531fJREYfawFNIAqDWCP6MayWVmEGHzLtzCNOb7Tnm+UTq7d+Szu
        aU+R3SiavJoNPz8PdcAAwvUxnls5jPnoxQhcGqjruw==
X-Google-Smtp-Source: ABdhPJyjPtHXPXxgtQ0AVGPTpqG2fXVtIIZm54elBHYCRwA8XbI0pmZ+X2oyzyAMLVWlc0R3MpRSEZkwGBAoxdDOP2c=
X-Received: by 2002:a17:907:7f1b:: with SMTP id qf27mr792124ejc.114.1644011877513;
 Fri, 04 Feb 2022 13:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20220201015518.3118404-1-wonchung@google.com> <Yfo+gYLLOGN69Re1@kuha.fi.intel.com>
 <CAOvb9ygyupib4cMXhcdeZmgNZmyaCmaTF98MHae+irY5ruZ1Qw@mail.gmail.com> <CAJZ5v0hGxYv1xagc+ZQFhvpLpcbs1c1szZZahR7wsDm=i5AcJg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hGxYv1xagc+ZQFhvpLpcbs1c1szZZahR7wsDm=i5AcJg@mail.gmail.com>
From:   Won Chung <wonchung@google.com>
Date:   Fri, 4 Feb 2022 13:57:45 -0800
Message-ID: <CAOvb9yhMgQ_4sDwqYS6ZYhauw3BKOidkp1uMFp6yw9nUWnLjSw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: device_sysfs: Add sysfs support for _PLD
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_50,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 11:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote=
:
>
> On Wed, Feb 2, 2022 at 9:43 PM Won Chung <wonchung@google.com> wrote:
> >
> > Hi Heikki,
> >
> > Thank you for the review!
> >
> > On Wed, Feb 2, 2022 at 12:19 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi Won,
> > >
> > > On Tue, Feb 01, 2022 at 01:55:18AM +0000, Won Chung wrote:
> > > > When ACPI table includes _PLD fields for a device, create a new
> > > > directory (pld) in sysfs to share _PLD fields.
> > >
> > > I think you need to explain what needs this information in user space=
.
> > >
> > > > Signed-off-by: Won Chung <wonchung@google.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-bus-acpi | 107 +++++++++++++++++++=
++++
> > > >  drivers/acpi/device_sysfs.c              |  55 ++++++++++++
> > > >  include/acpi/acpi_bus.h                  |   1 +
> > > >  3 files changed, 163 insertions(+)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentati=
on/ABI/testing/sysfs-bus-acpi
> > > > index 58abacf59b2a..b8b71c8f3cfd 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-acpi
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> > > > @@ -96,3 +96,110 @@ Description:
> > > >               hardware, if the _HRV control method is present.  It =
is mostly
> > > >               useful for non-PCI devices because lspci can list the=
 hardware
> > > >               version for PCI devices.
> > > > +
> > > > +What:                /sys/bus/acpi/devices/.../pld/
> > > > +Date:                Feb, 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             This directory contains the output of the device obje=
ct's _PLD
> > > > +             control method, if present. This information provides=
 details
> > > > +             on physical location of a device.
> > > > +
> > > > +What:                /sys/bus/acpi/devices/.../pld/revision
> > > > +Date:                Feb, 2022
> > > > +Contact:     Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             The current revision is 0x2.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/group_token
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Unique numerical value identifying a group.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/group_position
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Identifies this device connection point=E2=80=99s pos=
ition in the group.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/user_visible
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Set if the device connection point can be seen by the=
 user
> > > > +             without disassembly.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/dock
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Set if the device connection point resides in a docki=
ng station
> > > > +             or port replicator.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/bay
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Set if describing a device in a bay or if device conn=
ection
> > > > +             point is a bay.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/lid
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Set if this device connection point resides on the li=
d of
> > > > +             laptop system.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/panel
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Describes which panel surface of the system=E2=80=99s=
 housing the
> > > > +             device connection point resides on:
> > > > +             0 - Top
> > > > +             1 - Bottom
> > > > +             2 - Left
> > > > +             3 - Right
> > > > +             4 - Front
> > > > +             5 - Back
> > > > +             6 - Unknown (Vertical Position and Horizontal Positio=
n will be
> > > > +             ignored)
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/vertical_position
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             0 - Upper
> > > > +             1 - Center
> > > > +             2 - Lower
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/horizontal_position
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             ACPI specification does not define horizontal positio=
n field.
> > > > +             Can be used as either
> > > > +             0 - Left
> > > > +             1 - Center
> > > > +             2 - Right
> > > > +             or
> > > > +             0 - Leftmost
> > > > +             and higher numbers going toward the right.
> > > > +
> > > > +What:           /sys/bus/acpi/devices/.../pld/shape
> > > > +Date:           Feb, 2022
> > > > +Contact:        Won Chung <wonchung@google.com>
> > > > +Description:
> > > > +             Describes the shape of the device connection point.
> > > > +             0 - Round
> > > > +             1 - Oval
> > > > +             2 - Square
> > > > +             3 - Vertical Rectangle
> > > > +             4 - Horizontal Rectangle
> > > > +             5 - Vertical Trapezoid
> > > > +             6 - Horizontal Trapezoid
> > > > +             7 - Unknown - Shape rendered as a Rectangle with dott=
ed lines
> > > > +             8 - Chamfered
> > > > +             15:9 - Reserved
> > > > +
> > > > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysf=
s.c
> > > > index d5d6403ba07b..610be93635a0 100644
> > > > --- a/drivers/acpi/device_sysfs.c
> > > > +++ b/drivers/acpi/device_sysfs.c
> > > > @@ -509,6 +509,49 @@ static ssize_t status_show(struct device *dev,=
 struct device_attribute *attr,
> > > >  }
> > > >  static DEVICE_ATTR_RO(status);
> > > >
> > > > +#define DEV_ATTR_PLD_PROP(prop) \
> > > > +     static ssize_t prop##_show(struct device *dev, struct device_=
attribute *attr, \
> > > > +             char *buf) \
> > > > +{ \
> > > > +     struct acpi_device *acpi_dev =3D to_acpi_device(dev); \
> > > > +     if (acpi_dev->pld =3D=3D NULL) \
> > > > +             return -EIO; \
> > > > +     return sprintf(buf, "%u\n", acpi_dev->pld->prop); \
> > > > +}; \
> > >
> > > Ah, you are storing the _PLD below. Before there were concerns about
> > > the memory that the cached _PLD information would consume. Another wa=
y
> > > of doing this would be to just always evaluate the _PLD here.
> > >
> > > Rafael needs to comment on this. My personal opinion is that let's
> > > just store the thing.
> > >
> >
> > By "always evaluate the _PLD here", you mean something like
> >   acpi_get_physical_device_location(dev->handle, &pld)
> > for every _PLD field, right?
> >
> > I will wait for Rafael's comment on this.
>

Hi Rafael,

Thank you for the review.

> So I would like to get back to the very beginning: Do you need full
> _PLD output to address the issue at hand?

I do not think we need full _PLD output. In fact, the fields I am
adding are many but not all _PLD fields. To explain reasons behind
each field added:
*revision: current pld revision
*group token and position: like an identifier for the device
*panel, horizontal position, vertical position: to locate which
physical device corresponds to this device
*user visible, dock, bay, lid: to determine if and how the device can
be located by the user.
*shape: helps determine connection type

So, for example, let's say there are multiple Type C connectors (C0,
C1, and C2). We have 2 Type C ports on the left panel and 1 Type C
port on the right panel of the laptop. We can use PLD fields: panel
and horizontal position to determine which connector actually
corresponds to which physical port. Having this information, we can
determine which specific port (out of three) is doing what. (like
charging cable connected to the port on the left side of the left
panel)

The fields that are in _PLD output but not included here are:
ignore_color, color, width, height, ejectable, OSPM ejection required,
cabinet_number, card_cage_number, reference, group orientation,
rotation, order, vertical offset, horizontal offset.
These are not included because they do not help specify the device to
which one in specific physical location.

>
> If so, do you really need it for all devices that have _PLD?

Benson and Prashant, please correct me if I am wrong:

I do not think we need to store PLD for all devices, I think just user
visible devices to locate them physically. So, I think we can check if
device_type is ACPI_BUS_TYPE_DEVICE and user_visible pld field is 1.
Otherwise, I do not think we need to store pld information nor create
sysfs files.
What do you think?

>
> If not, then why waste memory for all that stuff?

If this sounds okay with you, I can make changes and send v6. (This
comment is on v4 but I already sent v5)

Thank you,
Won
