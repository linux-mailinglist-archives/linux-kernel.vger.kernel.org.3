Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1255AB4A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiFYPah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiFYPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:30:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2EB15820;
        Sat, 25 Jun 2022 08:30:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m184so2846396wme.1;
        Sat, 25 Jun 2022 08:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YJMG2xSKeKo8ovUlFDGAmK9lJxFqvsUKe5ouW/ZiPXQ=;
        b=B/Q7k/xTLmPZGpnd9T3Ix0mxJZqrQuN2NZlEG30Lx3HgX+lQYSSglKik60CZdo6Njr
         94Sc/afjuGNi9c6D7/rRPzDjLujW2tfKi1PpiLHUU77TPuEaaIILc5xm97CHBVgRQDNy
         EXJZftk4H9rFOB2SWIWz33EUOdsrQslM5ZGoXttecLpEjR9SUQQefZ8ahJ8dGkbmwIpc
         w0L26GE4tewY7HLZAjKK6p/mjKpl9kglC3JRa5G5tcNFFkzhytHNEDbbWFSNieUkgbxA
         wMDzUbIg7gW6U8Wr0uZFZHZFBPKEPURc6ykWhymDfWhBrXAfd9JB3S1wyaSC9c4qEkwz
         G5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YJMG2xSKeKo8ovUlFDGAmK9lJxFqvsUKe5ouW/ZiPXQ=;
        b=KJhM9QWSZ/WShNa0eDp/gESLy+9U5GLJmtzIuf79O0yV/ktGK9lzMP4dj0mskpM7ST
         kWEP9c7YoNUS2NKoaYgWIqaFcu1Y7FoogIXMPsaG/8pEoqGDAI28lDthnvbWk4XAU165
         5tBCaoP2PPMjh5ReH/cGdNCze3MoOxq4/9gnUWRmvU2g7wh8LcmrD0GvaCRD71nyYPuy
         G5E/Gh5m0ilM8+eGklfm8tnXhtQoWl6mypOkKYlAWMKWSp46BxMiQlXTLHz5l3GNyUYz
         i7IgvbvD9T0CqR8OqaHK6HiGK24c9eCN5Hjurh8Rm9cRg2vB8bkDug5hp6brJn3abDUq
         YlMw==
X-Gm-Message-State: AJIora8RSwgMqJ70fUnyxAT5u6l4f2Ij5iCm8r3LCacpD8GZ4TNPnVIQ
        2fDVpHfRGrPayupoUBjVRrY=
X-Google-Smtp-Source: AGRyM1v6olA3B0DyG292O/IxgHf1HD8MEu4dCykW2mUaVUkX+Aig2YjSVTyITO5BwbFSzGFbUXi+Qg==
X-Received: by 2002:a05:600c:58a:b0:39c:80ed:68be with SMTP id o10-20020a05600c058a00b0039c80ed68bemr5024339wmd.150.1656171032193;
        Sat, 25 Jun 2022 08:30:32 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c4f0e00b003942a244f40sm11217734wmq.25.2022.06.25.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:30:31 -0700 (PDT)
Date:   Sat, 25 Jun 2022 17:30:30 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Stefan Berzl <stefanberzl@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Message-ID: <20220625153030.GB4820@elementary>
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
 <20220623175116.GA4757@elementary>
 <3f37e3fa-1b7d-1dbb-327c-69a4e96bdcdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f37e3fa-1b7d-1dbb-327c-69a4e96bdcdc@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 12:24:09AM +0200, Stefan Berzl wrote:
> On 23/06/2022 19:51, José Expósito wrote:
> > At the moment, there are only HID descriptors for the frame and the pen
> > so, if your tablet is creating a touch ring device, something is not
> > working as expected.
> > 
> > Running "sudo libinput record" should display only the frame and the
> > pen. Does it show something different in your case?
> > 
> > 	$ sudo libinput record
> > 	[...]
> > 	/dev/input/event21:	Hanvon Ugee Technology Co.,Ltd Deco L
> > 	/dev/input/event22:	Hanvon Ugee Technology Co.,Ltd Deco L Pad
> 
> This is certainly true for the newer xppen devices we are working on. 
> However, while waiting for the xppen stuff to gain support, I bought a
> tablet  that's already supported, the Gaomon S620. Executing libinput 
> record or any other command that lists the devices, like evemu-describe, 
> gives:
> 
> /dev/input/event15: GAOMON Gaomon Tablet
> /dev/input/event16: GAOMON Gaomon Tablet Pad
> /dev/input/event17: GAOMON Gaomon Tablet Touch Strip
> /dev/input/event18: GAOMON Gaomon Tablet Dial

Ah OK, I though you were talking about the XP-PEN device. I don't know why
those extra event nodes are created, sorry.
 
> >> There is however one caveat that seems to be unique to the mini7, which 
> >> is the ack packet that is sent when switching to the vendor defined 
> >> usage. It doesn't do much though, as currently it gets interpreted as a 
> >> pen report and since it doesn't have useful values, causes the cursor to 
> >> go to the top left screen position. Since the ack packet is only sent 
> >> once, it ought to be of little consequence.
> >>
> >> I would of course fix this, but I don't really know what's the preferred 
> >> way. One can obviously simply set up an urb to catch this, but it would 
> >> have to be a special corner case for the mini 7, as José assures me that 
> >> none of his tablets display similar behavior. Is this acceptable?
> > 
> > My tablets also send an ACK packet, but in my case it does not have any
> > visible effects. Maybe it is related to the DE environment used. I
> > tested it on elementary OS (Ubuntu) and Fedora 36, in both cases the
> > ACK is ignored... But catching it is fine, we can include the code you
> > suggest.
> 
> Can the contents maybe differ?
> 
> This is the ack the mini 7 gives me:
> 02 b1 04 00 00 00 00 00 00 00 00 00
> 
> While this is a button:
> 02 f0 00 00 00 00 00 00 00 00 00 00
> 
> And here we have pen movement:
> 02 a1 59 23 ef 32 b8 0e 00 00 00 00

Yes, the contents are different. My ACK does not contain the last 2 bytes.
As mentioned in my previous email, I think that because the ACK of your
tablet matches the size of a pen report and starts with 02 it is handled as
a pen report.

Jose
