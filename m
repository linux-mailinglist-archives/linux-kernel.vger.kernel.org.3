Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82006487617
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346923AbiAGLB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:01:28 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33847 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237515AbiAGLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:01:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BDCD03202F0C;
        Fri,  7 Jan 2022 06:01:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jan 2022 06:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0uOllEHmyWHQCFH2isEqbtuxwyo
        wPioZhHuiykjOEIk=; b=oMk56Cmie07L+rT4TxLJkhvX67TCiHfSIpPOZsmgqM0
        lcU/R3xd6kQZ3ihEzHkmQN/N2Kz1mfKQ1fsGcWbpHEI+SNtur3qkouUBI3DKMJUe
        FYcfoaFIrXHdNtAYJhEv0dBic5c5S9/wQp1AnPomA+eloOeLtn2nKKF7lU1r3+pl
        WCejF65asseX1eo5VsLDFHuj7KCZNpSZdyX57dP4qXnPEhsC0qkeczFwIGZD0rHK
        r0QuOMXwA5UGqxTNSJzx59hTgDh77MktCH8I7IP5Y76Mkc+O09n5kLIkPwIZ92TQ
        VDYtstbgWNYLA1VZ7M2W4yAq0qhzyDUBN1QZ78G+f/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0uOllE
        HmyWHQCFH2isEqbtuxwyowPioZhHuiykjOEIk=; b=Mxf7K8GPJYli7nIf/Pr3l4
        8qV9SOb7o9jQPC1sUr9zISHSIYMoQR3Y6FNPwIqsE6ELTJDrnLxfvshh/kRkuMNm
        EWZecUhfRxdfBAzxmWKIWTu2PijBFO9mYtQRD4VssOP7WqbesM8iSJTMZs7GSCbt
        JsKbK5Mui80CY1PCJFAnki8h+eHYJdQRoTWnnacd8bliE/YpORR2oYzXMtpHF6Pq
        yHZJoHslXq4cAIEeE8EOvLw6QGnF7clJGP8FWEaaOfTDjQK84yH2Ut2DO0wBmm6c
        Lf3ekjA2KDHqkS12MR493UyHDUlhtcucT4NO1AStD6BtbqWlep9XXz/gbFiEzo1Q
        ==
X-ME-Sender: <xms:gx3YYVD9eDFiP_6zdS9uxZIVGlZF-_8tMrCPNXXF7t7q2-I5U47Peg>
    <xme:gx3YYTjXz_FMKmezWmi70fyeT0aTNM4ioQlIQlep3ZCz-q6FPh8_duAIbEZ6S1pd8
    9ci8ufUK3zvJcE3OGM>
X-ME-Received: <xmr:gx3YYQlL259wO42xcnBZ1QuI6xqkPnuigNVeav5e7e4H-8HQvr3oCXv_t_zo1Pa67Ux6mbUZ9IVCNq0XpXr3mLbSdGwuFhluLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeguddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtro
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephffhvdejve
    ffkeeifffhuedufeekkefgtddvteeggeehgeeljeduhfdvhfejvdeknecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:gx3YYfx0-FT6XCvoJqlZCLrjnttznhMWTYyZeVjsjOAbcvyf6aTe1A>
    <xmx:gx3YYaT7dwMP2C0z_1w3C8vldotqcpTEngXNZ3utMgqh9-gZg2Tzcw>
    <xmx:gx3YYSYZQvoeReTd-p-DM6jCxXE1R1q3yT1l5CHw2dzTaonLIFVvpw>
    <xmx:hR3YYYc9SnK7LvtO-CPqe-pD8Qef2HiOTOtWi_SCUiWNzxHe0DQ82Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:01:22 -0500 (EST)
Date:   Fri, 7 Jan 2022 20:01:18 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de, alsa-devel@alsa-project.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, marcan@marcan.st
Subject: Re: [PATCH 0/3] firewire: assist unit driver to compute packet
 timestamp
Message-ID: <YdgdfrcvhJrUXwYF@workstation>
Mail-Followup-To: stefanr@s5r6.in-berlin.de, alsa-devel@alsa-project.org,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        marcan@marcan.st
References: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
 <YcGycqUrptkWYeOV@workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcGycqUrptkWYeOV@workstation>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Wishing you a happy new year.

We are in the last week for release of v5.16 kernel, and soon merge
window for v5.17 kernel will be opened if thing goes well. I wish any
action for the review process to merge these patches into upstream.


Thanks

Takashi Sakamoto

On Tue, Dec 21, 2021 at 07:54:42PM +0900, Takashi Sakamoto wrote:
> Hi Stefan,
> 
> Thank you for your long effort to maintain Linux FireWire subsystem. I'd
> like to use the timestamp function for my integration in ALSA firewire
> stack planned at next version of Linux kernel. I'm glad if getting to
> your help for upstreaming.
> 
> On Thu, Dec 02, 2021 at 08:34:54PM +0900, Takashi Sakamoto wrote:
> > Hi,
> > 
> > In 1394 OHCI specification, each descriptor of IR/IT/AR/AT DMA context
> > has timeStamp field. The value of timeStamp field express the time in
> > which the controller accept packet. The resolution of value is isochronous
> > cycle count (8,000 Hz) with second up to 7.
> > 
> > I have a plan to use the value of timeStamp field for ALSA firewire stack
> > so that userspace ALSA PCM/Rawmidi applications can get converted timestamp
> > (ktime) for PCM frame/MIDI message. The timestamp can ideally express
> > finer granularity than the time to invoke IRQ handler (and co).
> > 
> > Current implementation of Linux FireWire subsystem delivers the value of
> > timeStamp field to unit driver for IR/IT/AT DMA context, but not for AR
> > DMA context. Additionally, the way to refer to Isochronous Cycle Timer
> > Register in MMIO region of 1394 OHCI controller is transaction to local
> > node. It includes overhead of transaction and it's preferable to add
> > less-overhead way available in any type of IRQ context.
> > 
> > This patchset adds two functions exposed in kernel space:
> > 
> >  * fw_card_read_cycle_time()
> >     * allow unit driver to access to CYCLE_TIME register in MMIO region
> >       without initiate transaction
> >  * fw_request_get_timestamp()
> >     * allow unit driver to get timestamp of request packet inner request
> >       handler
> > 
> > I note that Hector Martin found kernel null pointer dereference during
> > process to remove PCI card and has posted a patch:
> > 
> >  * https://lore.kernel.org/lkml/20211027113130.8802-1-marcan@marcan.st/
> > 
> > His patch is included in the series with my comment for relevant commit
> > 20802224298c ("firewire: core: add forgotten dummy driver methods, remove
> > unused ones"). The patch is required since unit driver can refer to dummy
> > driver between removal callback of PCI subsystem and removal callback of
> > FireWire subsystem.
> > 
> > Hector Martin (1):
> >   firewire: Add dummy read_csr/write_csr functions
> > 
> > Takashi Sakamoto (2):
> >   firewire: add kernel API to access CYCLE_TIME register
> >   firewire: add kernel API to access packet structure in request
> >     structure for AR context
> > 
> >  drivers/firewire/core-card.c        | 39 +++++++++++++++++++++++++++++
> >  drivers/firewire/core-cdev.c        |  6 +++--
> >  drivers/firewire/core-transaction.c | 18 +++++++++++++
> >  include/linux/firewire.h            |  3 +++
> >  4 files changed, 64 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.32.0
> 
> 
> Sincerely yours
> 
> Takashi Sakamoto
