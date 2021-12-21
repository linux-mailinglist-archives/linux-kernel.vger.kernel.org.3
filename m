Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99A47BE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhLUKyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:54:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52791 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236774AbhLUKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:54:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 486135C0305;
        Tue, 21 Dec 2021 05:54:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 21 Dec 2021 05:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=10u2seyTtDKFh00Zfz/k03hmkz3
        kOv0x/W4LJ4OGXIc=; b=J+2hudM1lN3q+QxEDzLvWHX/7r7mxc1nXK5x8lGZ0Fc
        VIDOQjMhbIQy0DpvWntNVfwlwgi4kvK5Uvg9iK8GlIhj3HHLqcQm73wIDt6bvrSU
        3t9xE3E3SkwjEO85VB5CS8lnos2V7/DVQ1yE+5urImo/K3r2quvJ7BCv3JzHdsBH
        8arcYlOKcx6oGMErfbHOh7rZ5602525Jx0EASKqkNkHV87uUUepW2CxOmnkkFvtn
        ALfuTkii2KqLN2ntfDerAoM2yYRDinxJdBDoavS4U6a400i4rcHmzobxo7ROZf6g
        k9R0QxlUK7d+c/ex8v2iUJZ/SajGRBkkmnwORHcnylg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=10u2se
        yTtDKFh00Zfz/k03hmkz3kOv0x/W4LJ4OGXIc=; b=Ui9Miq0wg67yWnAJnd27B/
        7LZlRDrb9vHQuZJYbyq84aAwboetzbrhfzUh4EQ0F5ERO1r0eziu9HM5SARgvzEt
        hjRhLqwzPXNRk8FA14Q7Uyje9cpmcazytyc10SyhJLZg2W5nZMQ8MDBPu8kx/a0g
        F0KzEse27fBuhiTd38EsGxHLvBdDlWNYMNVujlUUE1eGXikzwElI+Zt7n10Z0Egn
        vcWYEruoQhJgWweBeDhvv3DX8p+LSjYzZKyTXvs4L8T9YqzrM99l7QMt+Hv3g7NG
        klPcL2E+Au2wfkvbaT8YTqSG5of9ZJZIzNHsFHCYJn+KMd7rQXgtGX4XlXPTFqFA
        ==
X-ME-Sender: <xms:d7LBYenCx4WpenTpOzYfZqsQyIvZc2PGO1Y26yplXT-2IneSk71hhA>
    <xme:d7LBYV1v7XO8B5QCiQjHe4OYlw02af9L5nL_NsLWrgdOO9cGIcQl7lP5TXh_ZiNE7
    WLwBDjfviYSrigU-RM>
X-ME-Received: <xmr:d7LBYcpQQvV_cOmY7A3d8pqTE6PLlhlKyBWG927pDy_QQf05NrvfsFgM6eV2hVrpysry5nVU3bg4erK1d7eC8oA-zHhhffIY2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddruddtgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtro
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephffhvdejve
    ffkeeifffhuedufeekkefgtddvteeggeehgeeljeduhfdvhfejvdeknecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:d7LBYSlO7ey3mSyanWXGQgdOYXw2WlotdYHPCBAh84bF3_7WsRt6nA>
    <xmx:d7LBYc3hUu3PAo0YiSy77pYk7WPoMjlso4vmKMTVEXcyU7DU6Hr7pg>
    <xmx:d7LBYZvuCvMyL9v40I7_3hwib7cuaTZnyKYrk20jLA1dR2edxUiJpw>
    <xmx:eLLBYZxsqsVLwepd4A-bP51zIbADVIE-tMd4mHZzPAGawVjawn9VKA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Dec 2021 05:54:46 -0500 (EST)
Date:   Tue, 21 Dec 2021 19:54:42 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, marcan@marcan.st
Subject: Re: [PATCH 0/3] firewire: assist unit driver to compute packet
 timestamp
Message-ID: <YcGycqUrptkWYeOV@workstation>
Mail-Followup-To: stefanr@s5r6.in-berlin.de, alsa-devel@alsa-project.org,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        marcan@marcan.st
References: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202113457.24011-1-o-takashi@sakamocchi.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Thank you for your long effort to maintain Linux FireWire subsystem. I'd
like to use the timestamp function for my integration in ALSA firewire
stack planned at next version of Linux kernel. I'm glad if getting to
your help for upstreaming.

On Thu, Dec 02, 2021 at 08:34:54PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In 1394 OHCI specification, each descriptor of IR/IT/AR/AT DMA context
> has timeStamp field. The value of timeStamp field express the time in
> which the controller accept packet. The resolution of value is isochronous
> cycle count (8,000 Hz) with second up to 7.
> 
> I have a plan to use the value of timeStamp field for ALSA firewire stack
> so that userspace ALSA PCM/Rawmidi applications can get converted timestamp
> (ktime) for PCM frame/MIDI message. The timestamp can ideally express
> finer granularity than the time to invoke IRQ handler (and co).
> 
> Current implementation of Linux FireWire subsystem delivers the value of
> timeStamp field to unit driver for IR/IT/AT DMA context, but not for AR
> DMA context. Additionally, the way to refer to Isochronous Cycle Timer
> Register in MMIO region of 1394 OHCI controller is transaction to local
> node. It includes overhead of transaction and it's preferable to add
> less-overhead way available in any type of IRQ context.
> 
> This patchset adds two functions exposed in kernel space:
> 
>  * fw_card_read_cycle_time()
>     * allow unit driver to access to CYCLE_TIME register in MMIO region
>       without initiate transaction
>  * fw_request_get_timestamp()
>     * allow unit driver to get timestamp of request packet inner request
>       handler
> 
> I note that Hector Martin found kernel null pointer dereference during
> process to remove PCI card and has posted a patch:
> 
>  * https://lore.kernel.org/lkml/20211027113130.8802-1-marcan@marcan.st/
> 
> His patch is included in the series with my comment for relevant commit
> 20802224298c ("firewire: core: add forgotten dummy driver methods, remove
> unused ones"). The patch is required since unit driver can refer to dummy
> driver between removal callback of PCI subsystem and removal callback of
> FireWire subsystem.
> 
> Hector Martin (1):
>   firewire: Add dummy read_csr/write_csr functions
> 
> Takashi Sakamoto (2):
>   firewire: add kernel API to access CYCLE_TIME register
>   firewire: add kernel API to access packet structure in request
>     structure for AR context
> 
>  drivers/firewire/core-card.c        | 39 +++++++++++++++++++++++++++++
>  drivers/firewire/core-cdev.c        |  6 +++--
>  drivers/firewire/core-transaction.c | 18 +++++++++++++
>  include/linux/firewire.h            |  3 +++
>  4 files changed, 64 insertions(+), 2 deletions(-)
> 
> -- 
> 2.32.0


Sincerely yours

Takashi Sakamoto
