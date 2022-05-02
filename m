Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E08517625
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386785AbiEBRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386778AbiEBRwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:52:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9922065E8
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:49:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h12so13007296plf.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bkLGHzTKEdrIy6Qt0G9QFDowrxbzJM+znhmu2yYUYAo=;
        b=dWS5uUvSmMxz6Wu3LTEDsWYC36o3ISwjeXElDPk+UmgNqRkiaPG0e8eQNv5/hfJmDt
         Qac+u46E/cwYE5UsxrHBUXOMQwA6DoXo6CHvsuUELOADrV+jRgExhMNNsrkGgmSWX1de
         ifAhHK28ATDLFFqTv+W0uFSFiuf1+POlNHmgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bkLGHzTKEdrIy6Qt0G9QFDowrxbzJM+znhmu2yYUYAo=;
        b=V0Ah83W+fuL+RqVwuC/GcyCalQYt78Qw8fHr1vv+CUmdibm2CueuLHRI6uNPwWhgpv
         UnPT/aw8v8tc+z/GDXaqxl+nxY01TPeAmJLzNIs4BVSC6bY/L0yPpd8rEpUelVZRrShA
         0xp4zAF+AXqQkUN72duSl4x0H4DvhyxvYXM9T/PiG0zq4ccS88GtAlpON4aLKLl7/qPq
         ur+wFpopMtujt30VBDX/sBq8GaEPoM0iyRm5svt5YnDwbc/al/0ZXXtb9/vpCgEhYLRH
         +WviADw7x+tFwTBgFiNu9iKNBUK/BSi/tw6flaDYEir8iqeySObeBHETuVo90MOE7XSP
         y2+w==
X-Gm-Message-State: AOAM530EbbrleeFRsdbp3HiaWLtYiUt51NmRYeNK/COCk/a8cuGQJduM
        IV0Ixh4tDcamLrTEiVwuq4vzxA==
X-Google-Smtp-Source: ABdhPJw+1dOR0z6T4F0bzSHKwoHcz4zDlUY8RSRsQbj3jAdWoYNXoWWdWGeDLtBztkzIjiCjeBAwrA==
X-Received: by 2002:a17:902:da81:b0:15d:37b9:70df with SMTP id j1-20020a170902da8100b0015d37b970dfmr12961116plx.34.1651513761166;
        Mon, 02 May 2022 10:49:21 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:c272:7186:601f:66e6])
        by smtp.gmail.com with UTF8SMTPSA id d29-20020a631d1d000000b003c14af50641sm11536253pgd.89.2022.05.02.10.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:49:20 -0700 (PDT)
Date:   Mon, 2 May 2022 10:49:19 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <YnAZn+KzlwB81EI8@google.com>
References: <20220502210728.0b36f3cd@canb.auug.org.au>
 <Ym/DPS99n8K8Lltu@kroah.com>
 <YnAQRQWK6ozI8DZJ@google.com>
 <YnAVxtQNOOhtz3lO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnAVxtQNOOhtz3lO@kroah.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 07:32:54PM +0200, Greg KH wrote:
> On Mon, May 02, 2022 at 10:09:25AM -0700, Matthias Kaehlcke wrote:
> > On Mon, May 02, 2022 at 01:40:45PM +0200, Greg KH wrote:
> > > On Mon, May 02, 2022 at 09:07:28PM +1000, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > After merging the usb tree, today's linux-next build (x86_64
> > > > modules_install) failed like this:
> > > > 
> > > > depmod: ERROR: Cycle detected: usbcore -> onboard_usb_hub -> usbcore
> > > > depmod: ERROR: Found 2 modules in dependency cycles!
> > > > 
> > > > Caused by commit
> > > > 
> > > >   c40b62216c1a ("usb: core: hcd: Create platform devices for onboard hubs in probe()")
> > > > 
> > > > I have reverted that commit for today.
> > > 
> > > argh, I thought the build issues were fixed :(
> > 
> > Sorry about that :(
> > 
> > The *build* issues were actually fixed, however I did not try
> > modules_install ...
> > 
> > > I'll go revert that series from my tree later today, thanks for the
> > > report.
> > 
> > I think the dependency situation can only be resolved by linking
> > onboard_hub_create/destroy_pdevs() into the USB core module. My initial
> > idea was to build them into the kernel binary, however that doesn't
> > work because onboard_hub_create_pdevs() calls usb_of_get_device_node(),
> > which is part of the core module when CONFIG_USB=m. The two function
> > are relatively lightweight and don't depend on internals of the
> > onboard_usb_hub driver (besides the device id table) so linking them
> > into the core module doesn't seem too ugly.
> 
> I'll try to look at this next week, it shouldn't be that complex.  If it
> is, something feels wrong...

Thanks!

The root of all these dependency issues is that the core/HCD code
needs to call APIs of the onboard hub driver to create/destroy
platform devices based on the device tree. That's fine when CONFIG_USB=y
and CONFIG_USB_ONBOARD_HUB=y, but gets complicated when modules
come into play, since the core/HCD code depends on the aforementioned
driver functions and the driver depends on symbols from the USB core.
