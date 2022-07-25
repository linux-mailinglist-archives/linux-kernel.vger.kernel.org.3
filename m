Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70A5807C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 00:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiGYWsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGYWsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:48:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEE1DDB;
        Mon, 25 Jul 2022 15:48:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h9so17941013wrm.0;
        Mon, 25 Jul 2022 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v0eFbfS7O5AVR+EFjErfd5gP7h25CtoREQ2LCaVVvlU=;
        b=NYx1huxf8ioAZX8TZ59MtqRGUSdESFWIcHBWAmklig4cik0HGMmZqSpYGtr5aGTz4I
         RyngoUoGFV0aP5hfNtbO/13Sq4rmBd5VPM429zOvwrm0M4u/XePnmzGJfp9jD5Nkw3/B
         cEykMazhOyF8ZwyzChWx0+yyv7mj2KqM8+VDFMbdn8ZrG3pvwDhC7JdwwxYVtVCfn9B5
         LIRAfxmXpYWnfmZvLUASvUm4WqsJh2+AMLmoXqLaSnOFrkozUJ2VcORGZkL+PlhYsWwz
         4GGzk9j5/wAkhLFY+dtT4EsL/SBMYpDuVRAvyyhRmvmKgNGvQLmLuJdF2frnN4pyQZSA
         OBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v0eFbfS7O5AVR+EFjErfd5gP7h25CtoREQ2LCaVVvlU=;
        b=x7Z0eVoJvfwskeCgPF0pRNO8aPboa55K4o+ZCXSd1aIHa8WAHcDzTywLuNowjjoejk
         4qSMH5JzRCyjietdfforNhaZI8rl1Z+iOeQcIcusVVrR9SqT3uivafID1S5sPGc2j2bK
         L+aU44dJoGC2Ab5idgqrHDYWQ0cJ/wupYSycvsqB8FSC/UMQX3w3l6zGCJZRdCMzDeuN
         xMDX0MR89bOg6XwanR+ErChZQElPVi9kKvNsWl8dNEzfntLDHIJFwfKhiKmqnw5yNCqa
         CwCf9nlu9l+IyO9ETjVGn9vEYhGrA/OeCC+VHfIxC7OOU8wBB7rCGYSJJAbfSo4jKMbU
         bvjg==
X-Gm-Message-State: AJIora+VXOmyysRe/U84ILVXkbO5pzu0KDD07wlGP2N0ag2CuR6ZaOvU
        0hYSoWD0wh/GtyCV2OPF8mey5InjeH2DqQ==
X-Google-Smtp-Source: AGRyM1vzlsy5l3KyyFCstL3o+3bE4S18PzrDXsLo0P5a6Q3P33wG7KFEN0R1lfj3BD1IzKsA/WB3gA==
X-Received: by 2002:a5d:47a4:0:b0:21e:6994:9ec5 with SMTP id 4-20020a5d47a4000000b0021e69949ec5mr8916684wrb.568.1658789324992;
        Mon, 25 Jul 2022 15:48:44 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id z4-20020adfd0c4000000b0021d7b41255esm12817674wrh.98.2022.07.25.15.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:48:44 -0700 (PDT)
Date:   Tue, 26 Jul 2022 00:48:41 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Stefan Hansson <newbie13xd@gmail.com>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220725224841.GA75640@elementary>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220724114849.GA32182@elementary>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Sun, Jul 24, 2022 at 01:48:49PM +0200, José Expósito wrote:
> On Fri, 22 Jul 2022, Stefan Hansson wrote:
> > Hi!
> >
> > Somewhere between Linux 5.17.6 and 5.18.11 the Huion tablet I have stopped
> > working properly. In GNOME Control Center it is identified as Huion New 1060
> > Plus, however that's a different tablet than the one I have. Mine is a Huion
> > Inspiroy H640, and it uses the hid_uclogic driver.
> >
> > With Linux 5.17.6, the tablet works as expected with all the buttons being
> > detected and the stylus being usable. With 5.18.11, the buttons work fine but
> > the stylus does not work correctly. The first time I approach the tablet with
> > the stylus it works properly, i.e., the cursor on my screen moves around and
> > follows the stylus around the tablet as expected. It continues working like
> > this until I remove the stylus from the tablet. After I remove it from the
> > tablet, the cursor never gets controlled by the stylus again. I can see that
> > the tablet detects the stylus (it has a small indicator light), but the cursor
> > doesn't move when I approach the tablet again. To clarify, with Linux 5.17.6,
> > the cursor moves around just fine when I remove and then put it back to the
> > tablet, just as you would expected.
> >
> > It may also be worth noting that it worked fine when I previously used it
> > around six months ago, although I'm not sure what version of Linux I was using
> > at that time (whatever Fedora shipped back then). I also tried reproducing it
> > with yesterday's linux-next and Linux 5.19.0-RC7, and the behaviour was the
> > same as 5.18.11. I am currently trying to bisect this, but it's not going very
> > fast as I currently only have access to a dual core laptop from 2014, so
> > building Linux takes a good while.
> 
> Thanks a lot for reporting the issue.
> 
> HUION and other non-Wacom tablets are handled by the UCLogic driver.
> This driver is present in the kernel but its changes were deployed
> and tested first in the DIGImend driver:
> https://github.com/DIGImend/digimend-kernel-drivers
> 
> A while ago, I started including in the kernel the code present in
> DIGImend. At this moment, 5.19.0-RC7 and DIGImend have the same code
> (well, 5.19 has more features, but they don't affect your tablet).
> 
> I'm telling you this because it might be easier for you to bisect the
> changes in the DIGImend driver as it builds way faster than the kernel.
> Let me know if you need help bisecting it and I'll do my best to help
> you.
> 
> Is this your device?
> https://www.huion.com/pen_tablet/Inspiroy/H640P.html
> 
> It is affordable, so I ordered it. I don't have any HUION devices to
> debug and this is a good excuse to buy one ;)
> I'll let you know how it goes once I receive it.

The tablet arrived today and it is a bank holiday in Spain, so I had
some time to bisect the bug.

The first bad commit is 87562fcd1342 ("HID: input: remove the need for
HID_QUIRK_INVERT"):
https://lore.kernel.org/all/20220203143226.4023622-11-benjamin.tissoires@redhat.com/
(CCing the folks whose email is in the patch tags)

I reverted the patch on hid/for-next and, after fixing a tiny conflict,
I can confirm that the tablet works again as expected.

I'd need to investigate a bit more over the weekend, but I think that
all HUION tablets with the latest firmware (internally, v2) are
affected.

Those tablets do not set the inrange bit (UCLOGIC_PARAMS_PEN_INRANGE_NONE).
The driver sets it and uses a timer to remove it.
See drivers/hid/hid-uclogic-core.c, function uclogic_raw_event_pen().

However, at least the Huion Inspiroy H640, sends a 0x00 byte when the
tool is removed, making it possible to fix it in the driver [1].

Unfortunately, the affected code path is used by many tablets and I
can not test them, so I'd prefer to hear Benjamin's opinion and see if
this should be fixed in hid-input rather than in the driver before
sending a fix.

Best wishes,
José Expósito

[1] Diff of a possible fix:

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 47a17375c7fc..bdcbbd57d0fc 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -316,8 +316,11 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
        }
        /* If we need to emulate in-range detection */
        if (pen->inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE) {
                /* Set in-range bit */
-               data[1] |= 0x40;
+               if (data[1])
+                       data[1] |= 0x40;
+
                /* (Re-)start in-range timeout */
                mod_timer(&drvdata->inrange_timer,
                                jiffies + msecs_to_jiffies(100));
