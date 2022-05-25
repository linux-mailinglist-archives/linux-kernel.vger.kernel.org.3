Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2D533FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbiEYPCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244946AbiEYPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:01:55 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB3A4AFB08;
        Wed, 25 May 2022 08:01:40 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8666B92009C; Wed, 25 May 2022 17:01:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8066E92009B;
        Wed, 25 May 2022 16:01:39 +0100 (BST)
Date:   Wed, 25 May 2022 16:01:39 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Rewrite `csum_tcpudp_nofold' in plain C
In-Reply-To: <b567d6bd-b563-f696-60f2-0fc36261d094@gmail.com>
Message-ID: <alpine.DEB.2.21.2205251523120.52080@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2205222035380.52080@angie.orcam.me.uk> <7682977b-5929-890a-3a18-662fbfcede5c@gmail.com> <alpine.DEB.2.21.2205241811180.52080@angie.orcam.me.uk> <b567d6bd-b563-f696-60f2-0fc36261d094@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2022, Florian Fainelli wrote:

> >   Yeah, for this particular change, sure.  I don't have QEMU set up however
> > at the moment and would have to take some time to sort it, and it won't do
> > for peripherals it doesn't implement.  The failure is a fresh problem and
> > I yet need to figure out what to do about it.  A bad coincidence I guess
> > as I have MIPS hardware 10 years older that still goes strong.
> 
> If that makes it any easier, OpenWrt has 4 configurations of Malta for QEMU
> which allows you to have at least networking (relevant here) for 32/64 and
> le/be:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=tree;f=target/linux/malta;h=90b2913dec291a1926eefc332b90b5842746c6e6;hb=HEAD
> 
> Along with a readme file on how to start those platforms:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/malta/README;h=bbe806de3d6671d69ecc3db0fcfccf9f9176de13;hb=HEAD
> 
> It's really easy.

 Thanks.  I worked with QEMU in the past, up to contributing to the MIPS 
target, so I'm quite familiar with this stuff, but it does require some 
time to set up, which I'd rather use for something else right now.

 Also I'd rather I had the core card repaired or replaced really as the 
preferred solution before resorting to alternatives.  The baseboard seems 
fine and it would be a waste of a valuable resource to just have it lying 
around collecting dust.  I wonder if the problem could be a BGA failure 
(this is a pre-RoHS device, so no issue with early lead-free solder) or an 
actual component fault.

  Maciej
