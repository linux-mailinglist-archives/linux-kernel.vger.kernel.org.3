Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851CD5587E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiFWSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiFWSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:48:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47DAF3CD0;
        Thu, 23 Jun 2022 10:51:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o16so29000848wra.4;
        Thu, 23 Jun 2022 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rqbzJ3PRrjSptpFIRWHesRd/JU9FBRfAfHxN6ts4PVM=;
        b=PuZpeG0xxYnmUl1NS7hY2zdwFdrJ2FK1qrEwjEtkiJR9evvnI3MbgRYUBMHA8aAgGf
         kBA6CM4UR+yEvVr3Ql4tnXnisL+16u8niy6PtrMBvVgbxBXYod6VZm60AU8RgLY4mAMX
         bjMltJPa2gU93/SiiND4NVJnbEaLtoX5yebWeViGouc3mU0X+LAFgeDWZe7/B20e50Ou
         cAmUkRXmOs1tGSoKKVPBsU/VVoTqTyPCxFLJPmPOZGy6K03k8sPgYnGH3APrHqlaOQyg
         XHwHsbcgObUbtST6TKZcl/pq/R/oEFV7feLieDLVeVlewMCWiJIouVp8NhQ3iNJIRTgp
         PPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rqbzJ3PRrjSptpFIRWHesRd/JU9FBRfAfHxN6ts4PVM=;
        b=5XPk1q7YCoA7fVBOfzyBExjhcI5wUBPGu1MoIYzS+uE57lOQDuUXt6Wl/WpG2BMR7W
         Nw6mm3IHOfmS8GQkAfDjXg7jDct5CgCm8Dpgt6kLC9P91Egr3IfdMGpftX5P+z3Ynq4+
         Nd+HeXUwhYMtK90KmaAcENcv44p5llwkikr/4QDntLgI62bUB1ibdOcO8iB8xCBFQTCU
         UCBzyCk3+gMV+1QsIuhgnkEbayCl2o8PLtFCcA15uPV55CWx3MYmLkR+E/9Kro7N8cIr
         pwNrCQvdLhftyPEZrzqQuGbzaQKdS4riLtf7lrWsuYw8vjnVLi7Vh9nML5AIFAUTOE/c
         Fthw==
X-Gm-Message-State: AJIora9RgcCEfHrnGTW35vSjasV/mK2Obwh1sGYbYe15885gMKW8z5ox
        vgCzqZUjxrm56LC7BQruNhBNCHEJB0M=
X-Google-Smtp-Source: AGRyM1tYxFrtJQrLNHpaOuYLx8Zg+AQrL1G5vQyVRqA7kkIxz2smbhqehzYfeRjT+H+SnoQdPnB0jA==
X-Received: by 2002:a5d:64e4:0:b0:21b:940a:a002 with SMTP id g4-20020a5d64e4000000b0021b940aa002mr9483760wri.360.1656006680685;
        Thu, 23 Jun 2022 10:51:20 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b0039c693a54ecsm19763wmj.23.2022.06.23.10.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:51:20 -0700 (PDT)
Date:   Thu, 23 Jun 2022 19:51:16 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Message-ID: <20220623175116.GA4757@elementary>
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wed, Jun 22, 2022 at 11:31:05PM +0200, Stefan Berzl wrote:
> Hello!
> 
> >> >From f9bb82e400effd3aea37b2be710add9e2bb832da Mon Sep 17 00:00:00 2001
> >> From: Stefan Berzl <stefanberzl@gmail.com>
> >> Date: Fri, 11 Mar 2022 04:04:30 +0100
> >> Subject: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
> >>
> >> ...
> > 
> > Stefan,
> > 
> > sorry for not responding earlier, but this patch somehow fell in between 
> > cracks. Please for your further submissions do not forget to at least CC 
> > some of the relevant malinglists as well.
> 
> Will do... I am still new to the process and tend to forget things, but 
> I'll do my best.
> 
> > Quite a lot has changed in uclogic driver since then, as José has been 
> > pushing quite a lot of code there from DIGImend project ... could you 
> > please update your patch on top of current codebase and resend it?
> > 
> > Thanks,
> > 
> 
> I think you'll be pleased to find that José's work is basically a 
> superset of mine, therefore eliminating the need for my patch 
> altogether. When running his newest deco l code, the deco mini 7 is 
> fully supported as well. I should have given a tested-by or something, 
> but since I am still new to this, I was kinda hesitant with the big 
> changes introduced by the newest digimend work. As you know, there is no 
> sort of registry to differentiate devices by ability, so one or two
> useless evdev devices are generated for hardware the tablet may or may 
> not have, like "Touch Ring" or "Touch Strip". I thought that this might 
> cause confusion and would have to be amended.

Useless event nodes should not be created. At the moment, the driver
disables all interfaces that are not used and, after switching to "raw"
mode, it should only create a node for each valid device.

At the moment, there are only HID descriptors for the frame and the pen
so, if your tablet is creating a touch ring device, something is not
working as expected.

Running "sudo libinput record" should display only the frame and the
pen. Does it show something different in your case?

	$ sudo libinput record
	[...]
	/dev/input/event21:	Hanvon Ugee Technology Co.,Ltd Deco L
	/dev/input/event22:	Hanvon Ugee Technology Co.,Ltd Deco L Pad

 
> There is however one caveat that seems to be unique to the mini7, which 
> is the ack packet that is sent when switching to the vendor defined 
> usage. It doesn't do much though, as currently it gets interpreted as a 
> pen report and since it doesn't have useful values, causes the cursor to 
> go to the top left screen position. Since the ack packet is only sent 
> once, it ought to be of little consequence.
> 
> I would of course fix this, but I don't really know what's the preferred 
> way. One can obviously simply set up an urb to catch this, but it would 
> have to be a special corner case for the mini 7, as José assures me that 
> none of his tablets display similar behavior. Is this acceptable?

My tablets also send an ACK packet, but in my case it does not have any
visible effects. Maybe it is related to the DE environment used. I
tested it on elementary OS (Ubuntu) and Fedora 36, in both cases the
ACK is ignored... But catching it is fine, we can include the code you
suggest.

> José already had a look at some firmware device descriptor string that 
> reports the number of buttons and what not, but as far as I know, it 
> doesn't say anything about ack packets (right José? Does it say 
> anything about touch strips or similar?).

In the devices I tested, the ACK packet is always present, so it should
be fine to catch it. I'll test your patch in all the devices I own to
be safe.

Best wishes,
Jose

> Everything said, I think this can be closed
> https://patchwork.kernel.org/project/linux-input/patch/b401e453-9c66-15e3-1a1d-21f33b7a64e8@gmail.com/
> 
> Also I made this patch, which is very trivial and simplifies the hot path
> https://patchwork.kernel.org/project/linux-input/patch/17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com/
> 
> Thanks for your work on the linux input subsystem!
> 
> 
> Kind Regards
> Stefan Berzl
> 
> 
> PS: notice how I put the right CCs and stuff :)
