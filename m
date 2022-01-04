Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F4483F86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiADJ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiADJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:58:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AD3C061761;
        Tue,  4 Jan 2022 01:58:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y130so82107264ybe.8;
        Tue, 04 Jan 2022 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gm4YQA03GbwDtdl7H/xeyS693QxFu2muZ3RDUff2VW4=;
        b=aikpzcBsrhXwAwL/XdR3/YsTx27ZZtgHgbMOCXlRtX1em/cL53e5QDsLXcTG2ogsrp
         Ki/2BgYdz+rhbcPGYJAJKNv7FED7fJeHjOL6zsJ7trcIHevfc6iz1vYeK0xL6SR0gE6i
         KF94cib7jFbAMMONg4rZelBykvUp4y/4//+kTylENqFdbFVdAz0HK3fEXESmXGR41CJB
         ifvqol/jzGWaeEaYeI2Y+gn80Liz18C32VKhZwkMQjBE23BLLBIhCGb1GbMt1K2u0O1r
         9TK09Mq6rmoNa0re2F3HX+2d+g1iajM0bV9kQYxxFxyIXUUJIr8PVOJPgE/u4uyyaWL5
         mMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm4YQA03GbwDtdl7H/xeyS693QxFu2muZ3RDUff2VW4=;
        b=j04QEI89XRdxInela4WisR2+1mWxfHz6Dm7yFQaJkhAh65YXcIEMZ5HUnCfNOgDGmQ
         qjhJwxBgj/U/DYhGTe14fkjIFoM8NjQGYppeGOxLcZMaOi9rwGNuyGHLZn4vq7lVw+Kk
         JExZXApcaW6zFr2mpd05aUduXeSL7qPASvVWQ4s8yg+rv72NK5obz0SeOQSQ0Mqn3jAL
         TJcJ7/v70R1Rf2hZuuH6oJpfO5ynRHC/D0lUOnaMrtxtYrwTrgm0MeRe1LU6FC1BzLUv
         mvSilgGrQ7efOFZzb1BjTGh0tfBEyvINeNrwbgwLdYntzJDFDO/18y9yuQnj75vHbGau
         vX9Q==
X-Gm-Message-State: AOAM5337tkgS5FSSqmxT2aBsl5BoCfHRyytGJCI3j5HsSh97S4xGp7lK
        UxoC1aMIK2yj2W78S+Q7QHomqV6tEoFjmW8z1mY=
X-Google-Smtp-Source: ABdhPJz2oNC7raWN06tOcbhL0W8SduceINTK9F4cTYqBY2VafkZ23r7b6ex9j31wH9uLRo8lWXYqyg7ly0hXtB5Pc4U=
X-Received: by 2002:a25:e7cc:: with SMTP id e195mr50026845ybh.251.1641290299346;
 Tue, 04 Jan 2022 01:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20200904201835.5958-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200904201835.5958-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <8b5d4928-2921-b876-7d1e-04bb42eff4fa@st.com> <3b54ab9b-4ffd-ab32-d495-fad6132ea504@microchip.com>
 <5c56c87d-ca48-5573-0606-da1441fab7ff@microchip.com> <CA+V-a8uk3h95aL7n7cDjYdXJBbE6GWF_LkiAVMOFtVzv-83ZpQ@mail.gmail.com>
 <450850f6-9296-e505-4b92-c71ed190b95f@microchip.com> <CA+V-a8vsX9Ei8dS+fJQe9jqcFXmvfeVb==-HhDkXFnajQYT6tg@mail.gmail.com>
 <e6cfb1fd-7132-0b5c-9e85-dd9c8dfd6d79@microchip.com>
In-Reply-To: <e6cfb1fd-7132-0b5c-9e85-dd9c8dfd6d79@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 4 Jan 2022 09:57:53 +0000
Message-ID: <CA+V-a8vOOk4WunS-27d5hrvhLbs3YqAUoGX+Mcan7e6kuHkajQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] media: i2c: ov5640: Remain in power down for DVP
 mode unless streaming
To:     Eugen Hristev <Eugen.Hristev@microchip.com>
Cc:     Hugues Fruchet <hugues.fruchet@st.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Paul <paul.kocialkowski@bootlin.com>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On Mon, Jan 3, 2022 at 11:29 AM <Eugen.Hristev@microchip.com> wrote:
>
> On 12/21/21 5:11 PM, Lad, Prabhakar wrote:
> > Hi Eugen,
> >
> > On Tue, Dec 21, 2021 at 3:02 PM <Eugen.Hristev@microchip.com> wrote:
> >>
> >> On 12/21/21 4:47 PM, Lad, Prabhakar wrote:
> >>> Hi,
> >>>
> >>> Sorry for the delay.
> >>>
> >>> On Tue, Dec 21, 2021 at 7:37 AM <Eugen.Hristev@microchip.com> wrote:
> >>>>
> >>>> On 6/29/21 1:47 PM, Eugen Hristev - M18282 wrote:
> >>>>> On 9/9/20 7:16 PM, Hugues FRUCHET wrote:
> >>>>>> Hi Prabhakar,
> >>>>>>
> >>>>>> As discussed separately I would prefer to better understand issue before
> >>>>>> going to this patch.
> >>>>>> Nevertheless I have some remarks in code in case we'll need it at the end.
> >>>>>>
> >>>>>> On 9/4/20 10:18 PM, Lad Prabhakar wrote:
> >>>>>>> Keep the sensor in software power down mode and wake up only in
> >>>>>>> ov5640_set_stream_dvp() callback.
> >>>>>>>
> >>>>>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> >>>>>>> Tested-by: Jacopo Mondi <jacopo@jmondi.org>
> >>>>>>> ---
> >>>>>>>       drivers/media/i2c/ov5640.c | 19 ++++++++++++++++---
> >>>>>>>       1 file changed, 16 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> >>>>>>> index 2fe4a7ac0592..880fde73a030 100644
> >>>>>>> --- a/drivers/media/i2c/ov5640.c
> >>>>>>> +++ b/drivers/media/i2c/ov5640.c
> >>>>>>> @@ -34,6 +34,8 @@
> >>>>>>>       #define OV5640_REG_SYS_RESET02              0x3002
> >>>>>>>       #define OV5640_REG_SYS_CLOCK_ENABLE02       0x3006
> >>>>>>>       #define OV5640_REG_SYS_CTRL0                0x3008
> >>>>>>> +#define OV5640_REG_SYS_CTRL0_SW_PWDN 0x42
> >>>>>>> +#define OV5640_REG_SYS_CTRL0_SW_PWUP 0x02
> >>>>>>
> >>>>>> For the time being this section was only referring to registers
> >>>>>> addresses and bit details was explained into a comment right before
> >>>>>> affectation, see OV5640_REG_IO_MIPI_CTRL00 for example.
> >>>>>>
> >>>>>>>       #define OV5640_REG_CHIP_ID          0x300a
> >>>>>>>       #define OV5640_REG_IO_MIPI_CTRL00   0x300e
> >>>>>>>       #define OV5640_REG_PAD_OUTPUT_ENABLE01      0x3017
> >>>>>>> @@ -1120,6 +1122,12 @@ static int ov5640_load_regs(struct ov5640_dev *sensor,
> >>>>>>>                   val = regs->val;
> >>>>>>>                   mask = regs->mask;
> >>>>>>>
> >>>>>>> +             /* remain in power down mode for DVP */
> >>>>>>> +             if (regs->reg_addr == OV5640_REG_SYS_CTRL0 &&
> >>>>>>> +                 val == OV5640_REG_SYS_CTRL0_SW_PWUP &&
> >>>>>>> +                 sensor->ep.bus_type != V4L2_MBUS_CSI2_DPHY)
> >>>>>>> +                     continue;
> >>>>>>> +
> >>>>>>
> >>>>>> I understand that more or less register OV5640_REG_SYS_CTRL0 (0x3008)
> >>>>>> has been partially removed from big init sequence: for power-up part,
> >>>>>> but power-dwn remains at very beginning of sequence.
> >>>>>> We should completely remove 0x3008 from init sequence, including
> >>>>>> power-dwn, and introduce a new function ov5640_sw_powerdown(on/off) that
> >>>>>> should be called at the right place instead.
> >>>>>>
> >>>>>>
> >>>>>>>                   if (mask)
> >>>>>>>                           ret = ov5640_mod_reg(sensor, reg_addr, mask, val);
> >>>>>>>                   else
> >>>>>>> @@ -1297,9 +1305,14 @@ static int ov5640_set_stream_dvp(struct ov5640_dev *sensor, bool on)
> >>>>>>>            * PAD OUTPUT ENABLE 02
> >>>>>>>            * - [7:2]:     D[5:0] output enable
> >>>>>>>            */
> >>>>>>> -     return ov5640_write_reg(sensor,
> >>>>>>> -                             OV5640_REG_PAD_OUTPUT_ENABLE02,
> >>>>>>> -                             on ? 0xfc : 0);
> >>>>>>> +     ret = ov5640_write_reg(sensor, OV5640_REG_PAD_OUTPUT_ENABLE02,
> >>>>>>> +                            on ? 0xfc : 0);
> >>>>>>> +     if (ret)
> >>>>>>> +             return ret;
> >>>>>>> +
> >>>>>>> +     return ov5640_write_reg(sensor, OV5640_REG_SYS_CTRL0, on ?
> >>>>>>> +                             OV5640_REG_SYS_CTRL0_SW_PWUP :
> >>>>>>> +                             OV5640_REG_SYS_CTRL0_SW_PWDN);
> >>>>>>>       }
> >>>>>>>
> >>>>>>>       static int ov5640_set_stream_mipi(struct ov5640_dev *sensor, bool on)
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> BR,
> >>>>>> Hugues.
> >>>>>>
> >>>>>
> >>>>>
> >>>>> Hello everyone,
> >>>>>
> >>>>> When I updated driver in my tree with this patch, I noticed that my
> >>>>> setup using the ATMEL isc platform + ov5640 in parallel bus mode stopped
> >>>>> working.
> >>>>>
> >>>>> It looks like the culprit is this patch.
> >>>>> I am not sure which is the best way to fix it.
> >>>>> It looks like initially things work fine when probing the driver, but
> >>>>> when we want to start streaming at a later point, the register SYS_CTRL0
> >>>>> cannot be written anymore.
> >>>>> Here is an output of the log:
> >>>>>
> >>>>>      --- Opening /dev/video0...
> >>>>>         Trying source module v4l2...
> >>>>>         /dev/video0 opened.
> >>>>>         No input was specified, using the first.
> >>>>>         ov5640 1-003c: ov5640_write_reg: error: reg=3008, val=2
> >>>>>         atmel-sama5d2-isc f0008000.isc: stream on failed in subdev -121
> >>>>>         Error starting stream.
> >>>>>         VIDIOC_STREAMON: Remote I/O error
> >>>>>         Unable to use mmap. Using read instead.
> >>>>>         Unable to use read.
> >>>>>
> >>>>> I am using a simple application to read from /dev/video0 (which is
> >>>>> registered by the atmel-isc once the sensor probed)
> >>>>>
> >>>>> I have a feeling that something is wrong related to power, but I cannot
> >>>>> tell for sure.
> >>>>>
> >>>>> Reverting this patch makes it work fine again.
> >>>>>
> >>>>> Help is appreciated,
> >>>>> Thanks,
> >>>>> Eugen
> >>>>>
> >>>>
> >>>>
> >>>> Gentle ping.
> >>>>
> >>>> I would like to send a revert patch if nobody cares about this
> >>>> driver/patch except me.
> >>>>
> >>> I powered up the Renesas RZ/G1H connected with an ov5640 sensor and
> >>> was able to capture the video data [0] using the yavta application.
> >>> I'm fine with reverting the patch too as this works fine as well.
> >>
> >> Hi Prabhakar,
> >>
> >> Thanks for trying this out.
> >> ov5640 works in both parallel or CSI2 mode. Looking at the board, it
> >> looks a parallel connection but I am not 100%, you tested using parallel
> >> interface ?
> >>
> > I have tested it in parallel interface mode as RZ/G1H supports parallel capture
> >
> >>>
> >>> Just some suggestions:
> >>> - What is the application you are trying to use for capturing?
> >>
> >> I was using a simple app that reads from /dev/video0, it's called
> >> fswebcam. I can try more apps if it's needed.
> >>
> > could you give it a shot with yavta please.
>
> Hello Lad,
>
> I debugged this further, and I have some news:
>
> It looks like the 'write 0x2 to SYS_CLTR0' does not fail itself, rather
> the sensor refuses to accept a power up.
>
> I tried to read the register before the write, and it reads 0x42.
> Then, I tried to write 0x42 back, and it works fine.
> So, I do not think there is a problem with i2c communication.
> The only problem is that the sensor refuses to power up (accept the 0x2
> into the SYS_CTRL_0 ), due to an unknown (to me) reason.
>
That's strange.

> If the power up is performed at the initialization phase, it works.
>
> I also tried to capture with v4l2-ctl, and the result is the same.
>
you mean yavta ?

> Which of the init configuration set of registers your test is using?
I have been testing 320x240 and 640x480. Could you give that a try please?

> It may be that it does not work in a specific config .
>
> The datasheet which I have does not claim that the 'power up' might fail
> in some circumstances.
>
Let me check if I can ping OmniVision FAE.

> Thanks for helping,
>
> Eugen
>
>
> >
> >>> - Have you tried reducing the i2c clock speed?
> >>
> >> I did not, but without this patch, there is no problem whatsoever, and I
> >> have been using this sensor since around 4.9 kernel version.
> >>
> > Agreed, I'm thinking aloud just to narrow things.
> >
> >>> - Can you try and do a dummy write for some other register in
> >>> ov5640_set_stream_dvp() to see if i2c writes are failing for all regs?
> >>
> >> I can try
> >>
> > Thank you.
> >
> >>> - Can you add ov5640_read_reg() in ov5640_write_reg() when
> >>> i2c_transfer() fails to check if read too is failing.
> >>>
> >>> [0] https://paste.debian.net/1224317/
> >>
> >> You seem to be able to capture successfully, I have a feeling that in my
> >> case the sensor is somehow not powered up when the capture is being
> >> requested.
> >> Could you share a snippet of your device tree node for the sensor so I
> >> can have a look ?
> >>
> > [0] contains the bridge node and [1] contains the sensor node.
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts?h=v5.16-rc6#n309
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ov5640-single.dtsi?h=v5.16-rc6
> >
Cheers,
Prabhakar
