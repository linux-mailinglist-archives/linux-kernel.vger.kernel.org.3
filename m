Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CEE5919F9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiHMLJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMLJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 07:09:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA53881B3A;
        Sat, 13 Aug 2022 04:09:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so3646360wrp.10;
        Sat, 13 Aug 2022 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=Lwob7xDX18xuLzciMs6sBm4FASciIc2P3TkLVW9Vtr8=;
        b=lhqYuwLazf0BX+NIgPnn+2pq/UH/GRuuSy+uRVE/Q5pn8RtXQQWqDoQiCTE0RkBC9F
         QuYyVf17uFZgk1yhl4C5WVH0S+OPnwoBJvwc6esxR6sen+LOOvTnRse28Zm99EZHjFK7
         4E9Mxfd319Ry+Eznci8iZ/aV3bPID5zKqjEv/0I4Byk+YC/CwSVbnLbbyv6de3Ew2u09
         2sVJn0wJDk88jxU/0qbzM3xcKVrXsRBNFI8NQicEjEL8mwtiZ1t6l+6AfAVi0OwO+W/l
         7xIpC6AUJzhZqS9TqcObhsjCIOSjk5mx+wOpaM7l6AAOMrTF7h2sIgbX3TyRG+On1CMQ
         pVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=Lwob7xDX18xuLzciMs6sBm4FASciIc2P3TkLVW9Vtr8=;
        b=rAUQRnwRE0PXZd2LmT6VXAaqD+889ehvx1eDghq/cFPBiR/HYhH9PwgfEPQrldaUz/
         7/r27ObhAtEPhJY3vy7oYTSs22Lnnhq28XqHOFDd03E0adFHcrUvvNOZA0FM3l1B8gl+
         hf2DlR2myuMUa76vjrkDTRCQ6rYqQhKsZwj62bwc+H9vbZQj4GKJhpn/gf3yxUGKjBTu
         lTuSU+nRJwB0EWwwD7joea1zhsH81Npk6X5mnNVMrSuFTC2KMVmiab9iu8xUyiUfHoKH
         GS7kjJUKXoEKVYs/NuM6SZ3SaXLQMjvLfBvXmZs9c18JX1e0ok/xVInxv6Md6sZkXN1Z
         i9Nw==
X-Gm-Message-State: ACgBeo2hnjiV65EwQTeFKR5qbiVQw5H47P8XdChOoQ8zalGzgopTPFRe
        I4j1lVUz91sFLr9n2o3fGMyumSfTox99KA==
X-Google-Smtp-Source: AA6agR5m+uuldCzeXOiU1Q9D8HXKbLjpabwFRyPKwNsR0kNT/XwMtGz7uyFol70kboIDOx4jCHbc3A==
X-Received: by 2002:a05:6000:1549:b0:220:7199:bd4 with SMTP id 9-20020a056000154900b0022071990bd4mr4474052wry.673.1660388964476;
        Sat, 13 Aug 2022 04:09:24 -0700 (PDT)
Received: from elementary ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d430d000000b00224f605f39dsm792883wrq.76.2022.08.13.04.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 04:09:24 -0700 (PDT)
Date:   Sat, 13 Aug 2022 13:09:22 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Stefan Hansson <newbie13xd@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220813110922.GA47526@elementary>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary>
 <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
 <20220804182445.GA16569@elementary>
 <CAO-hwJ+hBipNJpeYaHRr2-rKXA5d79XT7zE2fo2oEKUKJtKJ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJ+hBipNJpeYaHRr2-rKXA5d79XT7zE2fo2oEKUKJtKJ0g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Thu, Aug 11, 2022 at 05:23:52PM +0200, Benjamin Tissoires wrote:
> On Thu, Aug 4, 2022 at 8:24 PM José Expósito <jose.exposito89@gmail.com> wrote:
> >
> > Hi again,
> >
> > On 2022-07-26 18:48, José Expósito wrote:
> > > The first bad commit is 87562fcd1342 ("HID: input: remove the need for
> > > HID_QUIRK_INVERT"):
> > > https://lore.kernel.org/all/20220203143226.4023622-11-benjamin.tissoires@redhat.com/
> > > (CCing the folks whose email is in the patch tags)
> > >
> > > I reverted the patch on hid/for-next and, after fixing a tiny conflict,
> > > I can confirm that the tablet works again as expected.
> > >
> > > I'd need to investigate a bit more over the weekend, but I think that
> > > all HUION tablets with the latest firmware (internally, v2) are
> > > affected.
> >
> > Indeed, it looks like v2 devices are affected. Similar reports:
> >
> >  - https://github.com/DIGImend/digimend-kernel-drivers/issues/626
> >  - https://bugzilla.kernel.org/show_bug.cgi?id=216106
> >
> > Kindly sending this thread back to your inbox to see if we could fix
> > this regression.
> 
> [sorry, I was out on vacation the past 2 weeks and this week was the
> usual "urgent" thing I have to day for yesterday]

No problem, I hope you enjoyed your holidays :D 

> Ideally, I'd like to not revert that commit. It solves a bunch of
> issues on many devices, so that's maybe not the way forward.
>
> FWIW, it was quite painful to tweak and that was a solution that
> matches the hid-multitouch devices I could find.
> 
> I tried to process your email when you described the succession of
> events without much success.
> 
> Would you mind dumping a hid-record when exposing the bug?

Sure, I added as an attachment in the existing report in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=216106#c2

I hope it helps you to debug the issue. Let me know if you need more
recordings, help testing patches or any other information.

In future changes to tablet code, feel free to cc me. I have a bunch of
non Wacom devices and I'll help you testing your changes.

Best wishes,
Jose

> Cheers,
> Benjamin
> 
> 
> >
> > Best wishes,
> > Jose
> >
> > > Those tablets do not set the inrange bit (UCLOGIC_PARAMS_PEN_INRANGE_NONE).
> > > The driver sets it and uses a timer to remove it.
> > > See drivers/hid/hid-uclogic-core.c, function uclogic_raw_event_pen().
> > > [...]
> >
> 
