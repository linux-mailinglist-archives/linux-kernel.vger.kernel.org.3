Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF494DEAF3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 22:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbiCSVZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbiCSVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 17:25:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF517E18;
        Sat, 19 Mar 2022 14:24:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h13so13986165ede.5;
        Sat, 19 Mar 2022 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KRLRxQFuDkV4XwZnkLpyAS1x2/YWT0F8R7jLRmwo6L4=;
        b=ckFFKU9ntPEoMlOM/P4zkdVIRQ+5w4TtiUirfdI8b7/r/1k+VhpBhx/DlK/vCNiMkD
         Bh6lOmkmHExMQXQj7oy246kLQ/HtynqmXdxscDyEJ1MpFeR3UwcfKgxQESw8zGKCcDMU
         5OR6T0OehlPY6RMcd81mO5u7nqlwQph3L+YCc6s6iHSWmPnZnyhtHx6baxn4OeOmX+DU
         1aIEPCogBFYj8XXdZSDUo60DbgR2xncPecAPESim9a/q83+E0d7lvsJL+6Lr9C7fJW8v
         c7ihCZq57oP2DLbkoOhhChPLoBliQalFsYOTHDaHoTP27igjO3Eu4Tu+F7ogxS7sLR84
         5hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KRLRxQFuDkV4XwZnkLpyAS1x2/YWT0F8R7jLRmwo6L4=;
        b=20pNi0E29nIrDdrNj3Y+dC8Pw95f6sYs0PXpVmtTgwR/+CPKUhXY12mPEbR8CfLP1t
         VaAxjyDzdngnIfwFbAdA0yLwpDsZ91EtKCoFz9kGagN15a9LuUG8E8McH3mTpRwqZil6
         5YtkB2VFSls3vxFtTV5K5gU7/Mf1sStC7eMKAMgjHDfl1RGTQMEK+yZWaOK4TAJYoc9n
         zC8CP3uBnhXOLCclWq1Vqv6m3sLWKq7T8kK5tiVIiYrDVvHRLEjH7JG2NZTfmkpGCh2Q
         K7c8J59EU5+5g5ulkWfqeRA9+P45MN5RmWi+Y65U5pnCNyxYbuAKmO2CdSE8kvLp+bAM
         Vn4g==
X-Gm-Message-State: AOAM533Ando1N7iha7q3ex/gYZrN+9SOCbxYaO+eSh/hB8JZe8UgWoqP
        xOtXPh3P2aiTqzhDI2QJKiDYgkGB88Ydm59QNJrC4qivFqY=
X-Google-Smtp-Source: ABdhPJx8xyZtjqqANjp1qdsdW4frrcybtDI8hcUIL1ci9B2xBFQ8Vnd+uMb38C+J/oBTTzDsIwFcsdexThI8WV8ND9Q=
X-Received: by 2002:aa7:cb18:0:b0:413:3a7a:b5d6 with SMTP id
 s24-20020aa7cb18000000b004133a7ab5d6mr15641286edt.254.1647725056396; Sat, 19
 Mar 2022 14:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220313115704.301718-1-aford173@gmail.com> <a146f554-837a-d19a-425c-b1fd790a0497@lucaceresoli.net>
 <MN2PR03MB5008F8DDC6DD934074EBBC0E93109@MN2PR03MB5008.namprd03.prod.outlook.com>
 <59ee78c2-7d05-6d97-1ff2-36ea326be188@lucaceresoli.net> <MN2PR03MB500803388839E563D29CF25C93129@MN2PR03MB5008.namprd03.prod.outlook.com>
In-Reply-To: <MN2PR03MB500803388839E563D29CF25C93129@MN2PR03MB5008.namprd03.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 19 Mar 2022 16:24:05 -0500
Message-ID: <CAHCN7xKZDTdKyMgCUOmKXrceC8Qhk8ES6xn5GFag-8Vt=NgpAA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH] clk: vc5: Enable VC5_HAS_PFD_FREQ_DBL on 5p49v6965
To:     "Fillion, Claude" <Claude.Fillion@mksinst.com>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "aford@beaconembedded.com" <aford@beaconembedded.com>,
        "cstevens@beaconembedded.com" <cstevens@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 1:57 PM Fillion, Claude
<Claude.Fillion@mksinst.com> wrote:
>
> Hello Luca,
>
> > -----Original Message-----
> > From: Luca Ceresoli <luca@lucaceresoli.net>
> > Sent: Tuesday, March 15, 2022 6:53 PM
> > To: Fillion, Claude <Claude.Fillion@mksinst.com>; Adam Ford
> > <aford173@gmail.com>; linux-clk@vger.kernel.org
> > Cc: aford@beaconembedded.com; cstevens@beaconembedded.com;
> > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > <sboyd@kernel.org>; linux-kernel@vger.kernel.org; Marek Vasut
> > <marek.vasut@gmail.com>
> > Subject: Re: [EXTERNAL] Re: [PATCH] clk: vc5: Enable
> > VC5_HAS_PFD_FREQ_DBL on 5p49v6965
> >
> > Hi Claude,
> >
> > [adding Marek in Cc:, the original author of the driver and also of the
> > frequency doubler]
> >
> > On 15/03/22 20:34, Fillion, Claude wrote:
> > > Hello Luca,
> > >
> > > I will defer to Adam, but a few comments:
> > >
> > >> -----Original Message-----
> > >> From: Luca Ceresoli <luca@lucaceresoli.net>
> > >> Sent: Tuesday, March 15, 2022 4:55 AM
> > >> To: Adam Ford <aford173@gmail.com>; linux-clk@vger.kernel.org
> > >> Cc: aford@beaconembedded.com; cstevens@beaconembedded.com;
> > Fillion,
> > >> Claude <Claude.Fillion@mksinst.com>; Michael Turquette
> > >> <mturquette@baylibre.com>; Stephen Boyd <sboyd@kernel.org>; linux-
> > >> kernel@vger.kernel.org
> > >> Subject: [EXTERNAL] Re: [PATCH] clk: vc5: Enable
> > VC5_HAS_PFD_FREQ_DBL
> > >> on 5p49v6965
> > >>
> > >> This email originated outside of MKS.  Use caution when sharing
> > >> information or opening attachments and links.
> > >>
> > >> --------------------------------------------------------------------=
-
> > >> -------------------------
> > >> ----------------------------------------------
> > >> Hi Adam, Claude,
> > >>
> > >> thanks for your patch.
> > >>
> > >> On 13/03/22 12:57, Adam Ford wrote:
> > >>> The 5p49v6965 has a reference clock frequency doubler.
> > >>> Enabling it adds versaclock_som.dbl to the clock tree, but the
> > >>> output frequency remains correct.
> > >>>
> > >>> Suggested-by: Claude Fillion <Claude.Fillion@mksinst.com>
> > >>> Signed-off-by: Adam Ford <aford173@gmail.com>
> > >>>
> > >>> diff --git a/drivers/clk/clk-versaclock5.c
> > >>> b/drivers/clk/clk-versaclock5.c index e7be3e54b9be..4d190579e874
> > >>> 100644
> > >>> --- a/drivers/clk/clk-versaclock5.c
> > >>> +++ b/drivers/clk/clk-versaclock5.c
> > >>> @@ -1211,7 +1211,7 @@ static const struct vc5_chip_info
> > >> idt_5p49v6965_info =3D {
> > >>>   .model =3D IDT_VC6_5P49V6965,
> > >>>   .clk_fod_cnt =3D 4,
> > >>>   .clk_out_cnt =3D 5,
> > >>> - .flags =3D VC5_HAS_BYPASS_SYNC_BIT,
> > >>> + .flags =3D VC5_HAS_BYPASS_SYNC_BIT | VC5_HAS_PFD_FREQ_DBL,
> > >>
> > >>
> > >> If my understanding is correct, the doubler is not mentioned by the
> > >> datasheet, but it exists. Maybe it's worth a line of comment to help
> > >> future readers not waste their time in finding out:
> > >>   /* Frequency doubler not mentioned on datasheet */
> > >>
> > >
> > > I see the doubler bit mentioned in Table 25 of both v6 and v6e specs.=
  It is
> > named differently, but appears to have the same purpose.
> >
> > Well, literally speaking what I wrote is correct: the _datasheet_ does =
not
> > mention the doubler. Table 25 you mention is on the "Register Descripti=
on
> > and Programming Guide".
> >
> > Practically speaking I would expect the datasheet to mention the hardwa=
re
> > blocks including the doubler, but apparently Renesas has a different op=
inion
> > and perhaps they are not alone.
> >
> > So I think you can forget about my proposal to add a comment.
> >
> > >> Can you confirm that:
> > >>  - the en_ref_doubler bit value defaults to zero when reading it, as=
 the
> > >>    register guide says?
> > >>  - if set to 1 the frequencies double?
> > >>
> > >> With that confirmed, the patch looks good.
> > >>
> > >> Thanks,
> > >> --
> > >> Luca
> > >
> > > I played around a bit with the programming board today and did not se=
e
> > what I expected to see.
> > >
> > > Using i2cget I see that the register in question (0x10) has a default=
 value of
> > 0xA0 for both 6901 and 6965.  Thus it seems disabled by default for bot=
h
> > parts.
> >
> > Coherently with the Register guide. OK.
> >
> > > Starting at my base frequency of 46.8MHz, setting the bit to 1 (i2cse=
t)
> > changes the output  frequency to 59.04MHz for the 6901 part, and to
> > 47.7MHz for the 6965 part.  So setting the 'doubler' bit changes output
> > frequency for both parts, but not the same amount.
> > >
> > > Not sure of the meaning, just want to pass the information along.
> >
> > Me neither.
> >
> > I have no clever idea, only this one that I consider unlikely: by enabl=
ing the
> > doubler you may have increased some internal frequency above its allowe=
d
> > range and thus the chip is not working properly anymore. Can you use a
> > lower base frequency or check the PLL settings to ensure you are not
> > exceeding some range?
> >
> > What output frequency are you measuring? OUT0 or another one? What
> > frequency do you measure with en_ref_doubler =3D 0?
> >
> > --
> > Luca
>
> Not sure what I did wrong with my earlier testing, but I am now seeing bo=
th parts respond similarly to the doubler bit being set.
>
> With doubler bit disabled (register 0x10, value 0xa0), I set the output f=
requencies to 1, 10, 100, and 46.8MHz.
>
> After setting doubler bit (0xa8), I saw frequencies of 1.260, 12.60, 126.=
0, and 58.9 Mhz for both 6901 and 6965 parts.
>
> So from my testing the doubler bit seems to behave similarly for both par=
ts.
>
> At this point I will leave my unofficial testing and move on to writing a=
 consumer driver.

I don't have a scope to measure the exact frequencies, but I was able
to test it with both USB and Ethernet, which are clock from the
versaclock, and I can check the output frequencies against the
clk_summary in debugfs.

Without this patch:

    clock-controller.mux              1        1        0    25000000
        0     0  50000         Y
       clock-controller.out0_sel_i2cb       0        0        0
25000000          0     0  50000         Y
       clock-controller.pfd           1        1        0    25000000
        0     0  50000         Y
          clock-controller.pll        1        1        0  2800000000
        0     0  50000         Y
             clock-controller.fod3       1        1        0
24576000          0     0  50000         Y
                clock-controller.out4       1        1        0
24576000          0     0  50000         Y
             clock-controller.fod2       0        0        0
24000000          0     0  50000         Y
                clock-controller.out3       0        0        0
24000000          0     0  50000         Y
             clock-controller.fod1       0        0        0
24000000          0     0  50000         Y
                clock-controller.out2       0        0        0
24000000          0     0  50000         Y
             clock-controller.fod0       0        0        0
24000000          0     0  50000         Y
                clock-controller.out1       0        0        0
24000000          0     0  50000         Y


With this patch:

    clock-controller.mux              1        1        0    25000000
        0     0  50000         Y
       clock-controller.out0_sel_i2cb       0        0        0
25000000          0     0  50000         Y
       clock-controller.dbl           1        1        0    25000000
        0     0  50000         Y
          clock-controller.pfd        1        1        0    25000000
        0     0  50000         Y
             clock-controller.pll       1        1        0
2800000000          0     0  50000         Y
                clock-controller.fod3       1        1        0
24576000          0     0  50000         Y
                   clock-controller.out4       1        1        0
24576000          0     0  50000         Y
                clock-controller.fod2       0        0        0
24000000          0     0  50000         Y
                   clock-controller.out3       0        0        0
24000000          0     0  50000         Y
                clock-controller.fod1       0        0        0
24000000          0     0  50000         Y
                   clock-controller.out2       0        0        0
24000000          0     0  50000         Y
                clock-controller.fod0       0        0        0
24000000          0     0  50000         Y
                   clock-controller.out1       0        0        0
24000000          0     0  50000         Y

From what I can tell, the only thing that changes is the introduction
of clock-controller.dbl into the clock dump.
In my interpretation of reading the programmer's manual, the frequency
that is doubled is the reference frequency, but based on looking at
the clock dump, it's not obvious what's happening.

Having said that, if Claude is measuring incorrect frequencies, I am
fine with abandoning this patch.

adam

>
> Regards,
> Claude
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This message and any attachments are intended only for the designated rec=
ipient(s) and may contain confidential or proprietary information and be su=
bject to the attorney-client privilege or other confidentiality protections=
.  If you are not a designated recipient, you may not review, use, copy or =
distribute this message or any attachments.  If you received this email in =
error, please notify the sender by reply e-mail and permanently delete the =
original and any copies of this message and any attachments thereto.  Thank=
 you.
