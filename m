Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431DB467B3F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352658AbhLCQZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:25:52 -0500
Received: from mxout1-ec2-va.apache.org ([3.227.148.255]:47748 "EHLO
        mxout1-ec2-va.apache.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352580AbhLCQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:25:51 -0500
Received: from mail.apache.org (mailroute1-lw-us.apache.org [207.244.88.153])
        by mxout1-ec2-va.apache.org (ASF Mail Server at mxout1-ec2-va.apache.org) with SMTP id 2714F43C09
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:22:03 +0000 (UTC)
Received: (qmail 18246 invoked by uid 99); 3 Dec 2021 16:22:03 -0000
Received: from mailrelay1-he-de.apache.org (HELO mailrelay1-he-de.apache.org) (116.203.21.61)
    by apache.org (qpsmtpd/0.29) with ESMTP; Fri, 03 Dec 2021 16:22:03 +0000
Received: from [10.23.2.128] (unknown [51.154.28.112])
        by mailrelay1-he-de.apache.org (ASF Mail Server at mailrelay1-he-de.apache.org) with ESMTPSA id 355083E823;
        Fri,  3 Dec 2021 16:22:02 +0000 (UTC)
Message-ID: <3091ef04c6ba6e70977a8d34d47528de866e7536.camel@apache.org>
Subject: Re: Regression: plugging in USB scanner breaks all USB functionality
From:   Robert Munteanu <rombert@apache.org>
To:     Takashi Iwai <tiwai@suse.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tiwai@suse.com, regressions@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Dec 2021 17:22:01 +0100
In-Reply-To: <s5hzgphsywk.wl-tiwai@suse.de>
References: <35f7428b39f996c793f5b4a6a314772681c73d7a.camel@apache.org>
         <a649395b-0b91-a0d2-c510-ea8ec4aef917@linux.intel.com>
         <s5hzgphsywk.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-03 at 12:36 +0100, Takashi Iwai wrote:
> > That patch has a fix that is not yet applied, fix can be found
> > here:
> > https://lore.kernel.org/linux-usb/20211126122340.1193239-2-mathias.nyman@linux.intel.com/
> > or
> > https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-linus&id=385b5b09c3546c87cfb730b76abe5f8d73c579a2
> > 
> > Does reverting the original patch, or applying the fix help?
> 
> Thanks!
> 
> For convenience, I'm building a test 15.5.x kernel for openSUSE TW in
> OBS home:tiwai:bsc1192569 repo.  Robert, if you have time, please
> test
> it later.

I confirm that building and installing the kernel from the repostiory
that Takashi has provided fixed the problem for me.

Thanks a lot for the help!

Robert
