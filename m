Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C704683ED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbhLDKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbhLDKGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:06:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDEC061751;
        Sat,  4 Dec 2021 02:03:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CF760B62;
        Sat,  4 Dec 2021 10:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1B2C341C2;
        Sat,  4 Dec 2021 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638612193;
        bh=HJT9Hv0enc0+lGkx6axfyMyhvhYAyUQhWuELpw+kMlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOskWpGkUOgKAtocLhoMo4BfgSI9ld2X11ZEwm/fm2TuaPRrzL7pDzeWa8ggd/u0j
         u/hqNHMxYqeyxFoV7oJTlcjRtChsrS5lMYIfJ3CKzqLc/Oh6K1y2ez7WG/JMGKUFpg
         fEux1xA94piRVWpO2lwMKCDsv4TkHtXplUrWvx6k=
Date:   Sat, 4 Dec 2021 11:03:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
 #forregzbot
Message-ID: <Yas83rCCAQcabahe@kroah.com>
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
 <3eb9c3f8-6bca-da08-47ec-af2a02d6a485@leemhuis.info>
 <e03ddc81-c60b-bd28-b959-0602142f0efc@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e03ddc81-c60b-bd28-b959-0602142f0efc@leemhuis.info>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 06:24:52PM +0100, Thorsten Leemhuis wrote:
> On 02.12.21 16:13, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker speaking.
> > 
> > Thanks for the report.
> > 
> > Top-posting for once, to make this easy accessible to everyone.
> > 
> > FWIW, 5.14 is EOL, so it might not be fixed there. As the problem is in
> > newer kernels as well, I suspect that it was a change applies to 5.15 or
> > 5.16 that got backported. Maybe one of the developers might have an idea
> > which commit causes it. If that's not the case you likely should try a
> > bisection to find the culprit. Performing one between v5.14.11..v5.14.14
> > is likely the easiest and quickest way to find it.
> > 
> > To be sure this issue doesn't fall through the cracks unnoticed, I'm
> > adding it to regzbot, my Linux kernel regression tracking bot:
> > 
> > #regzbot ^introduced v5.14.11..v5.14.14
> > #regzbot title usb: plugging in USB scanner breaks all USB functionality
> > [regression present in 5.15.2 und 5.16-rc3, too]
> > #regzbot ignore-activity
> 
> #regzbot introduced ff0e50d3564f
> #regzbot fixed-by 385b5b09c3546c87cfb730b76abe5f8d73c579a2

Odd, where did that git commit id come from?  I don't see it in
linux-next or Linus's tree.

confused,

greg k-h
