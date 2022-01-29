Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC0D4A2DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiA2Kqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 05:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiA2Kqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 05:46:50 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C95C061714;
        Sat, 29 Jan 2022 02:46:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p12so15518814edq.9;
        Sat, 29 Jan 2022 02:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b5iXX4PB/mwNbdjG9vSOuv8c1Dz8slB0se+u0ibPUWA=;
        b=mvb0wK2KZuNg6dB8VBg7cOwds5PSsv7eIGviTjCRSD5k3f2BKe0xunub+lkUjUiHGB
         htLvexWtojJB3ds48xALX3Us6s1epJmKOA5RUHed+hTk7syKRRNBFI1o3gZBLTDtWHfL
         TMO55PendjPseACGkpMiNnioSnVNhkMZMt9EMTQWshCfNxnsgMC0rFj3I9I9cm+elmv2
         /q4QLAxLz7HLXbMSpbNuTXaye2A4/XsZ283aHXcvAUGLRx6+3VlURKqM73wQYIboHUaM
         NM/mOIsWBTSTYXbVsyyBJiIjpnsJ+fEdMeGY2Jhyo/w81WJ+uyYkuRpYNGAGdHJOTq08
         oUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5iXX4PB/mwNbdjG9vSOuv8c1Dz8slB0se+u0ibPUWA=;
        b=dJdLXoeQ/ilbaJJ5RVr9XEJp9D2bL+BTNQpTqvDXrT34rttHUyQAl0NhjhMinYKETU
         B+mmyjRfxlqDIO+OQNIoCGQ5gDkjBoT5U6QcjAzNXHLNB8cDRubvBXoSx/rDO6T5WAGw
         DCNem6gL0GIRfuWgDEU4kvT9IRRtabY4TnXSKeJQiraOMnW4EBcQaU+1Ji6kdITLPv9b
         u6rsCT9F9A29oqTbTM1qydxn+9xtMt/nMhXdiRgigamMty8VKGALn6Nx4ZrSJeN9URbK
         Bc16TPw1r7yPpbPqZcSKOnSvZ3iEhFExkchYY5pfrreMBafBALhGsik5cUh8bFO9PNtV
         B91w==
X-Gm-Message-State: AOAM532MJLZG9oIpxHLCHmaK1vtUCN7iMzFBmAcQDiIG74gFjhzOTrIY
        AHD4ge/CJAbGssOh1faiRS8=
X-Google-Smtp-Source: ABdhPJx7f5+B15vH5QkFwKoy50w08J3WMx/78pt7LsUy4V5C913aHigLp/GqPUJIIai2w9Y0pBbUkA==
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr5717956edz.206.1643453208679;
        Sat, 29 Jan 2022 02:46:48 -0800 (PST)
Received: from tom-desktop (net-188-217-50-123.cust.vodafonedsl.it. [188.217.50.123])
        by smtp.gmail.com with ESMTPSA id rl11sm11130709ejb.15.2022.01.29.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 02:46:47 -0800 (PST)
Date:   Sat, 29 Jan 2022 11:46:45 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: usb251xb: add boost-up property support
Message-ID: <20220129104645.GA2196@tom-desktop>
References: <20220127231437.10893-1-tomm.merciai@gmail.com>
 <978bc09c-b963-566b-8fa4-a53f1e5c569b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978bc09c-b963-566b-8fa4-a53f1e5c569b@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 01:32:21PM +0300, Sergei Shtylyov wrote:
> Hello again!
> 
> On 1/28/22 2:14 AM, Tommaso Merciai wrote:
> 
> > Add u8 property to support boost-up register of usb251xb hub.
> > boost-up property control USB electrical drive strenght
> 
>    Strength.
> 
> > This register can be set:
> > 
> >  - Normal mode -> 0x00
> >  - Low         -> 0x01
> >  - Medium      -> 0x10
> >  - High        -> 0x11
> > 
> > (Normal Default)
> > 
> > References:
> >  - http://www.mouser.com/catalog/specsheets/2514.pdf p29
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> > Changes since v1:
> >  - Fix patch as suggested by RLeitner
> > 
> >  drivers/usb/misc/usb251xb.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> > index 507deef1f709..b60ab148e6ac 100644
> > --- a/drivers/usb/misc/usb251xb.c
> > +++ b/drivers/usb/misc/usb251xb.c
> > @@ -543,6 +543,8 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
> >  	if (of_property_read_u16_array(np, "language-id", &hub->lang_id, 1))
> >  		hub->lang_id = USB251XB_DEF_LANGUAGE_ID;
> >  
> > +	of_property_read_u8(np, "boost-up", &hub->boost_up))
> 
>    Isn't it hub->boost_up left uninitialized if an error occurs here?

Hi Sergey,
Thanks for your review. I invite you to check v3 of the patch.

 - https://lkml.org/lkml/2022/1/28/915

Tommaso

> 
> [...]
> 
> MBR, Sergey
