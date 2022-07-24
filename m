Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317957F4D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiGXLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:48:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3740013F10;
        Sun, 24 Jul 2022 04:48:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h8so12257563wrw.1;
        Sun, 24 Jul 2022 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GeCHift1a8zScCrrH9f61+/mv/on6JpccsDhJ3uucWk=;
        b=bUG7Zdi8h9xqYVFqGSU/z1/Sw+4Zk3neRnslH2wA4ee/Ssv/3O8a5TUdDNiA4O3hDz
         eJwog+SNHGvgqij1hVFHK3O3ZDJn2tNPDpAxMq7aEWe7GE6qxygq7rnfajv9ioGe6UCR
         P8RMvbFSy0fuzzthjGCH4ch8izFFrfrMbNQJVMbIZoaAtvkWhDaNJ8Zrjt6JunlxZUSH
         HV6mV9755JgF2ERQpPM52SL3Ij8ZaU7j8pKYXOtcRxTTOo6nzx+Hm/vLNEVuHsZXcPZt
         CfMLD0Hm2T8+H2fD7U0SVXYfKeBQnnrek1yNlSEtpEuvvd1l8O4a9vgKYSHzq7SkGOWE
         KIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GeCHift1a8zScCrrH9f61+/mv/on6JpccsDhJ3uucWk=;
        b=3F/nK2i7ToZNdMxVbRM4JAFVNaAFUhXpp73OWftGSCjjNyTpUmya9YBzztIK9WJ30i
         4N8LcCFJlRonjiTQ5pYSVA3FmWgLND8mtgFUw6AhKwxukAY/Ui3rAcx4QRLZee2FNJM3
         +3DuCSkDhZv4vdsJMHjUWOKsY1h3byUq0scQeaBqeSztMJ7lx3P263iejADL9PYgngCg
         t7aU3WaDEY7kAeSPLNi9XpQsRZLAF7yAg9D9qPyYi9n1QUF1xawNvN4neYiVHA2RpDjT
         5HjLxovusedU6SUfFWsaGBVgNk+9gD6ohjD2vsA9zN4QkmLRTkIDGKWKFuyTPirHupCF
         nK6A==
X-Gm-Message-State: AJIora+cGVrtv2U2v2J0TLS4stYeYKMEI+sGEr720FHtEHKZg2mrs66T
        L3eyeRYEiBiHc5nS9dWlhc58v7PBt4Q=
X-Google-Smtp-Source: AGRyM1uLnehANX7egU4d4z1tfke5a6PmX063+q2eEY2Z15hhzfbm03NvMQcUPUpwrZIMU2vVfSByiQ==
X-Received: by 2002:a05:6000:2aa:b0:21d:ac4f:587c with SMTP id l10-20020a05600002aa00b0021dac4f587cmr5217809wry.675.1658663331621;
        Sun, 24 Jul 2022 04:48:51 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b0021e47386eb8sm9294552wrw.2.2022.07.24.04.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 04:48:51 -0700 (PDT)
Date:   Sun, 24 Jul 2022 13:48:49 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Stefan Hansson <newbie13xd@gmail.com>,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Message-ID: <20220724114849.GA32182@elementary>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks for CCing me Jiří.

On Fri, 22 Jul 2022, Stefan Hansson wrote: 
> Hi!
> 
> Somewhere between Linux 5.17.6 and 5.18.11 the Huion tablet I have stopped
> working properly. In GNOME Control Center it is identified as Huion New 1060
> Plus, however that's a different tablet than the one I have. Mine is a Huion
> Inspiroy H640, and it uses the hid_uclogic driver.
> 
> With Linux 5.17.6, the tablet works as expected with all the buttons being
> detected and the stylus being usable. With 5.18.11, the buttons work fine but
> the stylus does not work correctly. The first time I approach the tablet with
> the stylus it works properly, i.e., the cursor on my screen moves around and
> follows the stylus around the tablet as expected. It continues working like
> this until I remove the stylus from the tablet. After I remove it from the
> tablet, the cursor never gets controlled by the stylus again. I can see that
> the tablet detects the stylus (it has a small indicator light), but the cursor
> doesn't move when I approach the tablet again. To clarify, with Linux 5.17.6,
> the cursor moves around just fine when I remove and then put it back to the
> tablet, just as you would expected.
> 
> It may also be worth noting that it worked fine when I previously used it
> around six months ago, although I'm not sure what version of Linux I was using
> at that time (whatever Fedora shipped back then). I also tried reproducing it
> with yesterday's linux-next and Linux 5.19.0-RC7, and the behaviour was the
> same as 5.18.11. I am currently trying to bisect this, but it's not going very
> fast as I currently only have access to a dual core laptop from 2014, so
> building Linux takes a good while.

Thanks a lot for reporting the issue.

HUION and other non-Wacom tablets are handled by the UCLogic driver.
This driver is present in the kernel but its changes were deployed
and tested first in the DIGImend driver:
https://github.com/DIGImend/digimend-kernel-drivers

A while ago, I started including in the kernel the code present in
DIGImend. At this moment, 5.19.0-RC7 and DIGImend have the same code
(well, 5.19 has more features, but they don't affect your tablet).

I'm telling you this because it might be easier for you to bisect the
changes in the DIGImend driver as it builds way faster than the kernel.
Let me know if you need help bisecting it and I'll do my best to help
you.

Is this your device?
https://www.huion.com/pen_tablet/Inspiroy/H640P.html

It is affordable, so I ordered it. I don't have any HUION devices to
debug and this is a good excuse to buy one ;)
I'll let you know how it goes once I receive it.

Jose
