Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0155537C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352062AbiFUQXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353961AbiFUQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:23:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B80D13F4A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:23:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq6so28551170ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67J1ELq2WzHgsGWcVocoSU2pvSvqCNhiy2w4xIp1RKg=;
        b=MrKXcvst61Ida9omdn7mOMevCg1iLZ+3RD7N/AvEb3GtCKK9YmU1qKdbZEqWD751fo
         Wl+u0JPqsLVj+13sa2nzPevwrOUthyU3xVh3hSqvG1n1bIoqTn6fVFx/lTylk6AYiEY5
         N+G4G7cPuCwRKdapmI5nQtDH1KBR7Y3UfJhPr+sB6z8XAESCsVnHWrmP9/6HbM0GS+KR
         whIlyQb9IMMirxFs6V+ldBT5pZ/YO7R8b3Q+r20K1GlLf4B3sjrok1IVr3RpfAD3yf7w
         l17RIKacR3mWLWBot+nEoK29x7tUyeAA9Apj6s6KKcv0CxIEDbL+M/rfG7TXdjqMNgP7
         gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67J1ELq2WzHgsGWcVocoSU2pvSvqCNhiy2w4xIp1RKg=;
        b=uyi9D/XnpKaX0nPeflaIjfbbMdJvaoW/LI4gOOxBMuqsjM9NqYt2SeOLwHn6hpMTKJ
         hg0a9XrFgz/J+dPnxV0/kYo/RgbjV/tfJqt8bcFnWxaTSrlWite9MO5Agn5700jn2j+8
         nJf6ABvikVba/x7TEGVDu3+ld9LLF7wU8tTi3C1LO1jN6KKXLG87LzWHMfmswRagX9Tk
         k40s07Ll6f7eHiTtePdi8tPDWCiK1QHw5ldlGhMGi0iTudXVCh6yb40duIWDSY5rcRjw
         /FpTxA+p0eWvfmNAp6Q+bXrYPtln4AjXZ7TB6EjqYqX4e5I8oDrYpo6x8Isib/GSjHHC
         Q+Ng==
X-Gm-Message-State: AJIora9YWSJkZFjECvoA6EvoAp+wxXVZ3xRSSyfaaeNd04lPRBV2jwpC
        GcHdFO82gEmOA4CgHriPcdRKbgsPmM6ykfAdW4YAJA==
X-Google-Smtp-Source: AGRyM1vlWHNLo6tqv/EkxFRRqi75W6NLsozY4E5d0v0jFHBAnXUhmzIEn9od7sit21eb0bMBNUp1BzP+Ak22HJY3rf0=
X-Received: by 2002:a17:906:5055:b0:6ff:1dfb:1e2c with SMTP id
 e21-20020a170906505500b006ff1dfb1e2cmr26501254ejk.200.1655828599822; Tue, 21
 Jun 2022 09:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220616123150.5890-1-aford173@gmail.com> <CAPY8ntCmov0OY3tBabf7ndSVCNgeYeSy+e4E0sdaW54zZpoauw@mail.gmail.com>
 <CAHCN7xKGhFn0NHEdjMg9kuPVOB_p_CL4FEiZczbGsPcob-Tv8Q@mail.gmail.com>
In-Reply-To: <CAHCN7xKGhFn0NHEdjMg9kuPVOB_p_CL4FEiZczbGsPcob-Tv8Q@mail.gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 21 Jun 2022 17:23:04 +0100
Message-ID: <CAPY8ntAW1nVc6=jjPeo13tZbmvTfCy=7Ha+45BNVbEsCMj1Xqg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] media: i2c: imx219: Split common registers from
 mode tables
To:     Adam Ford <aford173@gmail.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 16:58, Adam Ford <aford173@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 10:46 AM Dave Stevenson
> <dave.stevenson@raspberrypi.com> wrote:
> >
> > Hi Adam
> >
> > Thanks for the patch, and sorry it's taken me a few days to get to it.
> >
> > On Thu, 16 Jun 2022 at 13:31, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > There are four modes, and each mode has a table of registers.
> > > Some of the registers are common to all modes, so create new
> > > tables for these common registers to reduce duplicate code.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > V2:  Merge the PLL table into the common table instead of having
> > >      two separate, common tables.
> > >
> > > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > > index e10af3f74b38..a43eed143999 100644
> > > --- a/drivers/media/i2c/imx219.c
> > > +++ b/drivers/media/i2c/imx219.c
> > > @@ -145,23 +145,60 @@ struct imx219_mode {
> > >         struct imx219_reg_list reg_list;
> > >  };
> > >
> > > -/*
> > > - * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > > - * driver.
> > > - * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > > - */
> > > -static const struct imx219_reg mode_3280x2464_regs[] = {
> > > -       {0x0100, 0x00},
> > > +/* To Access Addresses 3000-5fff, send the following commands */

I've just noticed that this comment is still outside the table. The
registers you list as "Access Command Sequence" are the commands to
allow access, the rest are additional configuration.

> > > +static const struct imx219_reg imx219_common_regs[] = {
> > > +       {0x0100, 0x00}, /* Mode Select */
> > > +
> > > +       /* Access Command Sequence */
> > >         {0x30eb, 0x0c},
> > >         {0x30eb, 0x05},
> > >         {0x300a, 0xff},
> > >         {0x300b, 0xff},
> > >         {0x30eb, 0x05},
> > >         {0x30eb, 0x09},
> > > -       {0x0114, 0x01},
> > > -       {0x0128, 0x00},
> > > -       {0x012a, 0x18},
> > > +
> > > +       /* PLL Clock Table */
> > > +       {0x0301, 0x05}, /* VTPXCK_DIV */
> > > +       {0x0303, 0x01}, /* VTSYSCK_DIV */
> > > +       {0x0304, 0x03}, /* PREPLLCK_VT_DIV 0x03 = AUTO set */
> > > +       {0x0305, 0x03}, /* PREPLLCK_OP_DIV 0x03 = AUTO set */
> > > +       {0x0306, 0x00}, /* PLL_VT_MPY */
> > > +       {0x0307, 0x39},
> > > +       {0x030b, 0x01}, /* OP_SYS_CLK_DIV */
> > > +       {0x030c, 0x00}, /* PLL_OP_MPY */
> > > +       {0x030d, 0x72},
> > > +
> > > +       /* Undocumented registers */
> > > +       {0x455e, 0x00},
> > > +       {0x471e, 0x4b},
> > > +       {0x4767, 0x0f},
> > > +       {0x4750, 0x14},
> > > +       {0x4540, 0x00},
> > > +       {0x47b4, 0x14},
> > > +       {0x4713, 0x30},
> > > +       {0x478b, 0x10},
> > > +       {0x478f, 0x10},
> > > +       {0x4793, 0x10},
> > > +       {0x4797, 0x0e},
> > > +       {0x479b, 0x0e},
> > > +
> > > +       /* Frame Bank Register Group "A" */
> > > +       {0x0162, 0x0d}, /* Line_Length_A */
> > > +       {0x0163, 0x78},
> >
> > Registers 0x0170 and 0x171 for X_ODD_INC_A and Y_ODD_INC_A are also
> > common to all modes as 0x01. You could have modes with skipping, but
> > currently there are none.
> >
> > > +
> > > +       /* Output setup registers */
> > > +       {0x0114, 0x01}, /* CSI 2-Lane Mode */
> > > +       {0x0128, 0x00}, /* DPHY Auto Mode */
> > > +       {0x012a, 0x18}, /* EXCK_Freq */
> > >         {0x012b, 0x00},
> > > +};
> > > +
> > > +/*
> > > + * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> > > + * driver.
> > > + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 7.
> > > + */
> > > +static const struct imx219_reg mode_3280x2464_regs[] = {
> > >         {0x0164, 0x00},
> > >         {0x0165, 0x00},
> > >         {0x0166, 0x0c},
> > > @@ -176,51 +213,15 @@ static const struct imx219_reg mode_3280x2464_regs[] = {
> > >         {0x016f, 0xa0},
> > >         {0x0170, 0x01},
> > >         {0x0171, 0x01},
> > > -       {0x0174, 0x00},
> > > +       {0x0174, 0x00}, /* No-Binning */
> > >         {0x0175, 0x00},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x0c},
> > >         {0x0625, 0xd0},
> > >         {0x0626, 0x09},
> > >         {0x0627, 0xa0},
> > > -       {0x455e, 0x00},
> > > -       {0x471e, 0x4b},
> > > -       {0x4767, 0x0f},
> > > -       {0x4750, 0x14},
> > > -       {0x4540, 0x00},
> > > -       {0x47b4, 0x14},
> > > -       {0x4713, 0x30},
> > > -       {0x478b, 0x10},
> > > -       {0x478f, 0x10},
> > > -       {0x4793, 0x10},
> > > -       {0x4797, 0x0e},
> > > -       {0x479b, 0x0e},
> > > -       {0x0162, 0x0d},
> > > -       {0x0163, 0x78},
> > >  };
> > >
> > >  static const struct imx219_reg mode_1920_1080_regs[] = {
> > > -       {0x0100, 0x00},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x0c},
> > > -       {0x300a, 0xff},
> > > -       {0x300b, 0xff},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x09},
> > > -       {0x0114, 0x01},
> > > -       {0x0128, 0x00},
> > > -       {0x012a, 0x18},
> > > -       {0x012b, 0x00},
> > > -       {0x0162, 0x0d},
> > > -       {0x0163, 0x78},
> > >         {0x0164, 0x02},
> > >         {0x0165, 0xa8},
> > >         {0x0166, 0x0a},
> > > @@ -235,47 +236,15 @@ static const struct imx219_reg mode_1920_1080_regs[] = {
> > >         {0x016f, 0x38},
> > >         {0x0170, 0x01},
> > >         {0x0171, 0x01},
> > > -       {0x0174, 0x00},
> > > +       {0x0174, 0x00}, /* No-Binning */
> > >         {0x0175, 0x00},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x07},
> > >         {0x0625, 0x80},
> > >         {0x0626, 0x04},
> > >         {0x0627, 0x38},
> > > -       {0x455e, 0x00},
> > > -       {0x471e, 0x4b},
> > > -       {0x4767, 0x0f},
> > > -       {0x4750, 0x14},
> > > -       {0x4540, 0x00},
> > > -       {0x47b4, 0x14},
> > > -       {0x4713, 0x30},
> > > -       {0x478b, 0x10},
> > > -       {0x478f, 0x10},
> > > -       {0x4793, 0x10},
> > > -       {0x4797, 0x0e},
> > > -       {0x479b, 0x0e},
> > >  };
> > >
> > >  static const struct imx219_reg mode_1640_1232_regs[] = {
> > > -       {0x0100, 0x00},
> > > -       {0x30eb, 0x0c},
> > > -       {0x30eb, 0x05},
> > > -       {0x300a, 0xff},
> > > -       {0x300b, 0xff},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x09},
> > > -       {0x0114, 0x01},
> > > -       {0x0128, 0x00},
> > > -       {0x012a, 0x18},
> > > -       {0x012b, 0x00},
> > >         {0x0164, 0x00},
> > >         {0x0165, 0x00},
> > >         {0x0166, 0x0c},
> > > @@ -290,51 +259,15 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
> > >         {0x016f, 0xd0},
> > >         {0x0170, 0x01},
> > >         {0x0171, 0x01},
> > > -       {0x0174, 0x01},
> > > +       {0x0174, 0x01}, /* x2-Binning */
> > >         {0x0175, 0x01},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x06},
> > >         {0x0625, 0x68},
> > >         {0x0626, 0x04},
> > >         {0x0627, 0xd0},
> > > -       {0x455e, 0x00},
> > > -       {0x471e, 0x4b},
> > > -       {0x4767, 0x0f},
> > > -       {0x4750, 0x14},
> > > -       {0x4540, 0x00},
> > > -       {0x47b4, 0x14},
> > > -       {0x4713, 0x30},
> > > -       {0x478b, 0x10},
> > > -       {0x478f, 0x10},
> > > -       {0x4793, 0x10},
> > > -       {0x4797, 0x0e},
> > > -       {0x479b, 0x0e},
> > > -       {0x0162, 0x0d},
> > > -       {0x0163, 0x78},
> > >  };
> > >
> > >  static const struct imx219_reg mode_640_480_regs[] = {
> > > -       {0x0100, 0x00},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x0c},
> > > -       {0x300a, 0xff},
> > > -       {0x300b, 0xff},
> > > -       {0x30eb, 0x05},
> > > -       {0x30eb, 0x09},
> > > -       {0x0114, 0x01},
> > > -       {0x0128, 0x00},
> > > -       {0x012a, 0x18},
> > > -       {0x012b, 0x00},
> > > -       {0x0162, 0x0d},
> > > -       {0x0163, 0x78},
> > >         {0x0164, 0x03},
> > >         {0x0165, 0xe8},
> > >         {0x0166, 0x08},
> > > @@ -349,33 +282,12 @@ static const struct imx219_reg mode_640_480_regs[] = {
> > >         {0x016f, 0xe0},
> > >         {0x0170, 0x01},
> > >         {0x0171, 0x01},
> > > -       {0x0174, 0x03},
> > > +       {0x0174, 0x03}, /* x2-analog binning */
> > >         {0x0175, 0x03},
> > > -       {0x0301, 0x05},
> > > -       {0x0303, 0x01},
> > > -       {0x0304, 0x03},
> > > -       {0x0305, 0x03},
> > > -       {0x0306, 0x00},
> > > -       {0x0307, 0x39},
> > > -       {0x030b, 0x01},
> > > -       {0x030c, 0x00},
> > > -       {0x030d, 0x72},
> > >         {0x0624, 0x06},
> > >         {0x0625, 0x68},
> > >         {0x0626, 0x04},
> > >         {0x0627, 0xd0},
> > > -       {0x455e, 0x00},
> > > -       {0x471e, 0x4b},
> > > -       {0x4767, 0x0f},
> > > -       {0x4750, 0x14},
> > > -       {0x4540, 0x00},
> > > -       {0x47b4, 0x14},
> > > -       {0x4713, 0x30},
> > > -       {0x478b, 0x10},
> > > -       {0x478f, 0x10},
> > > -       {0x4793, 0x10},
> > > -       {0x4797, 0x0e},
> > > -       {0x479b, 0x0e},
> > >  };
> > >
> > >  static const struct imx219_reg raw8_framefmt_regs[] = {
> > > @@ -1041,6 +953,13 @@ static int imx219_start_streaming(struct imx219 *imx219)
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > +       /* Send the Manufacturing Header common to all modes */
> >
> > It's a table of common settings, not a manufacturing header.
> > s/Send the Manufacturing Header/Send all registers that are
>
> I used that term because the data sheet shows the following sequence:
>
> {0x30eb, 0x0c},
> {0x30eb, 0x05},
> {0x300a, 0xff},
> {0x300b, 0xff},
> {0x30eb, 0x05},
> {0x30eb, 0x09},
>
> It's listed as "Manufacturer Specific Registers" to access
> 0x3000-5fff, the specific sequence as specified in 3-4.  The entire
> table is common, but I tried to put comments into the sections to
> explain what they do.

That little bit is, yes, and you refer to it as such in the comments
for imx219_common_regs.
At this point you are sending the complete table of
imx219_common_regs, which includes registers outside that 0x3000-5fff
address space.

TBH All registers are manufacturer specific unless you implement the
MIPI CCS or SMIA standards (which, it seems, almost no one does).

> >
> >  Dave
> >
> > > +       ret = imx219_write_regs(imx219, imx219_common_regs, ARRAY_SIZE(imx219_common_regs));
> > > +       if (ret) {
> > > +               dev_err(&client->dev, "%s failed to send mfg header\n", __func__);
> > > +               goto err_rpm_put;
> > > +       }
> > > +
> > >         /* Apply default values of current mode */
> > >         reg_list = &imx219->mode->reg_list;
> > >         ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> > > --
> > > 2.34.1
> > >
