Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD352466641
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358882AbhLBPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhLBPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:17:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61018C06174A;
        Thu,  2 Dec 2021 07:13:44 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1msnmF-0004Eu-MA; Thu, 02 Dec 2021 16:13:39 +0100
Message-ID: <3eb9c3f8-6bca-da08-47ec-af2a02d6a485@leemhuis.info>
Date:   Thu, 2 Dec 2021 16:13:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To:     Robert Munteanu <rombert@apache.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     tiwai@suse.com, regressions@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
In-Reply-To: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1638458024;7dae5449;
X-HE-SMSGID: 1msnmF-0004Eu-MA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Thanks for the report.

Top-posting for once, to make this easy accessible to everyone.

FWIW, 5.14 is EOL, so it might not be fixed there. As the problem is in
newer kernels as well, I suspect that it was a change applies to 5.15 or
5.16 that got backported. Maybe one of the developers might have an idea
which commit causes it. If that's not the case you likely should try a
bisection to find the culprit. Performing one between v5.14.11..v5.14.14
is likely the easiest and quickest way to find it.

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.14.11..v5.14.14
#regzbot title usb: plugging in USB scanner breaks all USB functionality
[regression present in 5.15.2 und 5.16-rc3, too]
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:' tag
with the URL to the report (the parent of this mail), then regzbot will
automatically mark the regression as resolved once the fix lands in the
appropriate tree. For more details about regzbot see footer.

Sending this to everyone that got the initial report, to make all aware
of the tracking. I also hope that messages like this motivate people to
directly get regzbot involved when dealing with regressions, as messages
like this wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), as
long as they are intended just for regzbot. With a bit of luck no such
messages will be needed anyway.

Ciao, Thorsten, your Linux kernel regression tracker.

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave they thus might sent someone reading this down the
wrong rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

---
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
tell #regzbot about it in the report, as that will ensure the regression
gets on the radar of regzbot and the regression tracker. That's in your
interest, as they will make sure the report won't fall through the
cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include a 'Link:' tag to the report in the commit message, as explained
in Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c

On 02.12.21 15:55, Robert Munteanu wrote:
> Hi,
> 
> After updating from kernel 5.14.11 to 5.14.14 I am seeing the following
> problem:
> 
> When plugging in an USB scanner ( Brother DSMobile DS-740D ) to my
> Lenovo P52 laptop I lose connection to all USB devices. Not only are
> the devices no longer available on the host, but no power is drawn by
> them. Only a reboot fixes the problem.
> 
> The scanner is the only device that triggers the problem, even when it
> is the only device plugged in. I have a host of other devices,
> connected either directly or via a USB hub in my monitor:
> 
> - keyboard
> - mouse
> - logitech brio webcam
> - yubikey
> - stream deck
> - microphone
> 
> None of these cause any issues.
> I have tried the following kernels ( packaged for openSUSE Tumbleweed
> ), and none of them fixed the issue:
> 
> - 5.15.2
> - 5.15.5
> - 5.16~rc3-1.1.ge8ae228
> 
> The problem does not appear if the scanner is connected when the laptop
> is shutdown. It seems to have an init phase of about 6-7 seconds
> (blinking green led) and then stays on. However, it is not detected via
> lsusb or scanimage -L.
> 
> The problem does not appear on a desktop class machine ( ASUS Prime
> X470-PRO/Ryzen 3700x).
> 
> The relevant parts of the kernel log seem to be:
> 
> Nov 22 11:53:18 rombert kernel: xhci_hcd 0000:00:14.0: Abort failed to stop command ring: -110
> Nov 22 11:53:18 rombert kernel: xhci_hcd 0000:00:14.0: xHCI host controller not responding, assume dead
> Nov 22 11:53:18 rombert kernel: xhci_hcd 0000:00:14.0: HC died; cleaning up
> 
> I've initially reported this at
> https://bugzilla.opensuse.org/show_bug.cgi?id=1192569 and CC'ed the
> distribution's kernel maintainer.
> 
> Please let me know if additional information is needed.
> 
> Regards,
> Robert Munteanu
> 
> 
