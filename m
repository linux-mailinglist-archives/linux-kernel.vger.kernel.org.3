Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4834F6EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiDGAOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDGAOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:14:20 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC233E28
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:10:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3327E3201F24;
        Wed,  6 Apr 2022 20:10:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Apr 2022 20:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=U5WfQ+6qT79WcWmJEsxQhXGAhm+D0K
        JQuIx4kwqDUAQ=; b=LE60T11Y8eIKEJmIQYQFBkJvNvz59moAx/a92uEz1+hHAs
        khGz9FO1XCAihio4ldWIJSpcsceeIPmXqDOSEVvrl8ifUR0fiv5kt35F+AgcP/5c
        /+BfAwf7v+bNVcUDx6W1IIn6QgOYVljg+vHXgImH1lZ4BusBmZtlO8x58iTmD2D5
        6WeRT6omRRrd3dWz+9Nhu6IWmD0zbdx0esh9rmM6Vb6etG8S3uReSIG1m5KqeQyM
        CRmpY3BWAVwQCiPcSYlaM62+zlIwI9CWx1kdr9c3wSMKA5pMEX1J5cN6KD4dDBIN
        bSQVgogoFV947+w68ff3GsMfCBs5lGQaR3HXnLow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=U5WfQ+6qT79WcWmJE
        sxQhXGAhm+D0KJQuIx4kwqDUAQ=; b=ZPUFTidVN0jHZmK6d28u/Krm5zmOb8ki1
        H6mv6PdCeQKa8C+GMMkc1NFB3QgkrMjW4iMl9I18o3XSEmnM2456ZxEEkjbYFh9+
        XMMe4u/RZSfbbDF++qWqNSA87QQ0AKq7n/VM/gZnTmuc0yDHir9MllbPS0TM+TO+
        V/u1hlVg2c8VUHDpTu+Q+XDLH4i4e8v2gVZTHsyWdfJZYJAoxQppbWBESTjLgmCD
        jIIsPrO0eHCfpldzkv+u0yKk1DR8Ac+39+/JvlkYK4XVv7P0HFchpL4nXg/nxcqb
        Z76gUERoWGzzxM2CHD1GE53a8AKgpee/D752wAc/w+YDsWsb1LfAQ==
X-ME-Sender: <xms:8StOYsdKY2-rGhqPaPqAzIhgsDZalAvfYbCeU40kMWXV9iEkcetlDA>
    <xme:8StOYuO832uNnAcdB6HKg5uDkGGhTZTDfzEO0AgkujrAUWND8EasmhWW3IpQdWLDy
    vfeOcRao1njYzs-E7k>
X-ME-Received: <xmr:8StOYti2m-SAL5aNoygZSxXGPYt_1lgRNIJugDAONBmg0Z4XemFwcnHe2QM8FO3vjPwMxDMyUQYvRg-CSSv3Xs1RnVz24wdi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejjedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeejgeeifeeuveeufeeigeegjeelvdfgjeegffejgfdv
    keelhefgtdefteejleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:8StOYh9WlmD0GsoROWT8eztL7NWnFdPxFl-KuXZUbvLlsL9o8Nl_Fw>
    <xmx:8StOYotJOrS3n4tqFBh0xc_ZN4x-kjzX5azYMzUktI1AVfn-HVMOog>
    <xmx:8StOYoHO7vEtlUHYktVyDepWftci7FD1uf_m2BI0YellxKPYTLm7pg>
    <xmx:8StOYkIjWF-XyFlh7VYxEhlk9h68Kg2iSxizFliMFD1An1R5oCErog>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Apr 2022 20:10:23 -0400 (EDT)
Date:   Thu, 7 Apr 2022 09:10:21 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     clemens@ladisch.de, alsa-devel@alsa-project.org,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] firewire: assist unit driver to compute packet
 time stamp
Message-ID: <Yk4r7VcotHz0iMOU@workstation>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de,
        alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220405072221.226217-1-o-takashi@sakamocchi.jp>
 <s5hczhv5wjc.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hczhv5wjc.wl-tiwai@suse.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:23:35PM +0200, Takashi Iwai wrote:
> On Tue, 05 Apr 2022 09:22:18 +0200,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > Current implementation of Linux FireWire subsystem doesn't allow unit
> > driver to operate content of packet in IR context according to
> > time stamp. Additionally it doesn't allow unit driver to read current value
> > of CYCLE_TIME register in OHCI 1394 controller. It brings disadvantages to
> > drivers in Linux sound subsystem in regards of handling time for sampled
> > data such as PCM frames and MIDI messages.
> > 
> > This rerolled patchset is first step to improve the situation.
> > 
> > Changes in v3:
> >  * Rebase v2 patchset to v5.18-rc1
> > Changes in v2:
> >  * Rebase v1 patchset to v5.16 release
> >  * https://lore.kernel.org/lkml/20220212022131.199855-1-o-takashi@sakamocchi.jp/
> > V1:
> >  * https://lore.kernel.org/lkml/20211202113457.24011-1-o-takashi@sakamocchi.jp/
> > 
> > Hector Martin (1):
> >   firewire: Add dummy read_csr/write_csr functions
> > 
> > Takashi Sakamoto (2):
> >   firewire: add kernel API to access CYCLE_TIME register
> >   firewire: add kernel API to access packet structure in request
> >     structure for AR context
> 
> Thanks, applied all three patches now to for-next branch.

Although thanks for your applying them into your tree, I apologize to
trouble you if you overlook that the included changes is just for Linux
FireWire subsystem. It's my fault to send them only to Linux sound
subsystem, but the changes are required to my work in sound drivers... 

If you are willing to include patches to Linux FireWire subsystem for
your pull-request to Linus, I can prepare respined patches for it since
I have the list of patches posted to LKML as bug fixes for Linux FireWire
subsystem.

I need any help to solve current situation of Linux FireWire subsystem
that bug fixes and new changes are hardly merged. Of course, IEEE 1394 bus
is already outdated and legacy, but I know that some users still work
with it. If your path is available for it, it's the easiest and the most
convenient way for upstreaming, I think.


Thanks

Takashi Sakamoto
