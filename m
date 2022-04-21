Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C1A50A6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390622AbiDURQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390619AbiDURQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:16:54 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAB49F2B;
        Thu, 21 Apr 2022 10:14:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c12so5471866plr.6;
        Thu, 21 Apr 2022 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MxcqNBuLlgwV5pkJyNK1Jc4BB+ZpSfqWM7Qi+3NQsTM=;
        b=c77q8mWWdNUdQ37z3lmK3BhiXUigw1TAmxjMQh5leOxbnLJJvbVGRwYl10odV6mEKZ
         6LaP9Z6afKFPbruWD0TCUnjqYFk3kEsdYMYhgTKsY+nwQMZc4UdtVUScPcztpKs2RGsg
         iw0vOwaZzPVKKETvSQNOVblczz7vdvpKPvLD+4QM7uG0icQa9jDg2zptEPIgxhkRzqGl
         vNkoZX5iCq0EeZsOHGHxIop2bFa5n9xwJcCoJ+wJuqIO/cGYaK/BxmKeDTEgdOVtf12o
         FapYCl6B4pFuTjiEIwniSOUC5PM1u1phlJ//HlndXjbOGSGwVrV+EfAnTViDMxMmuZgk
         mFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MxcqNBuLlgwV5pkJyNK1Jc4BB+ZpSfqWM7Qi+3NQsTM=;
        b=6R0uq3+erWtLcUGjJe7jyVUJSCJeUxnhn2wn9rvysp3HmdbgP/EeqW/963+Ijpf1B/
         opjcpvqnmEIknDLbnOqRERwrGSpFsTHgVYrNLIoVib3Blgvufvvy24k+TsB9ZzrfIKof
         73KTBsqwozY7m9nDFN67h9DDqXRB8V5CmFOvRhaMQjuhHQipz2m4xs04HiUn4nevVMxe
         UgnYM1ghxCRKt93V/SGaRDZXkAAAhAbqVn62k1pwWeSd/X/PpVI0MaD2SKn0tfQo4zXL
         1uUUoxzmRzwTbrntUiBroHUFfQChCle6Xhe1vuWomsJYxTf/EB45JNT1XpSmUjFBxIR4
         iKBw==
X-Gm-Message-State: AOAM533jfNmdPVFVQZct5A96RuSWs57aGDiygKCtVCzmIr85NjVPXpYn
        iWAWht4Hl0e+TjhPF1v1b+Yf0kM1Q1OjiiDBGe8f9vuov2o=
X-Google-Smtp-Source: ABdhPJyDTdYxGS/8iArh56f5gpzRxC6dvMhO5iVqK1KW6EhJ0PBhhxmhLwO8UwIAirFIGizi5gFMiFKUQZvj0qChx98=
X-Received: by 2002:a17:90b:1c10:b0:1d2:a7c4:3cf with SMTP id
 oc16-20020a17090b1c1000b001d2a7c403cfmr718201pjb.100.1650561243688; Thu, 21
 Apr 2022 10:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220407115406.115112-1-hadess@hadess.net> <nycvar.YFH.7.76.2204111708230.30217@cbobk.fhfr.pm>
 <CANRwn3SVcqFtv0BTTtqpM7M4WRN4sMKVo7_-9t5M8itt-rEttQ@mail.gmail.com> <7a50fc20503e43c8172c42c621e01a111bc8104f.camel@hadess.net>
In-Reply-To: <7a50fc20503e43c8172c42c621e01a111bc8104f.camel@hadess.net>
From:   Jason Gerecke <killertofu@gmail.com>
Date:   Thu, 21 Apr 2022 10:13:52 -0700
Message-ID: <CANRwn3Qs7YB-qDC7FrZ+g4wB+92V8CqOQYKubTX0BpyOf0Ejhw@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: Correct power_supply type
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Jason Gerecke <jason.gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 1:52 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> On Wed, 2022-04-13 at 07:59 -0700, Jason Gerecke wrote:
> > Following up on my previous comment. I've been able to test this
> > patch
> > with both flavors of wireless interface. Both Bluetooth (Intuos Pro)
> > and dongle-based (Intuos5) appear to have mostly-correct behavior
> > while charging and discharging, even when the battery level gradually
> > drops to zero. The misbehaviors I see appear to be limited to upower
> > mis-categorizing the devices as an e.g. keyboard or generic battery
> > rather than as a tablet. This leads to some slightly confusing UI
> > issues (e.g. GNOME and KDE referring to the device incorrectly), but
> > nothing too annoying. If upower is taught to recognize tablets under
> > more circumstances those issues should disappear.
> >
> > Ping tells me you may have an Intuos4 Wireless, Bastien? Any
> > additional testing you can do with that device would be appreciated,
> > though even without it I'm personally comfortable enough to provide
> > an
> > ack:
> >
> > Acked-by: Jason Gerecke <jason.gerecke@wacom.com>
>
> Only devices I have is the original Wacom Graphire Bluetooth, and a
> wired Intuos4 (PTK-640) which I think changed names not long after.
>
> This might be enough:
> https://gitlab.freedesktop.org/upower/upower/-/merge_requests/127
>
> Please file an issue with the info discussed in the previous mail if it
> isn't.
>

Thanks Bastien, it seems to do the trick for Bluetooth devices but
needs a little more work for the dongle-based Intuos5. I've filed a
new issue with some suggestions as requested:
https://gitlab.freedesktop.org/upower/upower/-/issues/182

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> Cheers
>
> >
> > Jason
> > ---
> > Now instead of four in the eights place /
> > you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> > (That is to say, eight) to the two,     /
> > But you can=E2=80=99t take seven from three,    /
> > So you look at the sixty-fours....
> >
> > On Tue, Apr 12, 2022 at 1:53 AM Jiri Kosina <jikos@kernel.org> wrote:
> > >
> > > On Thu, 7 Apr 2022, Bastien Nocera wrote:
> > >
> > > > POWER_SUPPLY_TYPE_USB seems to only ever be used by USB ports
> > > > that are
> > > > used to charge the machine itself (so a "system" scope), like the
> > > > single USB port on a phone, rather than devices.
> > > >
> > > > The wacom_sys driver is the only driver that sets its device
> > > > battery as
> > > > being a USB type, which doesn't seem correct based on its usage,
> > > > so
> > > > switch it to be a battery type like all the other USB-connected
> > > > devices.
> > > >
> > > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > > ---
> > > >  drivers/hid/wacom_sys.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > > index 066c567dbaa2..620fe74f5676 100644
> > > > --- a/drivers/hid/wacom_sys.c
> > > > +++ b/drivers/hid/wacom_sys.c
> > > > @@ -1777,7 +1777,7 @@ static int
> > > > __wacom_initialize_battery(struct wacom *wacom,
> > > >       bat_desc->get_property =3D wacom_battery_get_property;
> > > >       sprintf(battery->bat_name, "wacom_battery_%ld", n);
> > > >       bat_desc->name =3D battery->bat_name;
> > > > -     bat_desc->type =3D POWER_SUPPLY_TYPE_USB;
> > > > +     bat_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> > > >       bat_desc->use_for_apm =3D 0;
> > > >
> > > >       ps_bat =3D devm_power_supply_register(dev, bat_desc,
> > > > &psy_cfg);
> > >
> > > Thanks Bastien, makes sense. CCing Jason and Ping (the Wacom driver
> > > maintainers) to get their Ack.
> > >
> > > --
> > > Jiri Kosina
> > > SUSE Labs
> > >
>
